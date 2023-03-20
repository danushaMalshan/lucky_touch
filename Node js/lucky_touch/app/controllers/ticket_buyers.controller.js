const db = require("../models");
const TicketBuyers = db.ticket_buyers;
const Tickets = db.tickets;
const Users = db.user;
const Rounds = db.rounds;

const Op = db.Sequelize.Op;

// Create and Save a new Tutorial
exports.create = (req, res) => {
  // Validate request
  if (!req.body.ticket_id) {
    res.status(400).send({
      message: "Content can not be empty!"
    });
    return;
  }

  // Create a Ticket

  const u_id = req.users_id
  const t_id = req.body.ticket_id

  const tb = {
    users_id: u_id,
    ticket_id: t_id,
    payment_id: req.body.payment_id,
    wallet_address: req.body.wallet_address
  };

  Users.findOne({ where: { users_id: u_id } })
    .then(data => {
      if (data) {

        if (data.banned != 1) {
          // Save Tutorial in the database
          TicketBuyers.create(tb)
            .then(data => {
              // res.send({ data });




              Tickets.update({
                sold: 1
              }, { where: { ticket_id: t_id } })
                .then(num => {
                  if (num == 1) {
                    res.send({
                      message: "Ticket buy successfully."
                    });
                  } else {
                    res.send({
                      message: `Cannot buy Ticket with id=${id}. Maybe Ticket was not found or req.body is empty!`
                    });
                  }
                })
                .catch(err => {
                  // res.status(500).send({
                  //   message: "Error buying Ticket with id=" + id
                  // });
                });



            })
            .catch(err => {
              res.status(500).send({
                message:
                  err.message || "Some error occurred while adding The Tickets."
              });
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

exports.getUserTickets = (req, res) => {
  const u_id = req.users_id

  TicketBuyers.findAll({
    where: { users_id: u_id }, include: Tickets, order: [
      ['createdAt', 'DESC'],

    ],
  })
    .then(data => {
      res.send({ data });
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while retrieving Tickets."
      });
    });
};

exports.updateRank = (req, res) => {
  const rk = req.body.rank;
  const id = req.body.buyer_id;

  console.log(rk);
  console.log(id);
  if (req.is_admin == 1) {
    TicketBuyers.update({ rank: rk }, {
      where: { buyer_id: id }
    })
      .then(num => {
        if (num == 1) {
          res.send({
            message: "updated successfully."
          });
        } else {
          res.send({
            message: `Cannot update  with id=${id}. Maybe Ticket was not found or req.body is empty!`
          });
        }
      })
      .catch(err => {
        res.status(500).send({
          message: "Error updating Tutorial with id=" + id
        });
      });
  }

};


exports.updatePrice = (req, res) => {
  const price = req.body.price;
  const id = req.body.buyer_id;

  // console.log(rk);
  // console.log(id);
  if (req.is_admin == 1) {
    TicketBuyers.update({ price: price }, {
      where: { buyer_id: id }
    })
      .then(num => {
        if (num == 1) {
          res.send({
            message: "updated successfully."
          });
        } else {
          res.send({
            message: `Cannot update  with id=${id}. Maybe Ticket was not found or req.body is empty!`
          });
        }
      })
      .catch(err => {
        res.status(500).send({
          message: "Error updating Tutorial with id=" + id
        });
      });
  }

};

exports.updateTimeLine = (req, res) => {
  const timeline = req.body.timeline;
  const id = req.body.buyer_id;


  console.log(id);
  TicketBuyers.update({ timeline: timeline }, {
    where: { buyer_id: id }
  })
    .then(num => {
      if (num == 1) {
        res.send({
          message: "updated successfully."
        });
      } else {
        res.send({
          message: `Cannot update  with id=${id}. Maybe Ticket was not found or req.body is empty!`
        });
      }
    })
    .catch(err => {
      res.status(500).send({
        message: "Error updating  with id=" + id
      });
    });
};



//------------------------------------------------------------------------

// Retrieve all Tutorials from the database.
exports.findTickets = (req, res) => {
  const tp = req.params.ticket_type

  Tickets.findAll({ where: { ticket_type: tp } })
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

exports.findWinners = (req, res) => {
  const tp = req.params.ticket_type

  Rounds.findOne({ order: [['createdAt', 'DESC']], })
    .then(data => {
      if (data) {



        TicketBuyers.findAll({
          where: { rank: { [Op.ne]: null } }, order:
            [['rank', 'ASC']], include: [{ model: Tickets, where: { round_no: data.round_no } }, {
              model: Users
            }]
        })
          .then(data => {
            res.send({ data });
          })
          .catch(err => {
            res.status(500).send({
              message:
                err.message || "Some error occurred while retrieving winners."
            });
          });

      } else {
        res.status(404).send({
          message: `Cannot find Last Round`
        });
      }
    })
    .catch(err => {
      res.status(500).send({
        message: "Error retrieving Round"
      });
    });


};

exports.findPreviousWinners = (req, res) => {
  const round = req.params.round



  TicketBuyers.findAll({
    where: { rank: { [Op.lt]: 4 } }, include: [{ model: Tickets, where: { round_no: round } }, { model: Users }], order:
      [['rank', 'ASC']]
  })
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

// Find a single Tutorial with an id
exports.findOne = (req, res) => {
  const id = req.params.id;

  Tutorial.findByPk(id)
    .then(data => {
      if (data) {
        res.send(data);
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

// Update a Tutorial by the id in the request
exports.update = (req, res) => {
  const id = req.params.id;

  Tutorial.update(req.body, {
    where: { id: id }
  })
    .then(num => {
      if (num == 1) {
        res.send({
          message: "Tutorial was updated successfully."
        });
      } else {
        res.send({
          message: `Cannot update Tutorial with id=${id}. Maybe Tutorial was not found or req.body is empty!`
        });
      }
    })
    .catch(err => {
      res.status(500).send({
        message: "Error updating Tutorial with id=" + id
      });
    });
};

exports.getTicketBuyers = (req, res) => {

  const type = req.params.ticket_type;


  Rounds.findOne({ order: [['createdAt', 'DESC']], })
    .then(data => {
      if (data) {

        const roundNo = data.round_no;
        TicketBuyers.findAll({
          where: { timeline: 'COMPLETED', },
          include: [{ model: Tickets, where: { ticket_type: type, round_no: roundNo } }, {
            model: Users, order:
              ['ticket_count', 'DESC'],
          }]
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
        res.status(404).send({
          message: `Cannot find Last Round`
        });
      }
    })
    .catch(err => {
      res.status(500).send({
        message: "Error retrieving Round"
      });
    });


};


exports.getAllTicketBuyers = (req, res) => {


  if (req.body.query == '' || req.body.query == null) {
    Rounds.findOne({ order: [['createdAt', 'DESC']], })
      .then(data => {
        if (data) {

          const roundNo = data.round_no;
          TicketBuyers.findAll({
            // where: { timeline: 'COMPLETED', },
            include: [{ model: Tickets, where: { round_no: roundNo } }, {
              model: Users, order:
                ['ticket_count', 'DESC'],
            }]
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
          res.status(404).send({
            message: `Cannot find Last Round`
          });
        }
      })
      .catch(err => {
        res.status(500).send({
          message: "Error retrieving Round"
        });
      });
  } else {
    Rounds.findOne({ order: [['createdAt', 'DESC']], })
      .then(data => {
        if (data) {

          const roundNo = data.round_no;
          TicketBuyers.findAll({
            // where: { timeline: 'COMPLETED', },
            include: [{ model: Tickets, where: { round_no: roundNo } }, {
              model: Users, order:
                ['ticket_count', 'DESC'], where: { [Op.or]: [{ first_name: { [Op.like]: '%' + req.body.query + '%' } }, { last_name: { [Op.like]: '%' + req.body.query + '%' } }], },
            }]
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
          res.status(404).send({
            message: `Cannot find Last Round`
          });
        }
      })
      .catch(err => {
        res.status(500).send({
          message: "Error retrieving Round"
        });
      });
  }



};

// Delete a Tutorial with the specified id in the request
exports.delete = (req, res) => {
  const id = req.params.id;

  Tutorial.destroy({
    where: { id: id }
  })
    .then(num => {
      if (num == 1) {
        res.send({
          message: "Tutorial was deleted successfully!"
        });
      } else {
        res.send({
          message: `Cannot delete Tutorial with id=${id}. Maybe Tutorial was not found!`
        });
      }
    })
    .catch(err => {
      res.status(500).send({
        message: "Could not delete Tutorial with id=" + id
      });
    });
};



// Delete all Tutorials from the database.
exports.deleteAll = (req, res) => {
  Tutorial.destroy({
    where: {},
    truncate: false
  })
    .then(nums => {
      res.send({ message: `${nums} Tutorials were deleted successfully!` });
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while removing all tutorials."
      });
    });
};

// find all published Tutorial
exports.findAllPublished = (req, res) => {
  Tutorial.findAll({ where: { published: true } })
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while retrieving tutorials."
      });
    });
};
