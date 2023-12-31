### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ 5eb13f22-1c79-4111-b61d-4438dfc7e48c
using PlutoUI

# ╔═╡ 902b33ca-9d48-11ee-334c-790f228c9dc2
grid=split(read("day17.txt",String))

# ╔═╡ 30e0212e-25cd-464d-913b-3d9ab35a1e03
gridchar=parse.(Int,reduce(vcat, permutedims.(collect.(grid))))


# ╔═╡ dd31e275-9378-4758-8deb-e27c679d322e


# ╔═╡ 5dd97b9c-14c6-4be2-a59d-efedcadcdb32


# ╔═╡ 32e7cb1d-db16-4aba-aea6-794918604f7e


# ╔═╡ 9680f35f-6e2b-46da-ac29-2f6546ff2124


# ╔═╡ d811ea3b-138b-4493-8c57-5284372840ea


# ╔═╡ 9cc5d892-cf7c-4ed1-9a4e-0d2f07109ab3


# ╔═╡ 3d66d277-02b8-4c96-8d55-50924c105c04


# ╔═╡ 36a38e3b-8cff-4229-aabd-efcd4202f1b0
# ╠═╡ disabled = true
#=╠═╡
function shortest_path(gridchar)
	tentative_dist=zeros(size(gridchar)...,12)
	tentative_dist[:,:,:] .=typemax(Int)-1
	tentative_dist[1,1,1]=0
	#parents=Array{CartesianIndex{3},3}(undef,size(tentative_dist)...)
	current_node=CartesianIndex(1,1,1)
	unvisited=trues(size(tentative_dist))

	#the third dimension is the incoming direction. 
	# 1,2,3 are up
	#4,5,6 are left
	#7,8,9 are down
	#10,11,12 are right
	levels=Dict(
		0=>CartesianIndex(-1,0),
		1=>CartesianIndex(0,-1),
		2=>CartesianIndex(1,0),
		3=>CartesianIndex(0,1)		
	)
	reset_index=Dict(
		CartesianIndex(-1,0)=>1,
		CartesianIndex(0,-1)=>4,
		CartesianIndex(1,0)=>7,
		CartesianIndex(0,1)=>10				
	)

	#need to check if direction is the same as the one coming in 
	#if so, increment. if not, go to 1
	
	while any(unvisited[end,end,7:12])

		for dir in cards
			lt_four_in_arow=true
			if dir == levels[(current_node[3]-1) ÷ 3] && mod(current_node[3]-1,3)==2
				lt_four_in_arow=false
				
			elseif dir == levels[(current_node[3]-1) ÷ 3]
				next_node = current_node + CartesianIndex(Tuple(dir)...,1)


			else 
				
				next_node = current_node + CartesianIndex(Tuple(dir)...,1)
				next_node=CartesianIndex(Tuple(next_node)[1:2]...,reset_index[dir])

			end
				
			if lt_four_in_arow && 1<=(next_node)[2]<=size(gridchar,2) && 1<=(next_node)[1]<=size(gridchar,1) && unvisited[next_node] && (dir !=levels[(current_node[3]-1) ÷ 3]*-1 || current_node==CartesianIndex(1,1,1))
				if tentative_dist[current_node]+gridchar[CartesianIndex(Tuple(next_node)[1:2])]<tentative_dist[next_node]
					tentative_dist[next_node]=tentative_dist[current_node]+gridchar[CartesianIndex(Tuple(next_node)[1:2])]
					#parents[next_node]=current_node
				end
	
			end
		end
		unvisited[current_node]=false
		current_node=findmin( x -> unvisited[x] ? tentative_dist[x] : Inf, eachindex(IndexCartesian(),tentative_dist))[2]
		
	end
	return tentative_dist
end
  ╠═╡ =#

# ╔═╡ fb74d14b-10f5-473a-abf9-2c69fcb26054
# ╠═╡ disabled = true
#=╠═╡
distances = shortest_path(gridchar)
  ╠═╡ =#

# ╔═╡ a609e3d5-edac-43b9-bba0-76888ff0440d
cards=[CartesianIndex(0,1),CartesianIndex(0,-1),CartesianIndex(1,0),CartesianIndex(-1,0) ]

# ╔═╡ 3319f1d4-b9be-4708-a401-1b5df49c37af


# ╔═╡ e1667574-5eb4-4be8-a7bf-1c1085a420d5


# ╔═╡ c253f935-e3ae-4017-b79c-351fc1261090
# ╠═╡ disabled = true
#=╠═╡
minimum(distances[end,end,:])
  ╠═╡ =#

# ╔═╡ 1f7abe6e-02c0-4579-b5a4-07a8cef9d4bf


# ╔═╡ 5be1939e-fd9a-43cd-a550-aaebafd1c8e1


# ╔═╡ fb4775bf-cfc2-4d34-ac1f-b9eea0fa4736


# ╔═╡ acad0eb5-0279-4287-aeca-68c80aee941c
function shortest_path_part2(gridchar)
	tentative_dist=zeros(size(gridchar)...,2)
	tentative_dist[:,:,:] .=typemax(Int)-1
	tentative_dist[1,1,2]=0
	parents=Array{CartesianIndex{3}}(undef,size(tentative_dist))
	
	current_node=CartesianIndex(1,1,2)

	unvisited=trues(size(tentative_dist))

	#the third dimension is the incoming direction. 1 is horizontal, 2 is vertical

	#need to check if direction is the same as the one coming in 
	#if so, increment. if not, go to 1
	if current_node[3]==1
		changelevel=CartesianIndex(0,0,1)
		dirs=[CartesianIndex(1,0,0),CartesianIndex(-1,0,0)]
	else
		changelevel=CartesianIndex(0,0,-1)
		dirs=[CartesianIndex(0,1,0),CartesianIndex(0,-1,0)]	
	end
	curr_node_next_level = current_node+changelevel
	for step in 4:10
		for dir in dirs
			next_node = curr_node_next_level + step*dir
			
			if CartesianIndex(Tuple(next_node)[1:2]) in CartesianIndices(gridchar) && unvisited[next_node]
				println(next_node)
				if sum(Tuple(dir))==-1
					new_cost=sum(gridchar[CartesianIndex(Tuple(next_node)[1:2]):CartesianIndex(Tuple(curr_node_next_level +dir)[1:2])])

				else
					new_cost=sum(gridchar[CartesianIndex(Tuple(curr_node_next_level +dir)[1:2]):CartesianIndex(Tuple(next_node)[1:2])])

				end
				println(new_cost)
				if tentative_dist[next_node]> new_cost+tentative_dist[current_node]
					tentative_dist[next_node] = min(tentative_dist[next_node],new_cost+tentative_dist[current_node])
					parents[next_node]=current_node
				end			
			end
		end
	end
	unvisited[current_node]=false
	
	tentative_dist[1,1,1]=0
	
	current_node=CartesianIndex(1,1,1)
	
	while any(unvisited[end,end,:])
		
		if current_node[3]==1
			changelevel=CartesianIndex(0,0,1)
			dirs=[CartesianIndex(1,0,0),CartesianIndex(-1,0,0)]
		else
			changelevel=CartesianIndex(0,0,-1)
			dirs=[CartesianIndex(0,1,0),CartesianIndex(0,-1,0)]	
		end
		curr_node_next_level = current_node+changelevel
		for step in 4:10
			for dir in dirs
				next_node = curr_node_next_level + step*dir
				
				if CartesianIndex(Tuple(next_node)[1:2]) in CartesianIndices(gridchar) && unvisited[next_node]
					println(next_node)
					if sum(Tuple(dir))==-1
						new_cost=sum(gridchar[CartesianIndex(Tuple(next_node)[1:2]):CartesianIndex(Tuple(curr_node_next_level +dir)[1:2])])
	
					else
						new_cost=sum(gridchar[CartesianIndex(Tuple(curr_node_next_level +dir)[1:2]):CartesianIndex(Tuple(next_node)[1:2])])
	
					end

					println(new_cost)
					if tentative_dist[next_node]> new_cost+tentative_dist[current_node]
						tentative_dist[next_node] = min(tentative_dist[next_node],new_cost+tentative_dist[current_node])
						parents[next_node]=current_node
	
					end
				end
			end
		end				
		
		unvisited[current_node]=false
		current_node=findmin( x -> unvisited[x] ? tentative_dist[x] : Inf, eachindex(IndexCartesian(),tentative_dist))[2]
		
	end
	return tentative_dist, parents
end


# ╔═╡ 2101db09-b671-4aa3-994d-49a353670491
part2dist , pars=shortest_path_part2(gridchar)

# ╔═╡ 936ef9e7-5b3e-409b-9b5a-e97bdfc7c6b1
minimum(part2dist[end,end,:])

# ╔═╡ 3cc11585-f622-4674-ae74-a3af8e4a2389
part2dist[:,:,1]

# ╔═╡ 86da2b0c-631d-4645-baed-105be1cfec18
PlutoUI.WithIOContext(part2dist[:,:,1], displaysize=(99999,99999))

# ╔═╡ 0b3cfbd8-4e6a-4512-90e2-699383300fa5
PlutoUI.WithIOContext(part2dist[:,:,2], displaysize=(99999,99999))

# ╔═╡ 6f898b4e-015c-488e-80c4-82be0585bcf5
PlutoUI.WithIOContext(pars[:,:,1], displaysize=(99999,99999))

# ╔═╡ 1cd6e207-21cc-4550-8530-cca1fea7c651
PlutoUI.WithIOContext(pars[:,:,2], displaysize=(99999,99999))

# ╔═╡ 25f20965-54de-49a3-aee9-372f5b70b1af
sum(Tuple(CartesianIndex(0,1)))

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.54"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.4"
manifest_format = "2.0"
project_hash = "3c61004d0ad425a97856dfe604920e9ff261614a"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "793501dcd3fa7ce8d375a2c878dca2296232686e"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.2.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.5+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "d75853a0bdbfb1ac815478bacd89cd27b550ace6"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.3"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

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

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

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

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "a935806434c9d4c506ba941871b327b96d41f2bf"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.9.2"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "bd7c69c7f7173097e7b5e1be07cee2b8b7447f51"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.54"

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

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

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

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "eae1bb484cd63b36999ee58be2de6c178105112f"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.8"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

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
# ╠═902b33ca-9d48-11ee-334c-790f228c9dc2
# ╠═30e0212e-25cd-464d-913b-3d9ab35a1e03
# ╠═dd31e275-9378-4758-8deb-e27c679d322e
# ╠═5dd97b9c-14c6-4be2-a59d-efedcadcdb32
# ╠═32e7cb1d-db16-4aba-aea6-794918604f7e
# ╠═9680f35f-6e2b-46da-ac29-2f6546ff2124
# ╠═d811ea3b-138b-4493-8c57-5284372840ea
# ╠═9cc5d892-cf7c-4ed1-9a4e-0d2f07109ab3
# ╠═3d66d277-02b8-4c96-8d55-50924c105c04
# ╠═36a38e3b-8cff-4229-aabd-efcd4202f1b0
# ╠═fb74d14b-10f5-473a-abf9-2c69fcb26054
# ╠═a609e3d5-edac-43b9-bba0-76888ff0440d
# ╠═3319f1d4-b9be-4708-a401-1b5df49c37af
# ╠═e1667574-5eb4-4be8-a7bf-1c1085a420d5
# ╠═c253f935-e3ae-4017-b79c-351fc1261090
# ╠═1f7abe6e-02c0-4579-b5a4-07a8cef9d4bf
# ╠═5be1939e-fd9a-43cd-a550-aaebafd1c8e1
# ╠═fb4775bf-cfc2-4d34-ac1f-b9eea0fa4736
# ╠═acad0eb5-0279-4287-aeca-68c80aee941c
# ╠═2101db09-b671-4aa3-994d-49a353670491
# ╠═936ef9e7-5b3e-409b-9b5a-e97bdfc7c6b1
# ╠═3cc11585-f622-4674-ae74-a3af8e4a2389
# ╠═5eb13f22-1c79-4111-b61d-4438dfc7e48c
# ╠═86da2b0c-631d-4645-baed-105be1cfec18
# ╠═0b3cfbd8-4e6a-4512-90e2-699383300fa5
# ╠═6f898b4e-015c-488e-80c4-82be0585bcf5
# ╠═1cd6e207-21cc-4550-8530-cca1fea7c651
# ╠═25f20965-54de-49a3-aee9-372f5b70b1af
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
