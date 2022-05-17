-- From= https://plotly.com/javascript/line-charts/
plotly = require("plotly")

fig = plotly.figure()

fig:add_trace{x = { 1, 2, 3, 4 }, y = { 10, 15, 13, 17 }, mode = 'markers'}

fig:add_trace{x = { 2, 3, 4, 5 }, y = { 16, 5, 11, 9 }, mode = 'lines'}

fig:add_trace{x = { 1, 2, 3, 4 }, y = { 12, 9, 15, 12 }, mode = 'lines+markers'}

fig:update_layout{title = 'Line and Scatter Plot'}

fig:show()