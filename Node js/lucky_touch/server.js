

const express = require("express");
// const bodyParser = require("body-parser"); /* deprecated */
const cors = require("cors");

const app = express();

var corsOptions = {
  origin: "http://localhost:8081"
};

app.use(cors(corsOptions));


// parse requests of content-type - application/json
app.use(express.json());  /* bodyParser.json() is deprecated */

// parse requests of content-type - application/x-www-form-urlencoded
app.use(express.urlencoded({ extended: true }));   /* bodyParser.urlencoded() is deprecated */

const db = require("./app/models");
const Role = db.role;

db.sequelize.sync();
// // drop the table if it already exists
// db.sequelize.sync({ force: true }).then(() => {
//   console.log("Drop and re-sync db.");
// });

// simple route
app.get("/", (req, res) => {
  res.json({ message: "Welcome to bezkoder application." });
});

//require("./app/routes/turorial.routes")(app);
require('./app/routes/auth.routes')(app);
require('./app/routes/user.routes')(app);
require('./app/routes/roles.routes')(app);
require('./app/routes/tickets.routes')(app);
require('./app/routes/ticket_buyers.route')(app);
require('./app/routes/rounds.routes')(app);
require('./app/routes/notifications.routes')(app);
require('./app/routes/chats.routes')(app);
require('./app/routes/banners.routes')(app);
require('./app/routes/api.routes')(app);



// set port, listen for requests
const PORT = process.env.PORT || 8082;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`);
});

// app.listen();

function initial() {
  Role.create({
    id: 1,
    name: "user"
  });

  Role.create({
    id: 2,
    name: "moderator"
  });

  Role.create({
    id: 3,
    name: "admin"
  });
}



app.listen(8083);