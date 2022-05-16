# plotly.lua
A simple interface for plotting with [Plotly](https://plotly.com/javascript/) in Lua

## Installation

Installation with `luarocks`:

    luarocks install plotly.lua

The interface in written in pure Lua and requires internet for rending the plots

## Usages
The module comes with two main functions, namely: `plotly.tofile` and `plotly.show`. 

Using `plotly.show`:
```lua
plotly = require("plotly")

-- Example from: https://plotly.com/javascript/line-charts/

-- Creating data traces
trace1 = {
    x = { 1, 2, 3, 4 }; 
    y = { 10, 15, 13, 17 }; 
    mode = 'markers';
    }

trace2 = {
    x = { 2, 3, 4, 5 };
    y = { 16, 5, 11, 9 };
    mode = 'lines'
    }

trace3 = {
    x = { 1, 2, 3, 4 }; 
    y = { 12, 9, 15, 12 }; 
    mode = 'lines+markers'
    }

-- Combining data in a table (with no field names)
data = { trace1, trace2, trace3 }

-- Adding plot title
layout = { title = 'Line and Scatter Plot'}

-- show the plot in the browser (temporary file is created)
plotly.show(data, layout)
```
Or showing and saving a file:
```lua
-- show the plot in the browser and save to line-charts.html 
plotly.show(data, layout, nil, "line-charts.html")
```
Using `plotly.tofile`:
```lua
-- Save the plot as an HTML file 
plotly.tofile("line-charts.html", data, layout)
```

## Update
- Change input to table input (`plotly.plot(x,y)` -> `plotly.plot{x,y, ls=1}`)
- Make `plotly.plot` interface (using matlab style interface (`x`,`y`, keyword: `ls`, `lw`, `name`, ...))
- Add `plotly.figure` method returning metatable with methods for adding traces (e.g `fig:plot{x,y}`, `fig:scatter{x,y}`) as well as layout and config (`fig:update_layout{title="Plot"}`) and saving to file or displaying (`fig:tofile{filename}`, `fig:show()`)
- Add methods for saving or rendering multiple plots in the same file (`plotly.tofile("plot.html", {fig1, fig2})`, `plotly.show({fig1, fig2})`)
- Extend figure metatable above to have Holoviews style layout rendering (e.g `fig1*fig2`-> overlaying plots, `fig1+fig2` -> subplots with additional methods for layout gird `(fig1+fig2+fig3+fig4).cols(2)` -> 2x2 grid)