plotly = require("plotly")

-- (From: https://plotly.com/javascript/line-charts/)
fig = plotly.figure()

-- Only giving x and y
fig:plot{{ 1, 2, 3, 4 }, { 10, 15, 13, 17 }, xlabel="x-axis", ylabel="y-axis", name="x- and y-labels"}

-- Changing line width and style
fig:plot{{ 2, 3, 4, 5 }, { 16, 5, 11, 9 }, ls="--", lw=5, c="red", name="line-style+line-width+color"}

-- Changing line width and style
fig:plot{{ 1, 2, 3, 4 }, y = { 12, 9, 15, 12 }, ms=20, mode="m", color="blue", name="Marker-size+marker-mode", title='Line and Scatter Plot'}

fig:show()