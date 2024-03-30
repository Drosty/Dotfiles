-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font = wezterm.font('JetBrains Mono', { })

config.initial_rows = 39 
config.initial_cols = 200

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = "Chalk"
--
config.ssh_domains = {
  {
    name = 'test-nix-2',
    remote_address = '10.1.67.60',
    username = 'ryan'
  },
  {
    -- This name identifies the domain
    name = 'mvtl-soil-be',
    -- The hostname or address to connect to. Will be used to match settings
    -- from your ssh config file
    remote_address = 'ssh-r730-mvtl-soil-be.devpod',
    -- The username to use on the remote host
    username = 'vscode',
  },
  {
    -- This name identifies the domain
    name = 'mvtl-soil-fe',
    -- The hostname or address to connect to. Will be used to match settings
    -- from your ssh config file
    remote_address = 'ssh-r730-mvtl-soil-fe.devpod',
    -- The username to use on the remote host
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
  -- This will create a new split and run the `top` program inside it
  {
    key = '[',
    mods = 'SUPER',
    action = wezterm.action.SplitPane {
      direction = 'Left',
      size = { Percent = 50 },
    },
  },
  {
    key = ']',
    mods = 'SUPER',
    action = wezterm.action.SplitPane {
      direction = 'Down',
      size = { Percent = 50 },
    },
  },
}

-- and finally, return the configuration to wezterm
return config
