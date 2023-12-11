### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ 2a7c40c6-972a-11ee-2dfc-e1c3dd08bf34
using DelimitedFiles

# ╔═╡ 314060b6-ff22-48fb-9dfa-75ce8cc81c20
using DataStructures

# ╔═╡ d34928f3-eaa7-4726-bb58-6890806df4ec
function readgrid(file::String)
	grid=[]
	open(file) do f
		
		while ! eof(f)
			s=split(readline(f),"")
			append!(grid,only.(s))
		end
	end
	return grid
end

# ╔═╡ 02bbf006-6aa7-4dcf-a868-39cb03442f6d
grid=permutedims(reshape(readgrid("day10.txt"),(140,:)))

# ╔═╡ a1752b90-580f-4b98-9956-6516e4b911c4
start=findfirst(x->x=='S',grid)

# ╔═╡ 981c3dcc-f708-4677-af11-a166a6f68042
cardinals=[CartesianIndex(y,x) for x in -1:1, y in -1:1 if ((x==0 || y==0) && !(x==0 && y==0))]

# ╔═╡ d30942d2-a650-4444-900f-9ad99aa7cf53
function isPipe(point,grid)
	return grid[point] !='.'
end

# ╔═╡ 977a5af4-30a3-4dc4-aa7e-c0b9ba62643b
	validentries=Dict([
	'|'=>[CartesianIndex(1,0),CartesianIndex(-1,0)],
	'-'=>[CartesianIndex(0,-1),CartesianIndex(0,1)],
	'7'=>[CartesianIndex(-1,0),CartesianIndex(0,1)],
	'J'=>[CartesianIndex(0,1),CartesianIndex(1,0)],
	'F'=>[CartesianIndex(0,-1),CartesianIndex(-1,0)],
	'L'=>[CartesianIndex(1,0),CartesianIndex(0,-1)]
	])


# ╔═╡ 868f4427-b880-4e59-84ce-502eb9ed9170
function isEnterable(point,grid,direction)
	return direction in validentries[ grid[point]]
end

# ╔═╡ 1fb93ea8-4b1e-482c-8575-14da8fb975b3
function getlength(grid,start)
	current_point=start
	current_dir =CartesianIndex(0,0)
	for dir in cardinals
		
		if isPipe(current_point+ dir,grid) && isEnterable(start+dir,grid,dir)
			current_point=current_point + dir
			current_dir=dir

			break
		end
	end
	length_pipe=1
	while grid[current_point]!='S'
		current_dir=filter(x->x!=current_dir,validentries[grid[current_point]])[1]*-1
		current_point+=current_dir
		length_pipe+=1
		
	end
	println("$length_pipe")
end

# ╔═╡ a256917d-6326-41aa-9ac2-ba349c186161
getlength(grid,start)

# ╔═╡ 54a9e542-0223-47f3-99e3-476fd89900ed


# ╔═╡ 6a14cca0-ecad-461b-a9ea-e39842bca05b
# Mark all tiles in loop
# Define a right hand rule. everything on right is inside, left is outside
#radiate outwards until all tiles are marked

# ╔═╡ d9778614-2cc6-4bf9-adc3-ece2d5c6adbf
# Part 2

# ╔═╡ 3e250b97-ae4a-4daa-847a-d211642374db
grid_flags = zeros((140,140))

# ╔═╡ 14408fb6-ef44-4070-b03f-151eca1bcc8a
# 1 means loop
# 2 means inside
# 3 means outside
# 0 means not touched yet

# ╔═╡ 8bfe6082-c45f-4cf6-9ad1-b5dd0b777bab
function getlength2(grid,start,grid_flags)
	#mark the path
	current_point=start
	grid_flags[current_point]=1
	current_dir =CartesianIndex(0,0)
	for dir in cardinals
		
		if isPipe(current_point+ dir,grid) && isEnterable(start+dir,grid,dir)
			current_point=current_point + dir
			current_dir=dir
			grid_flags[current_point]=1

			break
		end
	end
	length_pipe=1
	while grid[current_point]!='S'
		current_dir=filter(x->x!=current_dir,validentries[grid[current_point]])[1]*-1
		current_point+=current_dir
		grid_flags[current_point]=1
		
		length_pipe+=1
		
	 end

	#2nd time through to mark neighbors
	current_point=start
	current_dir =CartesianIndex(0,0)
	for dir in cardinals
		
		if isPipe(current_point+ dir,grid) && isEnterable(current_point+dir,grid,dir)
			
			current_point=current_point + dir
			current_dir=dir

			break
		end
	end
	length_pipe=1
	while grid[current_point]!='S'
		println("dir $current_dir")
		println("pt $current_point")
		if grid[current_point] in ['-'] && grid_flags[current_point+CartesianIndex(current_dir[2],current_dir[1])]!=1
				
			grid_flags[current_point+CartesianIndex(current_dir[2],current_dir[1])]=3
		elseif grid[current_point] in ['|'] && grid_flags[current_point+CartesianIndex(-current_dir[2],-current_dir[1])]!=1
			grid_flags[current_point+CartesianIndex(-current_dir[2],-current_dir[1])]=3

		
		else
		 	for direction in validentries[grid[current_point]]
				if 1<=(current_point + direction)[1]<= 140 &&
				1<=(current_point + direction)[2]<= 140 &&
				grid_flags[current_point + direction]!=1 &&
				current_dir==validentries[grid[current_point]][1]
					grid_flags[current_point + direction]=3
				end
			end		
		end
		current_dir=filter(x->x!=current_dir,validentries[grid[current_point]])[1]*-1
		current_point+=current_dir
		grid_flags[current_point]=1
		
		length_pipe+=1
		
	end

	
	println("$length_pipe")
end

# ╔═╡ 7eb1223a-2e3d-45fd-8eb2-540f69becc74
getlength2(grid,start,grid_flags)

# ╔═╡ 8ff20f88-ee90-4427-b133-87d30baff543
typeof(start)

# ╔═╡ 248284fc-cb56-489e-aca0-0b07dcecbdfc
function count_inside(grid_flags)
	total=0
	for row in 1:140
		row_sum=0
		outside =1
		for col in 1:140
			if grid_flags[CartesianIndex(row,col)]==1
				outside =outside* -1
			elseif outside == -1
				row_sum+=1
			end
		end
		total+=row_sum
		println("$row + $row_sum")
	end
	return total
end

# ╔═╡ 7a50c909-9449-4525-bb9f-ec9ab532173c
grid_flags[59:end,59:end]

# ╔═╡ 1d40d05f-6285-4ab9-ab74-3dab98c032e5
count_inside(grid_flags)

# ╔═╡ fe7307e0-bd6d-4c11-a547-086c467b7315
sum(filter(x->x==3,grid_flags))/3

# ╔═╡ dd89464e-81c5-4a69-94fe-c8fe73d87e6a
sum(filter(x->x<,grid_flags))

# ╔═╡ 6871d9b3-0058-4e26-a24f-b2045c4c9b80
sum(map(x->1,filter(x->x!=0   ,grid_flags)))

# ╔═╡ 4d8b7d2a-d21a-4fc0-b42f-b2fceda3368b

test="...........
.S-------7.
.|F-----7|.
.||.....||.
.||.....||.
.|L-7.F-J|.
.|..|.|..|.
.L--J.L--J.
..........."


# ╔═╡ 9707570f-7abc-4f37-81bd-2a70eb10cf45
test_grid=[]

# ╔═╡ fcd564c5-ea67-42ca-a44b-e4045c48560c
for row in split(test)
	
	s=split(row,"")
	push!(test_grid,only.(s))
end

# ╔═╡ 57fb55bc-70de-4512-b75c-6cecfc4d9212


# ╔═╡ ed1fbc50-41bf-4d45-a081-691a4f29d4da
test_grid2=permutedims(hcat(test_grid...))

# ╔═╡ c4be1d75-c9d2-47a1-9705-cf22d71db684


# ╔═╡ 74d9a0d4-f87a-4528-abff-1c8084563313
teststart=findfirst(x->x=='S',test_grid2)

# ╔═╡ 3fdda109-f8fc-4fec-a11e-ced38aced02a
grid2_Flags=zeros(9,11)

# ╔═╡ 69c15471-9e8a-4688-8772-33495223ccd8
getlength2(test_grid2,teststart,grid2_Flags)

# ╔═╡ 0e23ee6d-cf60-4a14-82aa-c5c0489c5cf1
grid2_Flags

# ╔═╡ 8c14a386-1f3b-4dd1-80b0-7267cafc048a
sum(filter(x->x==3,grid2_Flags))

# ╔═╡ f2f198af-39e8-4555-89de-ef0abb45047d
function bfs(grid_flags)
	# initialize storage
	explored = zeros(140,140)
	startingnodes=findall(x->x==3,grid_flags)
	println(startingnodes)
	q = Queue{CartesianIndex{2}}()
	# visit source
	explored[startingnodes].=1 
	for node in startingnodes
		enqueue!(q, node)
	end
	# go through the queue
	while !isempty(q)
		u = dequeue!(q)
		for dir in cardinals  # here
			
			v=u+dir
			if 1<=v[1]<=140 && 1<=v[2]<=140 && grid_flags[v]!=1 && explored[v]==0
				explored[v] = 1
				grid_flags[v]=3
				enqueue!(q, v)
			end
		end
	end
	return sum(explored)
end

# ╔═╡ ccd90aaa-1896-4a24-b180-5b62e0e1ca88
bfs(grid_flags)

# ╔═╡ 3625b579-5407-4b81-b502-96e490e65eb9
sum(filter(x->x==3,grid_flags))/3

# ╔═╡ a51c4855-54e4-4cdb-ac19-ac5d8441c727
140*140 - 5701-13630

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DataStructures = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
DelimitedFiles = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[compat]
DataStructures = "~0.18.15"
DelimitedFiles = "~1.9.1"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.4"
manifest_format = "2.0"
project_hash = "5586e3b429f44c97a482824d30615621d3eda404"

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

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

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
# ╠═2a7c40c6-972a-11ee-2dfc-e1c3dd08bf34
# ╠═d34928f3-eaa7-4726-bb58-6890806df4ec
# ╠═02bbf006-6aa7-4dcf-a868-39cb03442f6d
# ╠═a1752b90-580f-4b98-9956-6516e4b911c4
# ╠═981c3dcc-f708-4677-af11-a166a6f68042
# ╠═1fb93ea8-4b1e-482c-8575-14da8fb975b3
# ╠═a256917d-6326-41aa-9ac2-ba349c186161
# ╠═d30942d2-a650-4444-900f-9ad99aa7cf53
# ╠═868f4427-b880-4e59-84ce-502eb9ed9170
# ╠═977a5af4-30a3-4dc4-aa7e-c0b9ba62643b
# ╠═54a9e542-0223-47f3-99e3-476fd89900ed
# ╠═6a14cca0-ecad-461b-a9ea-e39842bca05b
# ╠═d9778614-2cc6-4bf9-adc3-ece2d5c6adbf
# ╠═3e250b97-ae4a-4daa-847a-d211642374db
# ╠═14408fb6-ef44-4070-b03f-151eca1bcc8a
# ╠═8bfe6082-c45f-4cf6-9ad1-b5dd0b777bab
# ╠═7eb1223a-2e3d-45fd-8eb2-540f69becc74
# ╠═8ff20f88-ee90-4427-b133-87d30baff543
# ╠═248284fc-cb56-489e-aca0-0b07dcecbdfc
# ╠═7a50c909-9449-4525-bb9f-ec9ab532173c
# ╠═1d40d05f-6285-4ab9-ab74-3dab98c032e5
# ╠═fe7307e0-bd6d-4c11-a547-086c467b7315
# ╠═314060b6-ff22-48fb-9dfa-75ce8cc81c20
# ╠═dd89464e-81c5-4a69-94fe-c8fe73d87e6a
# ╠═6871d9b3-0058-4e26-a24f-b2045c4c9b80
# ╠═4d8b7d2a-d21a-4fc0-b42f-b2fceda3368b
# ╠═9707570f-7abc-4f37-81bd-2a70eb10cf45
# ╠═fcd564c5-ea67-42ca-a44b-e4045c48560c
# ╠═57fb55bc-70de-4512-b75c-6cecfc4d9212
# ╠═ed1fbc50-41bf-4d45-a081-691a4f29d4da
# ╠═c4be1d75-c9d2-47a1-9705-cf22d71db684
# ╠═74d9a0d4-f87a-4528-abff-1c8084563313
# ╠═3fdda109-f8fc-4fec-a11e-ced38aced02a
# ╠═69c15471-9e8a-4688-8772-33495223ccd8
# ╠═0e23ee6d-cf60-4a14-82aa-c5c0489c5cf1
# ╠═8c14a386-1f3b-4dd1-80b0-7267cafc048a
# ╠═f2f198af-39e8-4555-89de-ef0abb45047d
# ╠═ccd90aaa-1896-4a24-b180-5b62e0e1ca88
# ╠═3625b579-5407-4b81-b502-96e490e65eb9
# ╠═a51c4855-54e4-4cdb-ac19-ac5d8441c727
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
