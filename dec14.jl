### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ 70ab9e76-9a41-11ee-3599-19ea2387ae37
using SHA

# ╔═╡ aec4dece-1664-4be3-ae0d-029d34921641
rocks=split(read("day14.txt",String))

# ╔═╡ cd0bc96e-d45d-47df-af72-a9d3dc36b4a6
function part1(rocks)
	overall_load=0
	for col in 1:size(rocks,2)
		sum_load=0
		last_cube=0
		num_rocks=0
		for row in 1:size(rocks,1)
	
			if rocks[row,col]=='O'
				num_rocks+=1
			end
			if rocks[row,col]=='#' || row==size(rocks,1)
				if num_rocks>0
					first_weight=size(rocks,1) -last_cube
					last_weight=first_weight - num_rocks +1
					sum_load+= first_weight*(first_weight+1)/2 - (last_weight-1)*(last_weight)/2
				end
				last_cube=row
				num_rocks=0
			end
			
			
		end
		overall_load+=sum_load
	end	
	return overall_load
end

# ╔═╡ 34e03294-5aff-435e-ba45-ae905f87d686
function tiltnorth(rocks)
	new_rocks = deepcopy(rocks)
	replace!(new_rocks, 'O'=> '.')

	for col in 1:size(rocks,2)
		last_cube=0
		num_rocks=0
		for row in 1:size(rocks,1)
	
			if rocks[row,col]=='O'
				num_rocks+=1
			end
			if rocks[row, col]=='#' || row==size(rocks,1)
				if num_rocks>0
					for i in 1:num_rocks
						new_rocks[last_cube+i,col]='O'
					end
				end
				last_cube=row
				num_rocks=0
			end
			
			
		end
	end	
	return new_rocks



	
end

# ╔═╡ 189e15ad-27a0-480b-a8a7-38ce8bda573d
function cycle(rocks)
	hash_array=[]
	push!(hash_array,deepcopy(rocks))
	while length(unique(hash_array))==length(hash_array)
	#for cnt in 1:156+72+72-1
		for i in 1:4
			rocks = rotr90(tiltnorth(rocks))
		end
		push!(hash_array,deepcopy(rocks))
	end
	return hash_array
end

	

# ╔═╡ 1cd1d7e9-b6a9-4f08-aec7-7df201888a44
rockschar=reduce(vcat, permutedims.(collect.(rocks)))


# ╔═╡ 169bd703-724c-40a6-bda0-d8826f3ba20a
part1(rockschar)

# ╔═╡ aed04a5d-a7c3-4364-a18b-160c01c1477b
firstcycle= cycle(rockschar)

# ╔═╡ 628237f9-fc55-4c60-a7e0-e4fead8f8e9a
findall(x->x==  firstcycle[end],firstcycle)

# ╔═╡ 838f4a59-1a64-4d1e-a7d8-81b61d234c74
mod(1000000000-83,72)

# ╔═╡ 72d0c542-a3ef-4cb1-b9b6-c8d0837a4a11
function part2(rocks)
	new_rocks=rocks
	for i in 1:96
		for j in 1:4
			new_rocks = rotr90(tiltnorth(new_rocks))
		end
	end
	return part1(new_rocks)
end


# ╔═╡ 37bee834-a123-4e29-a122-682032c3f9e6


# ╔═╡ 7eda440b-26b6-470b-aba6-972d3c28ed3c
sum(100-x[1]+1 for x in findall(x->x=='O',firstcycle[53+84]))

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
SHA = "ea8e919c-243c-51af-8825-aaa63cd721ce"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.4"
manifest_format = "2.0"
project_hash = "6a2bc76e9b3bd74644517927c755c3c99df132b2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"
"""

# ╔═╡ Cell order:
# ╠═70ab9e76-9a41-11ee-3599-19ea2387ae37
# ╠═aec4dece-1664-4be3-ae0d-029d34921641
# ╠═cd0bc96e-d45d-47df-af72-a9d3dc36b4a6
# ╠═169bd703-724c-40a6-bda0-d8826f3ba20a
# ╠═34e03294-5aff-435e-ba45-ae905f87d686
# ╠═189e15ad-27a0-480b-a8a7-38ce8bda573d
# ╠═1cd1d7e9-b6a9-4f08-aec7-7df201888a44
# ╠═aed04a5d-a7c3-4364-a18b-160c01c1477b
# ╠═628237f9-fc55-4c60-a7e0-e4fead8f8e9a
# ╠═838f4a59-1a64-4d1e-a7d8-81b61d234c74
# ╠═72d0c542-a3ef-4cb1-b9b6-c8d0837a4a11
# ╠═37bee834-a123-4e29-a122-682032c3f9e6
# ╠═7eda440b-26b6-470b-aba6-972d3c28ed3c
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
