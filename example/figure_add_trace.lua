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
