### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ 9f5c687d-f234-4b40-b75e-4b3d7c79a5f0
using DelimitedFiles

# ╔═╡ 453bb17a-9643-11ee-09b4-0dddecfd83f0
myarray=open(readdlm,"day3.txt")


# ╔═╡ 5e75f4e0-9968-4338-a4aa-73c4d0907709
function hasAdjacentSymbols(startind, endind, arrayname, rownum)
	adjacent=false
	row=arrayname[rownum]
	len_row=length(row)
	len_array=length(arrayname)
	for i in startind:endind
		adjacent_nums=[row[max(i-1,1)],row[min(i+1,len_row)]]
		if rownum>1
			prevrow=arrayname[rownum-1]
			push!(adjacent_nums,prevrow[max(i-1,1)])
			push!(adjacent_nums,prevrow[i])
			push!(adjacent_nums,prevrow[min(i+1,len_row)])	
		end
		if rownum<len_array
			nextrow = arrayname[rownum+1]
			push!(adjacent_nums,nextrow[max(i-1,1)])
			push!(adjacent_nums,nextrow[i])
			push!(adjacent_nums,nextrow[min(i+1,len_row)])	
		end
		for adj in adjacent_nums
			if !(isdigit(adj) || adj=='.')
				adjacent=true
			end
		end
	end
	return adjacent
end

# ╔═╡ 2ccd8def-4fed-42bd-ae5e-557f23b1de7a
function sumpartnums(myarray)
	total=0
	for (j,row) in enumerate(myarray)
		for partnum in eachmatch(r"\d+",row)
			startindex=partnum.offset
			endindex=partnum.offset+length(partnum.match)-1
			if hasAdjacentSymbols(startindex,endindex,myarray,j)
				total+=parse(Int,partnum.match)
			end
		end
	end
	return total
end

# ╔═╡ 9ec0e928-456f-44e0-8f8e-ac7abf2e50ab
sumpartnums(myarray)

# ╔═╡ d4157a87-c821-423c-81d8-b89a588c5fdc
function GearCount(arrayname)
	len_array=length(arrayname)
	total=0
	for (rownum,row) in enumerate(myarray)

		len_row=length(row)
		
		row_parts=eachmatch(r"\d+",row)
		if rownum>1
			prevrow=arrayname[rownum-1]
			prevrow_parts=eachmatch(r"\d+",prevrow)
		
		end		
		if rownum<len_array
			nextrow = arrayname[rownum+1]
			nextrow_parts=eachmatch(r"\d+",nextrow)
		end
		asterisks=findall('*',row)
		for asterisk in asterisks
			adjacents=[]
			for partnum in row_parts
				startindex=partnum.offset
				endindex=partnum.offset+length(partnum.match)-1
				if endindex==asterisk-1 || startindex == asterisk+1 
					push!(adjacents,parse(Int,partnum.match))
				end
			end

			if rownum>1
				for partnum in prevrow_parts
					startindex=partnum.offset
					endindex=partnum.offset+length(partnum.match)-1
					if endindex+1>=asterisk>=startindex-1  
						push!(adjacents,parse(Int,partnum.match))
					end
				end
			end
			
			if rownum<len_array
				for partnum in nextrow_parts
					startindex=partnum.offset
					endindex=partnum.offset+length(partnum.match)-1
					if endindex+1>=asterisk>=startindex-1  
						push!(adjacents,parse(Int,partnum.match))
					end
				end
			end
			if length(adjacents)==2
				total+=prod(adjacents)
			end
		end		
	end
	return total
end

# ╔═╡ dbedb154-1d96-414b-873d-0ab848cc22d2
GearCount(myarray)

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
# ╠═9f5c687d-f234-4b40-b75e-4b3d7c79a5f0
# ╠═453bb17a-9643-11ee-09b4-0dddecfd83f0
# ╠═2ccd8def-4fed-42bd-ae5e-557f23b1de7a
# ╠═5e75f4e0-9968-4338-a4aa-73c4d0907709
# ╠═9ec0e928-456f-44e0-8f8e-ac7abf2e50ab
# ╠═d4157a87-c821-423c-81d8-b89a588c5fdc
# ╠═dbedb154-1d96-414b-873d-0ab848cc22d2
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
