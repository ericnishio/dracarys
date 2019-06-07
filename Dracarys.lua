local frame = CreateFrame('FRAME')

frame:RegisterEvent('ADDON_LOADED')
frame:RegisterEvent('PLAYER_ENTERING_WORLD')

local DEFAULT = 0
local RARE = 1
local RARE_ELITE = 2
local ELITE = 3

local INDEX_TO_TEXTURE_MAP = {
  [DEFAULT] = 'Interface\\TargetingFrame\\UI-TargetingFrame.blp',
  [RARE] = 'Interface\\TargetingFrame\\UI-TargetingFrame-Rare.blp',
  [RARE_ELITE] = 'Interface\\TargetingFrame\\UI-TargetingFrame-Rare-Elite.blp',
  [ELITE] = 'Interface\\TargetingFrame\\UI-TargetingFrame-Elite.blp',
}

local INDEX_TO_LABEL_MAP = {
  [DEFAULT] = 'Default',
  [RARE] = 'Rare',
  [RARE_ELITE] = 'Rare Elite',
  [ELITE] = 'Elite',
}

function frame:OnEvent(event, arg1)
  if event == 'ADDON_LOADED' and arg1 == 'DracarysTextureIndex' then
    if DracarysTextureIndex == nil then
      DracarysTextureIndex = RARE -- first-time value
    end
  end

  if event == 'PLAYER_ENTERING_WORLD' then
    Dracarys_ChangePortrait(DracarysTextureIndex)
  end
end

frame:SetScript('OnEvent', frame.OnEvent)

SLASH_DRACARYS1 = '/dracarys'

SlashCmdList['DRACARYS'] = function(value)
  local index = tonumber(value)

  if (INDEX_TO_TEXTURE_MAP[index] == nil) then
    Dracarys_PrintHelp()
    return
  end

  DracarysTextureIndex = index

  Dracarys_PrintChanged(index)

  Dracarys_ChangePortrait(index)
end

function Dracarys_ChangePortrait(index)
  local texture = INDEX_TO_TEXTURE_MAP[index]

  PlayerFrameTexture:SetTexture(texture)
end

function Dracarys_PrintChanged(index)
  print('Player portrait changed to ' .. INDEX_TO_LABEL_MAP[index])
end

function Dracarys_PrintHelp()
  for key, value in pairs(INDEX_TO_LABEL_MAP) do
    print('/dracarys ' .. key .. ' (' .. value ..')')
  end
end
