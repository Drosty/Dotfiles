return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- "NicholasMata/nvim-dap-cs",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      -- "williamboman/mason.nvim",
    },
    config = function()
      local dap = require("dap")
      -- local dotnet = require("easy-dotnet")
      local ui = require("dapui")
      local debug_dll = nil

      local function ensure_dll()
        if debug_dll ~= nil then
          return debug_dll
        end
        local dll = dotnet.get_debug_dll()
        debug_dll = dll
        return dll
      end

      --- Rebuilds the project before starting the debug session
      ---@param co thread
      local function rebuild_project(co, path)
        local num = 0
        local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }

        local notification = vim.notify(spinner_frames[1] .. " Building", "info", {
          timeout = false,
        })

        vim.fn.jobstart(string.format("dotnet build %s", path), {
          on_stdout = function(a)
            num = num + 1
            local new_spinner = num % #spinner_frames
            notification =
              vim.notify(spinner_frames[new_spinner + 1] .. " Building", "info", { replace = notification })
          end,
          on_exit = function(_, return_code)
            if return_code == 0 then
              vim.notify("Built successfully", "info", { replace = notification, timeout = 1000 })
            else
              -- HACK: clearing previous building progress message
              vim.notify("", "info", { replace = notification, timeout = 1 })
              vim.notify("Build failed with exit code " .. return_code, "error", { timeout = 1000 })
              error("Build failed")
            end
            coroutine.resume(co)
          end,
        })
        coroutine.yield()
      end

      local t_get_environment_variables = function(project_name, relative_project_path)
        local launchSettings = vim.fs.joinpath(relative_project_path, "Properties", "launchSettings.json")

        local stat = vim.loop.fs_stat(launchSettings)
        if stat == nil then
          print("No launchSettings.json found")
          return nil
        end

        local success, result = pcall(vim.fn.json_decode, vim.fn.readfile(launchSettings, ""))
        if not success then
          print("Error parsing JSON: " .. result)
          return nil, "Error parsing JSON: " .. result
        end

        local launchProfile = result.profiles[project_name]

        if launchProfile == nil then
          print("No launch profile found for project " .. project_name)
          return nil
        end

        --TODO: Is there more env vars in launchsetttings.json?
        launchProfile.environmentVariables["ASPNETCORE_URLS"] = launchProfile.applicationUrl
        return launchProfile.environmentVariables
      end

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          env = function()
            local dll = ensure_dll()
            print(vim.inspect(dll))
            local vars = t_get_environment_variables(dll.project_name, dll.relative_project_path)
            print(vim.inspect(vars))
            return vars or nil
          end,
          program = function()
            local dll = ensure_dll()
            local co = coroutine.running()
            rebuild_project(co, dll.project_path)
            return dll.relative_dll_path
          end,
          cwd = function()
            local dll = ensure_dll()
            return dll.relative_project_path
          end,
        },
      }

      require("dapui").setup()
      -- require("dap-cs").setup({
      --   -- Additional dap configurations can be added.
      --   -- dap_configurations accepts a list of tables where each entry
      --   -- represents a dap configuration. For more details do:
      --   -- :help dap-configuration
      --   dap_configurations = {
      --     {
      --       -- Must be "coreclr" or it will be ignored by the plugin
      --       type = "coreclr",
      --       name = "Attach remote",
      --       mode = "remote",
      --       request = "attach",
      --     },
      --   },
      --   netcoredbg = {
      --     -- the path to the executable netcoredbg which will be used for debugging.
      --     -- by default, this is the "netcoredbg" executable on your PATH.
      --     path = "netcoredbg",
      --   },
      -- })

      dap.adapters.coreclr = {
        type = "executable",
        command = "netcoredbg",
        args = { "--interpreter=vscode" },
      }

      -- dap.listeners.before["event_terminated"]["easy-dotnet"] = function()
      --   debug_dll = nil
      -- end

      -- Handled by nvim-dap-go
      -- dap.adapters.go = {
      --   type = "server",
      --   port = "${port}",
      --   executable = {
      --     command = "dlv",
      --     args = { "dap", "-l", "127.0.0.1:${port}" },
      --   },
      -- }

      -- local elixir_ls_debugger = vim.fn.exepath("elixir-ls-debugger")
      -- if elixir_ls_debugger ~= "" then
      --   dap.adapters.mix_task = {
      --     type = "executable",
      --     command = elixir_ls_debugger,
      --   }

      --   dap.configurations.elixir = {
      --     {
      --       type = "mix_task",
      --       name = "phoenix server",
      --       task = "phx.server",
      --       request = "launch",
      --       projectDir = "${workspaceFolder}",
      --       exitAfterTaskReturns = false,
      --       debugAutoInterpretAllModules = false,
      --     },
      --   }
      -- end

      vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
      vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

      -- Eval var under cursor
      vim.keymap.set("n", "<space>?", function()
        require("dapui").eval(nil, { enter = true })
      end)

      vim.keymap.set("n", "<F1>", dap.continue)
      vim.keymap.set("n", "<F2>", dap.step_into)
      vim.keymap.set("n", "<F3>", dap.step_over)
      vim.keymap.set("n", "<F4>", dap.step_out)
      vim.keymap.set("n", "<F5>", dap.step_back)
      vim.keymap.set("n", "<F13>", dap.restart)

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}
