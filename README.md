# kBot

DevOps application from scratch. This project implements a simple Telegram bot for educational purposes.

Bot for example - [@T16TestBot](https://t.me/T16TestBot) (now powered off)

## How to

Minimum OS requirements:

- Active internet access;
- Installed Git;
- Installed Golang;

### Cloning a repository

If you want to test this kBot app together with your Telegram bot, you need to follow these steps:

To clone using SSH:
```sh
git clone git@github.com/artur-titov/kbot.git
```
To clone using HTTPS:
```sh
git clone https://github.com/artur-titov/kbot.git
```
To clone using GitHub CLI:
```sh
gh repo clone artur-titov/kbot
```

### Setting parameters

After this, you need to create your bot in Telegram and get an API-token. Then you need to transfer this token to the kBot app. While in the project directory, execute the commands:

```sh
touch .env && echo "TELE_TOKEN=<bot_api-token>" > .env
```

Add a .gitignore file if necessary:
```sh
touch .gitignore
```
```sh
echo ".gitignore" >> .gitignore && echo ".env" >> .gitignore
```

### Using kBot

After that, start the kBot app:
```sh
./kbot start
```

#### Supported commands 

*Text to your Bot in Telegram*:

| Command       | Response            |
| :---          | :---                |
| /start hello  | Current bot version |