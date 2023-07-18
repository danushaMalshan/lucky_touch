
# Lucky Touch

Lucky Touch is a project that I have built according to a Fiverr client's reqvirenments. it was a lottery app where users can buy tickets with USDT.

Furthermore, users can manage their profiles, see user-bought tickets and status, see winners and previous round winners, chat with the admin and many more. also, the admin can see all analytics, remove users, manage rounds, manage tickets, select winners and many other features.

I have used node.js for a backend server and flutter for an app build but the biggest challenge is implementing crypto payment for buying tickets.so I researched for a couple of days and finally, I choose coinbase commerce API for a crypto payment then I was able to do crypto payments and track all of these payments that are pending, expired or successful. when payment is the successful user can use their ticket.


## Screenshots

![App Screenshot](https://danncode.com/portfolio/images/lucky_touch/1.png =200)
![App Screenshot](https://danncode.com/portfolio/images/lucky_touch/2.png)
![App Screenshot](https://danncode.com/portfolio/images/lucky_touch/3.png)
![App Screenshot](https://danncode.com/portfolio/images/lucky_touch/4.png)
![App Screenshot](https://danncode.com/portfolio/images/lucky_touch/5.png)
![App Screenshot](https://danncode.com/portfolio/images/lucky_touch/6.png)
![App Screenshot](https://danncode.com/portfolio/images/lucky_touch/7.png)
![App Screenshot](https://danncode.com/portfolio/images/lucky_touch/8.png)
![App Screenshot](https://danncode.com/portfolio/images/lucky_touch/9.png)


## Run Locally

Clone the project

```bash
  git clone https://github.com/danushaMalshan/lucky_touch.git
```

### Start Node.js server
Go to the project directory

```bash
  cd lucky_touch/Node js/lucky_touch
```

Install dependencies

```bash
  npm install
```

Start the server

```bash
  node server.js
```

### Run Flutter App
Go to the project directory

```bash
  cd lucky_touch/flutter/lucky_touch
```

Install dependencies

```bash
  flutter pub get
```

Run the flutter app

```bash
  flutter run lib/main.dart
```

