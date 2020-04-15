const express = require('express');

const ItineraryController = require('./controllers/ItineraryController');
const PassengerController = require('./controllers/PassengerController');

const routes = express.Router();

// Itinerary
routes.get('/itinerary', ItineraryController.listItinerariesDay);
routes.get('/itinerary/:id/passenger', ItineraryController.listPassengerDay)

// Passenger
routes.get('/passenger/itinerary', PassengerController.listItinerariesDay)

module.exports = routes;