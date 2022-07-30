local notify_filter = vim.notify
vim.notify = function(msg, ...)
	if msg:match "Your workspace is set to" then
		return
	end

	notify_filter(msg, ...)
end
