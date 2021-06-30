.PHONY: publish
publish:
	@ echo "cleaning up" && \
	rm -r dist/ || true && \
	python setup.py sdist && \
	twine upload dist/*
