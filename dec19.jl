### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ c41e4c96-a685-11ee-34cf-5b1c85c7b6a4
using DelimitedFiles

# ╔═╡ 3cf9ccd8-c8ed-4841-811e-1e55f53b0716
using DataStructures

# ╔═╡ cb252185-ea38-4d02-899b-74994716cb34
function part1(workflows,parts)
	total=0
	for part in parts
		current_workflow="in"
		
		while current_workflow ∉ ["A","R"]
			for rule in workflows[current_workflow]
				if rule.comp( getfield(part,rule.prop))
					current_workflow = rule.target
					break
				end
			end
		end
		if current_workflow=="A"
			for s in [Symbol("x"),Symbol("m"),Symbol("a"),Symbol("s")]
				total += getfield(part,s)
			end
		end
	end	
	return total
end

# ╔═╡ fc95b71e-30b1-4fca-8042-277b53ff61e8
struct Rule
	prop::Symbol
	comp
	compvalue::Int
	sign::String
	target::String
end

# ╔═╡ 0869c3c0-6501-4c80-8c6c-b11311b2f035
function parserule(str)
	prop, sign, val, target = match(r"(.*)([<>])(\d+):(.*)",str)
	val = parse(Int,val)
	comp = sign == ">" ? >(val) : <(val)
	return Rule(Symbol(prop), comp,val,sign, target)
end

# ╔═╡ 7c981bb0-c34a-4980-8e01-84658e559a46


# ╔═╡ 2fa3591f-eb3e-4e4f-816e-8b4f2c86bf73
struct Part
	x::Int
	m::Int
	a::Int
	s::Int
end

# ╔═╡ 802abfb2-619f-467b-b92c-720fe25f5f7a
function read_file(file::String)
	workflows=Dict()
	parts=[]
	open(file, "r") do io
       lr=readuntil(io,"\n\n")
		for line in split.(split(lr),"{")
			rules=split(line[2],",")
			workflows[line[1]]=[parserule(x) for x in rules[1:end-1]]
			push!(workflows[line[1]], Rule(Symbol("x"),<(5000),5000,"<",strip(rules[end],'}')))
			
		end
		while !eof(io)   
        	
			push!(parts,Part(parse.(Int,split(readline(io),!isdigit;keepempty=false))... ))
		end
   end
   return workflows, parts
end

# ╔═╡ 1692004a-08d6-4316-924b-ff9f10908f42

workflows, parts =read_file("day19.txt")

# ╔═╡ 41a718af-cf86-4a98-a3d4-8f2d4cd34011
part1(workflows,parts)

# ╔═╡ 1c1a2078-ef84-4afc-8a04-03594cd03f7f
mutable struct PartInterval
	x::UnitRange{Int}
	m::UnitRange{Int}
	a::UnitRange{Int}
	s::UnitRange{Int}
end

# ╔═╡ c47f8222-e29e-494a-ae0f-8a54a1d9416a
function part2(workflows)
	total=0
	q=Queue{Any}()
	u=UnitRange(1,4000)
	current_workflow=("in",PartInterval(u,u,u,u))
	enqueue!(q,current_workflow)
	while !isempty(q)
		current_workflow=dequeue!(q)
		part=current_workflow[2]
		flow=current_workflow[1]
		if flow in ["A","R"]
			if flow=="A"
				
				prod=1
				for s in [Symbol("x"),Symbol("m"),Symbol("a"),Symbol("s")]
					prod =prod* length(getfield(part,s))
				end
				total+=prod
			end
		else		
			for rule in workflows[flow]
				currrange=getfield(part,rule.prop)
				
				if rule.comp(minimum(currrange)) || rule.comp(maximum(currrange))
					if rule.compvalue ∉ currrange
						enqueue!(q,(rule.target,part))
						break
					elseif rule.sign=="<"
						newpart=deepcopy(part)
						
						setfield!(newpart,rule.prop, UnitRange(minimum(currrange),rule.compvalue-1) )
						enqueue!(q,(rule.target,newpart))
						setfield!(part,rule.prop,UnitRange(rule.compvalue,maximum(currrange)))
					elseif rule.sign==">"
						newpart=deepcopy(part)
						setfield!(newpart,rule.prop, UnitRange(rule.compvalue+1,maximum(currrange)) )				
	
						enqueue!(q,(rule.target,newpart))
						setfield!(part,rule.prop,UnitRange(minimum(currrange),rule.compvalue))
						
	
					
					end
				end
			end
		end
	end
	return total
end

# ╔═╡ ea5e1834-e143-4d9d-ba53-bbfcb53f93f4
part2(workflows)

# ╔═╡ 9eab0855-2ff0-44e0-acab-9ceea9606f7c
PartInterval(UnitRange(1,4000),UnitRange(1,4000),UnitRange(1,4000),UnitRange(1,4000))

# ╔═╡ e1bb8b71-ef6f-4180-b564-75808e062a94
p=Symbol("x")

# ╔═╡ 0a769797-6001-4412-96ea-d7cc2cc08fc8
<(2)(minimum(UnitRange(typemin(Int),typemax(Int))))

# ╔═╡ bb3ec27e-70ba-4ffd-a3ba-597066ce5ca7
struct Interval{T<:Int}
    lo :: T
    hi :: T
end

# ╔═╡ a7ad7476-9fe0-46e8-b2ba-5727e429d53d
function splitInterval(i::Interval,f)
	if f(i.lo) || f(i.hi)
		println("hi")
	end
end

# ╔═╡ 53ed140c-c251-4c0f-aca7-51a4a62d2bc6
splitInterval(Interval(0,20),<(1))

# ╔═╡ 864c2d9c-4a6b-420a-bae4-c118feb77c06


# ╔═╡ 27aaf4d0-41f0-4dbb-b599-38d7cd537776
setfield!()

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
# ╠═c41e4c96-a685-11ee-34cf-5b1c85c7b6a4
# ╠═802abfb2-619f-467b-b92c-720fe25f5f7a
# ╠═1692004a-08d6-4316-924b-ff9f10908f42
# ╠═0869c3c0-6501-4c80-8c6c-b11311b2f035
# ╠═cb252185-ea38-4d02-899b-74994716cb34
# ╠═c47f8222-e29e-494a-ae0f-8a54a1d9416a
# ╠═3cf9ccd8-c8ed-4841-811e-1e55f53b0716
# ╠═41a718af-cf86-4a98-a3d4-8f2d4cd34011
# ╠═ea5e1834-e143-4d9d-ba53-bbfcb53f93f4
# ╠═fc95b71e-30b1-4fca-8042-277b53ff61e8
# ╠═7c981bb0-c34a-4980-8e01-84658e559a46
# ╠═2fa3591f-eb3e-4e4f-816e-8b4f2c86bf73
# ╠═1c1a2078-ef84-4afc-8a04-03594cd03f7f
# ╠═9eab0855-2ff0-44e0-acab-9ceea9606f7c
# ╠═e1bb8b71-ef6f-4180-b564-75808e062a94
# ╠═0a769797-6001-4412-96ea-d7cc2cc08fc8
# ╠═a7ad7476-9fe0-46e8-b2ba-5727e429d53d
# ╠═bb3ec27e-70ba-4ffd-a3ba-597066ce5ca7
# ╠═53ed140c-c251-4c0f-aca7-51a4a62d2bc6
# ╠═864c2d9c-4a6b-420a-bae4-c118feb77c06
# ╠═27aaf4d0-41f0-4dbb-b599-38d7cd537776
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
