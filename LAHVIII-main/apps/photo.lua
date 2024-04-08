return {
    draw = function (self) -- Draw
        Casement.gameCanvas:renderTo( function ()
            love.graphics.clear()

            love.graphics.draw(BlackHole, 30, 70, 0, 0.35, 0.35)

            love.graphics.print(Blackholetext, Fonts.enterCommand, 0, 0)
            love.graphics.print("ESC to go back to terminal", Fonts.enterCommand, 0, 300)

           
        end)
    end,
    load = function (self) -- Upon app load

        math.randomseed(os.time())
        local rand = math.random(1, 4)

        BlackHole = love.graphics.newImage("apps/blackhole" .. rand .. ".png")

        local open = io.open

        local function read_file(path)
            local file = open(path, "rb") -- r read mode and b binary mode
            if not file then return nil end
            local content = file:read "*a" -- *a or *all reads the whole file
            file:close()
            return content
        end

        Blackholetext = read_file("entries.txt");      
    end,
    update = function (self)

    end,
    exit = function (self, forced)
        
    end
}