.PHONY: up rebuild recreate exec stop

up:
	devcontainer up --workspace-folder .

rebuild:
	devcontainer up --workspace-folder . --build-no-cache --remove-existing-container

recreate:
	devcontainer up --workspace-folder . --remove-existing-container

exec:
	devcontainer exec --workspace-folder . fish

stop:
	docker stop $$(docker ps -q --filter "label=devcontainer.local_folder=$$(pwd)")
