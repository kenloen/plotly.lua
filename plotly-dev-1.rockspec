package = "plotly"
version = "dev-1"
source = {
   url = "git+https://github.com/kenloen/plotly.lua.git"
}
description = {
   summary = "A simple interface for plotting with Plotly in Lua",
   detailed = [[
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
   ]],
   homepage = "https://github.com/kenloen/plotly.lua",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1",
   "dkjson >= 2.5",
   "lfs" >= 1.7.0"
}
build = {
   type = "builtin",
   modules = {
      plotly = "plotly.lua"
   }
}
