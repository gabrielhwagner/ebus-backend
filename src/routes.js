const express = require('express');

const ItineraryController = require('./controllers/ItineraryController');
const PassengerController = require('./controllers/PassengerController');
const AuthController = require('./controllers/AuthController');

const routes = express.Router();

//
routes.post('/auth', AuthController.login);

// Itinerary
routes.get('/itinerary', ItineraryController.listItinerariesDay);
routes.get('/itinerary/:id/passenger', ItineraryController.listPassengerDay)
routes.get('/itinerary/:id/location', ItineraryController.searchLocationDriver)

// Passenger
routes.get('/passenger/itinerary', PassengerController.listItinerariesDay)

// GO

module.exports = routes;