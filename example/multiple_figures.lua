plotly = require("plotly")

-- Figure 1 (From: https://plotly.com/javascript/line-charts/)
fig1 = plotly.figure()

fig1:add_trace{x = { 1, 2, 3, 4 }, y = { 10, 15, 13, 17 }, mode = 'markers'}

fig1:add_trace{x = { 2, 3, 4, 5 }, y = { 16, 5, 11, 9 }, mode = 'lines'}

fig1:add_trace{x = { 1, 2, 3, 4 }, y = { 12, 9, 15, 12 }, mode = 'lines+markers'}

fig1:update_layout{title = 'Line and Scatter Plot'}


-- Figure with 3D plot
-- From: https://plotly.com/javascript/3d-isosurface-plots/
fig2 = plotly.figure()

fig2:add_trace {
    type = "isosurface",
    x = { 0, 0, 0, 0, 1, 1, 1, 1 },
    y = { 0, 1, 0, 1, 0, 1, 0, 1 },
    z = { 1, 1, 0, 0, 1, 1, 0, 0 },
    value = { 1, 2, 3, 4, 5, 6, 7, 8 },
    isomin = 2,
    isomax = 6,
    colorscale = "Reds"
}

fig2:update_layout {
    title="3D plot",
    margin = { t = 0, l = 0, b = 0 },
    scene = {
        camera = {
            eye = {
                x = 1.88,
                y = -2.12,
                z = 0.96
            }
        }
    }
}

-- Combining figures in the same document
plotly.show{fig1, fig2}
