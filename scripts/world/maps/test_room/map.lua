local VaporRoomTest, super = Class(Map)

function VaporRoomTest:onEnter()
    super.onEnter(self)

    Game.world:spawnObject(VaporBG(true), "objects_bg")
end

return VaporRoomTest