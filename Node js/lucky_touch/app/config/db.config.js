module.exports = {
  HOST: "localhost",
  USER: "root",
  // PASSWORD: "123456",
  DB: "luckytouch",
  dialect: "mysql",
  pool: {
    max: 5,
    min: 0,
    acquire: 30000,
    idle: 10000
  },

};

// module.exports = {
//   HOST: "localhost",
//   //USER: "root", //Production
//   USER: "luckadtc_luckytouch", //Testing
//   //PASSWORD: "fb2da9d052f9", //Production
//   //PASSWORD: "", //Local
//   PASSWORD: "7@7W]vq&sJmK", //Testing
//   //DB: "kahawanu", //Pruduction
//   DB: "luckadtc_lucky_touch", //Testing
//   dialect: "mysql",
//   // dialectOptions: {
//   //   // useUTC: false, //for reading from database
//   //   dateStrings: true,
//   //   typeCast: true,
//   //   timezone: "UTC+05:30"
//   // },
//   // timezone: "UTC+05:30",
//   pool: {
//     max: 5,
//     min: 0,
//     acquire: 30000,
//     idle: 10000
//   }
// };