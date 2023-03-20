const db = require("../models");
const Notifications = db.notifications;
const Op = db.Sequelize.Op;

// Create and Save a new Tutorial
exports.create = (req, res) => {
  // Validate request
  if (!req.body.noti_text) {
    res.status(400).send({
      message: "Content can not be empty!"
    });
    return;
  }

  // Create a Tutorial
  const notifications = {
    noti_title: req.body.noti_title,
    noti_text: req.body.noti_text,
    
  };

  // Save Tutorial in the database
  Notifications.create(notifications)
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while adding the Notification."
      });
    });
};

exports.findNotifications = (req, res) => {
    
  
    Notifications.findAll({ where: {did_read:0} })
      .then(data => {
        res.send({data});

        for(var i=0;i<data.length;i++){
            Notifications.update({did_read:1}, {
                where: { noti_id:data[i].noti_id}
              })
                .then(num => {
                  if (num == 1) {
                    // res.send({
                    //   message: "Tutorial was updated successfully."
                    // });
                  } else {
                    // res.send({
                    //   message: `Cannot update Tutorial with id=${id}. Maybe Tutorial was not found or req.body is empty!`
                    // });
                  }
                })
                .catch(err => {
                  res.status(500).send({
                    message: "Error updating Tutorial with id=" + id
                  });
                });
        }
      })
      .catch(err => {
        // res.status(500).send({
        //   message:
        //     err.message || "Some error occurred while retrieving tutorials."
        // });
      });
  };
//-------------------------------------------------------------------

// Retrieve all Tutorials from the database.


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
