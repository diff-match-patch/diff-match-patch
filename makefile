SRCS:=diff_match_patch
EXTRAS:=dev

ifeq ($(OS),Windows_NT)
    ACTIVATE:=.venv/Scripts/activate
else
    ACTIVATE:=.venv/bin/activate
endif

UV:=$(shell uv --version)
ifdef UV
	VENV:=uv venv
	PIP:=uv pip
else
	VENV:=python -m venv
	PIP:=python -m pip
endif

.venv:
	$(VENV) .venv

venv: .venv
	source $(ACTIVATE) && make install
	echo 'run `source $(ACTIVATE)` to use virtualenv'

install:
	$(PIP) install -Ue .[$(EXTRAS)]

release: lint test clean
	python -m flit publish

format:
	python -m ufmt format $(SRCS)

lint:
	python -m ufmt check $(SRCS)
	python -m mypy -p $(SRCS)

test:
	python -m unittest -v $(SRCS).tests

clean:
	rm -rf build dist html README MANIFEST *.egg-info

distclean: clean
	rm -rf .venv
