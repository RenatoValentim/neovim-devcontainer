.PHONY: up rebuild recreate exec stop ssh-agent-link

# Refresh a stable symlink to the live SSH agent socket. The agent socket path
# changes every login (e.g. wezterm's agent.<PID>), so we point a fixed path at
# it and mount that fixed path in devcontainer.json. The kernel re-resolves the
# symlink when the container starts, so it always tracks the current socket.
ssh-agent-link:
	@if [ -n "$$SSH_AUTH_SOCK" ]; then \
		ln -sf "$$SSH_AUTH_SOCK" "$$HOME/.ssh-agent.sock"; \
	else \
		echo "WARN: SSH_AUTH_SOCK empty; ssh-agent forwarding will be unavailable"; \
	fi

up: ssh-agent-link
	devcontainer up --workspace-folder .

rebuild: ssh-agent-link
	devcontainer up --workspace-folder . --build-no-cache --remove-existing-container

recreate: ssh-agent-link
	devcontainer up --workspace-folder . --remove-existing-container

exec:
	devcontainer exec --workspace-folder . fish

stop:
	docker stop $$(docker ps -q --filter "label=devcontainer.local_folder=$$(pwd)")
