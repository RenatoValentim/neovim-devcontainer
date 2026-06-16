.PHONY: up rebuild exec stop

up:
	devcontainer up --workspace-folder .

rebuild:
	devcontainer up --workspace-folder . --build-no-cache

exec:
	devcontainer exec --workspace-folder . fish

stop:
	docker stop $$(docker ps -q --filter "label=devcontainer.local_folder=$$(pwd)")
