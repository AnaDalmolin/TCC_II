class BaseBloc {
  formatValor(valor) {
    String valorFormatadoLetras = valor.replaceAll(RegExp('[^0-9,]'), '');
    String valorFormatado =
        valorFormatadoLetras.replaceAll(RegExp('[^A-Za-z0-9]'), '.');

    double valorDouble = double.parse(valorFormatado);
    return valorDouble;
  }

  // @override
  // void dispose() {}
}
