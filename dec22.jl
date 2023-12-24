### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ 2743ebc2-2db0-46b0-aec4-b9cc3f29bc5c
using DelimitedFiles

# ╔═╡ 0a1a205b-2618-49b8-bab7-213df729b8db
using Graphs

# ╔═╡ 3ca9a7bb-964b-4930-8995-7e87cbdb2707
A=CartesianIndex.(Tuple.([parse.(Int,x) for x in split.(readdlm("day22.txt",'~'),',')]))

# ╔═╡ 3b177881-f08f-41f5-8ff3-1582dd5a110b


# ╔═╡ aaf56dd6-39ac-4ff6-a533-644fe9234cd5


# ╔═╡ f1fcac3c-30a5-4da3-b8ce-400c8ea652e8


# ╔═╡ 6ef56d48-72a7-4ca0-a653-67a4cf5e0e76


# ╔═╡ a31e1227-c7d2-4ae4-9aca-9a3d498f2161


# ╔═╡ 75fb53eb-1e16-4e0f-91b8-4a5446a39e5a


# ╔═╡ 217a43b7-1ce6-48fa-a7d6-bb91a93841b8


# ╔═╡ db8ad2a3-a39a-4e14-96f5-9563c7040add


# ╔═╡ cd0844ab-fb2f-4df9-9878-af0b61e65fbc


# ╔═╡ 72ffeab2-fd51-461c-a4d1-987cb4bd9452


# ╔═╡ 15753057-d91e-46e3-b631-3c8391fcf341
function part1(A)
	B=[A[i,1]:A[i,2] for i in 1:size(A,1)]
	sort!(B,by=x->minimum(x))
	max_x=0
	max_y=0
	max_z=0
	for brick in A
		max_x=max(max_x,brick[1])
		max_y=max(max_y,brick[2])
		max_z=max(max_z,brick[3])	
	end
	is_supported_by=[]

	for (i,brick) in enumerate(B)
		highest_support=0
		for j in 1:i
			if i!=j
				candidate_brick = B[j]
				for a in Iterators.product(brick,candidate_brick)
					point1=a[1]
					point2=a[2]
					if point1[1]==point2[1] && point1[2]==point2[2] && point1[3]>point2[3]
						if point2[3]>highest_support
							highest_support=point2[3]
						end
					end
				end
			end
		end
		distance=minimum(brick)[3]-highest_support-1
		B[i] = B[i] .- CartesianIndex(0,0,  distance )
	end
	sort!(B,by=x->minimum(x))

	for (i,brick) in enumerate(B)
		supported_by=[]
		for j in 1:i
			if i!=j
				candidate_brick = B[j]
				for a in Iterators.product(brick,candidate_brick)
					point1=a[1]
					point2=a[2]
					if point1[1]==point2[1] && point1[2]==point2[2] && point1[3]==point2[3]+1
						push!(supported_by,j)
					end
				end
			end
		end
		push!(is_supported_by,unique(supported_by))
	end
	non_disintegrable=[]
	for block in is_supported_by
		if length(block)==1
			push!(non_disintegrable,block[1])
		end
	end
	non_disintegrable=unique(non_disintegrable)
	#return length(is_supported_by) - length(non_disintegrable)

	g = SimpleDiGraph(length(is_supported_by)+1)
	for (i, arr) in enumerate(is_supported_by)
		if length(arr)>0
			for j in arr
				add_edge!(g, i, j)
			end
		end
	end
	for (i, brick) in enumerate(B)
		if minimum(brick)[3]==1
			add_edge!(g, i, length(is_supported_by)+1)
		end
	end
	falling_bricks=0
	for (i, brick) in enumerate(B)
		
		if (i in non_disintegrable) 
			for (j, upper_brick) in enumerate(B)
				if i!=j

					if !has_path(g, j,length(is_supported_by)+1; exclude_vertices=[i])
						falling_bricks+=1
					end
				end
			end
		end
	end
	return falling_bricks
	

end

# ╔═╡ 8a6c22b1-4c3b-4202-9921-27917052cbcb
g=part1(A)

# ╔═╡ bdc3caf7-7cb8-4104-84d8-13188d6a3738
has_path(g, 8, 7; exclude_vertices=[2,3])

# ╔═╡ 9254b875-e620-48e1-985b-60b9d92ec0fb


# ╔═╡ 7b2c7740-0e97-4937-bcf9-331280411728


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DelimitedFiles = "8bb1440f-4735-579b-a4ab-409b98df4dab"
Graphs = "86223c79-3864-5bf0-83f7-82e725a168b6"

[compat]
DelimitedFiles = "~1.9.1"
Graphs = "~1.9.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.4"
manifest_format = "2.0"
project_hash = "834322349ac094329d43a069306a57ec9e4f50b8"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.ArnoldiMethod]]
deps = ["LinearAlgebra", "Random", "StaticArrays"]
git-tree-sha1 = "62e51b39331de8911e4a7ff6f5aaf38a5f4cc0ae"
uuid = "ec485272-7323-5ecc-a04f-4719b315124d"
version = "0.2.0"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Compat]]
deps = ["UUIDs"]
git-tree-sha1 = "886826d76ea9e72b35fcd000e535588f7b60f21d"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.10.1"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.5+0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "3dbd312d370723b6bb43ba9d02fc36abade4518d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.15"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.Graphs]]
deps = ["ArnoldiMethod", "Compat", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "899050ace26649433ef1af25bc17a815b3db52b7"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.9.0"

[[deps.Inflate]]
git-tree-sha1 = "ea8031dea4aff6bd41f1df8f2fdfb25b33626381"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.4"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.4.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "9ee1618cbf5240e6d4e0371d6f24065083f60c48"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.11"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.10.11"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.21+4"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.9.2"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "03b4c25b43cb84cee5c90aa9b5ea0a78fd848d2f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00805cd429dcb4870060ff49ef443486c262e38e"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore"]
git-tree-sha1 = "5ef59aea6f18c25168842bded46b16662141ab87"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.7.0"
weakdeps = ["Statistics"]

    [deps.StaticArrays.extensions]
    StaticArraysStatisticsExt = "Statistics"

[[deps.StaticArraysCore]]
git-tree-sha1 = "36b3d696ce6366023a0ea192b4cd442268995a0d"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.2"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.9.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "Pkg", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "5.10.1+6"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"
"""

# ╔═╡ Cell order:
# ╠═2743ebc2-2db0-46b0-aec4-b9cc3f29bc5c
# ╠═3ca9a7bb-964b-4930-8995-7e87cbdb2707
# ╠═3b177881-f08f-41f5-8ff3-1582dd5a110b
# ╠═aaf56dd6-39ac-4ff6-a533-644fe9234cd5
# ╠═f1fcac3c-30a5-4da3-b8ce-400c8ea652e8
# ╠═6ef56d48-72a7-4ca0-a653-67a4cf5e0e76
# ╠═a31e1227-c7d2-4ae4-9aca-9a3d498f2161
# ╠═75fb53eb-1e16-4e0f-91b8-4a5446a39e5a
# ╠═217a43b7-1ce6-48fa-a7d6-bb91a93841b8
# ╠═db8ad2a3-a39a-4e14-96f5-9563c7040add
# ╠═cd0844ab-fb2f-4df9-9878-af0b61e65fbc
# ╠═72ffeab2-fd51-461c-a4d1-987cb4bd9452
# ╠═15753057-d91e-46e3-b631-3c8391fcf341
# ╠═8a6c22b1-4c3b-4202-9921-27917052cbcb
# ╠═bdc3caf7-7cb8-4104-84d8-13188d6a3738
# ╠═0a1a205b-2618-49b8-bab7-213df729b8db
# ╠═9254b875-e620-48e1-985b-60b9d92ec0fb
# ╠═7b2c7740-0e97-4937-bcf9-331280411728
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
