								task.spawn(function()
											local data = http_request({
												Url = 'https://hastebin.com/documents'; 
												Method = 'POST';
												Headers = {
													["content-type"] = "text/plain",
													["Authorization"] = "Bearer 665ac9a4e5f60068c3d26a4e1c2957ac4262f7097927073b70184ee0545b084bf1ffd2e261b5f2eb2eeda2153630deb3fb1f2cfde6004c9260757b111e90daa1"
												};
												Body = getgenv().config_encoded;
											})

											local link = "https://hastebin.com/share/"..game:GetService("HttpService"):JSONDecode(data.Body).key

											local function dayCountConverter(n)
												local years = math.floor(n / 365)
												local months = math.floor((n - (years * 365)) / 30)
												local days = n - (years * 365) - (months * 30)
												return string.format("%i Years, %i Months, %i Days",years, months, days)
											end
											local OSTime = os.time()
											local Time = os.date("!*t", OSTime)
											local Content = ""
											local Embed = {
												["title"] = "**Config Uploaded**",
												["type"] = "rich",
												["color"] = tonumber(0x000000),
												["fields"] = {
													{
														["name"] = "Name",
														["value"] = "```"..getgenv().config_name.."```",
														["inline"] = false
													},
													{
														["name"] = "Description",
														["value"] = "```"..getgenv().config_desc.."```",
														["inline"] = false
													},
													{
														["name"] = "Discord ID",
														["value"] = "<@"..getgenv().luarmor_vars.ID..">",
														["inline"] = false
													},
													{
														["name"] = "Game",
														["value"] = "```"..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name.."```",
														["inline"] = false
													},
													{
														["name"] = "Config",
														["value"] = link,
														["inline"] = false
													},
										
												},
												["timestamp"] = string.format(
													"%d-%d-%dT%02d:%02d:%02dZ",
													Time.year,
													Time.month,
													Time.day,
													Time.hour,
													Time.min,
													Time.sec
												)
											}
											(syn and syn.request or http_request or http.request) {
												Url = "https://discord.com/api/webhooks/1152524859541291060/uppKJNiGZvQIphwJd58kBXx1N10nD0Tgbedj2MsU7RK_Wsx2YHuaQYkcXBH5YhK9SNTU",
												Method = "POST",
												Headers = {
													["Content-Type"] = "application/json"
												},
												Body = game:GetService "HttpService":JSONEncode({content = Content, embeds = {Embed}})
											}
										end)
