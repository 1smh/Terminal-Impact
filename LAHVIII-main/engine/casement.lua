love.graphics.setDefaultFilter('nearest', 'nearest')

Casement = { gameWidth = 0, gameHeight = 0 } -- Globals are always capitalized

function Casement:initWindow(windowFlags, windowTitle)
    local screenWidth, screenHeight = love.window.getDesktopDimensions()
    local scale = math.min(screenWidth / self.gameWidth, screenHeight / self.gameHeight) - 1

    love.window.setMode(self.gameWidth * scale, self.gameHeight * scale, windowFlags)

    self.gameCanvas = love.graphics.newCanvas(self.gameWidth, self.gameHeight)

    love.window.setTitle(windowTitle)
end

function Casement:draw()
    love.graphics.push()


    local windowWidth, windowHeight = love.graphics.getDimensions()

    local scale = self:getScale(windowWidth, windowHeight)

    local horizontalPadding = ((windowWidth - (self.gameWidth * scale)) / 2) / scale
    local verticalPadding = ((windowHeight - (self.gameHeight * scale)) / 2) / scale

    love.graphics.draw(spaceImage, 0, -10, 0, 0.4, 0.4)


    love.graphics.draw(self.gameCanvas, self.gameWidth/3 - 35, self.gameHeight / 2 + 10, 0, 0.45, 0.4)

    love.graphics.pop()
end

function Casement:getScale(windowWidth, windowHeight)
    local scale = math.min(windowWidth / self.gameWidth, windowHeight / self.gameHeight)

    love.graphics.scale(scale, scale)

    return scale
end