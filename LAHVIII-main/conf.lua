function love.conf(settings)
    -- Love will not load the window module, we create it manually using my Casement library. (engine.casement)
    settings.window = nil
end