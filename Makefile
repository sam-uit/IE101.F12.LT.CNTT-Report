fmt:
	tex-fmt thesis.tex
pdf:
	makeglossaries thesis
	bibtex thesis
	pdflatex --shell-escape thesis.tex
clean:
	rm thesis.{log,lol,lot,out,toc,xdy,lof,aux,bbl}
	rm */*.aux
