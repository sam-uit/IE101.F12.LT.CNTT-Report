pdf:
	# Build slides with LuaLaTeX (minted or other packages may need --shell-escape)
	cd $(dir $(realpath $(firstword $(MAKEFILE_LIST)))) && lualatex --shell-escape IE101-baocaomonhoc.tex

clean:
	rm -f IE101-baocaomonhoc.{aux,log,nav,snm,out}
