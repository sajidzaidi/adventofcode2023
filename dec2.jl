### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ bda44f5d-cbd5-4046-8756-44064cfc2ef5
limits=Dict([("red",12),("green",13),("blue",14)])

# ╔═╡ 83a848b6-95cc-11ee-03b6-f71af761f934
open("day2.txt") do f
	summed_value=0
	powerset=0
	while ! eof(f)
		s=split(readline(f),':')
		gameid=parse(Int,filter(isdigit,s[1]))		
		possible=true
		min_cubes=Dict()
		for subset in eachsplit(s[2],[';'])
			for color in eachsplit(subset,',')
				color_name=split(color)[2]
				color_amt=parse(Int,split(color)[1])
				possible=possible && limits[color_name]>=color_amt
				min_cubes[color_name]=haskey(min_cubes,color_name) ? max(min_cubes[color_name],color_amt) : color_amt
			end
		end
		if possible
			summed_value+=gameid
		end
		powerset+= prod(values(min_cubes))
	end
	println("$summed_value")
	println("$powerset")
end


# ╔═╡ Cell order:
# ╠═bda44f5d-cbd5-4046-8756-44064cfc2ef5
# ╠═83a848b6-95cc-11ee-03b6-f71af761f934
