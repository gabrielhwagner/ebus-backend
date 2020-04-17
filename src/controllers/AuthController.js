const connection = require('../database/connection');

module.exports = {
  async login(req, res) {
    try {
      const { email, password } = req.body;
      
      const user = await connection('usuario')
        .select('usuario.id', 'usuario.tipo')
        .where('usuario.email', email)
        .andWhere('usuario.senha', password);
  
      console.log(user);
      if(user.length > 0) {
        const table = user[0].tipo === 'PASSAGEIRO' ? 'passageiro' : 'motorista';
  
        const data = await connection(`${table} as user`)
          .select('user.id', 'user.nome',)
          .where('user.usuario_id', user[0].id)
  
        return res.json({
          ...data[0],
          tipo: user[0].tipo
        });
      }
  
      return res.status(401).send('Usuario não encontrado');
    } catch (err) {
      res.status(err.response.status)
        .json(err.response.data);
    }
  },
}