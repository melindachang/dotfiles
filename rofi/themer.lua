#!/usr/bin/env luajit

-- Use a list because table keys are randomly sorted
-- It's also easier to add options or edit them this way
local options = {
	{
		name = "Catppuccin Mocha",
		icon = "system-suspend",
		command = "fish -c 'switch_system_theme catppuccin_mocha'",
	},
	{
		name = "Gruvbox Material",
		icon = "system-shutdown",
		command = "fish -c 'switch_system_theme gruvbox_material'",
	},
	{
		name = "Tokyo Night",
		icon = "system-reboot",
		command = "fish -c 'switch_system_theme tokyo_night'",
	},
	{
		name = "Kanagawa Paper",
		icon = "system-reboot",
		command = "fish -c 'switch_system_theme kanagawa_paper'",
	},
}

for i, opt in ipairs(options) do
	if arg[1] then
		if opt.name == arg[1] then
			os.execute(opt.command)
		end
	else
		-- print(opt.name..'\0icon\x1f'..opt.icon)
		print(opt.name)
	end
end
