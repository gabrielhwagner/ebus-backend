const connection = require('../database/connection');
const dayjs = require('dayjs');

const Utils = require('../utils/utils');

module.exports = {
  async saveLocationDriver(req, res) {
    try {
      const { id } = req.params;
      const { latitude, longitude } = req.body;
      const data = dayjs().format('YYYY-MM-DD HH:mm:ss');

      await connection('localizacao_motorista')
        .insert({
          latitude,
          longitude,
          data,
          itinerario_iniciado_id: id
        })

      return res.sendStatus(200);
    } catch (err) {
      res.status(err.response.status)
        .json(err.response.data);
    }
  },

  async startItinerary(req, res) {
    try {
      const { id } = req.params;
      const { data } = req.body;

      // TODO - data
      // const dateTime = dayjs().format('YYYY-MM-DD HH:mm:ss');
      const dateTime = '2020-04-14 13:00:00';
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
}