const dayjs = require('dayjs');

const connection = require('../database/connection');
const Utils = require('../utils/utils');
const OneSignalService = require('../services/OneSignalService');

module.exports = {
  async listItinerariesDay(req, res) {
    try {
      const { day } = req.query;
      const { id } = req.user;
      const dayFormat = Utils.converteDateInNumber(day);
      
      const itineraries = await connection('itinerario_has_passageiro as ip')
        .select('ip.itinerario_id', 'it.turno', 'it.descricao', 'it.horarioInicio')
        .innerJoin('itinerario as it', 'it.id', 'ip.itinerario_id')
        .where('ip.passageiro_id', id)
        .whereNotIn('ip.itinerario_id',
          connection('ausencia_passageiro as ap')
            .select('ap.itinerario_id')
            .where('ap.data', day)
            .andWhere('ap.passageiro_id', id)
        )
        .whereIn('ip.itinerario_id',
          connection('dia_has_itinerario as di')
            .select('di.itinerario_id')
            .where('di.dia_id', dayFormat)
        )
        .groupBy('ip.itinerario_id');
  
      const data = itineraries.map(async (it) => {
        const active = await connection('itinerario_iniciado as ii')
          .select('ii.status')
          .innerJoin('itinerario as it', 'ii.itinerario_id', 'it.id')
          .where('ii.itinerario_id', it.itinerario_id)
          .andWhere('ii.dia_id', dayFormat)
          .andWhereBetween(
            'ii.data',
            [`${day} 00:00:00`, `${day} 23:59:00`]
          )
          .orderBy('ii.id', 'desc')
          .limit(1);
  
        return {
          id: it.itinerario_id,
          turno: it.turno,
          descricao: it.descricao,
          horarioInicio: it.horarioInicio,
          status: active.length > 0 ? active[0].status : 'NAO_INICIADO',  
        }
      });
        
      const retorno = await Promise.all(data);
  
      return res.json(retorno);
    } catch (err) {
      res.status(err.response.status)
        .json(err.response.data);
    }
  },

  async sendNotification(req, res) {
    try {
      const { id } = req.params;
      const { title, description } = req.body;

      const dateTime = dayjs().format('YYYY-MM-DD HH:mm:ss');
      
      const userId = await connection('passageiro as pa')
        .select('pa.usuario_id')
        .where('pa.id', id);
      
     
      await connection('notificacao')
        .insert({
          titulo: title,
          descricao: description,
          usuario_id: userId[0].usuario_id,
          data: dateTime,
          status: 'NOVO',
        });
      
      const playerId = await connection('indicador_notificacao as in')
        .select('in.app_id')
        .where('in.usuario_id', userId[0].usuario_id);

      if(playerId.length === 1) {
        await OneSignalService.pushUser(playerId[0].app_id, title, description);
      }

      return res.sendStatus(201);
    } catch (err) {
      res.status(err.response.status)
        .json(err.response.data);
    }
  },
}