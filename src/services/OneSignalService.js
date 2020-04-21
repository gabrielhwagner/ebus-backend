const api = require('./api');

class OneSignalService {

  async pushUser(playerId, title, description) {
    console.log('psuh');
    const url = 'https://onesignal.com/api/v1/notifications';

    const body = {
      app_id: process.env.APP_ID,
      contents: {
        en: description
      },
      headings: {
        en: title
      },
      include_player_ids: [playerId]
    };
    

    return api.post(url, body);
  }
}

module.exports = new OneSignalService();