local org = require("orgmode")
local config = require("orgmode.config")
local capture = require("orgmode.capture")
local utils = require("orgmode.utils")
local function open_template(self, template)
  local content = (self.templates):compile(template)
  local on_close
  local function _1_()
    return org.action("capture.refile", true)
  end
  on_close = _1_
  utils.open_tmp_org_window(16, config.win_split_mode, on_close)
  vim.cmd(string.format("setf %s", (template.filetype or "org")))
  vim.cmd("setlocal bufhidden=wipe nobuflisted nolist noswapfile nofoldenable")
  vim.api.nvim_buf_set_lines(0, 0, -1, true, content)
  do end (self.templates):setup()
  vim.api.nvim_buf_set_var(0, "org_template", template)
  vim.api.nvim_buf_set_var(0, "org_capture", true)
  return config:setup_mappings("capture")
end
capture.open_template = open_template
return nil
