const { authJwt } = require("../middleware");
const users = require("../controllers/user.controller.js");

module.exports = function(app) {
  app.use(function(req, res, next) {
    res.header(
      "Access-Control-Allow-Headers",
      "x-access-token, Origin, Content-Type, Accept"
    );
    next();
  });

  // Create a new Tutorial
  app.post("/api/users",users.create);

  // Retrieve all Tutorials
  app.get("/api/users/info", [authJwt.verifyToken], users.findOne);
  app.get("/api/users/online", users.onlineUsers);
  app.get("/api/users/banned", users.bannedUsers);
 
  app.get("/api/users/new", users.newUsers);
  app.put("/api/users/info", [authJwt.verifyToken],users.update);
  app.post("/api/users/info/online", [authJwt.verifyToken],users.update);
  app.post("/api/users/details/update", [authJwt.verifyToken],users.userDetailsUpdate);
  app.post("/api/users/findAll", [authJwt.verifyToken],users.getAllUsers);
  app.post("/api/users/ticket_count/update", [authJwt.verifyToken],users.updateTicketCount);
  app.post("/api/users/last_online/update", [authJwt.verifyToken],users.updateLastOnline);
  app.post("/api/users/reset_pass_send_mail", users.resetPassSendMail);
  app.delete("/api/users/remove/:id", users.banUser);
};
