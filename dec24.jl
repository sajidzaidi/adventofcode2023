### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ 3f480922-a21f-11ee-3d96-c9670550ea73
using DelimitedFiles

# ╔═╡ b54eb292-0f13-4d9f-8647-0d24fec7fb0a
using LinearAlgebra

# ╔═╡ bb999aab-b398-42ae-b488-bbb16daa44d5
points=readdlm("day24.txt",'@')

# ╔═╡ a0bece0b-8dca-4953-9ace-366a051e1493
vecs=map(x->parse.(Int128,x),split.(points,','))

# ╔═╡ ecc5c559-0ca6-436b-9115-de1c6239dab3


# ╔═╡ ce6f8403-d4bd-48ee-b422-f75309cf4b59


# ╔═╡ 25d74aa7-0a22-4810-8d3d-512b8a59d381


# ╔═╡ 7f672964-b764-40cd-bc96-2b59dcf95513


# ╔═╡ b2f4346b-a187-44f4-b211-be79097a2978


# ╔═╡ 4598e7e0-a810-43cd-850b-33d096724b15


# ╔═╡ 89cf4976-c079-4f4f-9740-f30eb322be88
function skew(x)
	[0 -x[3] x[2];x[3] 0 -x[1]; -x[2] x[1] 0]
end

# ╔═╡ d4aba746-3268-4a53-809d-59b12f052d03
function part1(vecs)
	crossings=0

	for i in 1:size(vecs,1)-1
		for j in i+1:size(vecs,1)
			v1=vecs[i,2]
			v2=vecs[j,2]
			p1=vecs[i,1]
			p2=vecs[j,1]
			
			m1=v1[2]/v1[1]
			m2=v2[2]/v2[1]		
	 
			A=[ m1 -1 ; m2 -1]
			b=[m1*p1[1]-p1[2], m2*p2[1]-p2[2]]
			
			# lower=200000000000000
			# upper=400000000000000
			 lower=7
			 upper=27

			if m1==m2
			
			else 
				cross=A\b
				if sign(cross[1]-p1[1])==sign(v1[1]) && sign(cross[1]-p2[1])==sign(v2[1]) && lower <=cross[1]<=upper &&  lower <= cross[2] <= upper
					crossings+=1
				end
			end
			#not parallel, in the box, and in the future
		end
	end
	#return crossings
	x1, v1 = vecs[1,1], vecs[1,2]
	x2, v2 = vecs[2,1], vecs[2,2]
	x3, v3 = vecs[3,1], vecs[3,2]
	
	A1 = hcat(skew(v1-v2), skew(x2-x1))
	A2 = hcat(skew(v2-v3), skew(x3-x2))
	RHS1= cross(x2 ,v2) -cross(x1 , v1)
	RHS2 = cross(x3 , v3) - cross(x2 , v2)
	A=vcat(A1,A2)
	RHS = vcat(RHS1,RHS2)
	sol=A \ RHS
	return round.(sol)
	
end

# ╔═╡ 5eb19f6b-0973-4506-b664-9f6b75bb8f2a
format(sum(part1(vecs)[1:3]))

# ╔═╡ b7e45ce8-8663-46a4-b0ec-7ca74e16124c


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DelimitedFiles = "8bb1440f-4735-579b-a4ab-409b98df4dab"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[compat]
DelimitedFiles = "~1.9.1"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.4"
manifest_format = "2.0"
project_hash = "bc23b1e1620c143dbe2c7d1dd5b0c15630ca00c6"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.5+0"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.21+4"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+0"
"""

# ╔═╡ Cell order:
# ╠═3f480922-a21f-11ee-3d96-c9670550ea73
# ╠═bb999aab-b398-42ae-b488-bbb16daa44d5
# ╠═a0bece0b-8dca-4953-9ace-366a051e1493
# ╠═ecc5c559-0ca6-436b-9115-de1c6239dab3
# ╠═ce6f8403-d4bd-48ee-b422-f75309cf4b59
# ╠═25d74aa7-0a22-4810-8d3d-512b8a59d381
# ╠═7f672964-b764-40cd-bc96-2b59dcf95513
# ╠═b2f4346b-a187-44f4-b211-be79097a2978
# ╠═d4aba746-3268-4a53-809d-59b12f052d03
# ╠═5eb19f6b-0973-4506-b664-9f6b75bb8f2a
# ╠═4598e7e0-a810-43cd-850b-33d096724b15
# ╠═89cf4976-c079-4f4f-9740-f30eb322be88
# ╠═b54eb292-0f13-4d9f-8647-0d24fec7fb0a
# ╠═b7e45ce8-8663-46a4-b0ec-7ca74e16124c
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
