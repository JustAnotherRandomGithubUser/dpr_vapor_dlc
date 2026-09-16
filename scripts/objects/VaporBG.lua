local VaporBG, super = Class(Object)

function VaporBG:init(do_mountains, do_lightbeams, sun_colors, sun_shadows)
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

	self.default_sun_colors = sun_colors or {
		ColorUtils.hexToRGB("#ffd500"),
		ColorUtils.hexToRGB("#ff9500"),
		ColorUtils.hexToRGB("#ff4800"),
	}
	self.sun_colors = TableUtils.copy(self.default_sun_colors, true)

	self.timer = 0

    self.parallax_x = 0
    self.parallax_y = 0

    self.backdrop = Sprite("world/maps/background/backdrop", 0, 0)
    self.backdrop:setScale(2)
    self:addChild(self.backdrop)

	self.sun_x = 232
	self.sun_y = 74
    self.sun_mask_tex = Assets.getFrames("world/maps/background/sun_mask")
    self.sun_tex = Assets.getFrames("world/maps/background/sun")
	self.sun_shader = Assets.newShader("sunwave")
	
	self.do_mountains = do_mountains or true
    self.mountains_tex = Assets.getTexture("world/maps/background/mountains")
    self.mountains_parallax = 0.1
	
    self.city_bg_tex = Assets.getTexture("world/maps/background/city_bg")
    self.city_bg_lights_tex = Assets.getTexture("world/maps/background/city_bg_lights")
    self.city_bg_parallax = 0.15
	
    self.city_fg_tex = Assets.getTexture("world/maps/background/city_fg")
    self.city_fg_parallax = 0.25
	
	self.do_lightbeams = do_lightbeams or true
	self.lightbeam_tex = Assets.getTexture("world/maps/background/lightbeam_gradient")
    self.vertices = {
        {0,0,0,0},
        {1,0,1,0},
        {1,1,1,1},
        {0,1,0,1},
    }
    self.lightbeam_mesh = love.graphics.newMesh(self.vertices, "fan")
	
	if sun_shadows or sun_shadows == nil then
		self.shadows = SunShadows()
		self.shadows:setLayer(WORLD_LAYERS["above_events"])
		for _, follower in ipairs(Game.world.followers) do
			follower:addFX(SelfShadowFX())
		end
		self.shadows.colour_shadowblend = ColorUtils.hexToRGB("#280a5c")
		self.shadows.alpha_shadowblend = 0.7
		self.shadows.skew_amt = 0
		self.shadows.tile_layer_names = {"tiles_shadows"}
		self.shadows.asset_layer_names = {"objects_shadows"}
		self.shadows.cutout_tile_layer_names = {"tiles_shadows_cutout"}
		self.shadows.cutout_asset_layer_names = {"objects_shadows_cutout"}
		self.shadows:refreshCanvases()
		Game.world:addChild(self.shadows)
		Game.world.map:getTileLayer("tiles_shadows").visible = false
		local layer = Game.world.map.layers["objects_shadows"]
		for _, obj in ipairs(Game.world.children) do
			if obj.layer == layer and obj then obj.visible = false end
		end	
		Game.world.map:getTileLayer("tiles_shadows_cutout").visible = false
		layer = Game.world.map.layers["objects_shadows_cutout"]
		for _, obj in ipairs(Game.world.children) do
			if obj.layer == layer and obj then obj.visible = false end
		end	
	end
end

function VaporBG:onRemove(parent)
    if self.shadows then
        self.shadows:remove()
    end
end

function VaporBG:drawLightBeam(x1, y1, x2, y2, x3, y3, x4, y4)
    self.lightbeam_mesh:setVertices({
        {x1,y1,0,0},
        {x2,y2,1,0},
        {x3,y3,1,1},
        {x4,y4,0,1},
    })
    self.lightbeam_mesh:setTexture(self.lightbeam_tex)
    Draw.draw(self.lightbeam_mesh)

    if DEBUG_RENDER then
        love.graphics.polygon("line", x1,y1,x2,y2,x3,y3,x4,y4)
    end
end

function VaporBG:draw()
	super.draw(self)
	self.timer = self.timer + DTMULT
	local cx, cy = -(Game.world.camera.x - SCREEN_WIDTH/2), -(Game.world.camera.y - SCREEN_HEIGHT/2)
	local sun_canvas = Draw.pushCanvas(100, 100)
	Draw.pushShader(self.sun_shader)
	self.sun_shader:send("texel", {1/87, 1/85})
	self.sun_shader:send("timer", math.floor((self.timer / 2) * 2) * 2)
	self.sun_shader:send("amp", 1)
	self.sun_shader:send("frequency", 1.2)
	Draw.draw(self.sun_tex[1], 4, 5)
	Draw.popShader()
	Draw.popCanvas(true)
	local sun_rim_canvas = Draw.pushCanvas(100, 100)
	Draw.pushShader(self.sun_shader)
	self.sun_shader:send("texel", {1/87, 1/85})
	self.sun_shader:send("timer", math.floor((self.timer / 2) * 2) * 2)
	self.sun_shader:send("amp", 1)
	self.sun_shader:send("frequency", 1.2)
	Draw.draw(self.sun_tex[2], 4, 5)
	Draw.popShader()
	Draw.popCanvas(true)
	local lightbeam_canvas = nil
	if self.do_lightbeams then
		lightbeam_canvas = Draw.pushCanvas(SCREEN_WIDTH*2, SCREEN_HEIGHT)
		love.graphics.clear(COLORS.black, 0)
		love.graphics.setBlendMode("add")
		Draw.setColor(COLORS.aqua, 0.5 + (math.sin(self.timer / 12) * 0.1))
		local x, width, rotation = 120, 80, 90 + math.sin(self.timer/24)*64
		local roty, rotx = math.sin(math.rad(rotation)) * -(SCREEN_HEIGHT/2), math.cos(math.rad(rotation)) * -(SCREEN_HEIGHT/2)
		self:drawLightBeam(x - (width / 2) + rotx, roty, x + (width / 2) + rotx, roty, x, SCREEN_HEIGHT, x, SCREEN_HEIGHT)
		x = x + SCREEN_WIDTH*2
		self:drawLightBeam(x - (width / 2) + rotx, roty, x + (width / 2) + rotx, roty, x, SCREEN_HEIGHT, x, SCREEN_HEIGHT)
		Draw.setColor(COLORS.fuchsia, 0.5 + (math.cos(self.timer / 20) * 0.1))
		x, width, rotation = 240, 60, 90 - math.cos(self.timer/32)*48
		roty, rotx = math.sin(math.rad(rotation)) * -(SCREEN_HEIGHT/2), math.cos(math.rad(rotation)) * -(SCREEN_HEIGHT/2)
		self:drawLightBeam(x - (width / 2) + rotx, roty, x + (width / 2) + rotx, roty, x, SCREEN_HEIGHT, x, SCREEN_HEIGHT)
		Draw.setColor(COLORS.yellow, 0.5 + (math.sin(self.timer / 36) * 0.1))
		x, width, rotation = 360, 40, 90 - math.sin(self.timer/48)*72
		roty, rotx = math.sin(math.rad(rotation)) * -(SCREEN_HEIGHT/2), math.cos(math.rad(rotation)) * -(SCREEN_HEIGHT/2)
		self:drawLightBeam(x - (width / 2) + rotx, roty, x + (width / 2) + rotx, roty, x, SCREEN_HEIGHT, x, SCREEN_HEIGHT)
		Draw.setColor(COLORS.lime, 0.5 + (math.cos(self.timer / 32) * 0.1))
		x, width, rotation = 540, 60, 90 + math.cos(self.timer/36)*56
		roty, rotx = math.sin(math.rad(rotation)) * -(SCREEN_HEIGHT/2), math.cos(math.rad(rotation)) * -(SCREEN_HEIGHT/2)
		self:drawLightBeam(x - (width / 2) + rotx, roty, x + (width / 2) + rotx, roty, x, SCREEN_HEIGHT, x, SCREEN_HEIGHT)
		x, width, rotation = SCREEN_WIDTH + 120, 80, 90 - math.sin(self.timer/24)*56
		Draw.setColor(COLORS.aqua, 0.5 + (math.sin(self.timer / 32) * 0.1))
		roty, rotx = math.sin(math.rad(rotation)) * -(SCREEN_HEIGHT/2), math.cos(math.rad(rotation)) * -(SCREEN_HEIGHT/2)
		self:drawLightBeam(x - (width / 2) + rotx, roty, x + (width / 2) + rotx, roty, x, SCREEN_HEIGHT, x, SCREEN_HEIGHT)
		Draw.setColor(COLORS.fuchsia, 0.5 + (math.cos(self.timer / 36) * 0.1))
		x, width, rotation = SCREEN_WIDTH + 240, 60, 90 + math.cos(self.timer/32)*72
		roty, rotx = math.sin(math.rad(rotation)) * -(SCREEN_HEIGHT/2), math.cos(math.rad(rotation)) * -(SCREEN_HEIGHT/2)
		self:drawLightBeam(x - (width / 2) + rotx, roty, x + (width / 2) + rotx, roty, x, SCREEN_HEIGHT, x, SCREEN_HEIGHT)
		Draw.setColor(COLORS.yellow, 0.5 + (math.sin(self.timer / 20) * 0.1))
		x, width, rotation = SCREEN_WIDTH + 360, 40, 90 + math.sin(self.timer/48)*48
		roty, rotx = math.sin(math.rad(rotation)) * -(SCREEN_HEIGHT/2), math.cos(math.rad(rotation)) * -(SCREEN_HEIGHT/2)
		self:drawLightBeam(x - (width / 2) + rotx, roty, x + (width / 2) + rotx, roty, x, SCREEN_HEIGHT, x, SCREEN_HEIGHT)
		Draw.setColor(COLORS.lime, 0.5 + (math.cos(self.timer / 12) * 0.1))
		x, width, rotation = SCREEN_WIDTH + 540, 60, 90 - math.cos(self.timer/36)*64
		roty, rotx = math.sin(math.rad(rotation)) * -(SCREEN_HEIGHT/2), math.cos(math.rad(rotation)) * -(SCREEN_HEIGHT/2)
		self:drawLightBeam(x - (width / 2) + rotx, roty, x + (width / 2) + rotx, roty, x, SCREEN_HEIGHT, x, SCREEN_HEIGHT)
		x = x - SCREEN_WIDTH*2
		self:drawLightBeam(x - (width / 2) + rotx, roty, x + (width / 2) + rotx, roty, x, SCREEN_HEIGHT, x, SCREEN_HEIGHT)
		love.graphics.setBlendMode("alpha")
		Draw.popCanvas(true)
	end
	for i = 0, 1 do
		local scale = 2 + (0.2 * (i + 1))
		love.graphics.stencil(function()
			Draw.pushShader("Mask")
			Draw.setColor(1, 1, 1, 1)
			Draw.draw(self.sun_mask_tex[(math.floor((Kristal.getTime() * 30)*0.2) % #self.sun_mask_tex)+1], self.sun_x - 10 + 100, self.sun_y + 100, 0, scale, scale, 50, 50)
			Draw.popShader()
		end, "replace", 1)
		love.graphics.setStencilTest("greater", 0)
		Draw.setColor(self.sun_colors[1], 0.07)
		Draw.draw(sun_canvas, self.sun_x - 10 + 100, self.sun_y - 10 + 100, 0, scale, scale, 50, 50)
	end
	love.graphics.setStencilTest()
	Draw.setColor(1, 1, 1, 1)
    love.graphics.stencil(function()
		Draw.pushShader("Mask")
		Draw.draw(self.sun_mask_tex[(math.floor((Kristal.getTime() * 30)*0.2) % #self.sun_mask_tex)+1], self.sun_x - 10, self.sun_y, 0, 2, 2)
		Draw.popShader()
	end, "replace", 1)
	Draw.setColor(1, 1, 1, 0.8)
    love.graphics.setStencilTest("greater", 0)
    local shader = Kristal.Shaders["GradientV"]
	Draw.pushShader(shader)
    shader:sendColor("from", self.sun_colors[1])
    shader:sendColor("to", self.sun_colors[2])
	Draw.setColor(COLORS.white, 1)
	Draw.drawCanvas(sun_canvas, self.sun_x - 10, self.sun_y - 10, 0, 2, 2)
    shader:sendColor("from", self.sun_colors[2])
    shader:sendColor("to", self.sun_colors[3])
	Draw.drawCanvas(sun_rim_canvas, self.sun_x - 10, self.sun_y - 10, 0, 2, 2)
	Draw.popShader()
	love.graphics.setStencilTest()
	Draw.setColor(COLORS.white, 1)
	if self.do_mountains then
		Draw.drawWrapped(self.mountains_tex, true, false, cx * self.mountains_parallax, 75 + cy * self.mountains_parallax, 0, 2, 2)
	end
	if self.do_lightbeams then
		love.graphics.setBlendMode("add")
		Draw.drawWrapped(lightbeam_canvas, true, false, cx * self.city_bg_parallax, cy * self.city_bg_parallax)
	end
	love.graphics.setBlendMode("alpha")
	Draw.drawWrapped(self.city_bg_tex, true, false, cx * self.city_bg_parallax, 305 + cy * self.city_bg_parallax, 0, 2, 2)
	Draw.setColor(COLORS.white, 0.5 + (math.sin(self.timer / 12) * 0.1))
	love.graphics.setBlendMode("add")
	Draw.drawWrapped(self.city_bg_lights_tex, true, false, cx * self.city_bg_parallax, 305 + cy * self.city_bg_parallax, 0, 2, 2)
	love.graphics.setBlendMode("alpha")
	Draw.setColor(COLORS.white, 1)
	Draw.drawWrapped(self.city_fg_tex, true, false, cx * self.city_fg_parallax, 389 + cy * self.city_fg_parallax, 0, 2, 2)
    Draw.setColor(COLORS.black)
	love.graphics.rectangle("fill", -10, 520 + cy * self.city_fg_parallax, SCREEN_WIDTH + 10, SCREEN_HEIGHT + cy * self.city_fg_parallax)
	Draw.setColor(COLORS.white)
end
return VaporBG