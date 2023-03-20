const { authJwt } = require("../middleware");
const roles = require("../controllers/roles.controller.js");

module.exports = function(app) {
  app.use(function(req, res, next) {
    res.header(
      "Access-Control-Allow-Headers",
      "x-access-token, Origin, Content-Type, Accept"
    );
    next();
  });
  
  app.get("/api/users/getAdmins",roles.GetAdmins);
  app.get("/api/users/getModerators",roles.GetModerators);
};
