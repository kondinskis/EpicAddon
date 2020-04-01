function GetPlayerLocation()
	local mapID = C_Map.GetBestMapForUnit("player")
	if mapID == nil then
		return "N/A"
	end

	local position = C_Map.GetPlayerMapPosition(mapID, "player")
	if position == nil then
		return "N/A"
	end

	posX, posY = position:GetXY();
	return format("(%.d, %.d)", posX * 100, posY * 100);
end

function GetCursorLocation()
	local posX, posY = 0, 0;

	if WorldMapFrame:IsMaximized() then
		posX, posY = WorldMapFrame:GetNormalizedCursorPosition();
	else
		posX, posY = WorldMapFrame.ScrollContainer:GetNormalizedCursorPosition();
	end

	return format("(%.d, %.d)", posX * 100, posY * 100);
end

function Init()
	local frame = CreateFrame("Frame", "EpicLocationFrame", WorldMapFrame.BorderFrame)
	frame:CreateFontString("EpicLocationPlayer", "ARTWORK", "GameFontNormal");
	frame:CreateFontString("EpicLocationCursor", "ARTWORK", "GameFontNormal");
	frame:HookScript("OnUpdate", OnUpdate);
end

function OnUpdate(self, elapsed)
	EpicLocationPlayer:SetText(GetPlayerLocation());
	EpicLocationCursor:SetText(GetCursorLocation());

	EpicLocationPlayer:ClearAllPoints()
	EpicLocationCursor:ClearAllPoints()

	if WorldMapFrame:IsMaximized() then
		EpicLocationPlayer:SetPoint("TOPRIGHT", WorldMapFrame, "TOPRIGHT", -10, -28)
		EpicLocationCursor:SetPoint("TOPRIGHT", WorldMapFrame, "TOPRIGHT", -10, -43)
	else
		EpicLocationPlayer:SetPoint("TOPRIGHT", WorldMapFrame, "TOPRIGHT", -50, -6)
		EpicLocationCursor:SetPoint("TOPLEFT", WorldMapFrame, "TOPLEFT", 95, -6)
	end
end

local initialized = false;
WorldMapFrame:HookScript("OnShow", function(self)
	if not initialized then
		initialized = true;
		Init();
	end
end);
