# kBot

DevOps application from scratch. This project implements a simple Telegram bot for educational purposes.

Bot for example - [@T16TestBot](https://t.me/T16TestBot) (now powered off)

## How to up

Requirements:

- Active internet access;
- [Installed Git](https://git-scm.com/downloads);
- [Installed Golang](https://go.dev/doc/install);
- [Installed GNU Make](https://www.gnu.org/software/make/manual/make.html);
- [Google Artifact Registry](https://cloud.google.com/artifact-registry)

### - Clone a repository:

If you want to test this kBot app with connection to your Telegram bot, you need to follow these steps:

Clone repository:
```sh
# via SSH
git clone git@github.com/artur-titov/kbot.git

# via HTTPS
git clone https://github.com/artur-titov/kbot.git

# or using GitHub CLI
gh repo clone artur-titov/kbot
```

### - Set environment variables:

First, you need to create your bot in [Telegram App](https://telegram.org/) and get an API-token. Then you need to transfer this token to the kBot. While in the project directory, execute the commands:

```sh
cp .env.dist .env && nano .env
```

Please, set your Docker Image repository in 'REGISTRY' variable. You also can change target OS and architecture for your App when 'make build' command is running. 

Add a .gitignore file if necessary:
```sh
touch .gitignore && echo -e ".gitignore\n.env\nkbot" >> .gitignore
```

### - Up Docker container:

```sh
make image
```

```sh
docker run <image_sha>
```



## How to use kBot

You can text to your Bot in Telegram App.

*Supported commands*:

| Command       | Response            |
| :---          | :---                |
| /start hello  | Current bot version |


## Make commands for Developers

#### For development:
| Commands         | Result                                       |
| :---             | :---                                         |
| make lint        | Lint your code                               |

#### For tests:
| Commands         | Result                                       |
| :---             | :---                                         |
| make test        | Start Golang tests                           |
| make build       | Build Application with 'fmt' and 'go get'    |
| make image-test  | Test Image creation with 'fmt' and 'linting' |
| make dive        | Check Image with Dive utility                |

#### For work with Docker Images:
| Commands         | Result                                       |
| :---             | :---                                         |
| make image       | Create Docker Image                          |
| make push        | Push Docker Image to your repository         |
| make clean       | Remove created Application Image             |
