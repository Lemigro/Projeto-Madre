window.addEventListener('load', function () {
    var telefoneInput = document.getElementById('telefone');

    telefoneInput.addEventListener('input', function () {
        var telefone = telefoneInput.value;

        // Remove all characters that are not digits
        telefone = telefone.replace(/\D/g, '');

        // Check if phone has 11 digits (Brazilian phone number format)
        if (telefone.length === 11) {
            telefoneInput.value = '(' + telefone.substring(0, 2) + ')' + telefone.substring(2, 7) + '-' + telefone.substring(7);
        } else {
            // If not, show the plain value without formatting
            telefoneInput.value = telefone;
        }
    });
});