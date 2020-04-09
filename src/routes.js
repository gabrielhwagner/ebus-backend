const express = require('express');
const connection = require('./database/connection');

const routes = express.Router();

routes.get('/', async (req, res) => {
   const itinerary = await connection('itinerary').select('*');

  return res.json(itinerary);
});

routes.post('/', async (req, res) => {
  const { name } = req.body;

  await connection('itinerary').insert({
    name
  });

  return res.json();
});

module.exports = routes;