GameConsole = {}
GameConsole.commands = {}
GameConsole.messages = {}
GameConsole.maxMessages = 16;

function GameConsole:print(text)
    self:addMessage(GameMessage.new(text))
end

function GameConsole:clear()
    GameConsole.messages = {}
end

function GameConsole:registerCommand(command)
    table.insert(self.commands, command)
end

function GameConsole:executeCommand(command)
    local desiredCommand = ''
    local arguments = {}
    local tempArgument = ''
    local mode = 1 -- Looking for command, 2 is loading arguments

    command:gsub('.', function(l)
        if mode == 1 then
            if l == ' ' then
                mode = 2
            else
                desiredCommand = desiredCommand .. l
            end
        else
            -- Loading arguments
            if l == ' ' then
                -- Move onto next argument
                table.insert(arguments, tempArgument)
                tempArgument = ''
            else
                tempArgument = tempArgument .. l
            end
        end
    end)

    if string.len(tempArgument) >= 1 then
        -- No trailing space
        table.insert(arguments, tempArgument)
    end

    local foundCommand = false
    for i, command in ipairs(self.commands) do
        if command.name == desiredCommand then
            foundCommand = true
            command:onExecute(arguments)
        end
    end
    if not foundCommand then
        GameConsole:print('Command \'' .. desiredCommand .. '\' not found!')
    end

    return desiredCommand, arguments
end

function GameConsole:newLine()
    GameConsole:addMessage(GameMessage.new(''))
end

function GameConsole:addMessage(message)
    if #self.messages >= self.maxMessages then
        table.remove(self.messages, 1) -- Remove message
    end
    table.insert(self.messages, message) -- Appends message to bottom of the messages
end


function GameConsole:draw(x, y)
    love.graphics.setColor(love.math.colorFromBytes(34, 156, 0))

    local messagesLength = #self.messages
    for i, message in ipairs(self.messages) do
        local offset = ((i - 1) * Fonts.enterCommand:getHeight()) - (2 * (i - 1))
        
        if i == messagesLength then
            love.graphics.setColor(love.math.colorFromBytes(3, 252, 11))
            GameMessage:drawMessage(message, x, y + offset)
            love.graphics.setColor(1, 1, 1, 1)
        else
            GameMessage:drawMessage(message, x, y + offset)
        end
    end

    love.graphics.setColor(1, 1, 1, 1)
end
