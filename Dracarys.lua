local frame = CreateFrame('FRAME')

frame:RegisterEvent('ADDON_LOADED')
frame:RegisterEvent('PLAYER_ENTERING_WORLD')

function frame:OnEvent(event, arg1)
  if event == 'ADDON_LOADED' and arg1 == 'DracarysTextureIndex' then
    if DracarysTextureIndex == nil then
      DracarysTextureIndex = 0
    end
  end

  if event == 'PLAYER_ENTERING_WORLD' then
    Dracarys_ChangePortrait(DracarysTextureIndex)
  end
end

frame:SetScript('OnEvent', frame.OnEvent)

SLASH_DRACARYS1 = '/dracarys'

SlashCmdList['DRACARYS'] = function(msg)
  local i = tonumber(msg)

  if i == nil or i < 0 or i > 3 then
    Dracarys_Help()
    return
  end

  DracarysTextureIndex = i

  Dracarys_PortraitChangedMessage(i)

  Dracarys_ChangePortrait(i)
end

function Dracarys_ChangePortrait(option)
  local i = tonumber(option)

  local textures = {
    [0] = 'Interface\\TargetingFrame\\UI-TargetingFrame.blp',
    [1] = 'Interface\\TargetingFrame\\UI-TargetingFrame-Rare.blp',
    [2] = 'Interface\\TargetingFrame\\UI-TargetingFrame-Rare-Elite.blp',
    [3] = 'Interface\\TargetingFrame\\UI-TargetingFrame-Elite.blp',
  }

  local texture = textures[i]

  PlayerFrameTexture:SetTexture(texture)
end

function Dracarys_PortraitChangedMessage(option)
  local messages = {
    [0] = 'None',
    [1] = 'Rare',
    [2] = 'Rare Elite',
    [3] = 'Elite',
  }

  print('Player portrait set to ' .. messages[option])
end

function Dracarys_Help()
  print('Commands:\n');
  print('/dracarys 1 (Rare)');
  print('/dracarys 2 (Rare Elite)');
  print('/dracarys 3 (Elite)');
  print('/dracarys 0 (None)');
end
