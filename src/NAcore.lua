-- Author      : watano
-- Create Date : 8/16/2009 7:40:50 PM
NA_IsRunning = false;
NA_IsTest = false;
NA_LogLevel = 3; -- 1 - 5
NA_CurrClass = "DEATHKNIGHT";
NA_CurrTelant = '';
NA_ProfileNo = 0;
NA_Actions = nil;
NA_ClassInfo = nil;
NA_PreviousSpell = nil;
NA_MaxProfile = 3;
NA_IsAOE = false;
NA_IsMaxDps = false;
NA_IsSolo = false;
NA_SpellTimes = {};

--[[
--血条显示K
function HealthBarText(statusFrame, textString, value, valueMin, valueMax) 
   if string.find(textString:GetName(), "Health") or string.find  then 
      if valueMax ~= 0 then 
         local percent = tostring(math.ceil((value / valueMax) * 100)) 
         value = HealthBarText_CapDisplayOfNumericValue(value) 
         valueMax = HealthBarText_CapDisplayOfNumericValue(valueMax) 
         textString:SetText(value.."") 
      end 
   end 
end 

function HealthBarText_CapDisplayOfNumericValue(value) 
   local strLen = strlen(value); 
   local retString = value; 
   if ( strLen > 9 ) then 
      retString = string.sub(value, 1, -9)..SECOND_NUMBER_CAP;                   
   elseif ( strLen > 4 ) then 
      retString = string.sub(value, 1, -4).."K";                                 
   end 
   return retString; 
end
]]--

function NA_init()
	W_SetBinding(0, "NA_Toggle", 3);
	NA_InitProfile(NA_ProfileNo);

	SLASH_NEXTACTIONS1 = "/nextactions"
	SLASH_NEXTACTIONS2 = "/na"
	SlashCmdList["NEXTACTIONS"] = NA_SlashHandler;
end

function NA_initClassData(className, profileNo)
	if(className == "WARRIOR") then
		NA_Actions = getNA1Actions(profileNo);
		NA_CurrTelant = getNA1Telants(profileNo);
		NA_MaxDps = NA1Dps;
	elseif(className == "PALADIN") then
		NA_Actions = getNA2Actions(profileNo);
		NA_CurrTelant = getNA2Telants(profileNo);
		NA_MaxDps = NA2Dps;
	elseif(className == "HUNTER") then
		NA_Actions = getNA3Actions(profileNo);
		NA_CurrTelant = getNA3Telants(profileNo);
		NA_MaxDps = NA3Dps;
	elseif(className == "ROGUE") then
		NA_Actions = getNA4Actions(profileNo);
		NA_CurrTelant = getNA4Telants(profileNo);
		NA_MaxDps = NA4Dps;
	elseif(className == "PRIEST") then
		NA_Actions = getNA5Actions(profileNo);
		NA_CurrTelant = getNA5Telants(profileNo);
		NA_MaxDps = NA5Dps;
	elseif(className == "DEATHKNIGHT") then
		NA_Actions = getNA6Actions(profileNo);
		NA_CurrTelant = getNA6Telants(profileNo);
		NA_MaxDps = NA6Dps;
	elseif(className == "SHAMAN") then
		NA_Actions = getNA7Actions(profileNo);
		NA_CurrTelant = getNA7Telants(profileNo);
		NA_MaxDps = NA7Dps;
	elseif(className == "MAGE") then
		NA_Actions = getNA8Actions(profileNo);
		NA_CurrTelant = getNA8Telants(profileNo);
		NA_MaxDps = NA8Dps;
	elseif(className == "WARLOCK") then
		NA_Actions = getNA9Actions(profileNo);
		NA_CurrTelant = getNA9Telants(profileNo);
		NA_MaxDps = NA9Dps;
	elseif(className == "MONK") then
		NA_Actions = getNA10Actions(profileNo);
		NA_CurrTelant = getNA10Telants(profileNo);
		NA_MaxDps = NA10Dps;
	elseif(className == "DRUID") then
		NA_Actions = getNA11Actions(profileNo);
		NA_CurrTelant = getNA11Telants(profileNo);
		NA_MaxDps = NA11Dps;
	else
		W_Log(4, "不能支持此职业!");
		return nil;
	end
	return {};
end

function NA_InitProfile(no)
	NA_ProfileNo = no;
	if(NA_ProfileNo ~= 0 and NA_ProfileNo ~=1 and NA_ProfileNo ~=2 and NA_ProfileNo ~=3) then NA_ProfileNo = 0; end

	local playerClass, englishClass = UnitClass(NA_Player);
	NA_CurrClass = englishClass;
	W_Log(3, "NA_InitProfile:"..NA_ProfileNo);

	if(NA_initClassData(NA_CurrClass, NA_ProfileNo) == nil) then
		return;
	end

	--initAllInfo(NA_CurrClass, UnitLevel(NA_Player), NA_CurrTelant);

	if(NA_Actions == nil) then
		W_Log(4, "不能支持此配置!");
		return;
	end
	W_UpdateLabelText('NA_SpellLabel', NA_CurrTelant);
	NA_InitClass();
end

function NA_InitClass()
   NA_ClassInfo = {}, {};
	--51:spell1/buff2/item3/marco4, 52:buff/debuff
	W_Log(2, "init NA_ClassInfo");
	W_Log(2, "init NA_Actions");

	local no=0;
	for k,v in pairs(NA_Actions) do
		no = no + 1;
		if(v ~= nil and NA_SpellInfoType(v) == 1) then
			--v = 'Spell_'..v;
		--if(NA_ClassInfo[v] ~= nil and NA_ClassInfo[v].name ~= nil)then
			local name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange;
			name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo(tonumber(v));
			if(name ~= nil) then
				NA_ClassInfo[v] = {};
            NA_ClassInfo[v]['spellID'] = tonumber(v);
				NA_ClassInfo[v]['name'] = name;
				NA_ClassInfo[v]['rank'] = rank;
				NA_ClassInfo[v]['icon'] = icon;
				NA_ClassInfo[v]['cost'] = cost;
				NA_ClassInfo[v]['isFunnel'] = isFunnel;
				NA_ClassInfo[v]['powerType'] = powerType;
				NA_ClassInfo[v]['castTime'] = castTime;
				NA_ClassInfo[v]['minRange'] = minRange;
				NA_ClassInfo[v]['maxRange'] = maxRange;
				W_Log(1,"NA_ClassInfo["..k.."]: ".. name);
				NA_ClassInfo[v]['keyNo'] = no;
				W_SetBinding(no, NA_ClassInfo[v].name, 1);
			else
				W_Log(3,"GetSpellInfo error: ".. k);
			end
		end
	end	
	--W_Log(1, W_toString(NA_ClassInfo))
	if(not W_IsInCombat())then SaveBindings(2); end

	W_Log(2, "NA_InitClass ok!");
end

function NA_Toggle()
	if(NA_IsRunning) then
		NA_IsRunning = false;
		NA_ClearAction();
		W_Log(4,"NextActions stop for "..NA_ProfileNo);
	else
		NA_IsRunning = true;
		W_Log(4,"NextActions start "..NA_ProfileNo);
	end
	return NA_IsRunning;
end

function NA_SlashHandler(msg)
	msg = string.lower(msg);
	if (msg == "options" or msg == "opt") then
		W_Log(4, "TODO options dialog!");
	elseif (msg == "version" or msg == "ver") then
		W_Log(3,"NextActions version: 6.0.2");
	elseif (msg == "toggle") then
		NA_Toggle();
	elseif (msg == "0") then
		NA_InitProfile(0);
	elseif (msg == "1") then
		NA_InitProfile(1);
	elseif (msg == "2") then
		NA_InitProfile(2);
	elseif (msg == "myui") then
		--隐藏主界面的菜单边框装饰物
		MainMenuBarLeftEndCap:Hide();
		MainMenuBarRightEndCap:Hide();
		MainMenuBar:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 0, 0);

		--头像上收到的伤害取消
		local p=PlayerHitIndicator;p.Show=p.Hide;p:Hide()
		--local p=PetHitIndicator;p.Show=p.Hide;p:Hide()

		--血条显示K
		--hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", HealthBarText);
	elseif (msg == "mykey") then
		SetBinding("q","ACTIONBUTTON11");
		SetBinding("e","ACTIONBUTTON12");
		SetBinding("r","ACTIONBUTTON10");
		SetBinding("f","ACTIONBUTTON9");
		SetBinding("BACKSPACE","TOGGLEAUTORUN");
		SetBinding("g","TOGGLEAUTORUN");
		SetBinding("BUTTON4","NONE");
		SetBinding("CTRL-M","NONE");
		SetBinding("CTRL-S","NONE");
		SetBinding("A","STRAFELEFT");
		SetBinding("D","STRAFERIGHT");
		SaveBindings(2);
	else
		W_Log(3,"NextActions commands (/nextactions or /na):");
		--W_Log(3,"/na options (/na opt) - Toggle the options window on or off");
		W_Log(3,"/na version (/na ver) - Shows the current version of NextActions.");
	end
end

function NA_OnEvent(event,...)
	if(event == 'UNIT_SPELLCAST_SUCCEEDED')then
		local unit, spellname, spellrank = ...;
		if(unit == NA_Player)then
			NA_UpdateSpellTime(spellname, spellrank);
		end
	end

	if(NA_IsRunning ~= nil and NA_IsRunning == true and not NA_DoAction()) then
		NA_ClearAction();
	end
end

function NA_UpdateSpellTime(spellname, spellrank)
	for k in pairs(NA_SpellTimes) do
		-- print('NA_UpdateSpellTime===>'..spellname);
		if(NA_ClassInfo[k] ~= nil and NA_ClassInfo[k]['name'] == spellname)then
			NA_SpellTimes[k] = GetTime();
			return;
		end
	end
end

function NA_DoAction()
	if(UnitIsDead(NA_Player) or UnitIsDead(NA_Target) or W_IsCasting(NA_Player) > 0.9
	or W_HasBuff(NA_Player, 1133) or W_HasBuff(NA_Player, 1131) or SpellIsTargeting()
	or IsMounted() or IsFlying() or UnitInVehicle(NA_Player)) then
		W_Log(1,"busy.....");
		return false;
	end
--	if(UnitName(NA_Target) == "艾雷·碎云" and IsMounted()) then
--		Dismount();
--		return false;
--	end --下马
	if(NA_MaxDps())then
		UIErrorsFrame:Clear();
		return true;
	end
	return false;
end

function NA_TestMaxDPS(no)
	local tmpNA_IsTest = NA_IsTest;
	local tmpNA_LogLevel = NA_LogLevel;

	NA_IsTest = true;
	NA_LogLevel = 1;
	NA_InitProfile(no);
	W_Log(1, NA_MaxDps());

	NA_IsTest = tmpNA_IsTest;
	NA_LogLevel = tmpNA_LogLevel;
end


function NA_SpellInfoType(spellID)
	if(spellID == nil)then
		return -1;
	elseif(strlen(spellID) > 7 and strsub(spellID,0,7) == 'NAItem_')then
		return 2;
	elseif(strlen(spellID) > 8 and strsub(spellID,0,8) == 'NAMacro_')then
		return 3;
	elseif(strlen(spellID) > 7 and strsub(spellID,0,7) == 'NABuff_')then
		return 3;
	end
	return 1;
end

function NA_getSpellInfo(spellID)
	return NA_ClassInfo[spellID];
end