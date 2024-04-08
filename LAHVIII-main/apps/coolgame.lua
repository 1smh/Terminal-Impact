return {
    input = Baton.new {
        controls = {
            up = { 'key:up' },
            down = { 'key:down' },
            left = { 'key:left' },
            right = { 'key:right' }
        }
    },
    update = function (self, deltaTime) -- Update
        self.input:update()

        local dx, dy = 0, 0
        if self.input:down 'up' then dy = -1 end
	    if self.input:down 'left' then dx = -1 end
	    if self.input:down 'right' then dx = 1 end
	    if self.input:down 'down' then dy = 1 end
	    if dx ~= 0 or dy ~= 0 then
		    if dx ~= 0 and dy ~= 0 then
			    dx = dx * 0.7071
			    dy = dy * 0.7071
		    end
		    self.player.x = self.player.x + dx
		    self.player.y = self.player.y + dy
	    end
    end,
    draw = function (self) -- Draw
        Casement.gameCanvas:renderTo( function ()
            love.graphics.clear()
            love.graphics.print('There is legitimately nothing here.', Fonts.enterCommand, 10, 100)
            love.graphics.print('Press Escape to Return to the Terminal.', Fonts.enterCommand, 10, 150)
            love.graphics.print(self.player.text, Fonts.enterCommand, self.player.x, self.player.y)
        end)
    end,
    load = function (self) -- Upon app load
        self.player = {
            x = 0,
            y = 0,
            text = '0'
        }
    end,
    exit = function (self, forced)
        
    end
}