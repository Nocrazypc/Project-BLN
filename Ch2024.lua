local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Christmas2024 = {}

function Christmas2024.getGingerbread()
    local GingerbreadMarkers = ReplicatedStorage.Resources.IceSkating.GingerbreadMarkers
    for _, v in GingerbreadMarkers:GetChildren() do
        if v:IsA("BasePart") then
            ReplicatedStorage.API:FindFirstChild("WinterEventAPI/PickUpGingerbread"):InvokeServer(v.Name)
            task.wait()
        end
    end
    task.wait(1)
    ReplicatedStorage.API:FindFirstChild("WinterEventAPI/RedeemPendingGingerbread"):FireServer()
end


return Christmas2024