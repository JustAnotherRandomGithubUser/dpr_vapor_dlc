function Mod:init()
    print("Loaded "..self.info.name.."!")
	Mod:setupVectorLetterData()
end

function Mod:postInit()
	Game:setFlag("vaporMainAreaMusicTime", 0)
	Game:setFlag("vaporSubAreaMusicTime", 0)
end

function Mod:setupVectorLetterData()
	Mod.vector_letter_data = {}
	Mod.vector_letter_data[" "] = {line_table = nil, width = 5}
	Mod.vector_letter_data["A"] = {line_table = {{0,10,0,2,2,0,4,2,4,10}, {0,5,4,5}}, width = 5}
	Mod.vector_letter_data["B"] = {line_table = {{3,5,4,4,4,0,0,0,0,10,4,10,4,6,3,5}, {0,5,3,5}}, width = 5}
	Mod.vector_letter_data["C"] = {line_table = {{4,8,4,10,0,10,0,0,4,0,4,2}}, width = 5}
	Mod.vector_letter_data["D"] = {line_table = {{0,10,0,0,3,0,4,1,4,9,3,10,0,10}}, width = 5}
	Mod.vector_letter_data["E"] = {line_table = {{4,10,0,10,0,0,4,0}, {0,5,3,5}}, width = 5}
	Mod.vector_letter_data["F"] = {line_table = {{0,10,0,0,4,0}, {0,5,3,5}}, width = 5}
	Mod.vector_letter_data["G"] = {line_table = {{4,0,0,0,0,10,4,10,4,5,3,5}}, width = 5}
	Mod.vector_letter_data["H"] = {line_table = {{0,0,0,10}, {0,5,4,5}, {4,0,4,10}}, width = 5}
	Mod.vector_letter_data["I"] = {line_table = {{0,0,4,0}, {2,0,2,10}, {0,10,4,10}}, width = 5}
	Mod.vector_letter_data["J"] = {line_table = {{4,0,4,10,0,10,0,8}}, width = 5}
	Mod.vector_letter_data["K"] = {line_table = {{0,0,0,10}, {4,0,4,3,2,5,0,5}, {4,10,4,7,2,5,0,5}}, width = 5}
	Mod.vector_letter_data["L"] = {line_table = {{0,0,0,10,4,10}}, width = 5}
	Mod.vector_letter_data["M"] = {line_table = {{0,10,0,0,3,3,6,0,6,10}}, width = 7}
	Mod.vector_letter_data["N"] = {line_table = {{0,10,0,0,4,10,4,0}}, width = 5}
	Mod.vector_letter_data["O"] = {line_table = {{0,0,0,10,4,10,4,0,0,0}}, width = 5}
	Mod.vector_letter_data["P"] = {line_table = {{0,10,0,0,4,0,4,5,0,5}}, width = 5}
	Mod.vector_letter_data["Q"] = {line_table = {{0,0,0,10,4,8,2,10,0,0}, {2,8,4,10}}, width = 5}
	Mod.vector_letter_data["R"] = {line_table = {{0,10,0,0,4,0,4,5,0,5}, {1,5,4,8,4,10}}, width = 5}
	Mod.vector_letter_data["S"] = {line_table = {{0,10,4,10,4,5,0,5,0,0,4,0}}, width = 5}
	Mod.vector_letter_data["T"] = {line_table = {{0,0,4,0}, {0,2,10,2}}, width = 5}
	Mod.vector_letter_data["U"] = {line_table = {{0,0,0,10,4,10,4,0}}, width = 5}
	Mod.vector_letter_data["V"] = {line_table = {{0,0,0,8,2,10,4,8,4,0}}, width = 5}
	Mod.vector_letter_data["W"] = {line_table = {{0,0,0,10,3,7,6,10,6,0}}, width = 7}
	Mod.vector_letter_data["X"] = {line_table = {{0,0,4,10}, {0,10,4,0}}, width = 5}
	Mod.vector_letter_data["Y"] = {line_table = {{0,0,2,5,4,0}, {2,5,2,10}}, width = 5}
	Mod.vector_letter_data["Z"] = {line_table = {{0,0,4,0,0,10,4,10}}, width = 5}
	Mod.vector_letter_data["a"] = {line_table = {{5,10,0,10,0,5,4,5,4,3,0,3}, {4,5,4,10}}, width = 5}
	Mod.vector_letter_data["b"] = {line_table = {{0,0,0,5,4,5,4,10,0,10,0,5}}, width = 5}
	Mod.vector_letter_data["c"] = {line_table = {{4,9,4,10,0,10,0,5,4,5,4,6}}, width = 5}
	Mod.vector_letter_data["d"] = {line_table = {{4,0,4,5,0,5,0,10,4,10,4,5}}, width = 5}
	Mod.vector_letter_data["e"] = {line_table = {{4,10,0,10,0,8,4,8,4,5,0,5,0,8}}, width = 5}
	Mod.vector_letter_data["f"] = {line_table = {{2,10,2,0,5,0}, {0,5,4,5}}, width = 6}
	Mod.vector_letter_data["g"] = {line_table = {{0,13,4,13,4,10,0,10,0,5,4,5,4,10}}, width = 5}
	Mod.vector_letter_data["h"] = {line_table = {{0,10,0,0}, {0,5,4,5,4,10}}, width = 5}
	Mod.vector_letter_data["i"] = {line_table = {{0,5,0,10}, {0,0,0,2}}, width = 1}
	Mod.vector_letter_data["j"] = {line_table = {{3,5,3,13,0,13,0,11}, {3,0,3,2}}, width = 4}
	Mod.vector_letter_data["k"] = {line_table = {{0,0,0,10}, {4,4,4,5,2,7,0,7}, {4,10,4,9,2,7,0,7}}, width = 5}
	Mod.vector_letter_data["l"] = {line_table = {{0,0,0,10,2,10}}, width = 3}
	Mod.vector_letter_data["m"] = {line_table = {{0,10,0,5,4,5,4,10}, {2,10,2,5}}, width = 5}
	Mod.vector_letter_data["n"] = {line_table = {{0,10,0,5,4,5,4,10}}, width = 5}
	Mod.vector_letter_data["o"] = {line_table = {{0,10,0,5,4,5,4,10,0,10}}, width = 5}
	Mod.vector_letter_data["p"] = {line_table = {{0,13,0,10,0,5,4,5,4,10,0,10}}, width = 5}
	Mod.vector_letter_data["q"] = {line_table = {{4,13,4,10,4,5,0,5,0,10,4,10}}, width = 5}
	Mod.vector_letter_data["r"] = {line_table = {{0,10,0,5,3,5}}, width = 4}
	Mod.vector_letter_data["s"] = {line_table = {{0,10,4,10,4,7,0,7,0,5,4,5}}, width = 5}
	Mod.vector_letter_data["t"] = {line_table = {{2,0,2,10,4,10}, {0,5,4,5}}, width = 5}
	Mod.vector_letter_data["u"] = {line_table = {{0,5,0,10,4,10,4,5}}, width = 5}
	Mod.vector_letter_data["v"] = {line_table = {{0,5,2,10,4,5}}, width = 5}
	Mod.vector_letter_data["w"] = {line_table = {{0,5,0,10,4,10,4,5}, {2,10,2,5}}, width = 5}
	Mod.vector_letter_data["x"] = {line_table = {{0,10,5,5}, {0,5,5,10}}, width = 6}
	Mod.vector_letter_data["y"] = {line_table = {{0,5,0,10,4,10,4,5}, {0,13,4,13,4,10}}, width = 5}
	Mod.vector_letter_data["z"] = {line_table = {{0,5,4,5,0,10,4,10}}, width = 5}
	Mod.vector_letter_data["0"] = {line_table = {{0,0,0,10,4,10,4,0,0,0}, {0,7,4,3}}, width = 5}
	Mod.vector_letter_data["1"] = {line_table = {{0,0,2,0,2,10}}, width = 5}
	Mod.vector_letter_data["2"] = {line_table = {{0,0,4,0,4,3,0,3,0,10,4,10}}, width = 5}
	Mod.vector_letter_data["3"] = {line_table = {{0,0,4,0,4,10,0,10}, {0,5,4,5}}, width = 5}
	Mod.vector_letter_data["4"] = {line_table = {{0,0,0,5,5,5}, {4,0,4,10}}, width = 6}
	Mod.vector_letter_data["5"] = {line_table = {{4,0,0,0,0,3,4,3,4,10,0,10}}, width = 5}
	Mod.vector_letter_data["6"] = {line_table = {{4,0,0,0,0,3,4,3,4,10,0,10,0,3}}, width = 5}
	Mod.vector_letter_data["7"] = {line_table = {{0,0,4,0,4,10}}, width = 5}
	Mod.vector_letter_data["8"] = {line_table = {{0,0,0,10,4,10,4,0,0,0}, {0,5,4,5}}, width = 5}
	Mod.vector_letter_data["9"] = {line_table = {{0,10,4,10,4,7,4,0,0,0,0,7,4,7}}, width = 5}
	Mod.vector_letter_data["!"] = {line_table = {{0,10,0,8}, {0,0,0,5}}, width = 1}
	Mod.vector_letter_data["?"] = {line_table = {{2,10,2,8}, {2,5,2,4,4,4,4,0,0,0,0,2}}, width = 5}
	Mod.vector_letter_data["."] = {line_table = {{0,10,0,8}}, width = 1}
	Mod.vector_letter_data[","] = {line_table = {{1,8,1,10,0,11}}, width = 2}
	Mod.vector_letter_data[":"] = {line_table = {{0,8,0,6}, {0,1,0,3}}, width = 1}
	Mod.vector_letter_data[";"] = {line_table = {{1,6,1,8,0,9}, {1,1,1,3}}, width = 2}
	Mod.vector_letter_data["'"] = {line_table = {{0,0,0,2}}, width = 1}
end

function Mod:onFootstep(char, num)
    if Game.world.map.use_footstep_sounds and char == Game.world.player then
        if num == 1 then
            Assets.playSound("step1")
        elseif num == 2 then
            Assets.playSound("step2")
        end
    end
end