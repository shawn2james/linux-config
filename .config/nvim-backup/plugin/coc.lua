vim.api.nvim_set_keymap("n", "gr", "<Plug>(coc-references)", {silent = true})

function check_back_space()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local linetext = vim.api.nvim_get_current_line()
  
  local checking = col==0 or string.match(linetext:sub(col, col), "%s") ~= nil
  if vim.fn.pumvisible() then 
	return [[\<C-n>]]
  else 
	if checking then
	  return [[\<Tab>]]
	else
	  return "coc#refresh()" 
	end
  end
end

vim.api.nvim_set_keymap('i', '<Tab>', check_back_space(), { silent=true, expr=true, noremap=true })
