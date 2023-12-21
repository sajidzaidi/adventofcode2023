### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

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


# ╔═╡ a609e3d5-edac-43b9-bba0-76888ff0440d
cards=[CartesianIndex(0,1),CartesianIndex(0,-1),CartesianIndex(1,0),CartesianIndex(-1,0) ]

# ╔═╡ 36a38e3b-8cff-4229-aabd-efcd4202f1b0
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

# ╔═╡ fb74d14b-10f5-473a-abf9-2c69fcb26054
distances,pars = shortest_path(gridchar)

# ╔═╡ 3319f1d4-b9be-4708-a401-1b5df49c37af


# ╔═╡ e1667574-5eb4-4be8-a7bf-1c1085a420d5


# ╔═╡ c253f935-e3ae-4017-b79c-351fc1261090
minimum(distances[end,end,:])

# ╔═╡ 1f7abe6e-02c0-4579-b5a4-07a8cef9d4bf


# ╔═╡ 5be1939e-fd9a-43cd-a550-aaebafd1c8e1


# ╔═╡ fb4775bf-cfc2-4d34-ac1f-b9eea0fa4736


# ╔═╡ acad0eb5-0279-4287-aeca-68c80aee941c



# ╔═╡ 2101db09-b671-4aa3-994d-49a353670491


# ╔═╡ 936ef9e7-5b3e-409b-9b5a-e97bdfc7c6b1


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
