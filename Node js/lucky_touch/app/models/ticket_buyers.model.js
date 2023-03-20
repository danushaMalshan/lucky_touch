module.exports = (sequelize, Sequelize) => {
    const TicketBuyers = sequelize.define("ticket_buyers", {
      buyer_id: {
         type: Sequelize.INTEGER,
          primaryKey: true,
          autoIncrement: true,
      },
      users_id:{
        type:Sequelize.INTEGER
      },
  
      ticket_id:{
        type:Sequelize.INTEGER
      },
      payment_id:{
        type:Sequelize.STRING
      },
      timeline:{
        type:Sequelize.STRING
      },
      wallet_address:{
        type:Sequelize.STRING
      },
      rank:{
        type:Sequelize.INTEGER
      },
      price:{
        type:Sequelize.INTEGER
      },
      
      
      
      
      
  
    });
  
    return TicketBuyers;
  };
  