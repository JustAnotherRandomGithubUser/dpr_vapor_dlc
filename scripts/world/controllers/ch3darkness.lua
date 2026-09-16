local Chapter3Darkness, super = Class(Event)

function Chapter3Darkness:init(data)
    super.init(self, data)

    self.darkness = Game.world:spawnObject(Ch3CouchDarkness(data.properties["intensity"] or 1), WORLD_LAYERS["below_ui"])
end

return Chapter3Darkness