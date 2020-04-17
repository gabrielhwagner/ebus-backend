const express = require('express');

const ItineraryController = require('./controllers/ItineraryController');
const PassengerController = require('./controllers/PassengerController');
const AuthController = require('./controllers/AuthController');
const GoController = require('./controllers/GoController');

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
routes.post('/go/:id/location', GoController.saveLocationDriver);
routes.post('/go/:id/start', GoController.startItinerary);

module.exports = routes;