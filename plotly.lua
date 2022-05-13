local json = require ("dkjson")

plotly = {}

plotly.cdn_str = "<script src='https://cdn.plot.ly/plotly-2.9.0.min.js'></script>"
plotly.header = ""
plotly.body = ""

-- Convert data, layout and config to JSON string
function tostring(data, layout, config, html_id)
    -- Convert data to json
    data_str = json.encode (data)
    layout_str = layout and json.encode (layout) or "{}"
    config_str = config and json.encode (config) or "{}"

    -- Create header tags
    header = "<head>\n"..plotly.cdn_str.."\n"..plotly.header.."\n</head>\n"

    -- Create body tags
    if html_id == nil then html_id = "plot" end
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
    body = string.format(body, html_id, data_str, layout_str, config_str, html_id)


    return header..body
end

function tofile(filename, data, layout, config, html_id)
    html_str = tostring(data, layout, config, html_id)
    file = io.open(filename, "w")    
    file:write(html_str)
    file:close()
end

function show(data, layout, config, filename, html_id)
    if not filename then filename = "_temp.html" end
    tofile(filename, data, layout, config, html_id)
    open_url(filename)
    if filename == "_temp.html" then
        sleep(1)
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



