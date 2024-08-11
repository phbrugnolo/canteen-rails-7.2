document.addEventListener('DOMContentLoaded', function() {
  const searchNameInput = document.getElementById('search_name');
  const searchStatusSelect = document.getElementById('search_status');
  const productsContainer = document.getElementById('products');

  function filterProducts() {
    const searchName = searchNameInput.value.trim().toLowerCase();
    const searchStatus = searchStatusSelect.value;

    Array.from(productsContainer.querySelectorAll('.card')).forEach(card => {
      const name = card.querySelector('.card-title').textContent.trim().toLowerCase();
      const status = card.getAttribute('data-status');

      const nameMatch = name.includes(searchName);
      const statusMatch = searchStatus === '' || status === searchStatus;

      if (nameMatch && statusMatch) {
        card.style.display = '';
      } else {
        card.style.display = 'none';
      }
    });
  }

  searchNameInput.addEventListener('input', filterProducts);
  searchStatusSelect.addEventListener('change', filterProducts);

  filterProducts();
});

function showModal(modalId) {
  var modal = document.getElementById(modalId);
  modal.style.display = "block";
}

function hideModal(modalId) {
  var modal = document.getElementById(modalId);
  modal.style.display = "none";
}
