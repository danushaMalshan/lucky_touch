module.exports = (sequelize, Sequelize) => {
  const Role = sequelize.define("roles", {
    roles_id: {
      type: Sequelize.INTEGER,
      primaryKey: true
    },
    name: {
      type: Sequelize.STRING
    }
  });

  return Role;
};
