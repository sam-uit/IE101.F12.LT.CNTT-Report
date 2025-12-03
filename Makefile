fmt:
	tex-fmt thesis.tex
pdf:
	lualatex --shell-escape thesis.tex
	makeglossaries thesis
	bibtex thesis
	lualatex --shell-escape thesis.tex
clean:
	rm thesis.{log,lol,lot,out,toc,xdy,lof,aux,bbl}
	rm */*.aux
