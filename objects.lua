-- Location object
cLocation = {}
function cLocation:New(X, Y, Z)
	local object = {
		X = X,
		Y = Y,
		Z = Z
	}
	setmetatable(object, { __index = cLocation })
	return object
end

-- Offsets
cFibers = {}
function cFibers:New()
	local object = {
		cLocation:New(2, -1, 2),
		cLocation:New(2, -1, 1),
		cLocation:New(2, -1, 0),
		cLocation:New(2, -1, -1),
		cLocation:New(2, -1, -2),
		cLocation:New(1, -1, 2),
		cLocation:New(1, -1, 1),
		cLocation:New(1, -1, 0),
		cLocation:New(1, -1, -1),
		cLocation:New(1, -1, -2),
		cLocation:New(0, -1, 2),
		cLocation:New(0, -1, 1),
		cLocation:New(0, -1, 0),
		cLocation:New(0, -1, -1),
		cLocation:New(0, -1, -2),
		cLocation:New(-1, -1, 2),
		cLocation:New(-1, -1, 1),
		cLocation:New(-1, -1, 0),
		cLocation:New(-1, -1, -1),
		cLocation:New(-1, -1, -2),
		cLocation:New(-2, -1, 2),
		cLocation:New(-2, -1, 1),
		cLocation:New(-2, -1, 0),
		cLocation:New(-2, -1, -1),
		cLocation:New(-2, -1, -2),
		imadeit = false
	}
	setmetatable(object, { __index = cFibers })
	return object
end

-- Carpet object
cCarpet = {}
function cCarpet:New()
	local object = {
		Location = cLocation:New(0, 0, 0),
		Fibers = cFibers:New()
	}
	setmetatable(object, { __index = cCarpet })
	return object
end

function cCarpet:Remove()
	for i, fib in ipairs(self.Fibers) do
		local X = self.Location.X + fib.X
		local Y = self.Location.Y + fib.Y
		local Z = self.Location.Z + fib.Z
		local Position = Vector3i(X, Y, Z)
		local BlockID = World:GetBlock(Position)
		if fib.imadeit == true and BlockID == E_BLOCK_GLASS then
			World:SetBlock(Position, E_BLOCK_AIR, 0)
			fib.imadeit = false
		end
	end
end

function cCarpet:Draw()
	for i, fib in ipairs(self.Fibers) do
		local X = self.Location.X + fib.X
		local Y = self.Location.Y + fib.Y
		local Z = self.Location.Z + fib.Z
		local Position = Vector3i(X, Y, Z)
		local BlockID = World:GetBlock(Position)
		if BlockID == E_BLOCK_AIR then
			World:SetBlock(Position, E_BLOCK_GLASS, 0)
			fib.imadeit = true
		else
			fib.imadeit = false
		end
	end
end

function cCarpet:MoveTo(NewPos)
	self:Remove()
	self.Location = cLocation:New(math.floor(NewPos.X), math.floor(NewPos.Y), math.floor(NewPos.Z))
	self:Draw()
end

function cCarpet:GetPosY()
	return self.Location.Y
end
