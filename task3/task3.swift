import Foundation

guard let firstLine = readLine(), let n = Int(firstLine) else {
    fatalError("Некорректный ввод для n")
}

var numbers: [String] = []

for _ in 0..<n {
    guard let number = readLine() else {
        fatalError("Недостаточно входных данных")
    }
    for ch in number {
        assert(ch.isNumber, "Символ должен быть цифрой")
    }
    numbers.append(number)
}

var results: [String] = []

for s in numbers {
    if s.count == 1 {
        results.append("-")
        continue
    }
    var counter = 0
    for ch in s {
        if let ascii = ch.asciiValue, ascii % 2 == 0 {
            counter += 1
        }
    }
    results.append(String(counter))
}

print(results.joined(separator: " "))