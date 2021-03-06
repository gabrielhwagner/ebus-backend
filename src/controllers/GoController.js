const connection = require('../database/connection');
const dayjs = require('dayjs');

const Utils = require('../utils/utils');

module.exports = {
  
  async startItinerary(req, res) {
    try {
      const { id } = req.params;
      const { data } = req.body;
      
      const date = dayjs(data).format('YYYY-MM-DD');
      const dayFormat = Utils.converteDateInNumber(date);
      
      const startItinerary = await connection('itinerario_iniciado')
        .insert({
          status: 'ATIVO',
          data: data,
          itinerario_id: id,
          dia_id: dayFormat
        })
      return res.json({startItinerary: startItinerary[0]});
    } catch (err) {
      res.status(err.response.status)
      .json(err.response.data);
    }
  },

  async saveLocationDriver(req, res) {
    try {
      const { idStart } = req.params;
      const { latitude, longitude, data } = req.body;

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
      const { status, data } = req.body;

      await connection('historico_passageiro')
        .insert({
          status,
          data,
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

      const date = dayjs(data).format('YYYY-MM-DD');
      const dayFormat = Utils.converteDateInNumber(date);

      await connection('itinerario_iniciado')
        .insert({
          status: 'CONCLUIDO',
          data,
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