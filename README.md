# BotBuddy

BotBuddy is a bot management and automation platform designed to streamline interaction with external DreamBot clients via a web interface.

Discord: https://discord.gg/MN5JytKrje

## Projects
| Project  | Description                                                                                                                                                                                        |
|----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| web      | Laravel backend primarily using Blade for server-side rendering. Serves as the central interface for bot management. JavaScript is used minimally, with a mix of vanilla JS, React, and Inertia.js |
| gomaster | Go-based command dispatcher and sync server. Receives updates from agents and forwards instructions from the web application to the appropriate agent clients                                      |
| goagent  | Go client that acts as a bridge between the master server and DreamBot instances. It executes commands from the master and forwards telemetry from the script wrapper to the master                |
| scriptwrapper | DreamBot script that collects runtime telemetry and sends it to the agent for processing and reporting                                                                                        |

## Requirements
- Git
- Docker
- Python (3.12.2 or similar - for Jagex account linking)

## Installation

Installation scripts for Linux and Windows environments are available. If you have any issues installing BotBuddy, feel free to join our Discord server for support.

1. Clone the repository & move into the directory

```bash
git clone https://github.com/drlolwat/BotBuddy.git
cd botbuddy
```

2. Run the install script compatible with your operating sytem. Enter a password for the database when prompted

Linux: 
```
bash install.sh
```

Windows:
```
./install.bat
```

3. You can now access BotBuddy at http://localhost

```
Email: demo@botbuddy.net
Password: demo
```

## Hosting remotely

If you plan to host BotBuddy on a remote server, you will need to make the following change
to ensure the agents point to your master server:

1. Open `web/.env`
2. Replace `BOTBUDDY_MASTER_HOST=localhost:7888` with `BOTBUDDY_MASTER_HOST=<remote_ip>:7888`
