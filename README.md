# plotly.lua
A simple interface for plotting with [Plotly](https://plotly.com/javascript/) in Lua

## Installation

Installation with `luarocks`:

    luarocks install plotly

The interface in written in pure Lua and requires internet for rending the plots

## Usages
Some examples can be found here: https://github.com/kenloen/plotly.lua/tree/main/example  

The module comes with two approches for creating figures/plots.  

### plotly.plot

The fastest interface is trying to mimic the plotting interface in Matlab and Matplotlib, using the `plotly.plot{x, y, ...}` or `fig.plot{x, y, ...}` api.

```lua
plotly = require("plotly")

plotly.plot{{ 1, 2, 3, 4 }, { 10, 15, 13, 17 }, 
            xlabel="x-axis", ylabel="y-axis",
            title="Using plotly.plot"}:show()
```
Which will open the plot in the browser.  
Examples are here:
- [Using plotly.plot](https://github.com/kenloen/plotly.lua/tree/main/example/plotly_plot.lua)
- [Using plotly.figure.plot](https://github.com/kenloen/plotly.lua/tree/main/example/figure_plot.lua)

### plotly.figure
The other one is a simple wrapper around the plain [plotly.js](https://plotly.com/javascript/reference/index/) where the data for a plot is provided though JSON data such as `data` (containing data about traces), `layout` (containing data about figure layout, e.g. title, axis-title, size), and `config` (containing data about figure configurations e.g. responsive sizing, interactive title editing).

```lua
plotly = require("plotly")

-- Figure with all traces, layout and config
-- From= https://plotly.com/javascript/line-charts/
fig1 = plotly.figure()

fig1:add_trace { x = { 1, 2, 3, 4 }, y = { 10, 15, 13, 17 }, mode = 'markers' }

fig1:add_trace { x = { 2, 3, 4, 5 }, y = { 16, 5, 11, 9 }, mode = 'lines' }

fig1:add_trace { x = { 1, 2, 3, 4 }, y = { 12, 9, 15, 12 }, mode = 'lines+markers' }

fig1:update_layout { title = 'Line and Scatter Plot with scroll-zoom and editable titles' }

fig1:update_config { scrollZoom = true, editable = true }

fig1:show()
```
Examples are here:
- [Using plotly.figure.add_trace](https://github.com/kenloen/plotly.lua/tree/main/example/figure_add_trace.lua)
- [Using plotly.show (mutiple figure in the same document)](https://github.com/kenloen/plotly.lua/tree/main/example/multiple_figures.lua)

### Saving to file
The examples above are using `:show()` to show the plot in the browser. If instead a file should be saved the `:tofile(filename)` method should be used. Using the example with `fig1` from above:
```lua
fig1:tofile("awesome_plot.html")
```
or if both a file should be saved and opening in the browser:
```lua
fig1:tofile("awesome_plot.html"):show()
```