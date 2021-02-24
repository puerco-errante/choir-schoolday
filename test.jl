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

# ╔═╡ 6677cb46-730c-11eb-02d5-df779155ff1e
md"""
Benvenutə!
Questo è un _notebook_, una specie di quaderno elettronico dove possiamo scrivere del testo (come questo que leggete), ma anche delle istruzioni particolari per fare al computer fare quello che vogliamo... circa :)

Questi istrumenti sono cruciali per il lavoro di noi fisici teorici, visto che ci permettono di condividere non solo i risultati, ma anche il modo in cui ci siamo arrivati ad essi.

Per esempio, questo notebook ci aiuterà a capire come si rappresentano le onde che sentiamo come suoni e magari qualcosina in più...
"""

# ╔═╡ abb27b0a-5f39-11eb-2363-ebbf45649749
begin
	f1_slider = @bind f1 Slider(20:0.1:500, show_value=true);
	f2_slider = @bind f2 Slider(20:0.1:500, show_value=true);
end

# ╔═╡ 3c657fec-5f3a-11eb-03f2-9d8cf6007e5b
begin
	wave_1(t) = sin(2pi *t * f1)
	wave_2(t) = sin(2pi *t * f2)
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
	time_range = 0:0.0001:0.1
	plot(time_range, wave_1, label="frequenza 1 = $(round(f1)) Hz") 
	plot!(time_range, wave_2, label="frequenza 2 = $(round(f2)) Hz") 
	plot!(xlabel = "Tempo (s)")
end

# ╔═╡ 308112a6-6555-11eb-1d5d-ddcba9b2bba3
function plot_and_play(f1,f2,a,b,length,p_range)
	fs = 8e3
	t = 0.0:1/fs:prevfloat(Float64(length))
	sum_wave(t) = (a*sin(2pi *t * f1) + b*sin(2pi *t * f2))/5
	wavplay(sum_wave.(t) , fs)
	plot(t[1:p_range], sum_wave, label="Somma") 
	plot!(xlabel = "Tempo (s)")
	
end

# ╔═╡ f6b4a024-5f52-11eb-3322-c1457d1cdae4
#plot_and_play(f1,f2,1,1,2,500)

# ╔═╡ 5bd27ffc-76ce-11eb-1bfd-7555c603db62
function harmonic(freq, n, length)
	fs = 100 * freq
	t = 0.0:1/fs:prevfloat(Float64(length))
	y = sum( ((1/i^2)*sin.(2pi * i * freq * t)) for i in 1:n)
	wavplay(y, fs)
	plot(y[1:500])
end
	

# ╔═╡ 308e694a-76cf-11eb-2141-6f79236f5b04
harmonic(110,5,0.5)

# ╔═╡ Cell order:
# ╠═f8409fca-5f38-11eb-3d70-abbd0172a48e
# ╠═6677cb46-730c-11eb-02d5-df779155ff1e
# ╟─6805c290-5f39-11eb-25b4-35af904a3f36
# ╠═abb27b0a-5f39-11eb-2363-ebbf45649749
# ╠═3c657fec-5f3a-11eb-03f2-9d8cf6007e5b
# ╟─7d7f0bbc-5f3a-11eb-160f-d93295e18826
# ╟─36afb2c8-5f57-11eb-0a13-21b31e1504a0
# ╟─fa023098-5f39-11eb-2f81-2952de65bb83
# ╠═5cf129d8-5f3b-11eb-1ca8-c7fd81335e53
# ╠═308112a6-6555-11eb-1d5d-ddcba9b2bba3
# ╠═f6b4a024-5f52-11eb-3322-c1457d1cdae4
# ╠═5bd27ffc-76ce-11eb-1bfd-7555c603db62
# ╠═308e694a-76cf-11eb-2141-6f79236f5b04
