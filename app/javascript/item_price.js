const price = () => {
  const priceInput = document.getElementById("item-price");
  const taxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  if (!priceInput) return; // priceInputが存在しない場合は終了

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const tax = Math.floor(inputValue * 0.1); // 手数料を10%と仮定
    const profit = inputValue - tax;

    taxDom.innerHTML = tax;
    profitDom.innerHTML = profit;
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);
