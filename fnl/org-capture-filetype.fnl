(local org (require :orgmode))
(local config (require :orgmode.config))
(local capture (require :orgmode.capture))
(local utils (require :orgmode.utils))

(fn open_template [self template]
  "Opens a split with the given capture template"
  (let [content (self.templates:compile template)
        on_close #(org.action "capture.refile" true)]
    (utils.open_tmp_org_window 16 config.win_split_mode on_close)
    (vim.cmd (string.format "setf %s" (or template.filetype :org)))
    (vim.cmd "setlocal bufhidden=wipe nobuflisted nolist noswapfile nofoldenable")
    (vim.api.nvim_buf_set_lines 0 0 -1 true content)
    (self.templates:setup)
    (vim.api.nvim_buf_set_var 0 :org_template template)
    (vim.api.nvim_buf_set_var 0 :org_capture true)
    (config:setup_mappings :capture)))

(set capture.open_template open_template)
