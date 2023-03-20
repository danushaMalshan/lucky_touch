module.exports = (sequelize, Sequelize) => {
    const UserRoles = sequelize.define("user_roles", {
      
      role_id: {
        type: Sequelize.INTEGER
      },
     
      user_id: {
        type: Sequelize.INTEGER
        
      },
    });
  
    return UserRoles;
  };
  