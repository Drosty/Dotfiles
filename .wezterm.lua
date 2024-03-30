-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

config.font = wezterm.font('JetBrains Mono', { })

config.initial_rows = 39 
config.initial_cols = 200

config.color_scheme = "Catppuccin Mocha"
config.ssh_domains = {
  {
    name = 'test-nix-2',
    remote_address = '10.1.67.60',
    username = 'ryan'
  },
  {
    name = 'mvtl-soil-be',
    remote_address = 'ssh-r730-mvtl-soil-be.devpod',
    username = 'vscode',
  },
  {
    name = 'mvtl-soil-fe',
    remote_address = 'ssh-r730-mvtl-soil-fe.devpod',
    username = 'vscode',
  },
}

config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.4,
}

config.keys = {
   {
    key = 'LeftArrow',
    mods = 'OPT',
    action = act.SendKey { key = 'b', mods = 'ALT' },
  },
  {
    key = 'RightArrow',
    mods = 'OPT',
    action = act.SendKey { key = 'f', mods = 'ALT' },
  },
}

-- and finally, return the configuration to wezterm
return config
