const jwt = require('jsonwebtoken');
const connection = require('../database/connection');

module.exports = {

  verifyJWT(req, res, next){
    const token = req.headers['authorization'];

    if (!token) return res.status(401).send({ auth: false, message: 'No token provided.' });
    
    jwt.verify(token, process.env.SECRET, (err, decoded) => {
      if (err) return res.status(500).send({ auth: false, message: 'Failed to authenticate token.' });

      const user = {
        userId: decoded.userId,
        id: decoded.id,
        tipo: decoded.tipo,
      };

      req.user = user;

      next();
    });
  },

  async login(req, res) {
    try {
      const { email, password } = req.body;
      
      const user = await connection('usuario')
        .select('usuario.id', 'usuario.tipo')
        .where('usuario.email', email)
        .andWhere('usuario.senha', password);
  
      if(user.length === 0) return res.status(401).send('Usuario não encontrado');

      const table = user[0].tipo === 'PASSAGEIRO' ? 'passageiro' : 'motorista';

      const data = await connection(`${table} as user`)
        .select('user.id', 'user.nome',)
        .where('user.usuario_id', user[0].id)

      const token = jwt.sign(
        {
          userId:user[0].id,
          ...data[0],
          tipo: user[0].tipo
        },
        process.env.SECRET,
        {
          expiresIn: '30d'
        }
      );

      return res.json({token});
  
    } catch (err) {
      res.status(err.response.status)
        .json(err.response.data);
    }
  },
}