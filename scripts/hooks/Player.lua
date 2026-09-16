local Player, super = HookSystem.hookScript(Player)

function Player:init(chara, x, y)
    super.init(self, chara, x, y)
	self.shadow_shader = Assets.newShader("shadowblend")
end

function Player:draw()
    self.state_manager:call("drawUnderPlayer")

    local r, g, b, a = self:getColor()
    local use_alpha = a

    if self.state == "CLIMB" and Game.world.soul and Game.inv_frames > 0 then
        use_alpha = a * 0.5
    end

    self:setColor(r, g, b, use_alpha)

    -- Draw the player
    super.draw(self)

	local sunshadows = Game.stage:getObjects(SunShadows)[1]
	if sunshadows and self.state ~= "CLIMB" then
		local last_shader = love.graphics.getShader()
		local shadow_col = sunshadows.colour_shadowblend
		shadow_col[4] = sunshadows.alpha_shadowblend
		self.shadow_shader:sendColor("shadowCol", shadow_col)
		love.graphics.setShader(self.shadow_shader)
		super.draw(self) -- Draw player self shadow
		love.graphics.setShader(last_shader)
	end
	
    self:setColor(r, g, b, a)

    self.state_manager:call("drawOverPlayer")

    if DEBUG_RENDER then
        self.state_manager:call("drawDebug")
    end
end

return Player