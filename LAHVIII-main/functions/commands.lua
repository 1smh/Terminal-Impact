GameConsole:registerCommand({
    name = "init",
    onExecute = function (self, arguments)
        GameConsole:print('Welcome to Terminal Impact!')
        GameConsole:print('Type \'help\' for a list of commands!')
    end
})

GameConsole:registerCommand({
    name = 'run',
    onExecute = function (self, arguments)
        local loadedApp = false
        if arguments[1] == 'coolgame' then
            AppLoadedFirstTime = true

            loadedApp = true
            App = require 'apps.coolgame'
            App:load()

            GameState = State.App
        elseif arguments[1] == 'asteroids' then
            os.execute('C:/Users/decla/github/LAHVIII/apps/asteroids/asteroids.exe')
        end

        if not loadedApp then
            self:onError(arguments)
        end
    end,
    onError = function (self, arguments)
        GameConsole:print('ERROR: No such app exists!')
    end
})

GameConsole:registerCommand({
    name = "tasks",
    onExecute = function (self, arguments)
        -- arguments[1] is the help page
        if arguments[1] == nil then
            GameConsole:print("Tasks:")
            GameConsole:print("Run: \'tasks (task number)\' to do your ")
            GameConsole:print("tasks (in order!).")
            GameConsole:print("1. Clear Asteroids")
            GameConsole:print("2. Take a Photo of a Black Hole!")
            GameConsole:print("3. Adjust the Satellite Angle")

        else
            arguments[1] = arguments[1]:gsub('[^0-9]', '') -- Anything that isn't a number gets set to ''

                if arguments[1] == '1' then
                    os.execute('C:/Users/decla/github/LAHVIII/apps/asteroids/asteroids.exe')

                    GameConsole:print("Good Job!")
                    TasksDone = 1

                    
                elseif arguments[1] == '2' then
                    
                    GameConsole:print("To take a photo type")
                    GameConsole:print("\'takephoto (object)\'")
                    GameConsole:print("(object can only be \'blackhole\',")
                    GameConsole:print("\'sun\', \'star\' or \'planet\')")
                    GameConsole:registerCommand({
                        name = "takephoto",
                        onExecute = function (self, arguments)
                            if arguments[1] == nil then
                                self:onError()
                            elseif arguments[1] == 'blackhole' then
                                GameConsole:print("You took a photo of a blackhole! ")
                                GameConsole:print("(Task Complete!)")
                                AppLoadedFirstTime = true

                                loadedApp = true
                                App = require 'apps.photo'
                                App:load()

                                TasksDone = 2

                                GameState = State.App
                            elseif arguments[1] == 'sun' then
                                GameConsole:print("(wrong object)")
                            elseif arguments[1] == 'star' then
                                GameConsole:print("(wrong object)")
                            elseif arguments[1] == 'planet' then
                                GameConsole:print("(wrong object)")
                            end
                        end,
                        onError = function (self, arguments)
                            GameConsole:print('ERROR: You can\'t take a photo of that!')
                        end
                        
                        })

                elseif arguments[1] == '3' then

                    GameConsole:print("To change angle run \'adjustangle (num)\'")

                    GameConsole:registerCommand({
                        name = "adjustangle",
                        onExecute = function (self, arguments)
                            if arguments[1] == nil then
                                self:onError()
                            elseif arguments[1] >= '301' then
                                GameConsole:print("(too large of an angle)")
                            elseif arguments[1] <= '299' then
                                GameConsole:print("(too small of an angle)")
                            elseif arguments[1] == '300' then
                                GameConsole:print("(correct angle!!)")
                                TasksDone = 3
                            end
                        end,
                        onError = function (self, arguments)
                            GameConsole:print('ERROR: You must input an angle')
                        end
                        
                        })

                end

            
        end
    end,
    onError = function (self, arguments)
        GameConsole:print('ERROR: That Task Does Not Exist')
    end
})



GameConsole:registerCommand({
    name = 'clear',
    onExecute = function (self, arguments)
        GameConsole:clear()
    end
})

GameConsole:registerCommand({
    name = "help",
    helpPages = {
        {
            '---------',
            'help [0-9] - Get help!',
            'tasks - look at your tasks [DO THIS]',
            'quit - Exit game!',
            'run [coolgame] - Run app (Esc to exit)!',
            'return - Return to your app!',
            'clear - Clear terminal',
            '--[1-?]--'
        }
    },
    onExecute = function (self, arguments)
        -- arguments[1] is the help page
        if arguments[1] == nil then
            arguments[1] = 1
            if type(self.helpPages[arguments[1]]) == 'table' then
                for i, helpMessage in ipairs(self.helpPages[arguments[1]]) do
                    GameConsole:print(self.helpPages[arguments[1]][i])
                end
            else
                GameConsole:print(self.helpPages[arguments[1]])
            end
        else
            arguments[1] = arguments[1]:gsub('[^0-9]', '') -- Anything that isn't a number gets set to ''
            if arguments[1] ~= '' then
                -- It's a number!
                arguments[1] = tonumber(arguments[1])
                if arguments[1] <= #self.helpPages then
                    if type(self.helpPages[arguments[1]]) == 'table' then
                        for i, helpMessage in ipairs(self.helpPages[arguments[1]]) do
                            GameConsole:print(self.helpPages[arguments[1]][i])
                        end
                    else
                        GameConsole:print(self.helpPages[arguments[1]])
                    end
                else
                    self:onError(arguments)
                end
            else
                self:onError(arguments)
            end
        end
    end,
    onError = function (self, arguments)
        GameConsole:print('ERROR: We haven\'t written that much!')
    end
})
GameConsole:registerCommand({
    name = 'quit',
    onExecute = function (self, arguments)
        os.exit()
    end,
    onError = function (self, arguments)
        GameConsole:print('Error with command \'' .. self.name .. '\'!')
    end
})

GameConsole:registerCommand({
    name = "return",
    onExecute = function (self, arguments)
        if AppLoadedFirstTime then
            GameState = State.App
        else
            self:onError(arguments)
        end
    end,
    onError = function (self, arguments)
        GameConsole:print('ERROR: No app loaded!')
    end
})