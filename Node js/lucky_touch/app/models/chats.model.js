module.exports = (sequelize, Sequelize) => {
    const Chats = sequelize.define("chats", {
      chat_id: {
         type: Sequelize.INTEGER,
          primaryKey: true,
          autoIncrement: true,
      },
      users_id:{
        type:Sequelize.INTEGER
      },
      msg:{
        type:Sequelize.STRING
      },
  
      is_sender:{
        type:Sequelize.INTEGER
      },
      
      
      
      
      
  
    });
  
    return Chats;
  };
  