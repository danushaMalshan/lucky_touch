const db = require("../models");
const Chats = db.chats;
const Users = db.user;

const Op = db.Sequelize.Op;

// Create and Save a new Tutorial
exports.create = (req, res) => {
  // Validate request
  if (!req.body.msg) {
    res.status(400).send({
      message: "Content can not be empty!"
    });
    return;
  }

  // Create a Tutorial
  const chats = {
    users_id: req.body.
      users_id,
    msg: req.body.msg,
    is_sender: req.body.is_sender
  };

  // Save Tutorial in the database
  Chats.create(chats)
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while sending message"
      });
    });
};

exports.findAll = (req, res) => {
  const u_id = req.users_id

  Chats.findAll({
    where: { users_id: u_id }, order: [
      ['createdAt', 'ASC'],

    ],
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


exports.updateChattedUser = (req, res) => {
  const uid = req.users_id;
  const msg = req.body.last_msg;

  Users.update({ chatted: 1, last_msg: msg, last_msg_time: Date.now(), msg_seen: 0 }, {
    where: { users_id: uid }
  })
    .then(num => {
      if (num == 1) {
        res.send({
          message: "User was updated successfully."
        });
      } else {
        res.send({
          message: `Cannot update user with id=${uid}. Maybe user was not found or req.body is empty!`
        });
      }
    })
    .catch(err => {
      res.status(500).send({
        message: "Error updating Tutorial with id=" + uid
      });
    });
};

exports.findChattedUser = (req, res) => {

  Users.findAll({
    where: { chatted: 1 }, order: [
      ['last_msg_time', 'DESC'],

    ]
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
};

exports.msgSeenupdate = (req, res) => {
  const id = req.params.id;

  Users.update({ msg_seen: 1 }, {
    where: { users_id: id }
  })
    .then(num => {
      if (num == 1) {
        res.send({
          message: "users was updated successfully."
        });
      } else {
        res.send({
          message: `Cannot update users with id=${id}. Maybe users was not found or req.body is empty!`
        });
      }
    })
    .catch(err => {
      res.status(500).send({
        message: "Error updating users with id=" + id
      });
    });
};
exports.findUserChats = (req, res) => {
  const u_id = req.params.id;

  Chats.findAll({
    where: { users_id: u_id }, order: [
      ['createdAt', 'ASC'],

    ],
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


//--------------------------------------------------------------------------------------------------------------------------------
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
