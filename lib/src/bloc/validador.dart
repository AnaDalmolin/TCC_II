class Validador {
  validaField(controller, item) {
    if (item == 'email') {
      if (controller.text == null) {
        return 'Email Invalido!';
      }
    }
  }
}
