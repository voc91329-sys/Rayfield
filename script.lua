-- FIX LAG ULTRA SAFE MAX (GIỮ NGUYÊN MAP, XÓA VẬT PHỤ + HIỆU ỨNG)
-- by ChatGPT

getgenv().FixLagUltraSafeMax = function()
    local Workspace = game:GetService("Workspace")
    local Lighting = game:GetService("Lighting")

    -- ===== 1. Xóa ~200 hiệu ứng =====
    for _,v in ipairs(game:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire")
        or v:IsA("Sparkles") or v:IsA("Beam") or v:IsA("Highlight") or v:IsA("ForceField")
        or v:IsA("Explosion") or v:IsA("SpecialMesh") or v:IsA("MeshPart") or v:IsA("UnionOperation")
        or v:IsA("WedgePart") or v:IsA("CornerWedgePart") or v:IsA("Decal") or v:IsA("Texture")
        or v:IsA("PointLight") or v:IsA("SpotLight") or v:IsA("SurfaceLight")
        or v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("SunRaysEffect")
        or v:IsA("ColorCorrectionEffect") or v:IsA("DepthOfFieldEffect") then
            pcall(function() v:Destroy() end)
        end
    end

    -- ===== 2. Xóa vật phụ nhưng giữ nền đảo =====
    for _,v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            -- Nếu Parent là map chính / kap / nền → giữ lại
            if v.Parent.Name:lower():find("map") or v.Parent.Name:lower():find("island") then
                -- giữ nền
            else
                local name = v.Name:lower()
                if name:find("tree") or name:find("leaf") or name:find("grass") or name:find("wood")
                or name:find("rock") or name:find("stone") or name:find("metal") or name:find("iron")
                or name:find("glass") or name:find("brick") or name:find("cobble") then
                    pcall(function() v:Destroy() end)
                end
            end
        end
        if v:IsA("Model") then
            pcall(function() v:Destroy() end)
        end
    end

    -- ===== 3. Vật liệu + độ họa cực khô =====
    for _,v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.Plastic
            v.CastShadow = false
            v.Reflectance = 0
            v.Transparency = 0
        end
    end

    -- ===== 4. Tắt đồ họa =====
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    end)

    -- ===== 5. Tắt ánh sáng cực khô =====
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.Brightness = 0
    Lighting.ExposureCompensation = 0
    Lighting.OutdoorAmbient = Color3.fromRGB(0,0,0)
    Lighting.Technology = Enum.Technology.Compatibility

    for _,v in ipairs(Lighting:GetDescendants()) do
        if v:IsA("Sky") or v:IsA("BloomEffect") or v:IsA("BlurEffect")
        or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("DepthOfFieldEffect") then
            pcall(function() v:Destroy() end)
        end
    end

    -- ===== 6. Tắt nước =====
    local terrain = Workspace:FindFirstChildOfClass("Terrain")
    if terrain then
        pcall(function()
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
            terrain.WaterReflectance = 0
            terrain.WaterTransparency = 1
        end)
    end
end

-- Chạy ngay
getgenv().FixLagUltraSafeMax()
