# Le Perch' Demo: Cards with map with markers and popups

This application scraps all the Cities where Le Wagon is settled and displays them according to world zones within cards and a map.

This code might help you learn:

- how to use a scrapper service, called within the seeds
- how to display markers on a mapbox with customized Popups
- how to link a card of a city with its related marker and popup. When clicking on the card, the map will automatically zoom in and fly to the corresponding map marker and open the attached Popup. The marker changes to a specific color.
- how to link a marker to its related card. When clicking on the marker, the corresponding card will be selected.
- how to filter different world zones without refreshing the whole page nor the map, but displaying the relevent cards and markers.
- how to build a column-like layout in CSS with customized filter tags displayed on the map.

Enjoy!

## Screenshot

![Map with cards app screenshot](https://res.cloudinary.com/pywagon/image/upload/v1638469962/screenshot_ixngya.png)

## Demo Setup

You'll need Ruby 2.7.4.

Create a `.env` file at the root of the application with the following line:

- `MAPBOX_API_KEY==…` : Fill in your own [mapbox account API key](https://account.mapbox.com/).

## Diff

[cca28960..master](https://github.com/pyveslg/cards_and_mapbox_markers/compare/cca2896087d6c7603e4fcd2fa957aca31075292d...master)

## Made for my beloved students and colleagues at [Le Wagon](https://www.lewagon.com/) ❤️
