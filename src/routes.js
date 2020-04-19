const express = require('express');

const ItineraryController = require('./controllers/ItineraryController');
const PassengerController = require('./controllers/PassengerController');
const AuthController = require('./controllers/AuthController');
const GoController = require('./controllers/GoController');

const routes = express.Router();

//
routes.post('/auth', AuthController.login);

// Itinerary
routes.get('/itinerary', AuthController.verifyJWT, ItineraryController.listItinerariesDay);
routes.get('/itinerary/:id/passenger', AuthController.verifyJWT, ItineraryController.listPassengerDay)
routes.get('/itinerary/:id/location', AuthController.verifyJWT, ItineraryController.searchLocationDriver)

// Passenger
routes.get('/passenger/itinerary', AuthController.verifyJWT, PassengerController.listItinerariesDay)

// GO
routes.post('/go/:id/location', AuthController.verifyJWT, GoController.saveLocationDriver);
routes.post('/go/:id/start', AuthController.verifyJWT, GoController.startItinerary);

module.exports = routes;