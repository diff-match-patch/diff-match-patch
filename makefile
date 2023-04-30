.venv:
	python -m venv .venv
	source .venv/bin/activate && make install
	echo 'run `source .venv/bin/activate` to develop diff-match-patch'

venv: .venv

install:
	python -m pip install -e .[dev]

release: lint test clean
	python -m flit publish

format:
	python -m ufmt format diff_match_patch

lint:
	python -m ufmt check diff_match_patch

test:
	python -m unittest -v diff_match_patch.tests
	python -m mypy -p diff_match_patch

clean:
	rm -rf build dist html README MANIFEST *.egg-info

distclean: clean
	rm -rf .venv
