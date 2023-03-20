const db = require("../models");
const config = require("../config/auth.config");
const User = db.user;
const Role = db.role;

const Op = db.Sequelize.Op;

var jwt = require("jsonwebtoken");
var bcrypt = require("bcryptjs");
const nodemailer = require("nodemailer");
exports.signup = (req, res) => {
  // Save User to Database
  User.create({
    first_name: req.body.first_name,
    last_name: req.body.last_name,
    profile_pic: req.body.profile_pic,
    country: req.body.country,
    usdt_address: req.body.usdt_address,
    email: req.body.email,
    password: bcrypt.hashSync(req.body.password, 8)
  })
    .then(user => {
      if (req.body.roles) {
        Role.findAll({
          where: {
            name: {
              [Op.or]: req.body.roles
            }
          }
        }).then(roles => {
          user.setRoles(roles).then(() => {
            res.send({ message: "User registered successfully!" });
          });
        });
      } else {
        // user role = 1
        
        user.setRoles([1]).then(() => {
          res.send({ message: "User registered successfully!" });
        });
      }      
    })
    .catch(err => {
      res.status(500).send({ message: err.message });
    });
};

exports.signin = (req, res) => {
  User.findOne({
    where: {
      email: req.body.email,
      
    }
  })
    .then(user => {
      if (!user) {
        return res.status(404).send({ message: "User Not found." });
      }

      if (user.banned==1) {
        return res.status(404).send({ message: "This user was banned!" });
      }

      var passwordIsValid = bcrypt.compareSync(
        req.body.password,
        user.password
      );

      if (!passwordIsValid) {
        return res.status(401).send({
          accessToken: null,
          message: "Invalid Password!"
        });
      }

      var token = jwt.sign({ users_id: user.users_id,is_admin:user.is_admin}, config.secret, {
        expiresIn: "300 days" // 24 hours
      });

      var authorities = [];
      user.getRoles().then(roles => {
        for (let i = 0; i < roles.length; i++) {
          authorities.push("ROLE_" + roles[i].name.toUpperCase());
        }
        res.status(200).send({
          id: user.users_id,
          first_name: user.first_name,
          last_name: user.last_name,
          profile_pic: user.profile_pic,
          country: user.country,
          usdt_address: user.usdt_address,
          email: user.email,
          is_admin:user.is_admin,
       
          accessToken: token
        });
      });
    })
    .catch(err => {
      res.status(500).send({ message: err.message });
    });
};


exports.signout = (req, res) => {
  User.findOne({
    where: {
      email: req.body.email,
      
    }
  })
    .then(user => {
      if (!user) {
        return res.status(404).send({ message: "User Not found." });
      }

      var passwordIsValid = bcrypt.compareSync(
        req.body.password,
        user.password
      );

      if (!passwordIsValid) {
        return res.status(401).send({
          accessToken: null,
          message: "Invalid Password!"
        });
      } else {
        res.status(200).send({
          message: "Logout Successful"
        });
      }




    })
    .catch(err => {
      res.status(500).send({ message: err.message });
    });




};

var code;
exports.resetPassword = (req, res) => {
  
  const email = req.body.email
  if (req.body.step == '1') {


    User.findOne({
      where: {
        email: email,

      }
    })
      .then(user => {
        if (!user) {
          return res.status(404).send({ message: "User Not found." });
        } else {
          code = Math.floor(100000 + Math.random() * 900000)
          var transporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
              user: 'luckytouch.win@gmail.com',
              pass: 'egyvbycoebwckskc'

            }
          })

          var mailOption = {
            from: 'luckytouch.win@gmail.com',
            to: `${email}`,
            subject: 'Reset Password',
            text: `Your password reset code-  ${code}`
          }

          transporter.sendMail(mailOption, function (err, info) {
            if (err) {
              console.log(err);
            } else {
              console.log('Email Sent:' + info.response);
              res.status(200).send({

                message: "Reset code sent"
              });
            }
          })
        }





      })
      .catch(err => {
        res.status(500).send({ message: err.message });
      });


  } else if (req.body.step == '2') {
    if (req.body.code == code) {
      User.update({ password: bcrypt.hashSync(req.body.password, 8) }, {
        where: { email: email }
      })
        .then(num => {
          if (num == 1) {
            res.send({
              message: "Password changed successfully."
            });
          } else {
            res.send({
              message: `Cannot changed Password with email=${email}. Maybe User was not found or req.body is empty!`
            });
          }
        })
        .catch(err => {
          res.status(500).send({
            message: "Error changing Password with email=" + email
          });
        });
    } else {
      res.status(500).send({
        message: "Reset code doesn't match. Enter correct code"
      });
    }

  }






};
