const connection = require('../database/connection');
const dayjs = require('dayjs');

const Utils = require('../utils/utils');

module.exports = {
  
  async saveAppId(req, res) {
    try {
      const { userId } = req.user;
      const { appId } = req.body;
      
      const user = await connection('indicador_notificacao as in')
        .select('*')
        .where('in.usuario_id', userId);
      
      
      console.log(user);
      if (user.length === 1 && user[0].app_id !== appId) {
        await connection('indicador_notificacao')
          .update({ app_id: appId})
          .where({ usuario_id: userId });

      } else if (user.length === 0) {
        console.log(appId, userId)
        await connection('indicador_notificacao')
          .insert({
            app_id: appId,
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