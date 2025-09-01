const price = () => {
const priceInput = document.getElementById("item-price");
priceInput.addEventListener("input", () => {
   const inputValue = priceInput.value;
   
   // 販売手数料の計算（10%）をMath.floorで切り捨て
   const addTaxPrice = Math.floor(inputValue * 0.1);
   
   // 利益の計算（価格 - 販売手数料）をMath.floorで切り捨て
   const profit = Math.floor(inputValue - addTaxPrice);
   
   // innerHTMLを使用して結果を表示
   const addTaxPriceElement = document.getElementById("add-tax-price");
   const profitElement = document.getElementById("profit");
   
   addTaxPriceElement.innerHTML = addTaxPrice;
   profitElement.innerHTML = profit;
})
};


window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);