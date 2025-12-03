fmt:
	tex-fmt thesis.tex
pdf:
	# First compilation to generate aux files
	# Full build: lualatex -> makeglossaries -> bibtex -> lualatex x2
	lualatex --shell-escape -interaction=nonstopmode thesis.tex
	# build glossaries (xindy) and bibliography
	makeglossaries thesis || true
	bibtex thesis || true
	# ensure references and TOC are updated
	lualatex --shell-escape -interaction=nonstopmode thesis.tex
	lualatex --shell-escape -interaction=nonstopmode thesis.tex
clean:
	rm thesis.{log,lol,lot,out,toc,xdy,lof,aux,bbl}
	rm */*.aux

slides:
	@echo "Building slides in ./presentations"
	@$(MAKE) -C presentations pdf
