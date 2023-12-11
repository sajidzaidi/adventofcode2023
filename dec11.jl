### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ 5644d5ac-265d-4790-bf1d-4b8fd1830dec
using DelimitedFiles

# ╔═╡ 8dcb75f1-79f8-4784-9872-3b2fbf389ed5
using Formatting

# ╔═╡ b79fc097-3512-40a1-83d4-c935d53c77b1
lines = map(collect, readlines("day11.txt"))



# ╔═╡ 74328731-5e6b-4d24-be12-ab4786b3b143
grid = permutedims(hcat(lines...))

# ╔═╡ 0b99a76b-057a-4f85-945a-24ac0fac23e3
function add_dupes(grid)
	dupe_rows=[]
	dupe_cols=[]
	for row in 1:140
		if !('#'  in grid[row,:])
			push!(dupe_rows,row)
		end
	end
	for col in 1:140
		if !('#'  in grid[:,col])
			push!(dupe_cols,col)
		end
	end
	grid2=grid
	for (i,row) in enumerate(dupe_rows)
		grid2=vcat(grid2[1: (row +i-1),:],grid2[(row +i-1):(row +i-1),:],grid2[(row+i):end,:])
	end
	for (i,col) in enumerate(dupe_cols)
		grid2=hcat(
			grid2[:, 1: (col+i-1)], grid2[:,(col +i-1):(col +i-1)]
			,grid2[:,(col+i):end] 
			)
	end
	return grid2
end

# ╔═╡ d9635f3e-a2f1-465e-8af9-177f09170193
grid2=add_dupes(grid)

# ╔═╡ b375f3ce-3419-4ae0-aa9b-3eb4b7287b72
galaxies=findall(x->x=='#',grid2)

# ╔═╡ c80d44a8-0a3a-4db0-a738-e8e66c482eb8
function alldistances(galaxies)
	distance=0
	for (i,galaxy1) in enumerate(galaxies)
		for galaxy2 in galaxies[i+1:end]
			distance+= abs(galaxy1[1]-galaxy2[1])+abs(galaxy1[2]-galaxy2[2])
		end
		
	end
	return distance
end

# ╔═╡ 99585510-bcab-44e1-811a-1346067f89ee
alldistances(galaxies)

# ╔═╡ eb6912bf-e01e-443b-9425-095b21c3a12d
function part2distances(grid)
	dupe_rows=[]
	dupe_cols=[]
	for row in 1:size(grid,1)
		if !('#'  in grid[row,:])
			push!(dupe_rows,row)
		end
	end
	for col in 1:size(grid,2)
		if !('#'  in grid[:,col])
			push!(dupe_cols,col)
		end
	end
	
	galaxies=findall(x->x=='#',grid)

	distance=0
	for (i,galaxy1) in enumerate(galaxies)
		for galaxy2 in galaxies[i+1:end]
			distance+= abs(galaxy1[1]-galaxy2[1])+abs(galaxy1[2]-galaxy2[2])
			low_row=min(galaxy1[1], galaxy2[1])
			high_row=max(galaxy1[1], galaxy2[1])
			low_col=min(galaxy1[2], galaxy2[2])
			high_col=max(galaxy1[2], galaxy2[2])
			
			 distance+=(1e6-1) * length(filter(x-> low_row< x< high_row,dupe_rows ))
			 distance+=(1e6-1) * length(filter(x-> low_col< x< high_col,dupe_cols ))
			
		end
		
	end
	return distance
end

# ╔═╡ 70879fa8-54d2-46e2-940e-ab96cfa51ad3
format(part2distances(grid))

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DelimitedFiles = "8bb1440f-4735-579b-a4ab-409b98df4dab"
Formatting = "59287772-0a20-5a39-b81b-1366585eb4c0"

[compat]
DelimitedFiles = "~1.9.1"
Formatting = "~0.4.2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.4"
manifest_format = "2.0"
project_hash = "2d3b7d1ede297379fae80b62e6df2cbad44d6b3e"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
"""

# ╔═╡ Cell order:
# ╠═5644d5ac-265d-4790-bf1d-4b8fd1830dec
# ╠═b79fc097-3512-40a1-83d4-c935d53c77b1
# ╠═74328731-5e6b-4d24-be12-ab4786b3b143
# ╠═0b99a76b-057a-4f85-945a-24ac0fac23e3
# ╠═d9635f3e-a2f1-465e-8af9-177f09170193
# ╠═b375f3ce-3419-4ae0-aa9b-3eb4b7287b72
# ╠═c80d44a8-0a3a-4db0-a738-e8e66c482eb8
# ╠═99585510-bcab-44e1-811a-1346067f89ee
# ╠═eb6912bf-e01e-443b-9425-095b21c3a12d
# ╠═70879fa8-54d2-46e2-940e-ab96cfa51ad3
# ╠═8dcb75f1-79f8-4784-9872-3b2fbf389ed5
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
