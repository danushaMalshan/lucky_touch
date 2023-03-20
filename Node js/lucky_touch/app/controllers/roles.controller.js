const db = require("../models");
const Roles = db.role;
const Users = db.user;
const UserRoles = db.user_roles;
const Op = db.Sequelize.Op;


// Retrieve all Admins from the database.
exports.GetAdmins = (req, res) => {

  UserRoles.findAll({ where:{role_id:4} ,include:Users})
    .then(data => {
      res.send({data});
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while retrieving Admins."
      });
    });
};


// Retrieve all Admins from the database.
exports.GetModerators = (req, res) => {
  
     UserRoles.findOne({ where:{role_id:2} ,include:Users})
       .then(data => {
         res.send(data);
       })
       .catch(err => {
         res.status(500).send({
           message:
             err.message || "Some error occurred while retrieving Ad."
         });
       });
   };


