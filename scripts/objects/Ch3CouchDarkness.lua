local Ch3CouchDarkness, super = Class(Object)

function Ch3CouchDarkness:init(intensity)
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    -- above everything, including ui, by default
    -- if you want it to be below ui, set its layer
    self.layer = WORLD_LAYERS["below_ui"]

    -- parallax set to 0 so it's always aligned with the camera
    self:setParallax(0, 0)
    -- don't allow debug selecting
    self.debug_select = false

	self.intensity = intensity or 1
	self.radius = 200
	self.max_radius = 200
	self.xx = 200
	self.yy = 200
	
	self.siner = 0
	self.type = 1
	self.init = false
end

function Ch3CouchDarkness:update()
	super.update(self)
	self.siner = self.siner + DTMULT
	
	if self.type == 0 then
		local x, y = Game.world.player:localToScreenPos()
		self.yy = self.yy + (math.cos(self.siner / 8) / 2)
		self.xx = self.xx + (math.sin(self.siner / 8) / 2)
	elseif self.type == 1 or self.type == 2 then
		if self.type == 1 then
			if self.radius < self.max_radius then
				self.radius = MathUtils.lerp(self.radius, self.max_radius, 0.1 * DTMULT)
			end
		elseif self.type == 2 then
			self.radius = self.radius + 10 * DTMULT
			if self.radius > 290 then
				self:remove()
			end
		end
		local x, y = Game.world.player:localToScreenPos()
		local righth = Input.down("right") and 1 or 0
		local lefth = Input.down("left") and 1 or 0
		local hold = (righth - lefth) * 16
		if Input.down("cancel") then
			hold = hold * 2
		end
		if not Game.world.player:isMovementEnabled() then
			hold = 0
		end
		x = x + hold
		local overwrite = false
		for k,v in pairs(Game.world.camera.mods) do
			if v.value ~= nil then
				overwrite = true
			end
		end
		
		if overwrite then
			x = MathUtils.lerp(x, SCREEN_WIDTH/2, 0.5 * DTMULT)
			y = MathUtils.lerp(y, SCREEN_HEIGHT/2, 0.5 * DTMULT)
		end
		
		if math.abs(x - self.xx) > 6 then
			self.xx = MathUtils.lerp(self.xx, x, 0.1 * DTMULT)
		end
		if math.abs(y - self.yy) > 6 then
			self.yy = MathUtils.lerp(self.yy, y, 0.1 * DTMULT)
		end
		
		self.yy = self.yy + (math.cos(self.siner / 8) / 2)
		self.xx = self.xx + (math.sin(self.siner / 8) / 2)
		
		if not self.init then
			self.xx = x
			self.yy = y
			self.init = true
		end
	end
end

function Ch3CouchDarkness:draw()
    local canvas = Draw.pushCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
	if Ch4Lib.accurate_blending then
		love.graphics.push()
		love.graphics.setBlendMode("alpha", "alphamultiply")
		if self.type == 0 then
			local x, y = self.xx, self.yy
			love.graphics.clear(COLORS.black)
			love.graphics.setColor(1,1,1,1)
			love.graphics.setBlendMode("add")
			Ch4Lib.setBlendState("add", "zero", "oneminussrccolor")
			love.graphics.circle("fill", x, y, self.radius, 24)
		else
			love.graphics.setColor(0,0,0,0.4*self.intensity)
			love.graphics.rectangle("fill",0,0,SCREEN_WIDTH,SCREEN_HEIGHT)
			local x, y = self.xx, self.yy
			love.graphics.setColor(1,1,1,0.4*self.intensity)
			love.graphics.setBlendMode("add")
			Ch4Lib.setBlendState("add", "zero", "oneminussrccolor")
			love.graphics.circle("fill", x, y, self.radius, 24)
			love.graphics.circle("fill", x, y, self.radius+20, 24)
			love.graphics.circle("fill", x, y, self.radius+40, 24)
			love.graphics.setColor(1,1,1,1)
		end
		love.graphics.pop()
	else
		if self.type == 0 then
			love.graphics.setColor(0,0,0)
			love.graphics.rectangle("fill",0,0,SCREEN_WIDTH,SCREEN_HEIGHT)
			local x, y = self.xx, self.yy

			love.graphics.setColor(1,1,1)
			love.graphics.circle("fill", x, y, self.radius, 24)
		else
			local alpha1 = ((self.radius / self.max_radius) * 0.4) * self.intensity
			local alpha2 = 0.05
			local alpha3 = 0.1
			local alpha4 = 0.3
			love.graphics.setColor(alpha1,alpha1,alpha1)
			love.graphics.rectangle("fill",0,0,SCREEN_WIDTH,SCREEN_HEIGHT)
			
			local x, y = self.xx, self.yy

			love.graphics.setBlendMode("add")
			love.graphics.setColor(alpha2,alpha2,alpha2)
			love.graphics.circle("fill", x, y, self.radius, 24)
			love.graphics.setColor(alpha3,alpha3,alpha3)
			love.graphics.circle("fill", x, y, self.radius+20, 24)
			love.graphics.setColor(alpha4,alpha4,alpha4)
			love.graphics.circle("fill", x, y, self.radius+40, 24)
			love.graphics.setStencilTest()
			love.graphics.setBlendMode("alpha")
		end
	end
    Draw.popCanvas(true)
    love.graphics.setBlendMode("alpha", "alphamultiply")
	Draw.drawCanvas(canvas)
end

return Ch3CouchDarkness