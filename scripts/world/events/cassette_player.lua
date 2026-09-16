---@class CassettePlayer : Event
---@overload fun(...) : CassettePlayer
local CassettePlayer, super = Class(Event)

function CassettePlayer:init(data)
    super.init(self, data.x, data.y, data.w, data.h)
	
	local properties = data.properties or {}
	
	self.map = properties["map"] or "test_room"
    self:setSprite("world/events/cassette_player")
    self:setOrigin(0.5, 1)
	
    self.palette_sprite = properties["palette"] or "world/events/player_palette"
    self.palette_fx = PaletteFX(self.palette_sprite, 0)
	self:addFX(self.palette_fx)
    self.pal_index = 0
end

function CassettePlayer:getPaletteIndex()
	
	if not Game.inventory:hasItem("vaporcassette") then
        return 7
    end
    return self.pal_index
end

function CassettePlayer:postLoad()
	super.postLoad(self)
	self.last_main_mus_time = self.world.music:tell()
	self.last_sub_mus_time = 0
end

function CassettePlayer:update()
    super.update(self)
    self.pal_index = MathUtils.wrap(self.pal_index + (0.2 * DTMULT), 0, 6)
    self.palette_fx:setPaletteIndex(self:getPaletteIndex())
end

function CassettePlayer:onInteract(player, dir)
	if not Game.inventory:hasItem("vaporcassette") then
		Game.world:showText({"* It's a mysterious tape player,[wait:5] sealed with some sort of power...", "* It seems you'll need a [color:#00FFFF]special [color:#FF00FF]cassette[color:reset] to use it."})
		return true
	end
	Game.lock_movement = true
	if Game.world.new_vcr_text then
		Game.world.new_vcr_text:remove()
	end
	if Game.world.vcr_text_timer then
		Game.world.timer:cancel(Game.world.vcr_text_timer)
		Game.world.vcr_text_timer = nil
	end
    Assets.stopAndPlaySound("grab", 0.7, 1.5)
    Assets.stopAndPlaySound("cassette_swap")
    Assets.stopAndPlaySound("cassette_insert")
	Game:setFlag("vaporSwapping", true)
	local vcr_blue = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
	vcr_blue:setParallax(0)
	vcr_blue:setColor(COLORS.black)
	vcr_blue.layer = WORLD_LAYERS["top"] - 2
	Game.world:addChild(vcr_blue)
	local vcr_text = Sprite("ui/vcr_stop", 10, 10)
	vcr_text.visible = false
	vcr_text:setParallax(0)
	vcr_text:setScale(2)
	vcr_text.layer = WORLD_LAYERS["top"] - 1
	Game.world:addChild(vcr_text)
	if Game:getFlag("vaporCurrentlyInSubArea", false) then
		Game:setFlag("vaporSubAreaMusicTime", math.max(Game.world.music:tell(), 0))
	else
		Game:setFlag("vaporMainAreaMusicTime", math.max(Game.world.music:tell(), 0))
	end
	Game.world.music:pause()
	if Kristal.Config["simplifyVFX"] then
		vcr_blue:setColor(ColorUtils.hexToRGB("#3F48CC"))
		vcr_text.visible = true
	else
		Game.world.timer:after(2/30, function()
			vcr_blue:setColor(ColorUtils.hexToRGB("#3F48CC"))
			Game.world.timer:after(2/30, function()
				vcr_text.visible = true
			end)
		end)
	end
	Game.world.timer:after(20/30, function()
		if vcr_blue then
			vcr_blue:remove()
		end
		if vcr_text then
			vcr_text:remove()
		end
		Game.world:loadMap(self.map, "cassette_warp", "down", function()
			Game.world.new_vcr_text = Sprite("ui/vcr_play", 10, 10)
			Game.world.new_vcr_text:setParallax(0)
			Game.world.new_vcr_text:setScale(2)
			Game.world.new_vcr_text.layer = WORLD_LAYERS["top"] - 1
			Game.world:addChild(Game.world.new_vcr_text)
			local vcr_change_fx = Ch3ChannelChange()
			vcr_change_fx.lifetime = 15
			vcr_change_fx.remove_after = true
			Game.world:addChild(vcr_change_fx)
			vcr_change_fx:startChannelChange(true, false)
			Game:setFlag("vaporCurrentlyInSubArea", not Game:getFlag("vaporCurrentlyInSubArea", false))
			if Game:getFlag("vaporCurrentlyInSubArea", false) then
				Game.world.music:play("can_you_feel")
				Game.world.music:seek(Game:getFlag("vaporSubAreaMusicTime", 0))
			else
				Game.world.music:play("citypop_sound_of_love")
				Game.world.music:seek(Game:getFlag("vaporMainAreaMusicTime", 0))
			end
			Game:setFlag("vaporSwapping", false)
			Game.world.music.volume = 0.5
			Game.world.music.pitch = 0.1
			Game.world.timer:tween(15/30, Game.world.music, {pitch = 1, volume = 1}, "in-quad", function()
				Game.lock_movement = false
				Game.world.vcr_text_timer = Game.world.timer:after(1, function()
					if Game.world.new_vcr_text then
						Game.world.new_vcr_text:remove()
						Game.world.new_vcr_text = nil
					end
					Game.world.vcr_text_timer = nil
				end)
			end)
		end)
	end)
    return true
end

return CassettePlayer
