module.exports = (sequelize, Sequelize) => {
    const Rounds = sequelize.define("rounds", {
      round_id: {
         type: Sequelize.INTEGER,
          primaryKey: true,
          autoIncrement: true,
      },
      round_no: {
        type: Sequelize.INTEGER,
        
     },
      price:{
        type:Sequelize.STRING
      },
  
      start_at:{
        type:Sequelize.STRING
      },
      end_at:{
        type:Sequelize.STRING
      },
      
      
      
      
      
  
    });
  
    return Rounds;
  };
  