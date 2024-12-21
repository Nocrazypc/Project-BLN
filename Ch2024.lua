local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Christmas2024 = {}

function Christmas2024.getGingerbread()
    local GingerbreadMarkers = ReplicatedStorage.Resources.IceSkating.GingerbreadMarkers
    for _, v in GingerbreadMarkers:GetChildren() do
        if v:IsA("BasePart") and not ClientData.get_data()[localPlayer.Name].winter_2024_gingerbread_captured_list[v.Name] then
            ReplicatedStorage.API:FindFirstChild("WinterEventAPI/PickUpGingerbread"):InvokeServer(v.Name)
        end
    end
    ReplicatedStorage.API:FindFirstChild("WinterEventAPI/RedeemPendingGingerbread"):FireServer()
end


return Christmas2024
