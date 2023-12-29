### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ ce4b44ab-b0ce-4568-b6fe-6136526512ed
using DataStructures

# ╔═╡ fcb7e1e0-a54d-11ee-3a75-095baca4512b
grid=split(read("day16.txt",String))

# ╔═╡ fb04d671-588a-49bd-af98-05de43b8c4f3
gridchar=reduce(vcat, permutedims.(collect.(grid)))

# ╔═╡ a41f51ed-7556-4692-81e3-9f1b134018bf


# ╔═╡ 49f21884-7349-41e8-aa7f-65019fa66101
# multiply by 1im to go  counterclockwise 90 degrees

# ╔═╡ c6f6b81d-e3ec-4719-a52a-9f8e5f7911b9
x=1

# ╔═╡ 1d052b5c-aa2a-4a22-9250-ec81d47d09b8
1im*1im*1im

# ╔═╡ 53f00506-fa09-4db7-90b0-57c1a9c540b4
function part1(gridchar,starting=(CartesianIndex(1,0),1))
	Visited=Set()
	current_pos = starting
	dirs=Dict([
	1=>CartesianIndex(0,1),
	1im=>CartesianIndex(-1,0),
	-1 =>CartesianIndex(0,-1),
	-1im =>CartesianIndex(1,0)	
	])
	q = Queue{Any}()
	enqueue!(q, current_pos)
	bounds=CartesianIndices(gridchar)
	#start with a point and direction
	while !isempty(q)
		current_pos = dequeue!(q)	
		#go to next position
		current_pos=(current_pos[1]+dirs[current_pos[2]],current_pos[2])
		
		if current_pos[1] in bounds && !(current_pos in Visited)
			
			push!(Visited,current_pos)
			if gridchar[current_pos[1]]=='.'
				enqueue!(q, current_pos)
			elseif gridchar[current_pos[1]]=='|'
				if current_pos[2] in [1,-1]
					enqueue!(q, (current_pos[1],current_pos[2]*1im)  )
					enqueue!(q, (current_pos[1],current_pos[2]*-1im)  )		
				else
					enqueue!(q, current_pos)
				end
			elseif gridchar[current_pos[1]]=='-'
				if current_pos[2] in [1im,-1im]
					enqueue!(q, (current_pos[1],current_pos[2]*1im)  )
					enqueue!(q, (current_pos[1],current_pos[2]*-1im)  )		
				else
					enqueue!(q, current_pos)
				end
			elseif gridchar[current_pos[1]]=='/'
				if current_pos[2] in [1,-1]
					enqueue!(q, (current_pos[1],current_pos[2]*1im)  )
				else
					enqueue!(q, (current_pos[1],current_pos[2]*-1im)  )
				end
			elseif gridchar[current_pos[1]]=='\\'
				if current_pos[2] in [1im,-1im]
					enqueue!(q, (current_pos[1],current_pos[2]*1im)  )
				else
					enqueue!(q, (current_pos[1],current_pos[2]*-1im)  )
				end				
			end			
		end		
		
	end
	length(unique(x[1] for x in values(Visited)))
end

# ╔═╡ 695f9d57-1bfe-4bf8-926b-96717f03206b
part1(gridchar)

# ╔═╡ e93cac28-6651-4d57-a8e0-5fbda20cb055
function part2(gridchar)
	most_energized=0
	for row in [0,size(gridchar,1)+1]
		for col in 1:size(gridchar,2)
			most_energized=max(most_energized,part1(gridchar,(CartesianIndex(row,col), 1im)))
			most_energized=max(most_energized,part1(gridchar,(CartesianIndex(row,col), -1im)))			
		end
	end
	for row in 1:size(gridchar,1)
		for col in [0,size(gridchar,2)+1] 
			most_energized=max(most_energized,part1(gridchar,(CartesianIndex(row,col), 1)))
			most_energized=max(most_energized,part1(gridchar,(CartesianIndex(row,col), -1)))			
		end
	end
	return most_energized
end

# ╔═╡ d92a004f-2208-4b24-a91c-6d4171b8114f
part2(gridchar)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DataStructures = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"

[compat]
DataStructures = "~0.18.15"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.4"
manifest_format = "2.0"
project_hash = "afddc9afffcecddf8e73c1b53d6c212c657b17e6"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Compat]]
deps = ["UUIDs"]
git-tree-sha1 = "886826d76ea9e72b35fcd000e535588f7b60f21d"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.10.1"

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

    [deps.Compat.weakdeps]
    Dates = "ade2ca70-3891-5945-98fb-dc099432e06a"
    LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "3dbd312d370723b6bb43ba9d02fc36abade4518d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.15"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
"""

# ╔═╡ Cell order:
# ╠═fcb7e1e0-a54d-11ee-3a75-095baca4512b
# ╠═fb04d671-588a-49bd-af98-05de43b8c4f3
# ╠═a41f51ed-7556-4692-81e3-9f1b134018bf
# ╠═49f21884-7349-41e8-aa7f-65019fa66101
# ╠═c6f6b81d-e3ec-4719-a52a-9f8e5f7911b9
# ╠═1d052b5c-aa2a-4a22-9250-ec81d47d09b8
# ╠═53f00506-fa09-4db7-90b0-57c1a9c540b4
# ╠═ce4b44ab-b0ce-4568-b6fe-6136526512ed
# ╠═695f9d57-1bfe-4bf8-926b-96717f03206b
# ╠═e93cac28-6651-4d57-a8e0-5fbda20cb055
# ╠═d92a004f-2208-4b24-a91c-6d4171b8114f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
