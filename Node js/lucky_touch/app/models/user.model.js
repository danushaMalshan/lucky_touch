module.exports = (sequelize, Sequelize) => {
  const User = sequelize.define("users", {
    users_id: {
       type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true,
    },
    first_name:{
      type:Sequelize.STRING
    },

    last_name:{
      type:Sequelize.STRING
    },

    profile_pic:{
      type:Sequelize.STRING
    },
    country:{
      type:Sequelize.STRING
    },
    usdt_address:{
      type:Sequelize.STRING
    },

    email:{
      type:Sequelize.STRING
    },
    password:{
      type:Sequelize.STRING
    },
    ticket_count:{
      type:Sequelize.INTEGER
    },
    last_online:{
      type:Sequelize.DATE
    },
    is_admin:{
      type:Sequelize.INTEGER
    },
    chatted:{
      type:Sequelize.INTEGER
    },

    banned:{
      type:Sequelize.INTEGER
    },
    last_msg:{
      type:Sequelize.STRING
    },
    last_msg_time:{
      type:Sequelize.DATE
    },
    msg_seen:{
      type:Sequelize.INTEGER
    },
    
    
    

  });

  return User;
};
