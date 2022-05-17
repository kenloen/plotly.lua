local json = require ("dkjson")

plotly = {}

plotly.cdn_str = "<script src='https://cdn.plot.ly/plotly-2.9.0.min.js'></script>"
plotly.header = ""
plotly.body = ""
plotly.id_count = 1
plotly.sleep_time = 1


function plotly.tohtml(figues)
    
    -- Create header tags
    header = "<head>\n"..plotly.cdn_str.."\n"..plotly.header.."\n</head>\n"

    -- Create body tags
    plots = ""
    for i, fig in pairs(figues) do
        plots = plots..fig:toplotstring()
    end

    return header.."<body>\n"..plots.."</body>"
end

function plotly.tofile(filename, figures)
    html_str = plotly.tohtml(figures)
    file = io.open(filename, "w")
    file:write(html_str)
    file:close()
end

function plotly.show(figures)
    filename = "_temp.html"
    plotly.tofile(filename, figures)
    open_url(filename)
    if filename == "_temp.html" then
        sleep(plotly.sleep_time)
        os.remove(filename)
    end
end

function sleep (a) 
    local sec = tonumber(os.clock() + a) 
    while (os.clock() < sec) do 
    end
end

-- From: https://stackoverflow.com/questions/11163748/open-web-browser-using-lua-in-a-vlc-extension#18864453
-- Attempts to open a given URL in the system default browser, regardless of Operating System.
local open_cmd -- this needs to stay outside the function, or it'll re-sniff every time...
function open_url(url)
    if not open_cmd then
        if package.config:sub(1,1) == '\\' then -- windows
            open_cmd = function(url)
                -- Should work on anything since (and including) win'95
                os.execute(string.format('start "%s"', url))
            end
        -- the only systems left should understand uname...
        elseif (io.popen("uname -s"):read'*a') == "Darwin" then -- OSX/Darwin ? (I can not test.)
            open_cmd = function(url)
                -- I cannot test, but this should work on modern Macs.
                os.execute(string.format('open "%s"', url))
            end
        else -- that ought to only leave Linux
            open_cmd = function(url)
                -- should work on X-based distros.
                os.execute(string.format('xdg-open "%s"', url))
            end
        end
    end

    open_cmd(url)
end

-- Figure metatable
local figure = {}

function figure.add_trace(self, trace)
    self["data"][#self["data"]+1] = trace
end

function figure.plot(self, args)
    
end

function figure.update_layout(self, layout)
    for name, val in pairs(layout) do
        self["layout"][name] = val
    end    
end

function figure.toplotstring(self)
    -- Converting input
    data_str = json.encode (self["data"])
    layout_str = json.encode (self["layout"])
    config_str = json.encode (self["config"])
    if not self.div_id then div_id = "plot"..plotly.id_count end
    plotly.id_count = plotly.id_count+1
    -- Creating string
    plot = [[<div id='%s'></div>
    <script type="text/javascript">
    var data = %s
    var layout = %s
    var config = %s
    Plotly.newPlot(%s, data, layout, config);
    </script>
    ]]
    plot = string.format(plot, div_id, data_str, layout_str, config_str, div_id)
    return plot
end

function figure.tohtmlstring(self)
    -- Create header tags
    header = "<head>\n"..plotly.cdn_str.."\n"..plotly.header.."\n</head>\n"

    -- Create body tags
    plot = self:toplotstring()

    return header.."<body>\n"..plot.."</body>"
end

function figure.tofile(self, filename)
    html_str = self:tohtmlstring()
    file = io.open(filename, "w")
    file:write(html_str)
    file:close()
end

function figure.show(self)
    filename = "_temp.html"
    self:tofile(filename)
    open_url(filename)
    if filename == "_temp.html" then
        sleep(plotly.sleep_time)
        os.remove(filename)
    end
end


-- Assigning functions
function plotly.figure()
    local fig = {data={}, layout={}, config={}}
    setmetatable(fig, {__index=figure})
    return fig
end

return plotly



