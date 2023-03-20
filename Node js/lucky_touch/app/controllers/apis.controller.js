const db = require("../models");
const Apis = db.apis;
const Op = db.Sequelize.Op;


// Update a Tutorial by the id in the request
exports.update = (req, res) => {

    if (req.is_admin == 1) {
        Apis.update({ api_key: req.body.api_key }, {
            where: { api_id: 1 }
        })
            .then(num => {
                if (num == 1) {
                    res.send({
                        message: "Api key updated successfully."
                    });
                } else {
                    res.send({
                        message: `Cannot update Api key with id=1. Maybe Api key was not found or req.body is empty!`
                    });
                }
            })
            .catch(err => {
                res.status(500).send({
                    message: "Error updating Api key with id=" + id
                });
            });
    }

};

exports.findKey = (req, res) => {


    Apis.findOne({ where: { api_id: 1 } })
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message:
                    err.message || "Some error occurred while retrieving key."
            });
        });
};

