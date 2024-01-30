if vim.fn.has "nvim-0.7" then
  local api = vim.api
  -- run Flowcat after saving files
  api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*"},
  callback = function()
	  local dir = vim.fn.getcwd()
	  local args = [[flowcat -l -f {dir} -o {dir}/todo]]
	  args = args:gsub('{dir}',dir)
	  args = [[flowcat -l]]
	--   vim.fn.jobstart({"flowcat", "-l", "-o", "todo"}, {
	--     stdout_buffered = true,
	--     --on_stderr = function(_, data)
	--       --if data then
	--         --print("yo")
	--         --print(data)
	--       --end
	--     --end,
	--   })
	  vim.fn.system('flowcat -l -f ' .. dir .. ' -o ' .. dir .. '/todo')
  end,
})
end
