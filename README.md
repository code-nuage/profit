# Profit

Profit is an e-commerce application tailored for niche markets, specializing in the sale of customized condoms. Our goal is to provide a personalized and high-quality service to our customers, allowing them to obtain products that meet their specific needs.

## 💻 Back-end Server Setup

### Install luvit

Follow these steps to install luvit: [https://luvit.io/install.html](https://luvit.io/install.html)

### Install Dependencies

Navigate into the back directory:

```sh
cd back
```

Install `json` and `coro-fs` with lit:

```sh
lit install luvit/json
lit install coro-fs
```

### Configure Back-end Server

Copy `config.sample.lua` to `config.lua`:

```sh
cp config.sample.lua config.lua
```

Configure it as needed.

### Initialize Back-end Server

Start the back-end server using luvit:

```sh
luvit server.lua
```

## ⭐️ Front-end Server Setup

### Install nvm

Follow these steps to install nvm: [https://github.com/nvm-sh/nvm#install--update-script](https://github.com/nvm-sh/nvm#install--update-script)

### Configure Front-end Server

### Install Dependencies

Navigate into the front directory:

```sh
cd front
```

Install dependencies with npm:

```sh
npm install webpack webpack-cli webpack-dev-server @babel/core @babel/preset-env babel-loader html-loader style-loader css-loader sass sass-loader --save-dev
```

### Initialize Front-end Server

Start the front-end server:

```sh
npm start # or npm run start
```

## 📜 License

Our project is released under a permissive license, allowing for free use and modification of our code. The license agreement can be found in the LICENSE file within the project repository.

License Terms:

• You are granted permission to freely use, modify, and distribute this project.
• All intellectual property rights to the project remain with the original authors.
• By using this project, you agree to abide by the terms of the license agreement.

Note that our project is open-source, and we encourage contributions and feedback from the community.
