const price = () => {
const priceInput = document.getElementById("item-price");
if (!priceInput) return;
priceInput.addEventListener("input", () => {
   const inputValue = priceInput.value;
   
   
   const addTaxPrice = Math.floor(inputValue * 0.1);
   
   
   const profit = Math.floor(inputValue - addTaxPrice);
   
   
   const addTaxPriceElement = document.getElementById("add-tax-price");
   const profitElement = document.getElementById("profit");
   
   addTaxPriceElement.innerHTML = addTaxPrice;
   profitElement.innerHTML = profit;
})
};


window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);