local Carpets = {}

function Initialize(Plugin)
	Plugin:SetName(g_PluginInfo.Name)
	Plugin:SetVersion(g_PluginInfo.Version)

	cPluginManager:AddHook(cPluginManager.HOOK_ENTITY_CHANGING_WORLD, OnEntityChangingWorld)
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_DESTROYED, OnPlayerDestroyed)
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_MOVING, OnPlayerMoving)

	dofile(cPluginManager:GetPluginsPath() .. "/InfoReg.lua")
	RegisterPluginInfoCommands()
	
	LOG("Initialised!")
	return true
end

function HandleMagicCarpetCommand(Split, Player)
	local Carpet = Carpets[Player:GetUUID()]
	World = Player:GetWorld()
	if Carpet == nil then
		Carpets[Player:GetUUID()] = cCarpet:New()
		Player:SendMessageSuccess("You're on a magic carpet!")
		Player:SendMessageInfo("Look straight down to descend. Jump to ascend.")
	else
		Carpet:Remove()
		Carpets[Player:GetUUID()] = nil
		Player:SendMessageSuccess("The carpet vanished!")
	end
	return true
end

function OnEntityChangingWorld(Entity, NewWorld)
	local Carpet = Carpets[Entity:GetUUID()]
	if Carpet and Entity:IsPlayer() then
		World = Entity:GetWorld()
		Carpet:Remove()
		World = NewWorld
		Carpet = cCarpet:New()
	end
end

function OnPlayerDestroyed(Player)
	local Carpet = Carpets[Player:GetUUID()]
	if Carpet then
		World = Player:GetWorld()
		Carpet:Remove()
		Carpets[Player:GetUUID()] = nil
	end
end

function OnPlayerMoving(Player)
	local X = Player:GetPosX()
	local Y = Player:GetPosY()
	local Z = Player:GetPosZ()
	local Carpet = Carpets[Player:GetUUID()]
	if Carpet then
		if Player:GetPitch() == 90 then
			Carpet:MoveTo(cLocation:New(X, Y - 1, Z))
		else
			if Y < Carpet:GetPosY() then
				Player:TeleportToCoords(X, Y + 1, Z)
			end
			Carpet:MoveTo(cLocation:New(X, Y, Z))
		end
	end
end

function OnDisable()
	LOG("Disabling...")
	for i, Carpet in pairs(Carpets) do
		Carpet:Remove()
	end
end
