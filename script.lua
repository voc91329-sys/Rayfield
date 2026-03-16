-- Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Tool + Booster",
   LoadingTitle = "Spirit GUI",
   LoadingSubtitle = "by You",
   ConfigurationSaving = {
      Enabled = false
   }
})

local Tab = Window:CreateTab("Main",4483362458)

local player = game.Players.LocalPlayer

-- XÓA TOOL ĐANG CẦM
Tab:CreateButton({
   Name = "Xóa Tool Đang Cầm",
   Callback = function()
      local char = player.Character
      if char then
         local tool = char:FindFirstChildOfClass("Tool")
         if tool then
            tool:Destroy()
         end
      end
   end,
})

-- XÓA TẤT CẢ TOOL
Tab:CreateButton({
   Name = "Xóa Tất Cả Tool",
   Callback = function()
      local char = player.Character
      if char then
         for _,v in pairs(char:GetChildren()) do
            if v:IsA("Tool") then
               v:Destroy()
            end
         end
      end

      for _,v in pairs(player.Backpack:GetChildren()) do
         if v:IsA("Tool") then
            v:Destroy()
         end
      end
   end,
})

-- GAME BOOSTER
Tab:CreateButton({
   Name = "Game Booster (Anti Lag)",
   Callback = function()

      -- giảm đồ họa 40%
      settings().Rendering.QualityLevel = Enum.QualityLevel.Level04

      game.Lighting.GlobalShadows = false
      game.Lighting.FogEnd = 100000

      for _,v in pairs(game:GetDescendants()) do

         -- xóa cây đá
         if v.Name:lower():find("tree") 
         or v.Name:lower():find("rock") then
            if v:IsA("Model") or v:IsA("Part") then
               v:Destroy()
            end
         end

         -- xóa nước lava
         if v:IsA("Terrain") then
            v.WaterWaveSize = 0
            v.WaterWaveSpeed = 0
            v.WaterReflectance = 0
            v.WaterTransparency = 1
         end

         -- xóa hiệu ứng 80%
         if v:IsA("ParticleEmitter")
         or v:IsA("Trail")
         or v:IsA("Smoke")
         or v:IsA("Fire")
         or v:IsA("Sparkles")
         or v:IsA("Explosion") then
            v.Enabled = false
         end

         -- giảm chuyển động 80%
         if v:IsA("BasePart") then
            v.Material = Enum.Material.Plastic
            v.Reflectance = 0
         end

      end

   end,
})

-- NOCLIP
Tab:CreateToggle({
   Name = "Noclip",
   CurrentValue = false,
   Callback = function(Value)

      noclip = Value
      game:GetService("RunService").Stepped:Connect(function()
         if noclip and player.Character then
            for _,v in pairs(player.Character:GetDescendants()) do
               if v:IsA("BasePart") then
                  v.CanCollide = false
               end
            end
         end
      end)

   end,
})

-- FLY
Tab:CreateToggle({
   Name = "Fly",
   CurrentValue = false,
   Callback = function(Value)

      local char = player.Character
      if char then
         local hrp = char:WaitForChild("HumanoidRootPart")

         if Value then
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(100000,100000,100000)
            bv.Velocity = Vector3.new(0,50,0)
            bv.Parent = hrp
         else
            if hrp:FindFirstChildOfClass("BodyVelocity") then
               hrp:FindFirstChildOfClass("BodyVelocity"):Destroy()
            end
         end
      end

   end,
})
