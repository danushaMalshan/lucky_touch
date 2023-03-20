const db = require("../models");
const Tickets = db.tickets;
const Rounds = db.rounds;
const Op = db.Sequelize.Op;
const Notifications = db.notifications;
// Create and Save a new Tutorial
exports.create = (req, res) => {
  // Validate request
  if (!req.body.ticket_type) {
    res.status(400).send({
      message: "Content can not be empty!"
    });
    return;
  }
  const quantity = req.body.quantity;
  // Create a Ticket

  var tickets = [];
  
 

  for (var i = 0; i < quantity; i++) {
    
    var digits = Math.floor(Math.random() * 9000000000) + 1000000000;

    var tc = {
      ticket_number:digits,
      ticket_type: req.body.ticket_type,
      round_no: req.body.round_no,
      title: req.body.title,
      price: req.body.price,
      start_date: req.body.start_date,
      expire_date: req.body.expire_date,
      sold: 0
    };
   
    tickets.push(tc)
  }


  if(req.is_admin==1){
    Tickets.bulkCreate(tickets)
    .then(data => {
      res.send({
        message:
          "Tickets Added"
      });

      // var text='text';
      // var title='title';

      
      // if(req.body.ticket_type==0){
      //   title="Golden"
      //   text='New Golden Tickets Added'
      // }else if(req.body.ticket_type==1){
      //   title="Silver"
      //   text='New Silver Tickets Added'
      // }else if(req.body.ticket_type==1){
      //   title="Platinum"
      //   text='New Platinum Tickets Added'
      // }

      // const notifications = {
      //   noti_title: title,
      //   noti_text: text,
        
      // };
    
      // // Save Tutorial in the database
      // Notifications.create(notifications)
      //   .then(data => {
          
      //   })
      //   .catch(err => {
        
      //   });

    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while adding The Tickets."
      });
    });
  }
  // Save Tutorial in the database
  




};

// Retrieve all Tutorials from the database.
exports.findTickets = (req, res) => {
  const tp = req.params.ticket_type

  Rounds.findOne({ order: [['createdAt', 'DESC']], })
        .then(data => {
          
            if (data) {

              Tickets.findAll({ where: { ticket_type: tp, sold: 0,round_no:data.round_no, } })
              .then(data => {
                res.send({ data });
             
              })
              .catch(err => {
                // res.status(500).send({
                //   message:
                //     err.message || "Some error occurred while retrieving tutorials."
                // });
              });

            } else {
                res.status(404).send({
                    message: `Round Not Added`
                });
            }
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving Round"
            });
        });

  
};


exports.findAllTickets = (req, res) => {
  const tp = req.params.ticket_type

  Rounds.findOne({ order: [['createdAt', 'DESC']], })
        .then(data => {
          
            if (data) {
              Tickets.findAll({ where: {  sold: 0,round_no:data.round_no, } })
              .then(data => {
                res.send({ data });
              })
              .catch(err => {
                // res.status(500).send({
                //   message:
                //     err.message || "Some error occurred while retrieving tutorials."
                // });
              });

            } else {
                res.status(404).send({
                    message: `Round Not Added`
                });
            }
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving Round"
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
