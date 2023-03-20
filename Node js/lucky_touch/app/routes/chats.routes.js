const { authJwt } = require("../middleware");
const chats = require("../controllers/chats.controller.js");

module.exports = function(app) {
  app.use(function(req, res, next) {
    res.header(
      "Access-Control-Allow-Headers",
      "x-access-token, Origin, Content-Type, Accept"
    );
    next();
  });

  // Create a new Tutorial
  app.post("/api/chats/add",[authJwt.verifyToken],chats.create);
//   app.post("/api/tickets/buyers/update/rank",[authJwt.verifyToken],ticket_buyers.updateRank);
app.get("/api/users/chatted", chats.findChattedUser);
  // Retrieve all Tutorials
  app.get("/api/user/chat/all",[authJwt.verifyToken],chats.findAll);
  app.get("/api/user/chat/:id",[authJwt.verifyToken],chats.findUserChats);
  app.post("/api/users/chat/update", [authJwt.verifyToken],chats.updateChattedUser);
  app.post("/api/users/chat/seen/update/:id", [authJwt.verifyToken],chats.msgSeenupdate);
//   app.get("/api/tickets/buyers/:ticket_type", [authJwt.verifyToken],ticket_buyers.getTicketBuyers);
  // app.put("/api/users/info", [authJwt.verifyToken],users.update);
//   app.post("/api/users/info/online", [authJwt.verifyToken],users.update);
  // app.post("/api/users/reset_pass_send_mail", users.resetPassSendMail);
};
