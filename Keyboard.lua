local Keyboard = {}

function Keyboard:keyPressForMoving()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.W, false, game)
    task.wait(3)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.W, false, game)
    task.wait()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.S, false, game)
    task.wait(3)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.S, false, game)
    task.wait()
end

function Keyboard:PressEKey()
    for _, v in game:GetService("Players").LocalPlayer.PlayerGui.InteractionsApp.BasicSelects:GetChildren() do
        if v.Name == "Template" and v.Visible then
            firesignal(v.TapButton.MouseButton1Click)
            break
        end
    end
end

function Keyboard:keyPressForMoving2()
    keypress(0x57)
    task.wait(3)
    keyrelease(0x57)
    task.wait()
    keypress(0x53)
    task.wait(3)
    keyrelease(0x53)
    task.wait()
end

function Keyboard:SetStartPosition()
    local distance = 5

    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    local startPosition = character.HumanoidRootPart.Position

    local pointA = startPosition + Vector3.new(distance, 0, 0)
    local pointB = startPosition - Vector3.new(distance, 0, 0)

    return pointA, pointB
end

function Keyboard:MoveBackAndForth(pointA, pointB)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    -- Move to point A
    humanoid:MoveTo(pointA)
    humanoid.MoveToFinished:Wait()  -- Wait until character reaches point A

    -- Move to point B
    humanoid:MoveTo(pointB)
    humanoid.MoveToFinished:Wait()  -- Wait until character reaches point B
end

return Keyboard

