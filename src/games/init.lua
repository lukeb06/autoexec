for _, v in pairs({
	{ require("./agoraphobia"), 7585283196 },
	{ require("./animal-hospital"), 10148749921 },
	{ require("./flee-the-facility"), 372226183 },
	{ require("./granny-shooters"), 10141757860 },
	{ require("./hide-and-seek"), 93740418 },
	{ require("./ink-game"), 7008097940 },
	{ require("./murder-mystery"), 66654135 },
	{ require("./reminiscence-zombies"), 1003981402 },
	{ require("./zoo-or-oof"), 7785400752 },
	{ require("./prison-life"), 73885730 },
}) do
	if game.GameId == v[2] then
		task.spawn(v[1])
		break
	end
end

return true
