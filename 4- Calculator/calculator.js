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

    switch(operator){

        case "+":
            return first + second;

        case "−":
            return first - second;

        case "×":
            return first * second;

        case "÷":

            if(second===0){
                errorState=true;
                return "Cannot divide by 0";
            }

            return first/second;
    }

}

function press(value){

    if(errorState){
        currentNumber="";
        previousNumber="";
        operator="";
        expression="";
        resultDisplayed=false;
        errorState=false;
    }

    if(value==="C"){

        currentNumber="";
        previousNumber="";
        operator="";
        expression="";
        resultDisplayed=false;

        updateDisplay("0");
        return;
    }

    if(!isNaN(value)){

        if(resultDisplayed){

            currentNumber="";
            previousNumber="";
            operator="";
            expression="";
            resultDisplayed=false;

        }

        currentNumber+=value;

        updateDisplay(expression+currentNumber);

        return;
    }

    if(value==="."){

        if(resultDisplayed){

            currentNumber="0";
            previousNumber="";
            operator="";
            expression="";
            resultDisplayed=false;

        }

        if(!currentNumber.includes(".")){

            if(currentNumber===""){
                currentNumber="0";
            }

            currentNumber+=".";

        }

        updateDisplay(expression+currentNumber);

        return;
    }

    if(["+","−","×","÷"].includes(value)){

        if(previousNumber==="" && currentNumber===""){

            if(value==="+" || value==="−"){

                previousNumber="0";
                operator=value;
                expression="0"+value;

                updateDisplay(expression);

            }

            return;
        }

        if(resultDisplayed){

            previousNumber=currentNumber;
            currentNumber="";
            operator=value;
            expression=previousNumber+value;
            resultDisplayed=false;

            updateDisplay(expression);

            return;
        }

        if(currentNumber==="" && operator!==""){

            operator=value;

            expression=expression.slice(0,-1)+value;

            updateDisplay(expression);

            return;

        }

        if(previousNumber!=="" && currentNumber!==""){

            const result=calculate();

            if(errorState){

                updateDisplay(result);

                return;

            }

            previousNumber=result.toString();
            currentNumber="";
            operator=value;
            expression=previousNumber+value;

            updateDisplay(expression);

            return;
        }

        previousNumber=currentNumber;
        currentNumber="";
        operator=value;
        expression=previousNumber+value;

        updateDisplay(expression);

        return;

    }

    if(value==="="){

        if(previousNumber==="" || currentNumber==="")
            return;

        const fullExpression=expression+currentNumber;

        const result=calculate();

        updateDisplay(fullExpression+" = "+result);

        if(!errorState){

            currentNumber=result.toString();
            previousNumber="";
            operator="";
            expression="";
            resultDisplayed=true;

        }

        return;

    }

}

buttons.forEach(button=>{

    button.addEventListener("click",()=>{

        press(button.textContent);

    });

});


document.addEventListener("keydown",(e)=>{

    if(e.key>='0' && e.key<='9'){
        press(e.key);
    }

    if(e.key==="."){
        press(".");
    }

    if(e.key==="+"){
        press("+");
    }

    if(e.key==="-" ){
        press("−");
    }

    if(e.key==="*"){
        press("×");
    }

    if(e.key==="/"){
        e.preventDefault();
        press("÷");
    }

    if(e.key==="Enter"){
        press("=");
    }

    if(e.key==="Escape"){
        press("C");
    }

    if(e.key==="Backspace"){

        if(resultDisplayed)
            return;

        if(currentNumber!==""){

            currentNumber=currentNumber.slice(0,-1);

            updateDisplay(expression+currentNumber);

        }

    }

});