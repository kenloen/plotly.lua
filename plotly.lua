local json = require ("dkjson")

plotly = {}

plotly.cdn_str = "<script src='https://cdn.plot.ly/plotly-2.9.0.min.js'></script>"
plotly.header = ""
plotly.body = ""
plotly.div_id = "plot"


---Convert data, layout and config tables to HTML string
---@param data table 
---@param layout table 
---@param config table
---@return string
function tostring(data, layout, config)
    -- Convert data to json
    data_str = json.encode (data)
    layout_str = layout and json.encode (layout) or "{}"
    config_str = config and json.encode (config) or "{}"

    -- Create header tags
    header = "<head>\n"..plotly.cdn_str.."\n"..plotly.header.."\n</head>\n"

    -- Create body tags
    body = [[<body>
    <div id='%s'></div>
    <script type="text/javascript">
    var data = %s
    var layout = %s
    var config = %s
    Plotly.newPlot(%s, data, layout, config);
    </script>
    </body>
    ]]
    body = string.format(body, plotly.div_id, data_str, layout_str, config_str, plotly.div_id)


    return header..body
end

---Writes an HTML file with data, layout and config tables similar to input for plotly.js
---@param data table 
---@param layout table 
---@param config table
---@param filename string
---@return string
function tofile(filename, data, layout, config)
    html_str = tostring(data, layout, config)
    file = io.open(filename, "w")
    file:write(html_str)
    file:close()
end

sleep_time = 1
---Opens a plot in the browser with data, layout and config tables similar to input for plotly.js.
---If no file name is given it will write to a file named "_temp.html" and open it in the browser and delete it after 1 secound.
---@param data table 
---@param layout table 
---@param config table 
---@param filename string
---@return string
function show(data, layout, config, filename)
    if not filename then filename = "_temp.html" end
    tofile(filename, data, layout, config)
    open_url(filename)
    if filename == "_temp.html" then
        sleep(sleep_time)
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


-- Assigning functions
plotly.tostring = tostring
plotly.tofile = tofile
plotly.show = show

return plotly



