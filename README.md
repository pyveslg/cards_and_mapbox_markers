# Le Perch' Demo : Cards with map with markers and popups (Mapbox-based map)

This application scraps all the Cities where Le Wagon is settled and display them according to world zones within cards and a map.

This code might help you to:
– how to use a scrapper service, called within the seeds
– how to display markers on a mapbox with customized Popups
– how to link a card of city with its related marker and popup. When clicking on the card, the map will automatically zoom in and fly to the marker, with open Popup. The marker turns in a specific color.
– how to link a marker with its related card. When clicking on the marker, the card will be selected.
– how to filter on different world zones without refreshing the whole page nor the map, but displaying the relevent cards and markers.

Enjoy!


## Demo Setup

You'll need Ruby 2.7.4.

Create a `.env` file at the root of the application with the following line:

- `MAPBOX_API_KEY==…` : Fill in your own mapbox account API key.


### Made for my beloved students and colleagues at (Le Wagon)[https://www.lewagon.com/] ❤️
