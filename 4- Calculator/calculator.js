const display = document.getElementById("display");
const buttons = document.querySelectorAll("button");

let currentNumber = "";
let previousNumber = "";
let operator = "";
let errorState = false;

function updateDisplay(value) {
    display.value = value;
}

function calculate() {

    let first = parseFloat(previousNumber);
    let second = parseFloat(currentNumber);

    switch(operator){

        case "+":
            return first + second;

        case "−":
            return first - second;

        case "×":
            return first * second;

        case "÷":

            if(second === 0){
                errorState = true;
                return "Cannot divide by 0";
            }

            return first / second;
    }

}

buttons.forEach(button => {

    button.addEventListener("click", function(){

        const value = button.textContent;

        if(errorState){
            currentNumber = "";
            previousNumber = "";
            operator = "";
            errorState = false;
        }

        // Clear

        if(value === "C"){
            currentNumber = "";
            previousNumber = "";
            operator = "";
            updateDisplay("0");
            return;
        }

        // Numbers

        if(!isNaN(value)){

            currentNumber += value;
            updateDisplay(currentNumber);
            return;
        }

        // Decimal

        if(value === "."){

            if(!currentNumber.includes(".")){
                if(currentNumber === ""){
                    currentNumber = "0";
                }

                currentNumber += ".";
            }

            updateDisplay(currentNumber);
            return;
        }

        // Operators

        if(["+","−","×","÷"].includes(value)){

            if(previousNumber !== "" && currentNumber !== ""){

                const result = calculate();

                if(errorState){
                    updateDisplay(result);
                    return;
                }

                previousNumber = result.toString();
                updateDisplay(previousNumber);

            }else{

                previousNumber = currentNumber;

            }

            currentNumber = "";
            operator = value;
            return;
        }

        // Equals

        if(value === "="){

            if(previousNumber === "" || currentNumber === ""){
                return;
            }

            const result = calculate();

            updateDisplay(result);

            if(!errorState){
                currentNumber = result.toString();
                previousNumber = "";
                operator = "";
            }

        }

    });

});