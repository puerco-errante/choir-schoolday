### A Pluto.jl notebook ###
# v0.12.12

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 6805c290-5f39-11eb-25b4-35af904a3f36
begin
	import Pkg
	Pkg.activate(mktempdir())
	Pkg.add("PlutoUI")
	using PlutoUI
	Pkg.add("Plots")
	using Plots
	Pkg.add("WAV")
	using WAV
 
end

# ╔═╡ f8409fca-5f38-11eb-3d70-abbd0172a48e
md"# Prova per robetta interattiva col coro"

# ╔═╡ abb27b0a-5f39-11eb-2363-ebbf45649749
begin
	f1_slider = @bind f1 Slider(1:0.01:25, show_value=true);
	f2_slider = @bind f2 Slider(1:0.01:25, show_value=true);
end

# ╔═╡ 3c657fec-5f3a-11eb-03f2-9d8cf6007e5b
begin
	wave_1(t) = sin(t * f1)
	wave_2(t) = sin(t * f2)
end

# ╔═╡ 7d7f0bbc-5f3a-11eb-160f-d93295e18826
plotly()

# ╔═╡ 36afb2c8-5f57-11eb-0a13-21b31e1504a0
md"""
Qua puoi divertirti generando due onde di diverse frequenze che poi suonerano. Vediamo se puoi scoprire qualche relazione fra le coppie di numeri che suonano 'bene' e quelle che suonano 'male'
"""

# ╔═╡ fa023098-5f39-11eb-2f81-2952de65bb83
md"""
Frequenza 1: $(f1_slider)

Frequenza 2: $(f2_slider)
"""

# ╔═╡ 5cf129d8-5f3b-11eb-1ca8-c7fd81335e53
begin
	time_range = 0:0.01:10
	plot(time_range, wave_1, label="frequenza 1 = $f1") 
	plot!(time_range, wave_2, label="frequenza 2 = $f2") 
	plot!(xlabel = "Tempo")
end

# ╔═╡ f6b4a024-5f52-11eb-3322-c1457d1cdae4
begin
	fs = 8e3
	t = 0.0:1/fs:prevfloat(2.5)
	y = sin.(100pi * f1 * t) * 0.1 + sin.(100pi * f2 * t) * 0.1
	wavwrite(y, "example.wav", Fs=fs)
	
	y, fs = wavread("example.wav")
	wavplay(y, fs)
end

# ╔═╡ Cell order:
# ╟─f8409fca-5f38-11eb-3d70-abbd0172a48e
# ╟─6805c290-5f39-11eb-25b4-35af904a3f36
# ╟─abb27b0a-5f39-11eb-2363-ebbf45649749
# ╟─3c657fec-5f3a-11eb-03f2-9d8cf6007e5b
# ╟─7d7f0bbc-5f3a-11eb-160f-d93295e18826
# ╟─36afb2c8-5f57-11eb-0a13-21b31e1504a0
# ╟─fa023098-5f39-11eb-2f81-2952de65bb83
# ╟─5cf129d8-5f3b-11eb-1ca8-c7fd81335e53
# ╟─f6b4a024-5f52-11eb-3322-c1457d1cdae4
