const connection = require('../database/connection');
const dayjs = require('dayjs');

const Utils = require('../utils/utils');

module.exports = {
  
  async startItinerary(req, res) {
    try {
      const { id } = req.params;
      const { data } = req.body;
      
      const dateTime = dayjs().format('YYYY-MM-DD HH:mm:ss');
      const dayFormat = Utils.converteDateInNumber(data);
      
      await connection('itinerario_iniciado')
      .insert({
        status: 'ATIVO',
        data: dateTime,
        itinerario_id: id,
        dia_id: dayFormat
      })
      
      return res.sendStatus(200);
    } catch (err) {
      res.status(err.response.status)
      .json(err.response.data);
    }
  },

  async saveLocationDriver(req, res) {
    try {
      const { idStart } = req.params;
      const { latitude, longitude } = req.body;
      const data = dayjs().format('YYYY-MM-DD HH:mm:ss');

      await connection('localizacao_motorista')
        .insert({
          latitude,
          longitude,
          data,
          itinerario_iniciado_id: idStart
        })

      return res.sendStatus(201);
    } catch (err) {
      res.status(err.response.status)
        .json(err.response.data);
    }
  },

  async saveStorePassenger(req, res) {
    try {
      const { idStart, id } = req.params;
      const { status } = req.body;

      const dateTime = dayjs().format('YYYY-MM-DD HH:mm:ss');

      await connection('historico_passageiro')
        .insert({
          status,
          data: dateTime,
          passageiro_id: id,
          itinerario_iniciado_id: idStart,
        })

      return res.sendStatus(201);
    } catch (err) {
      res.status(err.response.status)
        .json(err.response.data);
    }
  },
  
  async finishItinerary(req, res) {
    try {
      const { id } = req.params;
      const { data } = req.body;

      const dateTime = dayjs().format('YYYY-MM-DD HH:mm:ss');
      const dayFormat = Utils.converteDateInNumber(data);

      await connection('itinerario_iniciado')
        .insert({
          status: 'CONCLUIDO',
          data: dateTime,
          itinerario_id: id,
          dia_id: dayFormat
        })

      return res.sendStatus(200);
    } catch (err) {
      res.status(err.response.status)
        .json(err.response.data);
    }
  },
}