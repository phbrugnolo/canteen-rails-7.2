document.addEventListener('DOMContentLoaded', function () {
  const productsUrl = document.getElementById('products').dataset.url;

  console.log(productsUrl);

  $.ajax({
    url: productsUrl,
    dataType: 'json',
    success: function (data) {
      initializeStore(data.products);
      mapLinks(data.products);
      productSearch();
    }
  });


  $('.select2').select2({
    placeholder: "Selecione um cliente",
    allowClear: true
  });


  productSearch = () => {
    $("#input-busca").on("keyup", function () {
      var value = $(this).val().toLowerCase().trim();
      $("#tabela-produtos tr").filter(function () {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
      });

      // Atualizar o tamanho máximo da tabela
      adjustTableSize();
    });

    // Chamar a função para ajustar o tamanho da tabela inicialmente
    adjustTableSize();
  };

  adjustTableSize = () => {
    // Contar o número de linhas visíveis na tabela
    var filteredRowCount = $("#tabela-produtos tr:visible").length;

    // Ajustar o tamanho máximo da tabela
    if (filteredRowCount <= 5) {
      $("#products .table-wrapper-scroll-y").css("max-height", "none");
    } else {
      $("#products .table-wrapper-scroll-y").css("max-height", "400px");
    }
  };


  var selectedProducts = [];

  listOfProducts = (products) => {
    listOfProducts = "";
    products.map((product, index) => {


      let formattedPrice = parseFloat(product.price).toFixed(2);
      listOfProducts += `
          <tr>
            <td scope="row" class="col-2"><img src="/assets/img_product.png" width="50" height="50"/></td>
            <td class="col-6">${product.name}</td>
            <td class="col-2">${formattedPrice}</td>
            <td class="col-2 text-center"><input type="button" class="btn btn-success add" key="${index}" value="Adicionar"></td>
          </tr>
        `;

    });

    return listOfProducts;
  };

  initializeStore = (products) => {
    var containerProducts = document.getElementById('products');
    containerProducts.innerHTML = `
        <input id="input-busca" type="text" placeholder="Procurar produto.." class="mx-4">
        <div class="text-center table-wrapper-scroll-y">
          <table class="table table-bordered table-hover my-4 mx-6 my-custom-scrollbar">
            <thead class='table-size'>
              <tr>
                <th scope="col" class="col-2"></th>
                <th scope="col" class="col-6">Produto</th>
                <th scope="col" class="col-2">Preço (R$)</th>
                <th scope="col" class="col-2"></th>
              </tr>
            </thead>
            <tbody id="tabela-produtos" class='table-size'>
              ${listOfProducts(products)}
            </tbody>
          </table>
        </div>
      `;
  };

  removeProduct = (index) => {
    let product = selectedProducts[index];
    product.quantity = 0;
    selectedProducts.splice(index, 1);
    updateCart();
  };

  addItem = (index) => {
    let product = selectedProducts[index];
    product.quantity++;
    updateCart();
  };

  removeItem = (index) => {
    let product = selectedProducts[index];
    if (product.quantity <= 1) {
      removeProduct(index);
    } else {
      product.quantity--;
      updateCart();
    }
  };

  totalValue = () => {
    let totalValue = 0.0;

    selectedProducts.map((product) => {
      if (typeof product.quantity === 'number') {
        totalValue += product.quantity * product.price;
      }
    });
    console.log(totalValue);
    return totalValue;
  };

  updateTotalValue = () => {
    var cartContainer = document.getElementById('sale_total_price');
    cartContainer.value = `${totalValue().toFixed(2)}`
  };

  updateCartValue = () => {
    var cartContainer = document.getElementById('sale_cart');

    var cartData = selectedProducts.map(product => ({
      name: product.name,
      price: product.price,
      id: product.id,
      quantity: product.quantity
    }));

    cartContainer.value = JSON.stringify(cartData);

  }

  updateCart = () => {
    var cartContainer = document.getElementById('cart');
    listOfSelectedProducts = "";

    selectedProducts.map((product, index) => {
      let formattedPrice = parseFloat(product.price).toFixed(2);
      let subTotal = parseFloat(product.price * product.quantity).toFixed(2);
      if (product !== undefined) {
        listOfSelectedProducts += `
            <tr class="row">
              <td class="col-4"> ${product.name}</td>
              <td class="col-2"> ${product.quantity}</td>
              <td class="col-2"> R$ ${formattedPrice}</td>
              <td class="col-2"> R$ ${subTotal}</td>
              <td class="col-2 m-auto text-center">
                <button type="button" class="btn btn-primary" onclick="addItem(${index})">
                  <i class="bi bi-plus-circle"></i>
                </button>
                <button type="button" class="btn btn-primary" onclick="removeItem(${index})">
                  <i class="bi bi-dash-circle"></i>
                </button>
                <button type="button" class="btn btn-danger" onclick="removeProduct(${index})">
                  <i class="bi bi-trash3"></i>
                </button>
              </td>
            </tr>
          `;
      }
    });

    cartContainer.innerHTML = `
        <table class="table table-bordered table-hover table-sm my-4 m-auto">
          <thead>
            <tr class="row">
              <th class="col-4 text-center">Produto</th>
              <th class="col-2 text-center">Quantidade</th>
              <th class="col-2 text-center">Preço por unidade</th>
              <th class="col-2 text-center">Subtotal</th>
            </tr>
          </thead>
          <tbody>
            ${listOfSelectedProducts}
          </tbody>
        </table>
      `;

    updateTotalValue();
    updateCartValue();
  };

  mapLinks = (products) => {
    var links = document.getElementsByClassName('add');

    for (var i = 0; i < links.length; i++) {
      links[i].addEventListener("click", function () {
        let key = this.getAttribute("key");

        product = products[key];

        if (!product.quantity) {
          product.quantity = 1;
        } else {
          product.quantity++;
        }

        if (!selectedProducts.includes(product)) {
          selectedProducts.push(product);
        }

        updateCart();
      });
    }
  };
});
