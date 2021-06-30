VENV_PATH ?= .venv
PIP_INSTALL_QUIET ?= 1

activate-venv=source $(VENV_PATH)/bin/activate

ifeq ($(PIP_INSTALL_QUIET),1)
pip-quiet-flag=-q
endif

.PHONY: publish
publish: venv
	@ echo "cleaning up" && \
	rm -r dist/ || true && \
	$(activate-venv) && \
	python setup.py sdist && \
	twine upload dist/*

.PHONY: venv
venv:
	@ if [ ! -d "$(VENV_PATH)" ]; then \
		printf "[INFO]: Creating virtualenv\n"; \
		python3 -m venv $(VENV_PATH) && \
		\
		printf "[INFO]: Updating venv: [pip, setuptools]\n"; \
		$(activate-venv) && \
		pip install $(pip-quiet-flag) -U pip setuptools; \
	else \
		printf "[INFO]: Using existing virtualenv\n"; \
	fi; \
    printf "[INFO]: Installing requirements\n"; \
	$(activate-venv) && \
    pip install $(pip-quiet-flag) -r requirements.txt

.PHONY: clean
clean:
	@ echo "cleaning up" && \
	rm -r dist/ || true && \
	rm -rf $(VENV_PATH)
