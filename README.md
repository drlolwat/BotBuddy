# BotBuddy

BotBuddy is a bot management and automation platform designed to streamline interaction with external DreamBot clients via a web interface.

Discord: https://discord.gg/MN5JytKrje

## Requirements
- Git
- Docker

## Installation

Installation scripts for Linux and Windows environments are available. If you have any issues installing BotBuddy, feel free to join our Discord server for support.

1. Clone the repository & move into the directory

```bash
git clone https://gitlab.botbuddy.net/botbuddy/botbuddy.git
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