const display = document.getElementById("display");
const buttons = document.querySelectorAll("button");

let currentNumber = "";
let previousNumber = "";
let operator = null;
let resetScreen = false;
let errorState = false;

function updateDisplay(value) {
    display.value = value;
}

function clearCalculator() {
    currentNumber = "";
    previousNumber = "";
    operator = null;
    resetScreen = false;
    errorState = false;
    updateDisplay("0");
}

function calculate() {

    const prev = parseFloat(previousNumber);
    const curr = parseFloat(currentNumber);

    if (isNaN(prev) || isNaN(curr)) return;

    let result;

    switch(operator){

        case "+":
            result = prev + curr;
            break;

        case "-":
            result = prev - curr;
            break;

        case "*":
            result = prev * curr;
            break;

        case "/":

            if(curr === 0){
                updateDisplay("Cannot divide by 0");
                errorState = true;
                currentNumber = "";
                previousNumber = "";
                operator = null;
                return;
            }

            result = prev / curr;
            break;
    }

    currentNumber = result.toString();
    previousNumber = "";
    operator = null;
    updateDisplay(currentNumber);
}

buttons.forEach(button => {

    button.addEventListener("click", () => {

        const value = button.textContent;

        if(errorState){
            clearCalculator();
        }

        // Numbers
        if(!isNaN(value)){

            if(resetScreen){
                currentNumber = "";
                resetScreen = false;
            }

            currentNumber += value;
            updateDisplay(currentNumber);

            return;
        }

        // Decimal
        if(value === "."){

            if(resetScreen){
                currentNumber = "";
                resetScreen = false;
            }

            if(!currentNumber.includes(".")){
                currentNumber = currentNumber || "0";
                currentNumber += ".";
                updateDisplay(currentNumber);
            }

            return;
        }

        // Clear
        if(value === "C"){
            clearCalculator();
            return;
        }

        // Equals
        if(value === "="){

            if(operator && currentNumber !== ""){
                calculate();
                resetScreen = true;
            }

            return;
        }

        // Operators
        if(["+","-","*","/"].includes(value)){

            if(operator && currentNumber !== ""){
                calculate();
            }

            previousNumber = currentNumber;
            currentNumber = "";
            operator = value;
        }

    });

});

clearCalculator();