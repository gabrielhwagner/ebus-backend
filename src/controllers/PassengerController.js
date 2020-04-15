const connection = require('../database/connection');
const Utils = require('../utils/utils');

module.exports = {
  async listItinerariesDay(req, res) {
    const { day } = req.query;
    const { authorization } = req.headers;
    const dayFormat = Utils.converteDateInNumber(day);
    
    const itineraries = await connection('itinerario_has_passageiro as ip')
      .select('ip.itinerario_id')
      .where('ip.passageiro_id', authorization)
      .whereNotIn('ip.itinerario_id',
        connection('ausencia_passageiro as ap')
          .select('ap.itinerario_id')
          .where('ap.data', day)
          .andWhere('ap.passageiro_id', authorization)
      )
      .whereIn('ip.itinerario_id',
        connection('dia_has_itinerario as di')
          .select('di.itinerario_id')
          .where('di.dia_id', dayFormat)
      )
      .groupBy('ip.itinerario_id');

    return res.json(itineraries);
  },
}