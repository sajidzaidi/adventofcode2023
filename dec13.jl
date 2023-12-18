### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ 116a6d17-27ef-41dd-b6e4-7420291f2e3d
using DelimitedFiles

# ╔═╡ ae9fa038-9a2b-11ee-32c1-f7ab5ec07c70

function read_lava(file::String)
	
	dat=read(file,String)
	return readdlm.(IOBuffer.(split(dat,"\n\n")))
end


# ╔═╡ 1840204b-7a53-4c39-8e0c-a6634bb934ae
mat=read_lava("day13.txt")

# ╔═╡ 702f77b9-fa22-46a1-a78c-4d1e16cafd2d
function row_pivots(lava)
	num_rows=size(lava,1)
	
	for pivot in 1:num_rows ÷2
		
		if lava[1:pivot]==reverse(lava[pivot+1:  pivot*2])
			return pivot
		elseif lava[end-pivot+1:end] == reverse(lava[end - 2*pivot+1:end-pivot ])
			return num_rows-pivot
		
		end
	
	end
	return 0
end

# ╔═╡ 40da4685-21ca-48cf-85e1-9e5b6c9961eb


# ╔═╡ 46d8db60-89ea-4b79-8a9e-f3edf7f5e554
function col_pivots(lava)
	num_cols=length(lava[1])
	
	for pivot in 1:num_cols ÷2
		
		if all(map(x->x[1:pivot]==reverse(x[pivot+1:pivot*2]),lava))
			return pivot
		elseif all(map(x->x[end-pivot+1:end]==reverse(x[end - 2*pivot+1:end-pivot]),lava))
			return num_cols-pivot
		end
	
	end
	
	return 0
end

# ╔═╡ f5fa010c-10b7-4bc5-a505-17847cd5c593
sum(100*row_pivots(m) + col_pivots(m) for m in mat)

# ╔═╡ 7c309b6a-8e2a-4568-a513-1278cebbf56e
findall( mat[3][1:2] .!= reverse(mat[3][2+1:  2*2]))

# ╔═╡ 06f9bbf2-d3e7-480e-8df0-1f258d5ea3a1
newmat=reduce(vcat, permutedims.(collect.(mat[3])))

# ╔═╡ 8b3f5ba9-00b0-41d1-aa9f-494596122f17
length(findall( newmat[1:2,:] .!= reverse(mat[2+1:  2*2,:])))

# ╔═╡ 2ac7a653-03f9-4f6f-8117-3c4c86000c40
reverse(newmat[1:2,:] ,dims=1)

# ╔═╡ f0dabdb2-89cd-43e2-a411-e7cb41b03cd2
function row_pivots_smudge(lava)
	matrix_form=reduce(vcat, permutedims.(collect.(lava)))
	num_rows=size(matrix_form,1)
	
	for pivot in 1:num_rows ÷2
		
		if length(findall(matrix_form[1:pivot,:]  .!=  reverse(matrix_form[pivot+1:  pivot*2,:],dims=1)))==1
			return pivot
		elseif length(findall(matrix_form[end-pivot+1:end,:] .!= reverse(matrix_form[end - 2*pivot+1:end-pivot ,:],dims=1)))==1
			return num_rows-pivot
		
		end
	
	end
	return 0
end

# ╔═╡ d3cac56a-00bc-4e6d-b4a0-fccf8eab6df4
function col_pivots_smudge(lava)
	matrix_form=reduce(vcat, permutedims.(collect.(lava)))	
	
	num_cols=size(matrix_form,2)
	for pivot in 1:num_cols ÷2
		
		if length(findall(matrix_form[:,1:pivot] .!= reverse(matrix_form[:,pivot+1:pivot*2],dims=2)))==1
			return pivot
		elseif length(findall(matrix_form[:,end-pivot+1:end] .!=reverse(matrix_form[:,end - 2*pivot+1:end-pivot],dims=2)))==1
			return num_cols-pivot
		end
	
	end
	
	return 0
end

# ╔═╡ 250817e4-81d4-40e3-b36e-a22a403ca943
sum(100*row_pivots_smudge(m) + col_pivots_smudge(m) for m in mat)

# ╔═╡ fcb0a6ab-98a7-4ae2-be27-4c871aa69f78


# ╔═╡ 6898c7c0-6b16-455a-960b-ebff83543f08


# ╔═╡ 0fa229f2-2655-4069-8a06-d113caea9c22


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
# ╠═116a6d17-27ef-41dd-b6e4-7420291f2e3d
# ╠═ae9fa038-9a2b-11ee-32c1-f7ab5ec07c70
# ╠═1840204b-7a53-4c39-8e0c-a6634bb934ae
# ╠═702f77b9-fa22-46a1-a78c-4d1e16cafd2d
# ╠═40da4685-21ca-48cf-85e1-9e5b6c9961eb
# ╠═46d8db60-89ea-4b79-8a9e-f3edf7f5e554
# ╠═f5fa010c-10b7-4bc5-a505-17847cd5c593
# ╠═7c309b6a-8e2a-4568-a513-1278cebbf56e
# ╠═06f9bbf2-d3e7-480e-8df0-1f258d5ea3a1
# ╠═8b3f5ba9-00b0-41d1-aa9f-494596122f17
# ╠═2ac7a653-03f9-4f6f-8117-3c4c86000c40
# ╠═f0dabdb2-89cd-43e2-a411-e7cb41b03cd2
# ╠═d3cac56a-00bc-4e6d-b4a0-fccf8eab6df4
# ╠═250817e4-81d4-40e3-b36e-a22a403ca943
# ╠═fcb0a6ab-98a7-4ae2-be27-4c871aa69f78
# ╠═6898c7c0-6b16-455a-960b-ebff83543f08
# ╠═0fa229f2-2655-4069-8a06-d113caea9c22
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
