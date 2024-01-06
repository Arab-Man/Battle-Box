--TheNexusAvenger
--Manages getting custom and centralized modules.

local Resources = {}



--Returns a ModuleScript.
function Resources:GetResource(Name)
	return script:WaitForChild(Name)
end

return Resources