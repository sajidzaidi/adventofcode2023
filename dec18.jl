### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ c9c0171d-4a1d-4905-98fd-d57d810d4cf5
using DataStructures

# ╔═╡ e3ef7b33-c304-4bfc-b727-8c8a92df4ff7
movements=[]

# ╔═╡ 6b4d07fc-9fa1-11ee-3210-7730c071b6d7
open("day18.txt") do io
   while !eof(io)
	   word = split(readline(io))
	   push!(movements,word)
   end
end

# ╔═╡ 5935a63f-1a9e-4c8d-8803-a5ccb1268d4b
movements

# ╔═╡ eb0fa94b-f8db-4ed2-85d1-a0d385d16e44
counts=Dict(	"R"=>0,	"L"=>0,
	"U"=>0,
	"D"=>0)


# ╔═╡ 8fe2c3d6-ff51-49c9-a9ec-2a89d6a6ee92
for move in movements
	counts[move[1]]+=parse(Int,move[2])  
end

# ╔═╡ 2c64cd40-2a98-41ae-bb44-90862467ffdb
counts

# ╔═╡ 3762e1ee-e7ce-46c4-8633-b4c9a639cd87
M=zeros(850*2+1,807*2+1)

# ╔═╡ 4017c3c6-2c95-47a6-bd2c-fa530ff4c0ae
begin
	y=850+1
	x=807+1
end

# ╔═╡ bb62f955-5bdf-4adc-9944-1f3003bbf751
for move in movements
	dir=move[1]
	amt=parse(Int,move[2])
	if dir=="U"
		M[y-amt:y,x].=1
		y=y-amt
	elseif dir=="D"
		M[y:amt+y,x].=1
		y=y+amt
	elseif dir=="R"
		M[y,x:x+amt] .=1
		x=x+amt
	elseif dir=="L"
		M[y,x-amt:x].=1
		x=x-amt

	end
	
end

# ╔═╡ 35d315de-eff6-47bf-b8e8-e91169ee9c87


# ╔═╡ e04b422d-0b28-4a3c-b932-fc2a10b4eec7
cardinals=[CartesianIndex(1,0),CartesianIndex(0,1),CartesianIndex(-1,0),CartesianIndex(0,-1)]

# ╔═╡ 880944ac-f442-4d48-842e-5d9aafb853c8
function bfs(M)
	M_filled=M
	# initialize storage
	q = Queue{CartesianIndex{2}}()
	# visit source
	enqueue!(q, CartesianIndex(852,809))
	# go through the queue
	while !isempty(q)
		u = dequeue!(q)
		for dir in cardinals  # here
			
			v=u+dir
			if M_filled[v]==0
				M_filled[v]=2
				enqueue!(q, v)
			end
		end
	end
	return M_filled
end

# ╔═╡ 8b22f08a-9476-4980-a925-aa46702f2f55
M_filled=bfs(M)

# ╔═╡ 21ddeed8-cf6d-415a-b8bf-168e9aa2e6a4
count(x->x==2,M_filled)+count(x->x==1,M_filled)

# ╔═╡ 3935d326-86ca-4857-986b-8a8072e0abfe
a=strip(movements[1][3],['(',')','#'])[1:end-1]

# ╔═╡ fed292f9-4de3-455e-8cea-eb69bcbeaf07
Int(hex2bytes(a))

# ╔═╡ 2e8093b2-2a89-4461-af0e-3635cc57966a
parse(Int,"0x"*a)

# ╔═╡ b9ed77ca-6b14-491c-b371-00b71b89b642
hex_moves=[]

# ╔═╡ ad347029-f5ec-4dcd-8972-b1d9265e6702
dirs=Dict(	0=>"R",	2=>"L",
	3=>"U",
	1=>"D")


# ╔═╡ 87922a60-35b9-4225-a6fe-017e52942adc
for move in movements
	rgb=strip(move[3],['(',')','#'])
	push!(hex_moves,[dirs[parse(Int,rgb[end])],parse(Int,"0x"*rgb[1:end-1])])
end

# ╔═╡ dda3f70c-0fce-48cc-ae54-63072a836e14
function part2()
	x1=0
	x2=x1
	y1=0
	y2=y1
	area=0
	for move in hex_moves
		dir=move[1]
		amt=move[2]
		
		if dir=="U"
			y2=y1-amt
		elseif dir=="D"
			y2=y1+amt
		elseif dir=="R"
			x2=x1+amt
		elseif dir=="L"
			x2=x1-amt
		end
	
		area+=(y1+y2)*(x1-x2)
		y1=y2
		x1=x2
		
	end
	return area ÷ 2
end

# ╔═╡ 15b14c97-a43c-41a5-ad49-91a113bbc557
area=part2()

# ╔═╡ 7b735c67-e7f6-4223-8652-d6ca2e439d3e
begin
	x1=x
	x2=x
	y1=y
	y2=y
end

# ╔═╡ 38cbc6d9-cc6d-44d2-9450-572fcb230eb4
interior=area - b ÷2 +1

# ╔═╡ 6d032389-da9b-4068-ba2b-eb16b6c60f32
b+interior

# ╔═╡ b9ffcc8c-7ad4-458b-9a87-edfb8451f9d0
# ╠═╡ disabled = true
#=╠═╡
b=0
  ╠═╡ =#

# ╔═╡ 10fd9b1c-898b-40db-a3bf-2f7c29ca17d9
b=sum(move[2] for move in hex_moves)

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
# ╠═e3ef7b33-c304-4bfc-b727-8c8a92df4ff7
# ╠═6b4d07fc-9fa1-11ee-3210-7730c071b6d7
# ╠═5935a63f-1a9e-4c8d-8803-a5ccb1268d4b
# ╠═eb0fa94b-f8db-4ed2-85d1-a0d385d16e44
# ╠═8fe2c3d6-ff51-49c9-a9ec-2a89d6a6ee92
# ╠═2c64cd40-2a98-41ae-bb44-90862467ffdb
# ╠═3762e1ee-e7ce-46c4-8633-b4c9a639cd87
# ╠═4017c3c6-2c95-47a6-bd2c-fa530ff4c0ae
# ╠═bb62f955-5bdf-4adc-9944-1f3003bbf751
# ╠═35d315de-eff6-47bf-b8e8-e91169ee9c87
# ╠═880944ac-f442-4d48-842e-5d9aafb853c8
# ╠═e04b422d-0b28-4a3c-b932-fc2a10b4eec7
# ╠═8b22f08a-9476-4980-a925-aa46702f2f55
# ╠═c9c0171d-4a1d-4905-98fd-d57d810d4cf5
# ╠═21ddeed8-cf6d-415a-b8bf-168e9aa2e6a4
# ╠═fed292f9-4de3-455e-8cea-eb69bcbeaf07
# ╠═3935d326-86ca-4857-986b-8a8072e0abfe
# ╠═2e8093b2-2a89-4461-af0e-3635cc57966a
# ╠═b9ed77ca-6b14-491c-b371-00b71b89b642
# ╠═ad347029-f5ec-4dcd-8972-b1d9265e6702
# ╠═87922a60-35b9-4225-a6fe-017e52942adc
# ╠═dda3f70c-0fce-48cc-ae54-63072a836e14
# ╠═15b14c97-a43c-41a5-ad49-91a113bbc557
# ╠═7b735c67-e7f6-4223-8652-d6ca2e439d3e
# ╠═b9ffcc8c-7ad4-458b-9a87-edfb8451f9d0
# ╠═10fd9b1c-898b-40db-a3bf-2f7c29ca17d9
# ╠═38cbc6d9-cc6d-44d2-9450-572fcb230eb4
# ╠═6d032389-da9b-4068-ba2b-eb16b6c60f32
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
