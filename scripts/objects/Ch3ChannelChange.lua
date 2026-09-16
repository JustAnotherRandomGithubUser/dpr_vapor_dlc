local Ch3ChannelChange, super = Class(Object)

function Ch3ChannelChange:init()
    super.init(self, 0, 0)
	self.is_active = false
	self.strength = 0
	self.siner = 0
	self.strength = 200
	self.timer = 0
	self.lifetime = 7
	self.perlin_tex = Assets.getTexture("shaders/perlin_noise")
	self.static_tex = Assets.getFrames("shaders/static_effect")
	self.scan_x = 0
	self.scroll_speed = 5
	self.scroll_dir = Utils.randomSign()
	self.infinite = false
	self.init = false
	self.scroll = false
	self.shuffle = false
	self.siner = 0
	self.multa = 20
	self.multb = 30
	self.old_screen_canvas = love.graphics.newCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
	self.static_noise = nil
    self.shader = Assets.newShader("channelchange")
	self.is_finished = false
	self.remove_after = false
	self.main_canvas = nil
end

function Ch3ChannelChange:onAdd(parent)
    super.onAdd(self,parent)
    self:setLayer(WORLD_LAYERS["below_ui"])
    self:setParallax(0)
end

function Ch3ChannelChange:onRemove(parent)
    super.onRemove(self, parent)
	if self.static_noise then
		self.static_noise:stop()
		self.static_noise = nil
	end
	if self.old_screen_canvas then
		self.old_screen_canvas = nil
	end
end

function Ch3ChannelChange:onRemoveFromStage(stage)
    super.onRemoveFromStage(self, stage)
	if self.static_noise then
		self.static_noise:stop()
		self.static_noise = nil
	end
	if self.old_screen_canvas then
		self.old_screen_canvas = nil
	end
end

function Ch3ChannelChange:startChannelChange(shuffle, silent)
	local silent = silent or true
	local shuffle = shuffle or false
	self.silent = true
	self.is_active = true
	self.timer = self.lifetime
	if shuffle then
		self.scan_x = MathUtils.wrap(self.scan_x + MathUtils.randomInt(40, 439), 0, SCREEN_HEIGHT - 1)
	end
	if not silent then
		self.silent = false
		if self.static_noise then
			self.static_noise:stop()
			self.static_noise = nil
		end
		self.static_noise = Assets.newSound("tv_static")
		self.static_noise:setLooping(true)
		self.static_noise:play()
	end
end

function Ch3ChannelChange:update()
    super.update(self)
	if not self.init then
		self.timer = self.lifetime
		local variation = (self.lifetime * self.scroll_speed * self.scroll_dir) / 2
		local scroll = (SCREEN_HEIGHT / 2) - (variation / 2)
		self.scan_x = MathUtils.random(variation + (variation * -self.scroll_dir), scroll + (variation * -self.scroll_dir))
		self.init = true
	end
end

function Ch3ChannelChange:fullDraw(...)
    self.main_canvas = love.graphics.getCanvas()
    super.fullDraw(self)
end

function Ch3ChannelChange:draw()
    super.draw(self)
	if self.is_finished then return end
	if self.is_active ~= true or self.timer <= 0 or self.strength == 0 or not self.old_screen_canvas then
		if self.scroll then
			self.old_screen_canvas = Draw.pushCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
			Draw.drawCanvas(self.main_canvas, 0, 0)
			Draw.popCanvas(true)
		end
	end
	if self.is_active ~= true or self.timer <= 0 or self.strength == 0 then
		return
	end
	Draw.pushCanvasLocks()
	local screen_canvas = Draw.pushCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
	local ease = Utils.ease(0, 1, self.timer / self.lifetime, "in-quad")
	local strength = self.strength * ease
	if self.scroll then
		local yy = MathUtils.wrap(Utils.ease(0, 1, 1 - (self.timer / self.lifetime), "out-quart") * SCREEN_HEIGHT, 0, SCREEN_HEIGHT)
		love.graphics.setBlendMode("alpha", "premultiplied")
		Draw.drawPart(self.old_screen_canvas, 0, 0, 0, yy, SCREEN_WIDTH, SCREEN_HEIGHT - yy)
		Draw.drawPart(self.main_canvas, 0, SCREEN_HEIGHT - yy, 0, 0, SCREEN_WIDTH, yy)
		love.graphics.setBlendMode("alpha", "alphamultiply")
	else
		Draw.drawCanvas(self.main_canvas, 0, 0)
	end
	Draw.popCanvas(true)
	if self.scroll or Kristal.Config["simplifyVFX"] then
		strength = strength / 3
	end
	Draw.pushShader(self.shader)
	self.shader:send("perlin_tex", self.perlin_tex)
	self.shader:send("texel", {1 / SCREEN_WIDTH, 1 / SCREEN_HEIGHT})
	self.shader:send("strength", strength)
	self.shader:send("u_pixelSize", {1.0 / self.perlin_tex:getWidth(), 1.0 / self.perlin_tex:getHeight()})
	self.shader:send("u_UVs", {(1.0 / self.perlin_tex:getWidth()) * 0.5, (1.0 / self.perlin_tex:getHeight()) * 0.5})
	self.shader:send("scanx", math.floor(self.scan_x) + 0.5)
	Draw.drawCanvas(screen_canvas, 0, 0)
	Draw.popShader()
	Draw.popCanvasLocks()
	self.scan_x = MathUtils.wrap(self.scan_x + (self.scroll_speed * self.scroll_dir * (self.timer / self.lifetime) * 2), 0, SCREEN_HEIGHT - 1)
	if not self.infinite and self.timer > 0 then
		self.timer = self.timer - DTMULT
		if self.timer <= 0 then
			if self.remove_after then
				self:remove()
			else
				if self.static_noise then
					self.static_noise:stop()
					self.static_noise = nil
				end
				self.multa = MathUtils.random(10, 40)
				self.multb = MathUtils.random(5, 10)
			end
		end
	end
	self.siner = self.siner + DTMULT
	local alpha = ease / 2
	Draw.setColor(COLORS.white, alpha)
	if self.infinite then
		Draw.drawWrapped(self.static_tex[(math.floor(self.scan_x) % #self.static_tex) + 1], true, true, 0, 0, 0, 2, 2)
	else
		Draw.drawWrapped(self.static_tex[(math.floor(self.timer / 2) % #self.static_tex) + 1], true, true, 0, 0, 0, 2, 2)	
	end
	Draw.setColor(1, 1, 1, 1)
end

return Ch3ChannelChange