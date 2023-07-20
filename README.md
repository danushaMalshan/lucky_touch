
# Lucky Touch

Lucky Touch is a project that I have built according to a Fiverr client's reqvirenments. it was a lottery app where users can buy tickets with USDT.

Furthermore, users can manage their profiles, see user-bought tickets and status, see winners and previous round winners, chat with the admin and many more. also, the admin can see all analytics, remove users, manage rounds, manage tickets, select winners and many other features.

I have used node.js for a backend server and flutter for an app build but the biggest challenge is implementing crypto payment for buying tickets.so I researched for a couple of days and finally, I choose coinbase commerce API for a crypto payment then I was able to do crypto payments and track all of these payments that are pending, expired or successful. when payment is the successful user can use their ticket.


## Screenshots

<div style="display:flex;flex-wrap: wrap;justify-content: space-around; ">
<img src="https://danncode.com/portfolio/images/lucky_touch/1.webp"  width="350" height="auto">
<img src="https://danncode.com/portfolio/images/lucky_touch/2.webp"  width="350" height="auto">
<img src="https://danncode.com/portfolio/images/lucky_touch/3.webp"  width="350" height="auto">
<img src="https://danncode.com/portfolio/images/lucky_touch/4.webp"  width="350" height="auto">
<img src="https://danncode.com/portfolio/images/lucky_touch/5.webp"  width="350" height="auto">
<img src="https://danncode.com/portfolio/images/lucky_touch/6.webp"  width="350" height="auto">
<img src="https://danncode.com/portfolio/images/lucky_touch/7.webp"  width="350" height="auto">
<img src="https://danncode.com/portfolio/images/lucky_touch/8.webp"  width="350" height="auto">
<img src="https://danncode.com/portfolio/images/lucky_touch/9.webp"  width="350" height="auto">

</div>




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

