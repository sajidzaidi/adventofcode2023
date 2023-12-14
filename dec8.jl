### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ 37adee04-987f-11ee-14de-1f2039271fdc
function read_file(file::String)
   lr=""
	network=Dict()
	start=""
	open(file, "r") do io
       lr=readuntil(io,"\n")
		while !eof(io)   
          r = split(readline(io))
		  if length(keys(network))==0 && r !=[]
			  start=r[1]
		  end
		  if r!=[]
			  network[r[1]]=[strip(r[3],['(', ',' ] ),strip(r[4],[')'] )]	
		  end
		end
   end
   return lr, network, start
end

# ╔═╡ 3b762475-bdb0-431a-a23c-0c3bb0676141
lr, network , start= read_file("day8.txt")

# ╔═╡ 905c61cf-4c75-42e1-980d-b14ea07c6965
function steps(start,network,lr)
	enum=Dict(['L'=>1,'R'=>2])
	current_node = "AAA"
	lr_len=length(lr)
	step=0
	dir=lr[step+1]
	
	while current_node !="ZZZ"
		println("$current_node $step $dir")
		current_node = network[current_node][enum[dir]]
		step+=1
		dir=lr[mod(step,lr_len)+1]
	end
	return step
end

# ╔═╡ 603b07ce-0dad-479f-9461-be3c5b70d71b
steps("AAA",network,lr)

# ╔═╡ 885a4bff-5334-4ce2-99d5-197fa6b17085
function steps2(starting,network,lr)
	enum=Dict(['L'=>1,'R'=>2])
	current_node = starting
	lr_len=length(lr)
	step=0
	dir=lr[step+1]
	
	while current_node[3] !='Z'
		current_node = network[current_node][enum[dir]]
		step+=1
		dir=lr[mod(step,lr_len)+1]
	end
	return step
end

# ╔═╡ 5bc516db-096a-4a91-8a59-77dedc0c8a28
steps2("BLA",network,lr)

# ╔═╡ 13d4f3a4-e7d8-48ed-a48a-bb718bd2c6f5
for start in filter(x->x[3]=='A', keys(network))
	println(steps2(start,network,lr))
end

# ╔═╡ b4f1350b-a2f3-420a-b6ff-9cf72e4f6c90
lcm(15989,14363,21409,19241,12737,11653)

# ╔═╡ Cell order:
# ╠═37adee04-987f-11ee-14de-1f2039271fdc
# ╠═3b762475-bdb0-431a-a23c-0c3bb0676141
# ╠═905c61cf-4c75-42e1-980d-b14ea07c6965
# ╠═603b07ce-0dad-479f-9461-be3c5b70d71b
# ╠═885a4bff-5334-4ce2-99d5-197fa6b17085
# ╠═5bc516db-096a-4a91-8a59-77dedc0c8a28
# ╠═13d4f3a4-e7d8-48ed-a48a-bb718bd2c6f5
# ╠═b4f1350b-a2f3-420a-b6ff-9cf72e4f6c90
