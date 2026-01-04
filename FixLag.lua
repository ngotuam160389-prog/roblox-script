-- ===== LOAD SCRIPT GỐC =====
loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/wh0asked1/Script-Holder_wh0/refs/heads/main/TSBG-FIXLAGS",
    true
))()

Remove_Grass = true
Remove_Trees = true
Remove_Walls = true

loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/louismich4el/ItsLouisPlayz-Scripts/refs/heads/main/Anti%20Lag%20V2.lua"
))()

-- ===== THÊM XÓA KHÓI / HIỆU ỨNG SKILL =====
Remove_Skill_Smoke = true

local function DisableSmoke(v)
	if v:IsA("ParticleEmitter") then
		v.Enabled = false
		v.Rate = 0
		v.Lifetime = NumberRange.new(0)
	elseif v:IsA("Smoke") or v:IsA("Fire") then
		v.Enabled = false
	end
end

if Remove_Skill_Smoke then
	-- Xóa khói đã có
	for _, v in pairs(workspace:GetDescendants()) do
		DisableSmoke(v)
	end

	-- Khóa khói mới sinh ra (skill)
	workspace.DescendantAdded:Connect(function(v)
		task.wait()
		DisableSmoke(v)
	end)
end
