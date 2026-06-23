local M = {}

function M.isSeeker(plr)
	local char = plr and plr.Character
	local itscript = char and char:FindFirstChild("ItScript")
	return itscript ~= nil
end

return M
