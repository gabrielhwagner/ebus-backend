// Update with your config settings.

module.exports = {

  developmentLocal: {
    client: 'mysql2',
    connection: {
      host: 'localhost',
      user: 'root',
      password: 'password',
      database: 'mydb'
    }
  },

  development: {
    client: 'mysql2',
    connection: {
      host: 'us-cdbr-iron-east-01.cleardb.net',
      user: 'b2a5627f8a09f1',
      password: '2ccc2083',
      database: 'heroku_478adca6f832bfb'
    }
  },
};
