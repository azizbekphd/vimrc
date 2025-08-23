local dap = require('dap')

-- For Mason-installed adapter
dap.adapters['pwa-node'] = {
  type = 'server',
  host = 'localhost',
  port = '${port}',
  executable = {
    command = 'node',
    args = {
      vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
      '${port}'
    },
  }
}

-- Fallback if Mason registry isn't available
if not pcall(function() require('mason-registry').get_package('js-debug-adapter') end) then
  dap.adapters['pwa-node'].executable.args[1] = vim.fn.expand('~/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js')
end
