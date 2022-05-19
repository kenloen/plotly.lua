plotly = require("plotly")

plotly.plot{{ 1, 2, 3, 4 }, { 10, 15, 13, 17 }, 
xlabel="x-axis", 
ylabel="y-axis", 
title="Using plotly.plot"
}:show()