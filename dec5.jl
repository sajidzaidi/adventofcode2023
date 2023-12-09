### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ 309d987e-862d-413d-af91-c66a4e86e259
using DelimitedFiles

# ╔═╡ 630d38fb-815a-457d-b8d6-d7539acaf2dd
function read_maps(file::String)
   
   mappings=Dict{String,Array}()
   seeds=[]
   current_map=""
   open(file, "r") do io
      while !eof(io)   
         r = split(readline(io))
		 if r==[]
			
			
		 elseif r[1]=="seeds:"
		 	 
			 seeds=parse.(Int,r[2:end])
		 elseif occursin(r"[a-zA-z]", r[1])
		 	 current_map=r[1]	
			 mappings[current_map]=[]
		 else 
	         append!(mappings[current_map], [parse.(Int,r)])		 	
		 end	  
      end
	  
  end
  return mappings,seeds
end

# ╔═╡ 0a8eb060-96c0-11ee-0a67-cd10e6b63cf4
mappings, seeds = read_maps("day5.txt")

# ╔═╡ b9b459c2-b4dc-441e-940d-b715de82218b
function rangemap(value,map)
	output=value
	for interval in map
		if interval[2]<=value<=interval[3]+interval[2]-1
			output=interval[1] + value - interval[2]
		end
	end
	return output
	
end

# ╔═╡ 6a4079cd-6e9f-4c68-a9f9-38512284b4d9
function seedtolocation(seed, mappings)
	start=seed
	attribs=["seed","soil","fertilizer","water","light","temperature","humidity","location"]
	for (i, attrib) in enumerate(attribs)
		if i<length(attribs)
			str=attrib *"-to-" *attribs[i+1] 
			start=rangemap(start,mappings[str])
		end
	end
	return start
end

# ╔═╡ 774e1e20-1693-4230-b38b-d745bd9a2c2f
minimum([seedtolocation(x,mappings) for x in seeds])

# ╔═╡ 9e487eb2-8aff-4fb2-9d80-d42de08b1147
md"## Part 2"

# ╔═╡ 10ccee22-71b8-482a-b30a-05b1d26df99d
struct Interval{T<:Int}
    lo :: T
    hi :: T
end

# ╔═╡ 2a6be5f0-eb90-4569-8db2-f6f1dba35ae2
function intervalmap(inputInterval,map)
	subtracted=[]
	output=[]
	for func in map
		domain=Interval(func[2],func[3]+func[2]-1)
		codomain=Interval(func[1],func[3]+func[1]-1)
		if inputInterval.hi>= domain.hi && domain.lo>=inputInterval.lo
			#domain is entirely contained in input interval
			push!(output,codomain)
			push!(subtracted,domain)
		elseif inputInterval.hi>= domain.hi >= inputInterval.lo
			push!(output,Interval( inputInterval.lo-domain.lo+codomain.lo, codomain.hi ))
			push!(subtracted,Interval(inputInterval.lo,domain.hi))

		elseif inputInterval.hi>= domain.lo >= inputInterval.lo
			push!(output,Interval( codomain.lo,inputInterval.hi-domain.lo+codomain.lo))
			push!(subtracted,Interval(domain.lo,inputInterval.hi))

		
		elseif domain.lo<=inputInterval.lo && domain.hi>=inputInterval.hi
			push!(output,Interval(inputInterval.lo-domain.lo+codomain.lo,inputInterval.hi-domain.lo+codomain.lo))
			push!(subtracted,Interval(inputInterval.lo,inputInterval.hi))

		end
		
	end
	
	sort!(subtracted,by=x-> x.lo)
	if length(subtracted)==0
		push!(output,inputInterval)
	end
	for (i, sub_int) in enumerate(subtracted)
		if i==1
			push!(output,Interval(inputInterval.lo,sub_int.lo-1))
		end
		if i<length(subtracted)
			push!(output,Interval(sub_int.hi+1,subtracted[i+1].lo-1))
		else
			push!(output,Interval(sub_int.hi+1,inputInterval.hi))
		end
	end
	return filter(x->x.hi>=x.lo,output)
	
end

# ╔═╡ 34e3b106-527c-4c4d-9a98-ec76648f2809
function part2seedtolocation(seedinterval, mappings)
	start=[seedinterval]
	attribs=["seed","soil","fertilizer","water","light","temperature","humidity","location"]
	for (i, attrib) in enumerate(attribs)
		if i<length(attribs)
			str=attrib *"-to-" *attribs[i+1] 
			output=[]
			for intvl in start
				append!(output,intervalmap(intvl,mappings[str]))
			end
			start=output
		end
	end
	return start
end

# ╔═╡ 5ec89fe5-5873-4aa8-945f-65a985424e2a
function part2seeds(seeds,mappings)
	minpart2=seedtolocation(seeds[1],mappings)
	for (i,start) in enumerate(seeds[begin:2:end])
	 	current_int = Interval(start,start+seeds[i*2]-1)
		location_range=part2seedtolocation(current_int,mappings)
		minpart2=  min( minpart2, minimum(x->x.lo,location_range))
	end
	return minpart2
end

# ╔═╡ 0b47a19f-175b-44f0-bb62-9b588e95796d
part2seeds(seeds,mappings)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DelimitedFiles = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[compat]
DelimitedFiles = "~1.9.1"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.4"
manifest_format = "2.0"
project_hash = "eb696dba116621a072d91c57084a363ced7654e8"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
"""

# ╔═╡ Cell order:
# ╠═309d987e-862d-413d-af91-c66a4e86e259
# ╠═630d38fb-815a-457d-b8d6-d7539acaf2dd
# ╠═0a8eb060-96c0-11ee-0a67-cd10e6b63cf4
# ╠═b9b459c2-b4dc-441e-940d-b715de82218b
# ╠═6a4079cd-6e9f-4c68-a9f9-38512284b4d9
# ╠═774e1e20-1693-4230-b38b-d745bd9a2c2f
# ╠═9e487eb2-8aff-4fb2-9d80-d42de08b1147
# ╠═10ccee22-71b8-482a-b30a-05b1d26df99d
# ╠═2a6be5f0-eb90-4569-8db2-f6f1dba35ae2
# ╠═34e3b106-527c-4c4d-9a98-ec76648f2809
# ╠═5ec89fe5-5873-4aa8-945f-65a985424e2a
# ╠═0b47a19f-175b-44f0-bb62-9b588e95796d
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
