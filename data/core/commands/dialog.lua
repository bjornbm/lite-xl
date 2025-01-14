local core = require "core"
local command = require "core.command"

command.add("core.nagview", {
  ["dialog:previous-entry"] = function()
    local v = core.active_view
    local hover = v.hovered_item or 1
    v:change_hovered(hover == 1 and #v.options or hover - 1)
  end,
  ["dialog:next-entry"] = function()
    local v = core.active_view
    local hover = v.hovered_item or 1
    v:change_hovered(hover == #v.options and 1 or hover + 1)
  end,
  ["dialog:select-yes"] = function()
    local v = core.active_view
    if v ~= core.nag_view then return end
    v:change_hovered(findindex(v.options, "default_yes"))
    command.perform "dialog:select"
  end,
  ["dialog:select-no"] = function()
    local v = core.active_view
    if v ~= core.nag_view then return end
    v:change_hovered(findindex(v.options, "default_no"))
    command.perform "dialog:select"
  end,
  ["dialog:select"] = function()
    local v = core.active_view
    if v.hovered_item then
      v.on_selected(v.options[v.hovered_item])
      v:next()
    end
  end
})
