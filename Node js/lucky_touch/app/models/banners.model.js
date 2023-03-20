module.exports = (sequelize, Sequelize) => {
    const Banners = sequelize.define("banners", {
      banner_id: {
         type: Sequelize.INTEGER,
          primaryKey: true,
          autoIncrement: true,
      },
      banner_url:{
        type:Sequelize.STRING
      },
      lunch_url:{
        type:Sequelize.STRING
      },
     
      
      
      
      
  
    });
  
    return Banners;
  };
  