.PHONY: pdf clean fmt slides help quick

help:
	@echo "Thesis build targets:"
	@echo "  pdf       - Full build (lualatex + glossaries + bibtex + lualatex x2)"
	@echo "  quick     - Single lualatex pass (fast; no glossaries/bib update)"
	@echo "  clean     - Remove generated files"
	@echo "  fmt       - Format LaTeX source (requires tex-fmt)"
	@echo "  slides    - Build presentations (see presentations/)"

fmt:
	tex-fmt thesis.tex

quick:
	lualatex --shell-escape -interaction=nonstopmode thesis.tex

pdf:
	# Full build sequence for thesis
	# Pass 1: lualatex (generate aux, internal references)
	lualatex --shell-escape -interaction=nonstopmode thesis.tex
	# Build glossaries and bibliography
	makeglossaries thesis || true
	bibtex thesis || true
	# Pass 2-3: lualatex (update TOC, references, cross-refs)
	lualatex --shell-escape -interaction=nonstopmode thesis.tex
	lualatex --shell-escape -interaction=nonstopmode thesis.tex

clean:
	# Remove generated files; don't fail if files don't exist
	-rm -f thesis.{log,lol,lot,out,toc,xdy,lof,aux,bbl,fls,fdb_latexmk}
	-rm -f chapters/*.aux preamble/*.aux appendices/*.aux glossaries/*.aux presentations/*.aux
	-rm -f _minted/*/*.minted
	@echo "Clean complete."

slides:
	@echo "Building slides in ./presentations"
	@$(MAKE) -C presentations pdf
