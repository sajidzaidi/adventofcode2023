### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ c3237076-9f4d-11ee-3253-b97065f4e629
using DelimitedFiles

# ╔═╡ 5cb79573-3243-4651-8b42-d76ffdb997ba
using DataStructures

# ╔═╡ 82c72ce3-b204-498a-9126-b216659b31f7


# ╔═╡ bd7a0be2-462b-415b-80bd-c243a864270a


# ╔═╡ 02e3661d-48a3-4db0-b1e3-972d0e016de0


# ╔═╡ 4cca46cd-7778-4118-8632-32a74b813b0a


# ╔═╡ f0009927-e287-47c7-9caf-ac67ce2a1b20
lcm(3733,3797,3823,3907)

# ╔═╡ 076b96c1-7cce-4e27-86d7-771fb244a5a2
abstract type Node end

# ╔═╡ cb18028b-ecb8-4582-a97d-d1884b9d4ecb
begin
	struct flipflop <: Node
	  state::Bool
	  children::Vector{String}
	  name::String
	end
	flipflop(name)=flipflop(false,String[],name)
	flipflop(child::String,name)=flipflop(false,String[child],name)
	flipflop(children::Vector{String},name)=flipflop(false,children,name)
end

# ╔═╡ 305234c0-64da-4ff0-a2ae-3a66487ded2f
begin
	struct conjunction <: Node
	  memories::Dict{String,Bool}
	  children::Vector{String}
	  name::String
	end
	conjunction(children::Vector{String},name)=conjunction(Dict{String,Bool}(),children,name)
end

# ╔═╡ 759b35c0-8eb7-4989-b2a8-e75c8e5d04a3
begin
	struct broadcaster <: Node
	  children::Vector{String}
	  name::String
	end
end

# ╔═╡ 7bbf2a19-8948-4a99-b1b8-5ba54e58d47d
function addparent!(x::conjunction,parent::String)
	x.memories[parent]=false
end

# ╔═╡ 97419823-0f79-44d4-87d5-056de8a5510b
function read_mods(file::String)
	Nodes=Dict()
	open(file, "r") do io
		while !eof(io)   
			r = split(readline(io),[',',' '])
			r=filter((i) -> i != "", r)
			if r[1][1]=='%'
				Nodes[String(r[1][2:end])]=flipflop(String.(r[3:end]),String(r[1][2:end]))
			elseif r[1][1]=='&'
				Nodes[String(r[1][2:end])]=conjunction(String.(r[3:end]),String(r[1][2:end]))				
			elseif r[1]=="broadcaster"
				Nodes["broadcaster"]=broadcaster(r[3:end],"broadcaster")
			end
		end
	end
	for (key,val) in Nodes
		for child in val.children
			if child in keys(Nodes) && Nodes[child] isa conjunction
				addparent!(Nodes[child],key)
			end
		end
	end
	return Nodes
end


# ╔═╡ 539fe481-dfd7-49d9-b889-1d28c48a3529
Nodes=read_mods("day20.txt")

# ╔═╡ b6a02c47-5fc2-49e8-88de-a5c64450ad5a
function addchild!(x::flipflop,child::String)
	push!(x.children,child)
end

# ╔═╡ 67537e1d-7b3d-4802-a713-4e8e8dc4e144
function receivepulse(node::flipflop,pulse::Bool,sender::String)
	if pulse
		#high pulse do nothing
		return []
	elseif !pulse		
		Nodes[node.name]=flipflop(!node.state,node.children,node.name)
		return [(child,!node.state,node.name) for child in node.children]
		# low pulse switch the state between on and off
		
	end
end

# ╔═╡ 0bec91b8-548d-475c-9c94-fd2bf8254c7c
function receivepulse(node::conjunction,pulse::Bool,sender::String)
	node.memories[sender]=pulse
	if all(values(node.memories))
		return [(child,false,node.name) for child in node.children]
		
	else
		return [(child,true,node.name) for child in node.children]
	end
end

# ╔═╡ eb52895f-b83b-4a96-9c18-6bb1e188d496
function receivepulse(node::broadcaster,pulse::Bool,sender::String)
	return [(child,false,node.name) for child in node.children]
end

# ╔═╡ 5632e470-9597-4f16-8a96-955be09af62d
function part1(Nodes)
	lowpulses=0
	highpulses=0
	finalmachine=false
	buttons=0
	while !finalmachine
		buttons+=1
	#for i in 1:1000
		q = Queue{Any}()
		
		enqueue!(q, ("broadcaster",false,"button"))
		while !isempty(q)
			child=dequeue!(q)
			!child[2] ? lowpulses+=1 : highpulses+=1
			if child[1]=="rx" && !child[2]
				finalmachine=true
				println("$buttons buttons")
			end
			if haskey(Nodes,child[1])
				if child[1] in ("ct","kp","ks","xc") && !child[2]
					gate=child[1]
					println("$buttons and $gate")
				end
				a=receivepulse(Nodes[child[1]],child[2],child[3])
				for x in 1:length(a)
					enqueue!(q, a[x])
				end
			end
		end
		
	end
	return lowpulses*highpulses
end

# ╔═╡ 5c4e95f2-91a7-4881-aab3-68c9d7705e20
part1(Nodes)

# ╔═╡ 9abf055d-2a68-4a70-850f-d84e0f2ae68f


# ╔═╡ b9b093c2-5612-43a5-b290-9132d817b110


# ╔═╡ 64c3fbca-36d6-461f-8c0b-3bcea399d9af


# ╔═╡ 8d0eaea6-df7a-4c6c-b01e-187243a35b12


# ╔═╡ 53772ae8-b083-45ca-ba39-947b327ab68d


# ╔═╡ 0e0e5d67-2142-4081-970a-898922936461


# ╔═╡ a35b7e8e-e2a1-436a-9123-84ed087e1953


# ╔═╡ 22691f91-0aac-4fcf-858e-2abd6ea03332


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
# ╠═c3237076-9f4d-11ee-3253-b97065f4e629
# ╠═82c72ce3-b204-498a-9126-b216659b31f7
# ╠═97419823-0f79-44d4-87d5-056de8a5510b
# ╠═539fe481-dfd7-49d9-b889-1d28c48a3529
# ╠═bd7a0be2-462b-415b-80bd-c243a864270a
# ╠═5cb79573-3243-4651-8b42-d76ffdb997ba
# ╠═02e3661d-48a3-4db0-b1e3-972d0e016de0
# ╠═4cca46cd-7778-4118-8632-32a74b813b0a
# ╠═5632e470-9597-4f16-8a96-955be09af62d
# ╠═5c4e95f2-91a7-4881-aab3-68c9d7705e20
# ╠═f0009927-e287-47c7-9caf-ac67ce2a1b20
# ╠═076b96c1-7cce-4e27-86d7-771fb244a5a2
# ╠═cb18028b-ecb8-4582-a97d-d1884b9d4ecb
# ╠═305234c0-64da-4ff0-a2ae-3a66487ded2f
# ╠═759b35c0-8eb7-4989-b2a8-e75c8e5d04a3
# ╠═7bbf2a19-8948-4a99-b1b8-5ba54e58d47d
# ╠═b6a02c47-5fc2-49e8-88de-a5c64450ad5a
# ╠═67537e1d-7b3d-4802-a713-4e8e8dc4e144
# ╠═0bec91b8-548d-475c-9c94-fd2bf8254c7c
# ╠═eb52895f-b83b-4a96-9c18-6bb1e188d496
# ╠═9abf055d-2a68-4a70-850f-d84e0f2ae68f
# ╠═b9b093c2-5612-43a5-b290-9132d817b110
# ╠═64c3fbca-36d6-461f-8c0b-3bcea399d9af
# ╠═8d0eaea6-df7a-4c6c-b01e-187243a35b12
# ╠═53772ae8-b083-45ca-ba39-947b327ab68d
# ╠═0e0e5d67-2142-4081-970a-898922936461
# ╠═a35b7e8e-e2a1-436a-9123-84ed087e1953
# ╠═22691f91-0aac-4fcf-858e-2abd6ea03332
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
