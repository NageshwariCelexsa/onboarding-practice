const display = document.getElementById("display");
const buttons = document.querySelectorAll("button");

let currentNumber = "";
let previousNumber = "";
let operator = "";
let expression = "";
let resultDisplayed = false;
let errorState = false;

function updateDisplay(text) {
    display.value = text || "0";
}

function calculate() {

    const first = parseFloat(previousNumber);
    const second = parseFloat(currentNumber);

    switch (operator) {

        case "+":
            return first + second;

        case "−":
            return first - second;

        case "×":
            return first * second;

        case "÷":

            if (second === 0) {
                errorState = true;
                return "Cannot divide by 0";
            }

            return first / second;
    }
}

buttons.forEach(button => {

    button.addEventListener("click", () => {

        const value = button.textContent;

        if (errorState) {
            currentNumber = "";
            previousNumber = "";
            operator = "";
            expression = "";
            resultDisplayed = false;
            errorState = false;
        }

        // CLEAR

        if (value === "C") {

            currentNumber = "";
            previousNumber = "";
            operator = "";
            expression = "";
            resultDisplayed = false;

            updateDisplay("0");
            return;
        }

        // NUMBER

        if (!isNaN(value)) {

            if (resultDisplayed) {

                currentNumber = "";
                previousNumber = "";
                operator = "";
                expression = "";
                resultDisplayed = false;
            }

            currentNumber += value;

            updateDisplay(expression + currentNumber);
            return;
        }

        // DECIMAL

        if (value === ".") {

            if (resultDisplayed) {

                currentNumber = "0";
                previousNumber = "";
                operator = "";
                expression = "";
                resultDisplayed = false;
            }

            if (!currentNumber.includes(".")) {

                if (currentNumber === "") {
                    currentNumber = "0";
                }

                currentNumber += ".";
            }

            updateDisplay(expression + currentNumber);
            return;
        }

        // OPERATOR

        if (["+","−","×","÷"].includes(value)) {

            // Don't allow starting with × or ÷
            if (previousNumber === "" && currentNumber === "") {

                if (value === "+" || value === "−") {
                    return;
                }

                return;
            }

            // Continue after result
            if (resultDisplayed) {

                previousNumber = currentNumber;
                expression = currentNumber + value;
                operator = value;
                currentNumber = "";
                resultDisplayed = false;

                updateDisplay(expression);
                return;
            }

            // Replace operator if pressed twice
            if (currentNumber === "" && operator !== "") {

                operator = value;

                expression = expression.slice(0,-1) + value;

                updateDisplay(expression);

                return;
            }

            if (previousNumber !== "" && currentNumber !== "") {

                const result = calculate();

                if (errorState) {
                    updateDisplay(result);
                    return;
                }

                previousNumber = result.toString();

                expression = previousNumber + value;

                currentNumber = "";

                operator = value;

                updateDisplay(expression);

                return;
            }

            previousNumber = currentNumber;
            operator = value;
            expression = currentNumber + value;
            currentNumber = "";

            updateDisplay(expression);

            return;
        }

        // EQUALS

        if (value === "=") {

            if (previousNumber === "" || currentNumber === "") {
                return;
            }

            const fullExpression = expression + currentNumber;

            const result = calculate();

            updateDisplay(fullExpression + " = " + result);

            if (!errorState) {

                currentNumber = result.toString();
                previousNumber = "";
                operator = "";
                expression = "";
                resultDisplayed = true;

            }

            return;
        }

    });

});