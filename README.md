# Vector Charts Plugin for AvNav

[AvNav](https://github.com/wellenvogel/avnav) plugin to access online and offline vector charts based on [maplibre](https://maplibre.org/) and [pmtiles](https://pmtiles.io/). 

The plugin requires at least AvNav version 20261102 as it uses the new plugin interfaces. It is also usable for AvNav on Android.

## Installation

Download the ZIP from the releases and upload it into AvNav.

## Charts

You can use the online charts out of the box.  
For the offline charts, the data files have to be downloaded. To do this, just call `make` in the plugin directory.

If you want US charts, too, call `make us`.

## Technical Details

The plugin registers the charts listed in `plugin.json` (see [docs](https://www.wellenvogel.net/software/avnav/newDoc/latest/en/special/charts.html#insertingdefs)).  
It uses the `maplibre` layer profile and may use a proxy to access tiles with closed CORS policies.

In `plugin.mjs` a `featureListFormatter` is registered that will be called when the user clicks on the map and there are rendered features at this position. The formatter will return the information to be shown.

## Building

To build you just need to create a zip with `make build`. Any downloaded data files will be included.
