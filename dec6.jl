### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ 8b89cbae-752d-43d1-8914-d80a70fb3726
function nways(time,distance)
	min_time = ceil((-time+sqrt(time^2 - 4 * distance))/(-2))
	return Int(time - 2*min_time +1)
end

# ╔═╡ 26c9ad10-0cf7-4d2d-bff8-ee0ed5705d22
inputs=[[54,446],[81,1292],[70,1035],[88,1007]]

# ╔═╡ 4ba40bba-805d-4e8b-9113-d7bf93ac27bd
prod(nways(x[1],x[2]) for x in inputs)

# ╔═╡ fecd170a-11a6-4e46-9cb6-8229c14fd988
nways(54817088,446129210351007)

# ╔═╡ Cell order:
# ╠═8b89cbae-752d-43d1-8914-d80a70fb3726
# ╠═26c9ad10-0cf7-4d2d-bff8-ee0ed5705d22
# ╠═4ba40bba-805d-4e8b-9113-d7bf93ac27bd
# ╠═fecd170a-11a6-4e46-9cb6-8229c14fd988
