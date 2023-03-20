const { authJwt } = require("../middleware");
const tickets = require("../controllers/tickets.controller.js");

module.exports = function(app) {
  app.use(function(req, res, next) {
    res.header(
      "Access-Control-Allow-Headers",
      "x-access-token, Origin, Content-Type, Accept"
    );
    next();
  });

  // Create a new Tutorial
  app.post("/api/tickets/add",[authJwt.verifyToken],tickets.create);

  // Retrieve all Tutorials
  app.get("/api/tickets/find_tickets/:ticket_type", tickets.findTickets);
  app.get("/api/tickets/find_tickets/all", tickets.findAllTickets);
  // app.put("/api/users/info", [authJwt.verifyToken],users.update);
  // app.post("/api/users/info/online", [authJwt.verifyToken],users.update);
  // app.post("/api/users/reset_pass_send_mail", users.resetPassSendMail);
};
