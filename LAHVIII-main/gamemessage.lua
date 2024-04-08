GameMessage = {}

function GameMessage.new(text, color) -- Constructor
    local newGameMessage = {
        text = text,
        animation = 0
    }
    return newGameMessage
end

function GameMessage:drawMessage(message, x, y)
    message.animation = math.clamp(0, message.animation + 0.1, 1)
    love.graphics.print(message.text, Fonts.enterCommand, x, y + love.math.lerp(2, 0, message.animation))
end