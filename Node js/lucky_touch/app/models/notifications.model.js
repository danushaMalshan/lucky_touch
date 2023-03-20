module.exports = (sequelize, Sequelize) => {
    const Notifications = sequelize.define("notifications", {
      noti_id: {
         type: Sequelize.INTEGER,
          primaryKey: true,
          autoIncrement: true,
      },
      noti_title:{
        type:Sequelize.STRING
      },
  
      noti_text:{
        type:Sequelize.STRING
      },
      
      did_read:{
        type:Sequelize.INTEGER
      }
      
      
      
  
    });
  
    return Notifications;
  };
  