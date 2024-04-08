State = {
    Boot = 0,
    Terminal = 1,
    App = 2
}
GameState = State.Terminal

App = {}
AppLoadedFirstTime = false

require 'functions.commonfunctions'

require 'gamemessage'
require 'gameconsole'
require 'gameinput'
Baton = require 'engine.baton' -- input library

require 'functions.commands'

require 'engine.casement' -- Casement is a library that manages the window and makes it pixel perfect (🤓)
Casement.gameWidth, Casement.gameHeight = 590, 320
Casement:initWindow({ minwidth = Casement.gameWidth, minheight = Casement.gameHeight, centered = true, resizable = true, vsync = 1 }, "Terminal Impact")

local Moonshine = require 'moonshine'

local input = Baton.new {
    controls = {
        enter = { 'key:return' },
        backspace = { 'key:backspace' },
        space = { 'key:space' },
        abort = { 'key:escape' } -- Escape app
    }
}

function love.load()
    spaceImage = love.graphics.newImage("spaceArt.png")
    Fonts = {
        enterCommand = love.graphics.newFont('resources/fonts/SpaceHarrier.ttf', 12)
    }

    Effect = Moonshine(Moonshine.effects.crt)
        .chain(Moonshine.effects.glow)
        .chain(Moonshine.effects.chromasep)
    Effect.chromasep.radius = 2
    Effect.crt.distortionFactor = {1.04, 1.04}

    GameConsole:executeCommand('init')

    os.execute("C:/Users/decla/github/LAHVIII/ai.py")

    TasksDone = 0
end
function love.update(dt)
    input:update()
    if GameState == State.App then
        love.graphics.clear()

        if input:pressed('abort') then
            App:exit(true)
            GameState = State.Terminal
        end

        App:update(dt)
        App:draw()
    end

    if TasksDone == 3 then
        
        GameConsole:print("YOU WIN!!!!! Thank you for playing!!")
        GameConsole:print("We heavily believe that the Shutdown")
        GameConsole:print("of the Chandra X-ray Observatory")
        GameConsole:print("Satellite would be a terrible")
        GameConsole:print("loss for humanity We urge you to")
        GameConsole:print("visit www.savechandra.org")
        GameConsole:print("Because we would lose sight of 25%")
        GameConsole:print("of the Universe if they shut it down")

        TasksDone = 0
    end

    if GameState == State.Terminal then
        GameInput:updateBlink()

        if input:pressed('enter') then
            GameConsole:executeCommand(GameInput.keyboardInput)
            GameInput:clear()
        end

        if input:pressed('backspace') then
            GameInput:removeKeyboardInput() -- Backspace
        end

        if input:pressed('space') and not GameInput.spacePressed then
            GameInput.keyboardInput = GameInput.keyboardInput .. ' '
            GameInput.spacePressed = true
        end

        Casement.gameCanvas:renderTo( function ()
            love.graphics.clear()
            GameInput:draw(4, Casement.gameHeight - Fonts.enterCommand:getHeight() - 4)
            GameConsole:draw(4, 4)
        end)
    end
end

function love.textinput(newLetter)
    if GameState == State.Terminal then
        GameInput:addKeyboardInput(newLetter)
    end
end

function love.draw()
    if love.window.isOpen() then
        Effect(function ()
            Casement:draw()
        end)
    end

end
