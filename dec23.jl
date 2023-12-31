### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ e76625a0-d88a-4315-ab20-6c89a050b867
import Pkg

# ╔═╡ e7634b90-34b7-4e6e-b88d-2b9570765f32
Pkg.add("LongestPaths")

# ╔═╡ edeab654-f37e-47ae-8c20-a537ba5318e7
using DataStructures

# ╔═╡ bb30030b-d98a-402b-b893-0885bf9bfa0d
using LongestPaths

# ╔═╡ 521f5613-0869-4f0f-804e-8e78f9a91fa6
using Graphs

# ╔═╡ c1d56892-a811-11ee-110d-677a8510edc7
grid=split(read("day23.txt",String))

# ╔═╡ 5d4e8c33-a286-4091-ad7f-b617c2cc184f
gridchar=reduce(vcat, permutedims.(collect.(grid)))


# ╔═╡ 212b9306-bf80-45f6-bb45-7b7335f0c4e6
function part1(gridchar)
	paths_from_breakpoint=Dict()
	q=Queue{Any}()
	dirs=[CartesianIndex(0,1),CartesianIndex(1,0),CartesianIndex(0,-1),CartesianIndex(-1,0)]
	current_node =CartesianIndex(1,2)
	unique_id=0
	paths_from_breakpoint[(current_node,unique_id)]=[current_node]
	enqueue!(q,(current_node,unique_id))

	unique_id+=1
	ice_map=Dict('>'=> CartesianIndex(0,1),
		'<'=> CartesianIndex(0,-1),
		'v'=> CartesianIndex(1,0),		
		'^'=> CartesianIndex(-1,0)		
	)
	
	
	while !isempty(q)
		last_breakpoint=dequeue!(q)
		current_node = last_breakpoint[1]
		while true
			nodes_to_explore=[]
			for dir in dirs
				next_node=current_node + dir
#				if gridchar[next_node]='v' println(ice_map[gridchar[next_node]])
				if next_node in CartesianIndices(gridchar) && gridchar[next_node]!='#' && (gridchar[next_node]=='.' || gridchar[next_node] in collect(keys(ice_map)) ) && next_node ∉ paths_from_breakpoint[last_breakpoint]
					
					push!(nodes_to_explore, next_node)
				end
			end
			if length(nodes_to_explore)>1
				for n in nodes_to_explore[2:end]
					enqueue!(q,(n,unique_id))
					paths_from_breakpoint[(n,unique_id)]=deepcopy(paths_from_breakpoint[last_breakpoint])
					push!(paths_from_breakpoint[(n,unique_id)],n)
					unique_id+=1
					
				end

				push!(paths_from_breakpoint[last_breakpoint],nodes_to_explore[1])
				current_node=nodes_to_explore[1]
			elseif length(nodes_to_explore)==1
				push!(paths_from_breakpoint[last_breakpoint],nodes_to_explore[1])
				current_node=nodes_to_explore[1]
			else
				break
				
			end
			
		end
	end
	 #paths_from_breakpoint 
	return maximum(map(x->length(x), filter(x->x[end][1]==size(gridchar,1), collect(values(paths_from_breakpoint)))))-1
end


# ╔═╡ aeaeae9e-fb8d-43ea-8014-dc6d84b4ef1b
# ╠═╡ disabled = true
#=╠═╡
part1(gridchar)
  ╠═╡ =#

# ╔═╡ b858c8fd-1439-4b59-bbea-3646b4f2e223
#copied from zulip, brute force not working
function part2_copy(input)
	#m = eachline(input)
	vertices = Dict(p=>i for (i,p) in enumerate(findall(!=('#'),input )))
	g=SimpleDiGraph(length(vertices))
	for (p,i ) in vertices
		for dp in CartesianIndex.(((1,0),(0,1),(-1,0),(0,-1)))
			if get(input,p+dp,'#') !='#'
				add_edge!(g,i,vertices[p+dp])
			end
		end
	end
	find_longest_path(g,1,length(vertices),reduce_unbranched=true)
end
	

# ╔═╡ d471261f-e944-4e26-b123-cf1665e22b8b
part2_copy(gridchar)

# ╔═╡ Cell order:
# ╠═c1d56892-a811-11ee-110d-677a8510edc7
# ╠═5d4e8c33-a286-4091-ad7f-b617c2cc184f
# ╠═212b9306-bf80-45f6-bb45-7b7335f0c4e6
# ╠═edeab654-f37e-47ae-8c20-a537ba5318e7
# ╠═aeaeae9e-fb8d-43ea-8014-dc6d84b4ef1b
# ╠═bb30030b-d98a-402b-b893-0885bf9bfa0d
# ╠═b858c8fd-1439-4b59-bbea-3646b4f2e223
# ╠═d471261f-e944-4e26-b123-cf1665e22b8b
# ╠═e76625a0-d88a-4315-ab20-6c89a050b867
# ╠═521f5613-0869-4f0f-804e-8e78f9a91fa6
# ╠═e7634b90-34b7-4e6e-b88d-2b9570765f32
