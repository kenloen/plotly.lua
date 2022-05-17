plotly = require("plotly")

-- Figure 1 (From: https://plotly.com/javascript/line-charts/)
fig1 = plotly.figure()

fig1:add_trace{x = { 1, 2, 3, 4 }, y = { 10, 15, 13, 17 }, mode = 'markers'}

fig1:add_trace{x = { 2, 3, 4, 5 }, y = { 16, 5, 11, 9 }, mode = 'lines'}

fig1:add_trace{x = { 1, 2, 3, 4 }, y = { 12, 9, 15, 12 }, mode = 'lines+markers'}

fig1:update_layout{title = 'Line and Scatter Plot'}


-- Figure 2 (From: https://plotly.com/javascript/heatmaps/)
fig2 = plotly.figure()

fig2:add_trace{z={{1, 20, 30}, {20, 1, 60}, {30, 60, 1}}, type="heatmap"}

fig2:update_layout{title = 'Heatmap'}

-- Combining figures in the same document
plotly.show{fig1, fig2}
