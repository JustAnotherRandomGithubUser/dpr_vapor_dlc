local VectorizedSpeechBubble, super = Class(Object)

function VectorizedSpeechBubble:init(text, speaker, x, y)
    super.init(self, x, y)

    self.done = false
    self.speaker = speaker
    self.text = text
    self.wait_timer = 15/30
	self.canvas = love.graphics.newCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
	self.framethreshold = 3
	self.framecount = self.framethreshold
	self.text_scale = 1.5
	self.text_width = 0
	self.text_height = 0
	self:alignText(self.text, self.text_scale)
end

function VectorizedSpeechBubble:onRemove()
    self.canvas:release()
    self.canvas = nil
end

function VectorizedSpeechBubble:setStyle(style) end

function VectorizedSpeechBubble:onRemoveFromStage(stage)
    super.onRemoveFromStage(self, stage)
    if self.speaker and self.speaker.bubble == self then
        self.speaker:onBubbleRemove(self)
        self.speaker.bubble = nil
    end
    self:remove()
    self.advanced = true
end

function VectorizedSpeechBubble:advance()
    if self.wait_timer == 0 then
        self.done = true
        self:remove()
    end
end

function VectorizedSpeechBubble:isTyping()
    return false
end

function VectorizedSpeechBubble:isDone()
    return self.done
end

function VectorizedSpeechBubble:update()
    super.update(self)
    self.wait_timer = MathUtils.approach(self.wait_timer, 0, DT)

    if Input.pressed("confirm") or Input.down("menu") then
        self:advance()
    end
end

function VectorizedSpeechBubble:alignText(text, scale)
	local x, y = self.x, self.y
	local last_text_width = -1
	local current_text_width = 0
	local last_x = x
	local current_x = x
	for i = 1, StringUtils.len(text) do
		local letter = StringUtils.sub(text, i, i)
		if letter == "\n" or letter == "\r" then
			y = y - 8 * scale
			last_x = current_x
			current_x = self.x
			last_text_width = self.text_width
			current_text_width = 0
			self.text_height = self.text_height + 16 * scale
		else
			local data = Mod.vector_letter_data[letter] or nil
			if data then
				current_x = current_x - ((data.width or 5) + 1) * scale
				if current_x <= last_x then
					x = current_x
				end
				current_text_width = current_text_width + ((data.width or 5) + 1) * scale
				if current_text_width >= last_text_width then
					self.text_width = current_text_width
				end
			end
		end
	end
	self.x, self.y = x, y
end

function VectorizedSpeechBubble:drawLetter(letter, x, y, scale, last_x)
	local x, y = x or 0, y or 0
	local last_x = last_x or 0
	if letter == "\n" or letter == "\r" then
		y = y + 16 * scale
		x = last_x
	else
		local data = Mod.vector_letter_data[letter] or nil
		if data then
			if data.line_table then
				local letter_lines = {}
				for _, lines in ipairs(data.line_table) do
					letter_lines = {}
					for i = 1, #lines, 2 do
						table.insert(letter_lines, x + ((lines[i] + MathUtils.random(-0.5, 0.5)) * scale))
						table.insert(letter_lines, y + ((lines[i + 1] + MathUtils.random(-0.5, 0.5)) * scale))
					end
					love.graphics.line(letter_lines)
				end
			end
			x = x + ((data.width or 5) + 1) * scale
		end
	end
	return x, y
end

function VectorizedSpeechBubble:drawBubble()
	local x, y, width, height, spikeheight, scale = self.x, self.y, self.text_width, self.text_height + 16 * self.text_scale, (self.text_height > 0 and 1 or 0.5), self.text_scale
	local bubble_lines = {
		(x - 10) + (MathUtils.random(-0.5, 0.5) * scale),
		(y) + (MathUtils.random(-0.5, 0.5) * scale),
		(x - 7) + (MathUtils.random(-0.5, 0.5) * scale),
		(y - 7) + (MathUtils.random(-0.5, 0.5) * scale),
		(x) + (MathUtils.random(-0.5, 0.5) * scale),
		(y - 10) + (MathUtils.random(-0.5, 0.5) * scale),
		(x + width) + (MathUtils.random(-0.5, 0.5) * scale),
		(y - 10) + (MathUtils.random(-0.5, 0.5) * scale),
		(x + width + 7) + (MathUtils.random(-0.5, 0.5) * scale),
		(y - 7) + (MathUtils.random(-0.5, 0.5) * scale),
		(x + width + 10) + (MathUtils.random(-0.5, 0.5) * scale),
		(y) + (MathUtils.random(-0.5, 0.5) * scale),
		(x + width + 10) + (MathUtils.random(-0.5, 0.5) * scale),
		(y + height / 2 - (10 * spikeheight)) + (MathUtils.random(-0.5, 0.5) * scale),
		(x + width + 20) + (MathUtils.random(-0.5, 0.5) * scale),
		(y + height / 2) + (MathUtils.random(-0.5, 0.5) * scale),
		(x + width + 10) + (MathUtils.random(-0.5, 0.5) * scale),
		(y + height / 2 + (10 * spikeheight)) + (MathUtils.random(-0.5, 0.5) * scale),
		(x + width + 10) + (MathUtils.random(-0.5, 0.5) * scale),
		(y + height) + (MathUtils.random(-0.5, 0.5) * scale),
		(x + width + 7) + (MathUtils.random(-0.5, 0.5) * scale),
		(y + height + 7) + (MathUtils.random(-0.5, 0.5) * scale),
		(x + width) + (MathUtils.random(-0.5, 0.5) * scale),
		(y + height + 10) + (MathUtils.random(-0.5, 0.5) * scale),
		(x) + (MathUtils.random(-0.5, 0.5) * scale),
		(y + height + 10) + (MathUtils.random(-0.5, 0.5) * scale),
		(x - 7) + (MathUtils.random(-0.5, 0.5) * scale),
		(y + height + 7) + (MathUtils.random(-0.5, 0.5) * scale),
		(x - 10) + (MathUtils.random(-0.5, 0.5) * scale),
		(y + height) + (MathUtils.random(-0.5, 0.5) * scale),
		(x - 10) + (MathUtils.random(-0.5, 0.5) * scale),
		(y) + (MathUtils.random(-0.5, 0.5) * scale),
	}
	love.graphics.line(bubble_lines)
end

function VectorizedSpeechBubble:drawText()
	local xoff, yoff = self.x, self.y
	for i = 1, StringUtils.len(self.text) do
		local ch = StringUtils.sub(self.text, i, i)
		xoff, yoff = self:drawLetter(ch, xoff, yoff, self.text_scale, self.x)
	end
end

function VectorizedSpeechBubble:draw()
	self.framecount = self.framecount + DTMULT
	local xx, yy = 0, 0
	if Game.state == "BATTLE" then
		xx = Game.battle.camera.x - SCREEN_WIDTH / 2
		yy = Game.battle.camera.y - SCREEN_HEIGHT / 2
	else
		xx = Game.world.camera.x - SCREEN_WIDTH / 2
		yy = Game.world.camera.y - SCREEN_HEIGHT / 2
	end
	local surfaceupdate = false
	if self.framecount >= self.framethreshold then
		surfaceupdate = true
	end
	if surfaceupdate then
		Draw.pushCanvas(self.canvas)
		love.graphics.clear()
		love.graphics.push()
		love.graphics.origin()
		Draw.setColor(COLORS.white, 1)
		self:drawBubble()
		self:drawText()
		love.graphics.pop()
		Draw.popCanvas()
		self.framecount = 0
	end
	love.graphics.push()
	love.graphics.origin()
	Draw.setColor(1,1,1,1)
	Draw.draw(self.canvas, 0, 0)
	love.graphics.pop()
	Draw.setColor(1,1,1,1)
    super.super.draw(self)
end

return VectorizedSpeechBubble