const readline = require('readline');

function checkCyclicShift(S, T) {
    if (S === T) {
        return "Yes";
    }
    
    let current = S;
    for (let i = 0; i < S.length; ++i) {
        current = current[current.length - 1] + current.slice(0, -1);
        if (current === T) {
            return "Yes";
        }
    }
    return "No";
}

async function main() {
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout
    });

    const question = (query) => new Promise(resolve => rl.question(query, resolve));

    const S = await question("Введите строку S: ");
    const T = await question("Введите строку T: ");
    rl.close();

    console.log(checkCyclicShift(S, T));
}

main();