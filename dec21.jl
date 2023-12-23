### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ c049d405-1968-4989-9964-dca1cf8e4a7f
using Formatting

# ╔═╡ f84bce24-9fc8-11ee-37c0-5daa0e4a7166
grid=split(read("day21.txt",String))

# ╔═╡ 72fddcf0-101c-43f9-b111-bda22c704fac
gridchar=reduce(vcat, permutedims.(collect.(grid)))

# ╔═╡ 8ecb02ff-cd3a-4ce2-8441-ed6a0724261c
dirs=[CartesianIndex(0,1),CartesianIndex(0,-1),CartesianIndex(1,0),CartesianIndex(-1,0) ]

# ╔═╡ 1aaf28f9-f787-43a2-bdf3-392a99cb6894
function steps(n,grid)
	gridchar=grid
	cells=Dict()
	start=findall(x->x=='S',gridchar)[1]
	cells[0]=Set([(590,590)])
	for step in 1:n
		cells[step]=Set()
		for cell in cells[step-1]	
			for dir in dirs
				candidate=CartesianIndex(cell...)+dir
				if !checkbounds(Bool,gridchar,candidate) 
					println("$candidate")
				end
				if checkbounds(Bool,gridchar,candidate) && (gridchar[candidate]=='.' || gridchar[candidate]=='S')
					push!(cells[step],Tuple(candidate))
				end
			end
		end
	end	

	return length(cells[n])
end

# ╔═╡ 0b745ff6-f149-442f-b627-e1d867f1a99e
65+131

# ╔═╡ 60d273fa-a941-46d2-b78e-3f216f26b2c4


# ╔═╡ c6cbb984-d870-48d0-b4b3-70a45b418bd9
newgrid=[gridchar gridchar gridchar ; gridchar gridchar gridchar; gridchar gridchar gridchar]

# ╔═╡ 72324a24-aad9-4287-b89a-44933708aa52
newgrid2=[newgrid newgrid newgrid ; newgrid newgrid newgrid; newgrid newgrid newgrid]

# ╔═╡ b1d50688-f68b-40a8-af70-d44b521f817e
x=div(26501365-65,131)

# ╔═╡ 03961f5f-36a3-4540-b2ec-ce3ef40aff16
format(15505*x^2+15633*x+3944)

# ╔═╡ 99743bf0-97e6-46cc-b601-c2e33707e7d3
131*131*9*9

# ╔═╡ 8a6c5366-924d-4260-9411-81065a0e6dc2
steps(65+131*2,newgrid2)

# ╔═╡ 099b2789-b298-4e23-9efa-ce123e7b389b
newgrid2

# ╔═╡ a6542cfe-0b12-4591-a6f1-ac6f887c5516
start=findall(x->x=='S',gridchar)[1]


# ╔═╡ 7ccf4a65-b89a-4e8c-9b34-2356f705ed9f
a=Tuple(start)

# ╔═╡ 77accc90-c9b4-4e63-923d-db2ef4e1ad95
b=Set([a,a])

# ╔═╡ 36f0296d-a6a4-4cd6-8f95-fc4612b121ec
b

# ╔═╡ 97885fef-e357-46de-bc36-1cfad73601b0
push!(b,(45,45))

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Formatting = "59287772-0a20-5a39-b81b-1366585eb4c0"

[compat]
Formatting = "~0.4.2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.4"
manifest_format = "2.0"
project_hash = "2cd656843ed1d118ea623a8384039a9dd22dafac"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
"""

# ╔═╡ Cell order:
# ╠═f84bce24-9fc8-11ee-37c0-5daa0e4a7166
# ╠═72fddcf0-101c-43f9-b111-bda22c704fac
# ╠═8ecb02ff-cd3a-4ce2-8441-ed6a0724261c
# ╠═1aaf28f9-f787-43a2-bdf3-392a99cb6894
# ╠═0b745ff6-f149-442f-b627-e1d867f1a99e
# ╠═60d273fa-a941-46d2-b78e-3f216f26b2c4
# ╠═c6cbb984-d870-48d0-b4b3-70a45b418bd9
# ╠═72324a24-aad9-4287-b89a-44933708aa52
# ╠═b1d50688-f68b-40a8-af70-d44b521f817e
# ╠═03961f5f-36a3-4540-b2ec-ce3ef40aff16
# ╠═99743bf0-97e6-46cc-b601-c2e33707e7d3
# ╠═c049d405-1968-4989-9964-dca1cf8e4a7f
# ╠═8a6c5366-924d-4260-9411-81065a0e6dc2
# ╠═099b2789-b298-4e23-9efa-ce123e7b389b
# ╠═a6542cfe-0b12-4591-a6f1-ac6f887c5516
# ╠═7ccf4a65-b89a-4e8c-9b34-2356f705ed9f
# ╠═77accc90-c9b4-4e63-923d-db2ef4e1ad95
# ╠═36f0296d-a6a4-4cd6-8f95-fc4612b121ec
# ╠═97885fef-e357-46de-bc36-1cfad73601b0
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
