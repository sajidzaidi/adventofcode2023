### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ f0f58ad9-6c2d-4459-90f9-65311c8d3721
using DelimitedFiles

# ╔═╡ e664530e-9934-4ac1-90f1-4014200e9f6d
using StatsBase

# ╔═╡ f8a8bc4c-3da2-485d-bd9f-cb6f8154ee4e
mat=readdlm("day7.txt")

# ╔═╡ b5a144c9-46cd-4956-8b79-7b1cfb643880
function hand_value(hand::String)
	xcounts=countmap([c for c in hand])
	hand_type=0
	if maximum(values(xcounts))==5
		hand_type=6
	elseif maximum(values(xcounts))==4
		hand_type =5
	elseif 3 in values(xcounts) && 2 in values(xcounts)
		hand_type = 4
	elseif 3 in values(xcounts)
		hand_type = 3
	elseif count(x->x==2,values(xcounts))==2
		hand_type=2
	elseif count(x->x==2,values(xcounts))==1
		hand_type=1
	end
	return hand_type
end

# ╔═╡ d9d09ee5-e998-4039-9e39-32c3e057bd24
function hand_value2(hand::String)
	xcounts=countmap([c for c in hand])
	hand_type=0
	if maximum(values(xcounts))==5
		hand_type=6
	elseif maximum(values(xcounts))==4
		if 'J' in keys(xcounts)
			hand_type=6
		else
			hand_type =5
		end
	elseif 3 in values(xcounts) && 2 in values(xcounts)
		if 'J' in keys(xcounts)
			hand_type=6
		else
			hand_type =4
		end
	elseif 3 in values(xcounts)
		if 'J' in keys(xcounts)
			hand_type=5
		else
			hand_type =3
		end
	elseif count(x->x==2,values(xcounts))==2
		if 'J' in keys(xcounts) && xcounts['J']==2
			hand_type=5
		elseif 'J' in keys(xcounts) && xcounts['J']==1
			hand_type =4
		else
			hand_type=2		
		end
		

	elseif count(x->x==2,values(xcounts))==1
		if 'J' in keys(xcounts)
			hand_type=3
		else
		
			hand_type=1
		end
	elseif 'J' in keys(xcounts)
		hand_type=1
	end
	return hand_type
end

# ╔═╡ 77f6acf6-9394-4e82-91c1-ab501c8513a6
begin
	abstract type AbstractHand end
	struct Hand <: AbstractHand
		hand::String
		bid::Int
		hand_type::Int
	end
	Hand(hand,bid)=Hand(hand,bid,hand_value(hand))

	struct Hand2 <: AbstractHand
		hand::String
		bid::Int
		hand_type::Int
	end
	Hand2(hand,bid)=Hand2(hand,bid,hand_value2(hand))

end

# ╔═╡ 466e012a-9716-11ee-0e5e-3d9f1c94bde5
function read_cards(file::String)
	hands=[]
	hands2=[]
	open(file, "r") do io
		while !eof(io)   
			r = split(readline(io))
			push!(hands,Hand(string(r[1]),parse(Int,r[2])))
			push!(hands2,Hand2(string(r[1]),parse(Int,r[2])))
			
		end
	end
	return hands, hands2
end


# ╔═╡ d7e244b7-c16d-466c-a45c-b7b80db384cb
hands, hands2 = read_cards("day7.txt")

# ╔═╡ bdfa01a0-b14f-4e66-9521-39612314ae60
function Base.:isless(x::T,y::T) where {T<:Hand} 
	
	if x.hand_type!=y.hand_type
		return x.hand_type<y.hand_type
	else 
		vals=Dict([('A',14),('K',13),('Q',12),('J',11),('T',10),('9',9),('8',8), ('7',7),('6',6),('5',5),('4',4), ('3',3),('2',2)])
		return [vals[card] for card in x.hand] < [vals[card] for card in y.hand]
	end
end

# ╔═╡ a985b0f5-3d8e-42d0-a15f-bcd59a1f68c7
function Base.:isless(x::T,y::T) where {T<:Hand2} 
	
	if x.hand_type!=y.hand_type
		return x.hand_type<y.hand_type
	else 
		vals=Dict([('A',14),('K',13),('Q',12),('J',1),('T',10),('9',9),('8',8), ('7',7),('6',6),('5',5),('4',4), ('3',3),('2',2)])
		return [vals[card] for card in x.hand] < [vals[card] for card in y.hand]
	end
end

# ╔═╡ 28263027-cc12-4ee9-bcc6-133280d1153c
sorted_hands=sort(hands)

# ╔═╡ ef22880f-bc6a-483c-9e5e-dbfe83cef87f
sum(i*x.bid for (i,x) in enumerate(sorted_hands))

# ╔═╡ 9682eb92-8880-46a3-a80a-06fd29baf262
sorted_hands2=sort(hands2)

# ╔═╡ 09b35853-2a4a-4bc8-859b-c389eba68f22
sum(i*x.bid for (i,x) in enumerate(sorted_hands2))

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DelimitedFiles = "8bb1440f-4735-579b-a4ab-409b98df4dab"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"

[compat]
DelimitedFiles = "~1.9.1"
StatsBase = "~0.34.2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.4"
manifest_format = "2.0"
project_hash = "358611211942936f16447937aac68ee9bfff8c87"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

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

[[deps.DataAPI]]
git-tree-sha1 = "8da84edb865b0b5b0100c0666a9bc9a0b71c553c"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.15.0"

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

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

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

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "7d6dd4e9212aebaeed356de34ccf262a3cd415aa"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.26"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+0"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "f66bdc5de519e8f8ae43bdc598782d35a25b1272"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.1.0"

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

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "5165dfb9fd131cf0c6957a3a7605dede376e7b63"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.0"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.9.0"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1ff449ad350c9c4cbc756624d6f8a8c3ef56d3ed"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "1d77abd07f617c4868c33d4f5b9e1dbb2643c9cf"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.2"

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
# ╠═f0f58ad9-6c2d-4459-90f9-65311c8d3721
# ╠═f8a8bc4c-3da2-485d-bd9f-cb6f8154ee4e
# ╠═466e012a-9716-11ee-0e5e-3d9f1c94bde5
# ╠═d7e244b7-c16d-466c-a45c-b7b80db384cb
# ╠═77f6acf6-9394-4e82-91c1-ab501c8513a6
# ╠═b5a144c9-46cd-4956-8b79-7b1cfb643880
# ╠═d9d09ee5-e998-4039-9e39-32c3e057bd24
# ╠═e664530e-9934-4ac1-90f1-4014200e9f6d
# ╠═bdfa01a0-b14f-4e66-9521-39612314ae60
# ╠═a985b0f5-3d8e-42d0-a15f-bcd59a1f68c7
# ╠═28263027-cc12-4ee9-bcc6-133280d1153c
# ╠═ef22880f-bc6a-483c-9e5e-dbfe83cef87f
# ╠═9682eb92-8880-46a3-a80a-06fd29baf262
# ╠═09b35853-2a4a-4bc8-859b-c389eba68f22
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
