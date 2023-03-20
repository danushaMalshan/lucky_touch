const { authJwt } = require("../middleware");
const apis = require("../controllers/apis.controller.js");

module.exports = function(app) {
  app.use(function(req, res, next) {
    res.header(
      "Access-Control-Allow-Headers",
      "x-access-token, Origin, Content-Type, Accept"
    );
    next();
  });

  // Create a new Tutorial
  app.post("/api/update",[authJwt.verifyToken],apis.update);
//   app.post("/api/tickets/buyers/update/rank",[authJwt.verifyToken],ticket_buyers.updateRank);

  // Retrieve all Tutorials
  app.get("/api/get", [authJwt.verifyToken],apis.findKey);
//   app.get("/api/tickets/buyers/:ticket_type", [authJwt.verifyToken],ticket_buyers.getTicketBuyers);
  // app.put("/api/users/info", [authJwt.verifyToken],users.update);
//   app.post("/api/users/info/online", [authJwt.verifyToken],users.update);
  // app.post("/api/users/reset_pass_send_mail", users.resetPassSendMail);
};
