### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ 902b33ca-9d48-11ee-334c-790f228c9dc2
grid=split(read("day17_test.txt",String))

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
	tentative_dist=zeros(size(gridchar))
	tentative_dist[:,:] .=typemax(Int)-1
	tentative_dist[1,1]=0
	parents=Array{Array{CartesianIndex{2},1},2}(undef,size(gridchar,1),size(gridchar,2))
	current_node=CartesianIndex(1,1)
	unvisited=trues(size(gridchar))

	while unvisited[end,end]
		
		for dir in cards
			if 1<=(current_node+dir)[2]<=size(gridchar,2) && 1<=(current_node+dir)[1]<=size(gridchar,1) && unvisited[current_node+dir] && ((current_node+dir)[2]+(current_node+dir)[1]<6 || !(dir==current_node - parents[current_node]==parents[current_node]-parents[parents[current_node]]==parents[parents[current_node]]-parents[parents[parents[current_node]]]   ))
				if tentative_dist[current_node]+gridchar[current_node+dir]<tentative_dist[current_node+dir]
					tentative_dist[current_node+dir]=tentative_dist[current_node]+gridchar[current_node+dir]
					parents[current_node+dir]=current_node
				end
	
			end
		end
		unvisited[current_node]=false
		current_node=findmin( x -> unvisited[x] ? tentative_dist[x] : Inf, eachindex(IndexCartesian(),tentative_dist))[2]
		
	end
	return tentative_dist, parents
end

# ╔═╡ fb74d14b-10f5-473a-abf9-2c69fcb26054
distances,parents = shortest_path(gridchar)

# ╔═╡ c253f935-e3ae-4017-b79c-351fc1261090
parents

# ╔═╡ 1f7abe6e-02c0-4579-b5a4-07a8cef9d4bf
parents[1:3,3:5]

# ╔═╡ 5be1939e-fd9a-43cd-a550-aaebafd1c8e1
ENV["ROWS"] = 1000

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
# ╠═c253f935-e3ae-4017-b79c-351fc1261090
# ╠═1f7abe6e-02c0-4579-b5a4-07a8cef9d4bf
# ╠═5be1939e-fd9a-43cd-a550-aaebafd1c8e1
