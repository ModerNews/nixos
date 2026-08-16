-- Imperative half of the Hyprland config.
--
-- Everything here needs runtime state — the focused monitor, the focused
-- workspace, event payloads — and therefore has no `settings` representation.
-- Home Manager appends this after the generated settings, so the `local`s
-- declared there (mainMod, DESC_*, MON_*) are in scope.

------------------------------
---- SCRATCHPAD AUTO-MOVE ----
------------------------------

-- Size/float rules and the toggle binds are declarative; only this is not.
-- It moves a scratchpad app into its special workspace even when it was
-- launched from a desktop entry rather than the bind.
local scratchpad_classes = {
	["org.pulseaudio.pavucontrol"] = "audio",
	["kitty-yazi"] = "files",
}

hl.on("window.open", function(w)
	local name = scratchpad_classes[w.class]
	if name then
		hl.dispatch(hl.dsp.window.move({ workspace = "special:" .. name }))
	end
end)

-------------------------------------
---- RELATIVE WORKSPACE SWITCHING ----
-------------------------------------

-- Keys 1–5 are relative to the focused monitor:
--   primary -> offset 0 (ws 1–5), right -> offset 5 (ws 6–10)
--   portrait is reached by grave, and so has no offset entry.
--
-- Keyed on description rather than connector: hl.get_active_monitor() returns
-- an HL.Monitor userdata (pairs() fails on it) exposing .description and
-- .serial, so no shell-out is needed.
local monitorOffset = { [DESC_PRIMARY] = 0, [DESC_RIGHT] = 5 }

for i = 1, 5 do
	hl.bind(mainMod .. " + " .. i, function()
		local mon = hl.get_active_monitor()
		local offset = monitorOffset[mon.description] or 0
		hl.dispatch(hl.dsp.focus({ workspace = i + offset }))
	end)
	hl.bind(mainMod .. " + SHIFT + " .. i, function()
		local mon = hl.get_active_monitor()
		local offset = monitorOffset[mon.description] or 0
		hl.dispatch(hl.dsp.window.move({ workspace = i + offset }))
	end)
end

----------------------------
---- MONITOR FOCUS CYCLE ----
----------------------------

-- NOTE: this list is right-to-left, despite the original comment claiming
-- left-to-right. Order preserved verbatim so the bind behaves exactly as it did
-- on the old system; flip it if the comment was the intent.
local monitorOrder = { DESC_RIGHT, DESC_PRIMARY, DESC_PORTRAIT }

local function focusMonitorByOffset(delta)
	local mon = hl.get_active_monitor()
	if mon == nil then
		return
	end
	for i, name in ipairs(monitorOrder) do
		if name == mon.description then
			local target = monitorOrder[((i - 1 + delta) % #monitorOrder) + 1]
			hl.dispatch(hl.dsp.focus({ monitor = target }))
			return
		end
	end
end

hl.bind(mainMod .. " + bracketright", function()
	focusMonitorByOffset(1)
end)
hl.bind(mainMod .. " + bracketleft", function()
	focusMonitorByOffset(-1)
end)

-------------------------------
---- WORKSPACE-AWARE SCROLL ----
-------------------------------

-- On ws11 (scrolling layout) the wheel scrolls columns; everywhere else it
-- switches workspaces. Needs the focused workspace at press time.
hl.bind(mainMod .. " + mouse_down", function()
	local ws = hl.get_active_workspace()
	if ws ~= nil and ws.id == 11 then
		hl.dispatch(hl.dsp.layout("move +150"))
	else
		hl.dispatch(hl.dsp.focus({ workspace = "e+1" }))
	end
end, { repeating = true })

hl.bind(mainMod .. " + mouse_up", function()
	local ws = hl.get_active_workspace()
	if ws ~= nil and ws.id == 11 then
		hl.dispatch(hl.dsp.layout("move -150"))
	else
		hl.dispatch(hl.dsp.focus({ workspace = "e-1" }))
	end
end, { repeating = true })

------------------------------
---- SCREENSHARE INHIBITOR ----
------------------------------

-- Hold a logind idle inhibitor while screensharing.
--
-- Why this exists: Hyprland implements zwp_idle_inhibit_manager_v1, but that is
-- a Wayland protocol requiring a surface — unusable from a config file — and
-- xdg-desktop-portal-hyprland holds no idle inhibitor of its own. So it has to
-- come from logind.
--
-- The handle is a NAMED transient unit rather than a pid. That is what makes it
-- reload-safe: `hyprctl reload` re-runs this file and resets Lua locals, which
-- previously orphaned the inhibitor process every time (eight had accumulated,
-- each holding --what=idle --mode=block, which is exactly what stopped
-- hypridle's idle suspend from firing). A unit name survives that, and systemd
-- refuses to start a second instance under the same name, so double-start
-- cannot duplicate.

local INHIBIT_UNIT = "hypr-screenshare-inhibit"

local function inhibitStart()
	os.execute(
		"systemd-run --user --quiet --collect --unit=" .. INHIBIT_UNIT .. " "
			.. "systemd-inhibit --what=idle --who=Hyprland --why='Screenshare active' "
			.. "--mode=block sleep infinity 2>/dev/null"
	)
end

local function inhibitStop()
	os.execute("systemctl --user stop " .. INHIBIT_UNIT .. " 2>/dev/null")
end

-- Reload-safety: stop any inhibitor left by a previous load of this file.
-- One line, addressed by name; no pid tracking and no process scanning.
inhibitStop()

-- Refcount so overlapping shares release the inhibitor exactly once, when the
-- last one ends, rather than when the first one does.
local shareCount = 0

hl.on("screenshare.state", function(active, type, name)
	if active then
		shareCount = shareCount + 1
		if shareCount == 1 then
			inhibitStart()
		end
	else
		shareCount = math.max(0, shareCount - 1)
		if shareCount == 0 then
			inhibitStop()
		end
	end
end)
