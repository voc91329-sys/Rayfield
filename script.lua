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

-- MEDKIT
local debounce = false
Tab:CreateButton({
   Name = "Medkit",
   Callback = function()

      if debounce then return end
      debounce = true

      game:GetService("ReplicatedStorage").Remotes.GetMedkit:FireServer()

      task.wait(0.5)
      debounce = false

   end,
})

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
