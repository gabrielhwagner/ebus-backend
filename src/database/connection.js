const knex = require('knex');
const configuration = require('../../knexfile');

const connection = knex(configuration.developmentLocal);

module.exports = connection;