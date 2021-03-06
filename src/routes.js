const express = require('express');

const ItineraryController = require('./controllers/ItineraryController');
const PassengerController = require('./controllers/PassengerController');
const AuthController = require('./controllers/AuthController');
const GoController = require('./controllers/GoController');
const UserController = require('./controllers/UserController');

const routes = express.Router();

// auth
routes.post('/auth', AuthController.login);

// Itinerary
routes.get('/itinerary', AuthController.verifyJWT, ItineraryController.listItinerariesDay);
routes.get('/itinerary/:id/passenger', AuthController.verifyJWT, ItineraryController.listPassengerDay);
routes.get('/itinerary/:id/location', AuthController.verifyJWT, ItineraryController.searchLocationDriver);
routes.get('/itinerary/:id/points', AuthController.verifyJWT, ItineraryController.findPointsItinerary);
routes.post('/itinerary/:id/passenger/:idPassenger/remove', AuthController.verifyJWT, ItineraryController.removePassenger);

// Passenger
routes.get('/passenger/itinerary', AuthController.verifyJWT, PassengerController.listItinerariesDay);
routes.post('/passenger/:id/notification', AuthController.verifyJWT, PassengerController.sendNotification);
routes.post('/passenger/itinerary/:id/remove', AuthController.verifyJWT, ItineraryController.removePassengerOfPassenger);


// GO
routes.post('/go/:id/start', AuthController.verifyJWT, GoController.startItinerary);
routes.post('/go/:id/finish', AuthController.verifyJWT, GoController.finishItinerary);
routes.post('/go/:idStart/location', AuthController.verifyJWT, GoController.saveLocationDriver);
routes.post('/go/:idStart/passenger/:id', AuthController.verifyJWT, GoController.saveStorePassenger);

// User
routes.post('/user/app', AuthController.verifyJWT, UserController.savePlayerId)

module.exports = routes;