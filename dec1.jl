### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ 032c0f2e-918f-11ee-3863-adc22fd065c2
md"""
# Advent of Code, December 1st
"""

# ╔═╡ 6b0f079c-1b8e-45f0-a59f-e0745b560644

open("day1.txt") do f
	summed_value=0
	while ! eof(f)
		s=readline(f)
		digits=filter(isdigit,s)
		if length(digits)>0
			first=parse(Int,digits[1])
			last=parse(Int,digits[end])
			calibration = first*10 +last
			summed_value +=calibration
		end
	end
	println("$summed_value")
end


# ╔═╡ 260cb742-7b4f-4997-80a8-2b41b774c257
md"Part 2"

# ╔═╡ bbe9b923-1265-492e-ac3d-868fafeb4abd
nums=Dict([("one", "1"), ("two", "2"),("three", "3"),("four", "4"),("five", "5"),("six", "6"),("seven", "7"),("eight","8"),("nine","9"),("zero","0") ])

# ╔═╡ 4762169c-c1f0-445d-986f-1a717952b84d
open("day1.txt") do f
	summed_value=0
	while ! eof(f)
		s=readline(f)
		first_num =findfirst(isdigit,s)
		first_num=UnitRange(first_num,first_num)
		last_num =findlast(isdigit,s)
		last_num=UnitRange(last_num,last_num)
		for (key,value) in nums
			if !isnothing(findfirst(key,s))
				first_num =argmin(x-> x.start,[first_num,findfirst(key,s)])
				last_num =argmax(x-> x.start, [last_num,findlast(key,s)])
			end
		end
		if isdigit(s[first_num][1])
			first=10*parse(Int,s[first_num])
		else 
			first =10* parse(Int,nums[s[first_num]])
		end

		if isdigit(s[last_num][1])
			last=parse(Int,s[last_num])
		else 
			last=parse(Int,nums[s[last_num]])
		end
						
		calibration = first +last
		#println("$s  . $first . $last . $calibration")
		summed_value +=calibration
	end
	println("$summed_value")
end


# ╔═╡ Cell order:
# ╟─032c0f2e-918f-11ee-3863-adc22fd065c2
# ╠═6b0f079c-1b8e-45f0-a59f-e0745b560644
# ╟─260cb742-7b4f-4997-80a8-2b41b774c257
# ╠═bbe9b923-1265-492e-ac3d-868fafeb4abd
# ╠═4762169c-c1f0-445d-986f-1a717952b84d
