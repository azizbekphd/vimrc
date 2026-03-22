local neotest = require("neotest")

neotest.setup({
  adapters = {
    require("neotest-jest")({
      jestCommand = "npm test --",
      jestArguments = function(defaultArguments, context)
        return defaultArguments
      end,
      jestConfigFile = "custom.jest.config.ts",
      env = { CI = true },
      cwd = function(path)
        return vim.fn.getcwd()
      end,
      isTestFile = require("neotest-jest.jest-util").defaultIsTestFile,
    }),
  },
  -- Other Neotest settings (optional)
  status = { virtual_text = true },
  output = { open_on_run = true },
  quickfix = {
    open = function()
      vim.cmd("copen") -- Open quickfix window on failure
    end
  },
})

vim.keymap.set("n", "<leader>tt", function()
  neotest.run.run()
end, { desc = "Run nearest test" })

vim.keymap.set("n", "<leader>ttt", function()
  neotest.run.stop()
end, { desc = "Stop nearest test" })

vim.keymap.set("n", "<leader>tf", function()
  neotest.run.run(vim.fn.expand("%"))
end, { desc = "Run current test file" })

vim.keymap.set("n", "<leader>ttf", function()
  neotest.run.stop(vim.fn.expand("%"))
end, { desc = "Stop current test file" })

vim.keymap.set("n", "<leader>tc", function()
  neotest.run.run(vim.fn.getcwd())
end, { desc = "Run all tests" })

vim.keymap.set("n", "<leader>ttc", function()
  neotest.run.stop(vim.fn.getcwd())
end, { desc = "Stop all test" })

vim.keymap.set("n", "<leader>td", function()
  local file_path = vim.fn.expand("%:p")
  local line_num = vim.fn.line(".")

  vim.schedule(function()
    require('dap').run({
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest Test",
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/bin/jest.js",
        "--runInBand",
        "--no-coverage",
        file_path,
        "--testNamePattern",
        vim.fn.input("Test name pattern (leave empty for all): ")
      },
      rootPath = "${workspaceFolder}",
      cwd = vim.fn.getcwd(),
      console = "integratedTerminal",
      sourceMaps = true,
      skipFiles = {"<node_internals>/**"}
    })
  end)
end, { desc = "Debug nearest test" })

vim.keymap.set("n", "<leader>ts", function()
  neotest.summary.toggle()
end, { desc = "Toggle test summary" })

vim.keymap.set("n", "<leader>to", function()
  neotest.output.open({ enter = true })
end, { desc = "Show test output" })
