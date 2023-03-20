const { authJwt } = require("../middleware");
const ticket_buyers = require("../controllers/ticket_buyers.controller.js");

module.exports = function (app) {
  app.use(function (req, res, next) {
    res.header(
      "Access-Control-Allow-Headers",
      "x-access-token, Origin, Content-Type, Accept"
    );
    next();
  });

  // Create a new Tutorial
  app.post("/api/tickets/buy", [authJwt.verifyToken], ticket_buyers.create);
  app.post("/api/tickets/buyers/update/rank", [authJwt.verifyToken], ticket_buyers.updateRank);
  app.post("/api/tickets/buyers/update/price", [authJwt.verifyToken], ticket_buyers.updatePrice);
  app.post("/api/tickets/buyers/update/timeline", [authJwt.verifyToken], ticket_buyers.updateTimeLine);

  // Retrieve all Tutorials
  app.get("/api/tickets/user", [authJwt.verifyToken], ticket_buyers.getUserTickets);
  app.get("/api/tickets/winners", [authJwt.verifyToken], [authJwt.verifyToken], ticket_buyers.findWinners);
  app.get("/api/tickets/buyers/:ticket_type", [authJwt.verifyToken], ticket_buyers.getTicketBuyers);
  app.get("/api/tickets/previous_winners/:round", [authJwt.verifyToken], ticket_buyers.findPreviousWinners);
  app.post("/api/tickets/buyers/all", [authJwt.verifyToken], ticket_buyers.getAllTicketBuyers);
  // app.put("/api/users/info", [authJwt.verifyToken],users.update);
  //   app.post("/api/users/info/online", [authJwt.verifyToken],users.update);
  // app.post("/api/users/reset_pass_send_mail", users.resetPassSendMail);
};
