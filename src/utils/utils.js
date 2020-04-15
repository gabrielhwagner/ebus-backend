module.exports = {
  converteDateInNumber(day) {
    return new Date(day + ' 00:00:00').getDay();
  },
  
  converterDateInString(day) {
    const numberDay = new Date(day + ' 00:00:00').getDay();
    return this.converterNumberWithDay(numberDay);
  },

  converterNumberWithDay(number) {
    switch (number) {
      case 0:
        return 'DOM';
      case 1:
        return 'SEG';
      case 2:
        return 'TER';
      case 3:
        return 'QUA';
      case 4:
        return 'QUI';
      case 5:
        return 'SEX';
      case 6:
        return 'SAB';
    }
  }
}