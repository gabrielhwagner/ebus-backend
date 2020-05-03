const connection = require('../database/connection');
const Utils = require('../utils/utils');

module.exports = {
  async listItinerariesDay(req, res) {
    try {
      const { day } = req.query;
      const dayFormat = Utils.converteDateInNumber(day);

      const itineraries = await connection('itinerario')
        .select('itinerario.*', 'dia.dia')
        .innerJoin('dia_has_itinerario as di', 'di.itinerario_id', 'itinerario.id')
        .innerJoin('dia', 'dia.id', 'di.dia_id')
        .where('dia.id', dayFormat);

      const data = itineraries.map(async (iti) => {
        const passengers = await connection('itinerario_has_passageiro as ip')
          .select('ip.passageiro_id')
          .where('ip.itinerario_id', iti.id)
          .whereNotIn('ip.passageiro_id',
            connection('ausencia_passageiro ')
              .select('ausencia_passageiro.passageiro_id')
              .where('ausencia_passageiro.data', day)
              .andWhere('ausencia_passageiro.itinerario_id', iti.id)
          )
          .groupBy('ip.passageiro_id');

        const active = await connection('itinerario_iniciado as ii')
          .select('ii.status')
          .innerJoin('itinerario as it', 'ii.itinerario_id', 'it.id')
          .where('ii.itinerario_id', iti.id)
          .andWhere('ii.dia_id', dayFormat)
          .andWhereBetween(
            'ii.data',
            [`${day} 00:00:00`, `${day} 23:59:00`]
          )
          .orderBy('ii.id', 'desc')
          .limit(1);
        
        delete iti.instituicao_id;
        delete iti.dia;

        return {
          ...iti,
          status: active.length > 0 ? active[0].status : 'NAO_INICIADO',
          numeroPassageiros: passengers.length
        }
      });
      
      const retorno = await Promise.all(data);
      return res.json(retorno);
    } catch (err) {
      res.status(err.response.status)
        .json(err.response.data);
    }
  },

  async listPassengerDay(req, res) {
    try {
      const { id } = req.params;
      const { day } = req.query;
      
      const passengers = await connection('itinerario_has_passageiro as ip')
        .select('pa.id', 'pa.nome', 'pa.endereco_id')
        .innerJoin('passageiro as pa', 'pa.id', 'ip.passageiro_id')
        .where('ip.itinerario_id', id)
        .whereNotIn('ip.passageiro_id',
          connection('ausencia_passageiro')
            .select('ausencia_passageiro.passageiro_id')
            .where('ausencia_passageiro.data', day)
            .andWhere('ausencia_passageiro.itinerario_id', id)
        )
        .groupBy('ip.passageiro_id');

      const data = passengers.map(async (passenger) => {
        const address = await connection('passageiro')
          .select('en.*')
          .innerJoin('endereco as en', 'en.id', 'passageiro.endereco_id')
          .where('passageiro.id', passenger.id);
  
        delete address[0].id;
        delete passenger.endereco_id;
  
        return {
          ...passenger,
          endereco: address[0]
        }
      });
      
      const retorno = await Promise.all(data);
      return res.json(retorno);

    } catch (err) {
      res.status(err.response.status)
        .json(err.response.data);
    }
  },

  async searchLocationDriver(req, res) {
    try {
      const { day } = req.query;
      const { id } = req.params;
      const dayFormat = Utils.converteDateInNumber(day);

      const itineraryStart = await connection('itinerario_iniciado as ii')
        .select('ii.id')
        .where('ii.itinerario_id', id)
        .andWhere('ii.dia_id', dayFormat)
        .andWhereBetween(
          'ii.data',
          [`${day} 00:00:00`, `${day} 23:59:00`]
        )
        .orderBy('ii.id', 'desc')
        .limit(1);

      const data = await connection('localizacao_motorista as lm')
        .select('lm.latitude', 'lm.longitude')
        .where('lm.itinerario_iniciado_id', itineraryStart[0].id)
        .orderBy('lm.id', 'desc')
        .limit(1);
        
      return res.json(data[0]);
    } catch (err) {
      res.status(err.response.status)
        .json(err.response.data);
    }
  },

  async findPointsItinerary(req, res) {
    try {
      const { day } = req.query;
      const { id } = req.params;

      const passengers = await connection('itinerario_has_passageiro as ip')
        .select('pa.id', 'pa.nome', 'pa.endereco_id', 'it.instituicao_id')
        .innerJoin('passageiro as pa', 'pa.id', 'ip.passageiro_id')
        .innerJoin('itinerario as it', 'it.id', 'ip.itinerario_id')
        .where('ip.itinerario_id', id)
        .whereNotIn('ip.passageiro_id',
          connection('ausencia_passageiro')
            .select('ausencia_passageiro.passageiro_id')
            .where('ausencia_passageiro.data', day)
            .andWhere('ausencia_passageiro.itinerario_id', id)
        )
        .groupBy('ip.passageiro_id');
      
      const institution = await connection('instituicao as in')
        .select('*')
        .where('in.id', passengers[0].instituicao_id);

      passengers.push(institution[0]);

      const data = passengers.map(async (passenger, index) => {
        const address = await connection('endereco as en')
          .select('*')
          .where('en.id', passenger.endereco_id);
  
        delete address[0].id;
        delete passenger.endereco_id;
        delete passenger.instituicao_id;

        const tipo = index === passengers.length - 1 ? 'INSTITUICAO' : 'PASSAGEIRO';

        return {
          ...passenger,
          tipo,
          endereco: address[0]
        }
      });


      
      const retorno = await Promise.all(data);
      return res.json(retorno);

    } catch (err) {
      res.status(err.response.status)
        .json(err.response.data);
    }
  },

  async removePassenger(req, res) {
    try {
      const { id, idPassenger } = req.params;
      const { data, author } = req.body;
      
      await connection('ausencia_passageiro')
        .insert({
          autor: author,
          data: data,
          itinerario_id: id,
          passageiro_id: idPassenger
        });

      return res.sendStatus(201);

    } catch (err) {
      res.status(err.response.status)
        .json(err.response.data);
    }
  },

  async removePassengerOfPassenger(req, res) {
    try {
      const { id } = req.params;
      const { data, author } = req.body;
      
      await connection('ausencia_passageiro')
        .insert({
          autor: author,
          data: data,
          itinerario_id: id,
          passageiro_id: req.user.id
        });

      return res.sendStatus(201);

    } catch (err) {
      res.status(err.response.status)
        .json(err.response.data);
    }
  }
}