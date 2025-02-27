CreateThread(function()
	while true do
		if IsPedArmed(cache.ped, 4) ~= false then
			if IsPedShooting(cache.ped) and not IsPedDoingDriveby(cache.ped) then
				local _, wep = GetCurrentPedWeapon(cache.ped)
				_, cAmmo = GetAmmoInClip(cache.ped, wep)
				if Config.recoils[wep] and Config.recoils[wep] ~= 0 then
					local tv = 0
					if GetFollowPedCamViewMode() ~= 4 then
						repeat
							Wait(0)
							local p = GetGameplayCamRelativePitch()
							SetGameplayCamRelativePitch(p + 0.1, 0.2)
							tv += 0.1
						until tv >= Config.recoils[wep]
					else
						repeat
							Wait(0)
							local p = GetGameplayCamRelativePitch()
							if Config.recoils[wep] > 0.1 then
								SetGameplayCamRelativePitch(p + 0.6, 1.2)
								tv += 0.6
							else
								SetGameplayCamRelativePitch(p + 0.016, 0.333)
								tv += 0.1
							end
						until tv >= Config.recoils[wep]
					end
				end
			end
		else
			Wait(100)
		end
		Wait(10)
	end
end)

--Spread system
CreateThread(function()
	while true do
		if IsPedArmed(cache.ped, 4) ~= false then
			local ped = PlayerPedId()
			if IsPedShooting(cache.ped) and not IsPedDoingDriveby(cache.ped) then
				local _, wep = GetCurrentPedWeapon(cache.ped)
				_, cAmmo = GetAmmoInClip(cache.ped, wep)
				if Config.recoils[wep] and Config.recoils[wep] ~= 0 then
					local tv = 0
					local spread = math.random() * 1 * math.pi
					local radius = math.sqrt(math.random()) * Config.maxspread
					local xSpread = radius * math.cos(spread)
					local ySpread = radius * math.sin(spread)
					if GetFollowPedCamViewMode() ~= 4 then
						repeat
							Wait(0)
							local p = GetGameplayCamRelativePitch()
							SetGameplayCamRelativePitch(p + 0.1, 0.2)
							tv = tv + 0.1
						until tv >= Config.recoils[wep]
					else
						repeat
							Wait(0)
							local p = GetGameplayCamRelativePitch()
							if Config.recoils[wep] > 0.1 then
								SetGameplayCamRelativePitch(p + 0.6, 1.2)
								tv = tv + 0.6
							else
								SetGameplayCamRelativePitch(p + 0.016, 0.333)
								tv = tv + 0.1
							end
						until tv >= Config.recoils[wep]
					end
					SetGameplayCamRelativeHeading(GetGameplayCamRelativeHeading() + xSpread) -- add x and y spread values to camera heading and pitch
					SetGameplayCamRelativePitch(GetGameplayCamRelativePitch() + ySpread, 1.0)
				end
			end
		else
			Wait(10)
		end
		Wait(10)
	end
end)
