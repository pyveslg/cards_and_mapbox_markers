import { Controller } from "@hotwired/stimulus";
import mapboxgl from 'mapbox-gl';

export default class extends Controller {
  static targets = ["map", "marker", "card", "radio", "form", "cardsContainer"];
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.mapTarget,
      style: 'mapbox://styles/mapbox/streets-v10'
    });
    this.map.once('load', () => {
      this.map.resize()
      this._addMarkersToMap(this.markersValue);
      this._fitMapToMarkers(this.markersValue);
    })
  }

  filterMarker() {
    const checkedRadioValue = this.radioTargets.find(radio => radio.checked).value;
    const url = this.element.dataset.filterPath;
    fetch(`${url}?filter=${checkedRadioValue}`, {
      method: 'GET',
      headers: { 'Accept': 'application/json' },
    })
      .then(response => response.json())
      .then((data) => {
        this.markers.forEach(marker => marker.remove());
        this._addMarkersToMap(data.markers);
        this._fitMapToMarkers(data.markers);
        this.cardsContainerTarget.innerHTML = data.html;
    })
  }

  highlightMarker() {
    this._reinitHighlight();
    this._setMarkerActive(event, event.currentTarget.dataset.target)
  }

  highlightCard() {
    this._reinitHighlight();
    const eventTargetId = event.currentTarget.id;
    this._setMarkerActive(event, eventTargetId)
    this.cardTargets.find(card => card.dataset.target == eventTargetId).classList.add("active");
  }

  _addMarkersToMap(markers) {
    this.markers = markers.map((marker) => {
      const popup = new mapboxgl.Popup({
        maxWidth: '400px',
        className: 'camps',
        closeButton: false,
        focusAfterOpen: false,
      }).setHTML(marker.info_window);
      this.marker = new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map);
      const markerElement = this.marker._element;
      markerElement.id = marker.id;
      markerElement.dataset.action = "click->mapbox#highlightCard";
      return this.marker
    });
  }

  _fitMapToMarkers(markers) {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 10, duration: 0 });
  }

  _setMarkerActive(event, comparator) {
    const eventTarget = event.currentTarget;
    eventTarget.classList.add('active');
    const markerElement = this.markers.find(marker => marker._element.id === comparator);
    markerElement.getElement().classList.add('active');
    if (!markerElement.getPopup().isOpen()) {markerElement.togglePopup()}
    this._flyTo(markerElement);
  }

  _reinitHighlight() {
    this.cardTargets.forEach(card => card.classList.remove("active"));
    this.markers.forEach((marker) => {
      const markerElement = marker.getElement();
      markerElement.classList.remove('active');
      if (marker.getPopup().isOpen()) { marker.togglePopup()}
    })
  }

  _flyTo(marker) {
    this.map.flyTo({
        center: marker.getLngLat(),
        zoom: 9
    });
  }

}
