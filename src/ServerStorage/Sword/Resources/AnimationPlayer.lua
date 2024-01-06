--TheNexusAvenger
--Centralizes storing and playing animations.
--Unless non-Roblox animations become public, the R15 animations will not work.

local ASSET_URL = "http://www.roblox.com/asset?id="



local Animationids
Animationids = {
	--Bomb
	["BombHold"] = {
		[Enum.HumanoidRigType.R6] = ASSET_URL.."94861246",
		[Enum.HumanoidRigType.R15] = ASSET_URL.."2016146879",
	},
	["BombThrow"] = {
		[Enum.HumanoidRigType.R6] = ASSET_URL.."94861252",
		[Enum.HumanoidRigType.R15] = ASSET_URL.."2016149562",
	},
	
	--Broom
	["BroomIdle"] = {
		[Enum.HumanoidRigType.R6] = ASSET_URL.."101074752",
		[Enum.HumanoidRigType.R15] = ASSET_URL.."2016194803",
	},
	["BroomWhack"] = {
		[Enum.HumanoidRigType.R6] = ASSET_URL.."101078539",
		[Enum.HumanoidRigType.R15] = ASSET_URL.."2016197675",
	},
	
	--Reflector
	["ReflectorActivate"] = {
		[Enum.HumanoidRigType.R6] = ASSET_URL.."94190213",
		[Enum.HumanoidRigType.R15] = ASSET_URL.."2016204897",
	},
	
	--Rocket Launcher
	["RocketLauncherFireAndReload"] = {
		[Enum.HumanoidRigType.R6] = ASSET_URL.."94771598",
		[Enum.HumanoidRigType.R15] = ASSET_URL.."1937739969"
	},
	
	--Slingshot
	["SlingshotEquip"] = {
		[Enum.HumanoidRigType.R6] = ASSET_URL.."94123357",
		[Enum.HumanoidRigType.R15] = ASSET_URL.."2016224711",
	},
	["SlingshotShoot"] = {
		[Enum.HumanoidRigType.R6] = ASSET_URL.."94126022",
		[Enum.HumanoidRigType.R15] = ASSET_URL.."2016213090",
	},
	
	--Superball
	["SuperballEquip"] = {
		[Enum.HumanoidRigType.R6] = ASSET_URL.."94156535",
		[Enum.HumanoidRigType.R15] = ASSET_URL.."2016244952",
	},
	["SuperballUnequip"] = {
		[Enum.HumanoidRigType.R6] = ASSET_URL.."94156580",
		--Unused
	},
	["SuperballIdle"] = {
		[Enum.HumanoidRigType.R6] = ASSET_URL.."94156486",
		[Enum.HumanoidRigType.R15] = ASSET_URL.."2016239591",
	},
	["SuperballThrow"] = {
		[Enum.HumanoidRigType.R6] = ASSET_URL.."94157627",
		[Enum.HumanoidRigType.R15] = ASSET_URL.."2016242911",
	},
	
	--Sword
	["SwordEquip"] = {
		[Enum.HumanoidRigType.R15] = ASSET_URL.."2994083974",
	},
	["SwordUnequip"] = {
		[Enum.HumanoidRigType.R15] = ASSET_URL.."2994087214",
	},
	["SwordIdle"] = {
		[Enum.HumanoidRigType.R15] = ASSET_URL.."2994084692",
	},
	["SwordSlash"] = {
		[Enum.HumanoidRigType.R15] = ASSET_URL.."2994086066",
	},
	["SwordThrust"] = {
		[Enum.HumanoidRigType.R15] = ASSET_URL.."2994086696",
	},
	["SwordOverhead"] = {
		[Enum.HumanoidRigType.R15] = ASSET_URL.."2994085548",
	},
	
	--Lobby Flag
	["FlagPlant"] = {
		[Enum.HumanoidRigType.R6] = ASSET_URL.."74897796",
		[Enum.HumanoidRigType.R15] = ASSET_URL.."2016269660",
	}
}

local AnimationSettings = {
	--Bomb
	["BombHold"] = {
		FadeTime = 0,
		Weight = 1,
		Speed = 2,
	},
	
	--Broom
	["BroomWhack"] = {
		FadeTime = 0,
		Weight = 1,
		Speed = 10, --Should be BROOM_WHACK_SPEED
	},
	
	--Reflector
	["ReflectorActivate"] = {
		FadeTime = 0.1,
		Weight = 1,
		Speed = 6,
	},
	
	--Rocket Launcher
	["RocketLauncherFireAndReload"] = {
		FadeTime = 0.1,
		Weight = 1,
		Speed = 1.5,
	},
	
	--Lobby Flag
	["FlagPlant"] = {
		Speed = 0.5,
	}
}



local AnimationPlayer = {}

local Tool = script.Parent.Parent

--Returns an animation class for the given id.
local AnimationCache = {}
local function GetAnimation(AnimationId)
	if not AnimationCache[AnimationId] then
		local Animation = Instance.new("Animation")
		Animation.AnimationId = AnimationId
		AnimationCache[AnimationId] = Animation
	end
	
	return AnimationCache[AnimationId]
end

--Players the animation by name for the tool holder.
function AnimationPlayer:PlayAnimation(AnimationName)
	local Character = Tool.Parent
	if Character then
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		if Humanoid then
			local AnimationGroup = Animationids[AnimationName]
			if AnimationGroup then
				local Animationid = AnimationGroup[Humanoid.RigType]
				if Animationid then
					local LoadedAnimation = Humanoid:LoadAnimation(GetAnimation(Animationid))
					local AnimationData = AnimationSettings[AnimationName] or {}
					LoadedAnimation:Play(AnimationData.FadeTime,AnimationData.Weight,AnimationData.Speed)
					
					return LoadedAnimation
				end
			else
				warn("Missing animation name: "..tostring(AnimationName))
			end
		end
	end
end

return AnimationPlayer