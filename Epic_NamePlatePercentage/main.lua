local frame = CreateFrame("Frame", "EpicNamePlatePercentageFrame")
frame:CreateFontString("EpicNamePlatePercentage", "OVERLAY", "GameFontNormalSmall");
frame:RegisterEvent("PLAYER_TARGET_CHANGED");
frame:RegisterEvent("NAME_PLATE_CREATED")
frame:RegisterEvent("NAME_PLATE_UNIT_ADDED");
frame:RegisterEvent("NAME_PLATE_UNIT_REMOVED");
frame:RegisterUnitEvent("UNIT_HEALTH", "target");

frame:HookScript("OnEvent", function(self, event)

	local namePlateTarget = C_NamePlate.GetNamePlateForUnit("target");

	if event == "NAME_PLATE_UNIT_REMOVED" and not namePlateTarget then
		EpicNamePlatePercentage:SetText("");
		return;
	end

	if namePlateTarget ~= nil then
		local percent = (UnitHealth("target") / UnitHealthMax("target")) * 100;
		EpicNamePlatePercentage:SetText(format("%.0f%%", math.ceil(percent)));
		EpicNamePlatePercentage:ClearAllPoints();
		EpicNamePlatePercentage:SetPoint("BOTTOM", namePlateTarget.UnitFrame.healthBar, "RIGHT", -12, -5);
	else
		EpicNamePlatePercentage:SetText("");
	end

end);
