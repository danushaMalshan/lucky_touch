// const { notifications } = require("../models");
//const { now } = require("sequelize/dist/lib/utils");
const db = require("../models");
const Users = db.user;
const Roles = db.role;
const Banners = db.banners;
const Op = db.Sequelize.Op;
const TicketBuyers = db.ticket_buyers;
// Create and Save a new Tutorial
exports.create = (req, res) => {
  //   Validate request
  if (!req.body.first_name) {

    res.status(400).send({
      message: "Content can not be empty!"
    });
    return;
  }
  // Create a Tutorial
  let date = Date.now();
  const use = {
    // title: req.body.title,

    users_id: req.body.users_id,
    first_name: req.body.first_name,
    last_name: req.body.last_name,
    country: req.body.country,
    usdt_address: req.body.usdt_address,
    email: req.body.email,
    password: req.body.password,
    last_online: date

  };

  Users.create(use)
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while Adding User info."
      });
    });
};

exports.findOne = (req, res) => {
  const id = req.users_id;
  console.log(id)


  Users.findOne({ where: { users_id: id } })
    .then(data => {
      const obj = JSON.parse(JSON.stringify(data));
      obj['dev_by'] = 'D-Soft';

      res.send(obj);
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while retrieving User."
      });
    });
};


exports.userDetailsUpdate = (req, res) => {
  const id = req.users_id;


  Users.findOne({ where: { users_id: id } })
    .then(data => {
      if (data) {

        if (data.banned != 1) {
          Users.update(req.body, {
            where: { users_id: id }
          })
            .then(num => {
              if (num == 1) {
                res.send({
                  message: "User was updated successfully."
                });
              } else {
                res.send({
                  message: `Cannot update User with id=${id}. Maybe User was not found or req.body is empty!`
                });
              }
            })
            .catch(err => {
              res.status(500).send({
                message: "Error updating User with id=" + id
              });
            });
        }else{
          res.status(404).send({
            message: `Cannot update. this user was banned`
          });
        }
        // res.send(data);
      } else {
        res.status(404).send({
          message: `Cannot find Tutorial with id=${id}.`
        });
      }
    })
    .catch(err => {
      res.status(500).send({
        message: "Error retrieving Tutorial with id=" + id
      });
    });



};

exports.getAllUsers = (req, res) => {
  console.log(req.body.query)
  if (req.body.query == '' || req.body.query == null) {
    console.log(1)
    Users.findAll({where:{banned:0},
      order: [['createdAt', 'DESC']],
    })
      .then(data => {
        res.send({ data });
      })
      .catch(err => {
        res.status(500).send({
          message:
            err.message || "Some error occurred while retrieving users."
        });
      });
  } else {
    console.log(2)
    Users.findAll({
      order: [['createdAt', 'DESC']], where: {
        [Op.or]: [{ first_name: { [Op.like]: '%' + req.body.query + '%' } }, { last_name: { [Op.like]: '%' + req.body.query + '%' } }],

      }
    })
      .then(data => {
        res.send({ data });
      })
      .catch(err => {
        res.status(500).send({
          message:
            err.message || "Some error occurred while retrieving users."
        });
      });
  }

};

exports.update = (req, res) => {
  const id = req.users_id;

  if (req.body.last_online != null) {
    Users.update(req.body, {
      where: { users_id: id }
    })
      .then(num => {
        if (num == 1) {
          res.send({
            message: "User updated successfully."
          });
        } else {
          res.send({
            message: `Cannot update user  with id=${id}. Maybe user was not found or req.body is empty!`
          });
        }
      })
      .catch(err => {
        res.status(500).send({
          message: "Error updating User with id=" + id
        });
      });
  }

  if (req.body.last_online == null) {
    Users.update(req.body, {
      where: { users_id: id }
    })
      .then(num => {
        if (num == 1) {
          res.send({
            message: "User was updated successfully."
          });
        } else {
          res.send({
            message: `Cannot update User with id=${id}. Maybe Ad was not found or req.body is empty!`
          });
        }
      })
      .catch(err => {
        res.status(500).send({
          message: "Error updating User with id=" + id
        });
      });
  }


};

function between(min, max) {
  return Math.floor(
    Math.random() * (max - min) + min
  )
}


exports.updateTicketCount = (req, res) => {
  const id = req.users_id;
  Users.findOne({ where: { users_id: id } })
    .then(data => {
      if (data) {
        // res.send(data);

        Users.update({ ticket_count: parseFloat(data.ticket_count) + 1 }, {
          where: { users_id: id }
        })
          .then(num => {
            if (num == 1) {
              res.send({
                message: "users  updated successfully."
              });
            } else {
              res.send({
                message: `Cannot update . Maybe User was not found or req.body is empty!`
              });
            }
          })
          .catch(err => {
            res.status(500).send({
              message: "Error updating Users with id=" + id
            });
          });

      } else {
        res.status(404).send({
          message: `Cannot find Tutorial with id=${id}.`
        });
      }
    })
    .catch(err => {
      res.status(500).send({
        message: "Error retrieving Users with id=" + id
      });
    });
};

exports.updateLastOnline = (req, res) => {
  const u_id = req.users_id;
  Users.update({ last_online: req.body.last_online }, {
    where: { users_id: u_id }
  })
    .then(num => {
      if (num == 1) {
        res.send({
          message: "Last Online updated"
        });
      } else {
        res.send({
          message: `Cannot update last online with id=${u_id}. !`
        });
      }
    })
    .catch(err => {
      res.status(500).send({
        message: "Error updating last online with id=" + u_id
      });
    });
};

exports.onlineUsers = (req, res) => {
  let dt = new Date()
  dt.setHours(dt.getHours() - 1)

  console.log(dt)
  Users.findAll({ where: { last_online: { [Op.gt]: dt } } })
    .then(data => {
      res.send({ data });
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while retrieving tutorials."
      });
    });
};



exports.newUsers = (req, res) => {
  let dt = new Date()
  dt.setDate(dt.getDate() - 5)

  Users.findAll({ where: { createdAt: { [Op.gt]: dt } } })
    .then(data => {
      res.send({ data });
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while retrieving users."
      });
    });
};

exports.bannedUsers = (req, res) => {
  

  Users.findAll({ where: { banned:1 } })
    .then(data => {
      res.send({ data });
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while retrieving users."
      });
    });
};

exports.banUser = (req, res) => {
  const id = req.params.id;

  Users.update({ banned: 1 }, {
    where: { users_id: id }
  })
    .then(num => {
      if (num == 1) {
        TicketBuyers.destroy({
          where: { users_id: id }
        })
          .then(num => {
            if (num == 1) {
              // res.send({
              //   message: "Tutorial was deleted successfully!"
              // });
            } else {
              // res.send({
              //   message: `Cannot delete Tutorial with id=${id}. Maybe Tutorial was not found!`
              // });
            }
          })
          .catch(err => {
            // res.status(500).send({
            //   message: "Could not delete Tutorial with id=" + id
            // });
          });
        res.send({
          message: "user was banned successfully."
        });
      } else {
        res.send({
          message: `Cannot ban user with id=${id}. Maybe user was not found or req.body is empty!`
        });
      }
    })
    .catch(err => {
      res.status(500).send({
        message: "Error  with id=" + id
      });
    });
};

exports.resetPassSendMail = (req, res) => {
  if (req.body.email != null) {
    rCode = between(10000, 99999);

    const randKey = {
      reset_code: rCode,
    };

    Users.update(randKey, {
      where: { email: req.body.email }
    })
      .then(num => {
        if (num == 1) {
          res.send({
            message: "User updated successfully."
          });
        } else {
          res.send({
            message: `Cannot update user . Maybe user was not found or req.body is empty!`
          });
        }
      })
      .catch(err => {
        res.status(500).send({
          message: "Error updating User"
        });
      });
  }


};
