const price = () => {
  const priceInput = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  const updateValues = () => {
    const inputValue = priceInput.value;
    const price = parseInt(inputValue) || 0;
    const fee = Math.floor(price * 0.1);
    const profitValue = price - fee;

    addTaxPrice.innerHTML = `¥${fee.toLocaleString()}`;
    profit.innerHTML = `¥${profitValue.toLocaleString()}`; 
  };

  priceInput.addEventListener("input", updateValues)
  updateValues(); 
};

  window.addEventListener("turbo:load", price);
  window.addEventListener("turbo:render", price);
