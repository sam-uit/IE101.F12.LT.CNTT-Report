fmt:
	tex-fmt thesis.tex
pdf:
	# First compilation to generate aux files
	lualatex --shell-escape thesis.tex
	makeglossaries thesis
	bibtex thesis
	# Second run to ensure all references are updated
	lualatex --shell-escape thesis.tex
	# Third run to finalize the document
	lualatex --shell-escape thesis.tex
clean:
	rm thesis.{log,lol,lot,out,toc,xdy,lof,aux,bbl}
	rm */*.aux

slides:
	@echo "Building slides in ./presentations"
	@$(MAKE) -C presentations pdf
