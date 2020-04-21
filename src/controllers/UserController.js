const connection = require('../database/connection');

module.exports = {
  
  async savePlayerId(req, res) {
    try {
      const { userId } = req.user;
      const { playerId } = req.body;

      const user = await connection('indicador_notificacao as in')
        .select('*')
        .where('in.usuario_id', userId);
      
      const equal = await connection('indicador_notificacao as in')
        .select('*')
        .where('in.app_id', playerId);
      
      if (user.length === 1 && user[0].app_id !== playerId) {
        if (equal.length > 0) {
          await connection('indicador_notificacao as in')
            .where('in.app_id', playerId)
            .del();
        }

        await connection('indicador_notificacao')
          .update({ app_id: playerId})
          .where({ usuario_id: userId });

      } else if (user.length === 0) {
        if (equal.length > 0) {
          await connection('indicador_notificacao as in')
            .where('in.app_id', playerId)
            .del();
        }

        await connection('indicador_notificacao')
          .insert({
            app_id: playerId,
            usuario_id: userId,
          });
      }

      
      return res.sendStatus(200);
    } catch (err) {
      res.status(err.response.status)
      .json(err.response.data);
    }
  },
}