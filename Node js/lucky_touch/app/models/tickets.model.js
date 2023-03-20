module.exports = (sequelize, Sequelize) => {
    const Tickets = sequelize.define("tickets", {
      ticket_id: {
         type: Sequelize.INTEGER,
          primaryKey: true,
          autoIncrement: true,
      },

      ticket_number:{
        type:Sequelize.STRING
      },
      ticket_type:{
        type:Sequelize.INTEGER
      },
      round_no:{
        type:Sequelize.INTEGER
      },
  
      title:{
        type:Sequelize.STRING
      },
      price:{
        type:Sequelize.INTEGER
      },
      start_date:{
        type:Sequelize.STRING
      },
  
      expire_date:{
        type:Sequelize.STRING
      },
      sold:{
        type:Sequelize.INTEGER
      },
      
      
      
      
      
      
  
    });
  
    return Tickets;
  };
  