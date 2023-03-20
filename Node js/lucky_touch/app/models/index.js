const config = require("../config/db.config.js");

const Sequelize = require("sequelize");
const sequelize = new Sequelize(
  config.DB,
  config.USER,
  config.PASSWORD,
  {
    host: config.HOST,
    dialect: config.dialect,
    operatorsAliases: false,

    pool: {
      max: config.pool.max,
      min: config.pool.min,
      acquire: config.pool.acquire,
      idle: config.pool.idle
    }
  }
);

const db = {};

db.Sequelize = Sequelize;
db.sequelize = sequelize;

db.user = require("../models/user.model.js")(sequelize, Sequelize);
db.role = require("../models/role.model.js")(sequelize, Sequelize);
db.tutorials = require("./tutorial.model.js")(sequelize, Sequelize);
db.banners = require("./banners.model")(sequelize, Sequelize);
// db.users=require("./user.model.js")(sequelize,Sequelize);
db.user_roles=require("./user_roles.model.js")(sequelize,Sequelize);
db.tickets=require("./tickets.model.js")(sequelize,Sequelize);
db.ticket_buyers=require("./ticket_buyers.model.js")(sequelize,Sequelize);
db.rounds=require("./rounds_model.js")(sequelize,Sequelize);
db.notifications=require("./notifications.model.js")(sequelize,Sequelize);
db.chats=require("./chats.model.js")(sequelize,Sequelize);
db.apis=require("./apis.model.js")(sequelize,Sequelize);


db.role.belongsToMany(db.user, {
  through: "user_roles",
  foreignKey: "roles_id",
  otherKey: "user_id"
});
db.user.belongsToMany(db.role, {
  through: "user_roles",
  foreignKey: "user_id",
  otherKey: "role_id"
});

db.user_roles.belongsTo(db.role, {
  // through: "user_roles",
  foreignKey: "role_id",
  // otherKey: "user_id"
});
db.role.hasOne(db.user_roles, {
  // through: "user_roles",
  foreignKey: "role_id",
  // otherKey: "role_id"
});

db.user_roles.belongsTo(db.user, {
  // through: "user_roles",
  foreignKey: "user_id",
  // otherKey: "user_id"
});
db.user.hasOne(db.user_roles, {
  // through: "user_roles",
  foreignKey: "user_id",
  // otherKey: "role_id"
});

db.chats.belongsTo(db.user, {
  // through: "user_roles",
  foreignKey: "users_id",
  // otherKey: "user_id"
});
db.user.hasOne(db.chats, {
  // through: "user_roles",
  foreignKey: "users_id",
  // otherKey: "role_id"
});

//-----------new-----------


db.tickets.hasMany(db.ticket_buyers, {
  // through: "user_roles",
  foreignKey: "ticket_id",
  // otherKey: "user_id"
});
db.ticket_buyers.belongsTo(db.tickets, {
  // through: "user_roles",
  foreignKey: "ticket_id",
  // otherKey: "role_id"
});

db.user.hasOne(db.ticket_buyers, {
  // through: "user_roles",
  foreignKey: "users_id",
  // otherKey: "user_id"
});
db.ticket_buyers.belongsTo(db.user, {
  // through: "user_roles",
  foreignKey: "users_id",
  // otherKey: "role_id"
});

//------------------------

// db.role.belongsToMany


db.ROLES = ["user", "admin", "moderator"];

module.exports = db;
