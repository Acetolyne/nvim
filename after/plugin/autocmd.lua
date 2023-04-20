if vim.fn.has "nvim-0.7" then
  local api = vim.api

  -- run Flowcat after saving files
  api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*"},
  callback = function()
	  --vim.cmd(string.format([[ autocmd BufWritePost * lua vim.notify(%s) ]], Filename_icon))
	  local dir = vim.fn.getcwd()
	  --print(dir)
	  --local args = [["flowcat  -l -f {dir} -o {dir}/todo"]]
	  --args = args:gsub('{dir}',dir)
	  --print(args)
	  os.execute('flowcat -l -f '..dir..' -o '..dir..'/todo&') 
  end,
})
end
