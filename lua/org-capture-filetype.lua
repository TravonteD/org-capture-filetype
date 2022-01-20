local config = require("orgmode.config")
local capture = require("orgmode.capture")
local function open_template(self, template)
  local content = (self.templates):compile(template)
  vim.cmd(string.format("16split %s", vim.fn.tempname()))
  vim.cmd(string.format("setf %s", (template.filetype or "org")))
  vim.cmd("setlocal bufhidden=wipe nobuflisted nolist noswapfile nofoldenable")
  vim.api.nvim_buf_set_lines(0, 0, -1, true, content)
  do end (self.templates):setup()
  vim.api.nvim_buf_set_var(0, "org_template", template)
  vim.api.nvim_buf_set_var(0, "org_capture", true)
  config:setup_mappings("capture")
  return vim.cmd("autocmd OrgCapture BufWipeout <buffer> ++once lua require('orgmode').action('capture.refile', true)")
end
capture.open_template = open_template
return nil
