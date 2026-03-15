-- FIX LAG MOBILE / LOW RAM

-- Giảm đồ họa
settings().Rendering.QualityLevel = 1

-- Tắt hiệu ứng ánh sáng
game.Lighting.GlobalShadows = false
game.Lighting.FogEnd = 9e9
game.Lighting.Brightness = 1

-- Xóa particles / hiệu ứng
for i,v in pairs(game:GetDescendants()) do
    if v:IsA("ParticleEmitter") 
    or v:IsA("Trail") 
    or v:IsA("Smoke") 
    or v:IsA("Fire") then
        v:Destroy()
    end
end

-- Xóa nước / lava
for i,v in pairs(workspace:GetDescendants()) do
    if v:IsA("Terrain") then
        v.WaterWaveSize = 0
        v.WaterWaveSpeed = 0
        v.WaterReflectance = 0
        v.WaterTransparency = 1
    end
end

-- Xóa cây đá nhà nhỏ trang trí
for i,v in pairs(workspace:GetDescendants()) do
    if v:IsA("Model") then
        local name = string.lower(v.Name)
        if string.find(name,"tree") 
        or string.find(name,"rock")
        or string.find(name,"house")
        or string.find(name,"decor") then
            v:Destroy()
        end
    end
end

-- Làm nhạt texture
for i,v in pairs(game:GetDescendants()) do
    if v:IsA("BasePart") then
        v.Material = Enum.Material.Plastic
        v.Reflectance = 0
    end
end

-- Tắt animation
for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
    if v:IsA("Animator") then
        v:Destroy()
    end
end
