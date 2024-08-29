const price = () => {

  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  if (!priceInput){ return false;}
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
  addTaxDom.innerHTML = Math.floor(inputValue * 0.1);
  profit.innerHTML = Math.floor(inputValue - inputValue * 0.1);
  console.log("InputValue");
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);