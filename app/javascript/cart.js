function decrementQuantity(button) {
  const input = button.parentNode.querySelector('.quantity-input');
  if (input.value > 1) {
    input.value = parseInt(input.value) - 1;
    input.form.submit();
  }
}

function incrementQuantity(button) {
  const input = button.parentNode.querySelector('.quantity-input');
  input.value = parseInt(input.value) + 1;
  input.form.submit();
} 