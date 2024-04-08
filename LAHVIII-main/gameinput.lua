GameInput = {}
GameInput.keyboardInput = ''
GameInput.spacePressed = false
GameInput.blink = false
GameInput.blinkTimer = 0
GameInput.animation = 0

function GameInput:draw(x, y)
    self.animation = math.clamp(0, self.animation + 0.1, 1)
    local textToDraw = '  ' .. self.keyboardInput
    if self.blink then
        textToDraw = textToDraw .. '_'
    end
    love.graphics.setColor(love.math.colorFromBytes(148, 148, 148))
    love.graphics.print('> ', Fonts.enterCommand, x + love.math.lerp(1, 0, self.animation), y)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(textToDraw, Fonts.enterCommand, x, y + love.math.lerp(2, 0, self.animation))
end

function GameInput:updateBlink()
    self.blinkTimer = self.blinkTimer - 1
    if self.blinkTimer <= 0 then
        self.blink = not self.blink
        self.blinkTimer = 30
    end
end

function GameInput:addKeyboardInput(newLetter)
    local filteredInput = newLetter:gsub('[^a-zA-Z0-9]','')
    if filteredInput ~= '' then
        -- Pressed something other than space
        self.animation = 0
        self.spacePressed = false
    end
    self.keyboardInput = self.keyboardInput .. filteredInput

end

function GameInput:removeKeyboardInput()
    self.keyboardInput = self.keyboardInput:gsub('.?$', '')
end

function GameInput:clear()
    self.keyboardInput = ''
end