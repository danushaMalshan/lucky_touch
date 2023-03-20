module.exports = (sequelize, Sequelize) => {
    const Apis = sequelize.define("apis", {
      api_id: {
         type: Sequelize.INTEGER,
          primaryKey: true,
          autoIncrement: true,
      },
      api_key:{
        type:Sequelize.STRING
      },
      
     
      
      
      
      
  
    });
  
    return Apis;
  };
  