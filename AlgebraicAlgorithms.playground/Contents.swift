import Foundation

// MARK: - УРОВЕНЬ JUNIOR -

// 1. Итеративный алгоритм возведения числа в степень (O(N))
func iterativePower(base: Double, exponent: Int) -> Double {
    var result = 1.0
    for _ in 0..<exponent {
        result *= base
    }
    return result
}

print(iterativePower(base: 2, exponent: 10))  // Ожидается: 1024.0


// 2.1. Рекурсивный алгоритм поиска чисел Фибоначчи (O(2^N))
func recursiveFibonacci(n: Int) -> Int {
    if n <= 1 {
        return n
    }
    return recursiveFibonacci(n: n - 1) + recursiveFibonacci(n: n - 2)
}

print(recursiveFibonacci(n: 10))  // Ожидается: 55


// 2.2. Итеративный алгоритм поиска чисел Фибоначчи (O(N))
func iterativeFibonacci(n: Int) -> Int {
    if n <= 1 {
        return n
    }
    var a = 0
    var b = 1
    for _ in 2...n {
        let temp = a + b
        a = b
        b = temp
    }
    return b
}

print(iterativeFibonacci(n: 10))  // Ожидается: 55


// 3. Алгоритм поиска количества простых чисел через перебор делителей (O(N^2))
func countPrimes(upTo n: Int) -> Int {
    var primeCount = 0
    for number in 2...n {
        var isPrime = true
        for divisor in 2..<number {
            if number % divisor == 0 {
                isPrime = false
                break
            }
        }
        if isPrime {
            primeCount += 1
        }
    }
    return primeCount
}

print(countPrimes(upTo: 10))  // Ожидается: 4 (простые: 2, 3, 5, 7)


// MARK: - УРОВЕНЬ MIDDLE -

// 11. Возведение в степень через домножение (O(N/2 + LogN))
func powerWithMultiplication(base: Double, exponent: Int) -> Double {
    if exponent == 0 { return 1.0 }
    var result = 1.0
    var currentExponent = exponent
    var currentBase = base
    
    while currentExponent > 0 {
        if currentExponent % 2 == 1 {
            result *= currentBase
        }
        currentBase *= currentBase
        currentExponent /= 2
    }
    
    return result
}

print(powerWithMultiplication(base: 2, exponent: 10))  // Ожидается: 1024.0


// 12. Возведение в степень через двоичное разложение (O(LogN))
func powerBinaryExponentiation(base: Double, exponent: Int) -> Double {
    var result = 1.0
    var currentExponent = exponent
    var currentBase = base
    
    while currentExponent > 0 {
        if currentExponent % 2 == 1 {
            result *= currentBase
        }
        currentBase *= currentBase
        currentExponent /= 2
    }
    
    return result
}

print(powerBinaryExponentiation(base: 2.0, exponent: 10))  // Ожидается: 1024.0


// 13. Алгоритм чисел Фибоначчи по формуле золотого сечения
func fibonacciGoldenRatio(n: Int) -> Int {
    let phi = (1 + sqrt(5.0)) / 2
    let fibonacci = (pow(phi, Double(n)) - pow(1 - phi, Double(n))) / sqrt(5.0)
    return Int(round(fibonacci))
}

print(fibonacciGoldenRatio(n: 10))  // Ожидается: 55


// 14. Класс для умножения матриц и алгоритм возведения матрицы в степень
class Matrix {
    var values: [[Int]]
    
    init(_ values: [[Int]]) {
        self.values = values
    }
    
    func multiply(with matrix: Matrix) -> Matrix {
        let size = values.count
        var result = Array(repeating: Array(repeating: 0, count: size), count: size)
        
        for i in 0..<size {
            for j in 0..<size {
                for k in 0..<size {
                    result[i][j] += values[i][k] * matrix.values[k][j]
                }
            }
        }
        
        return Matrix(result)
    }
    
    func power(exponent: Int) -> Matrix {
        var result = Matrix([[1, 0], [0, 1]])  // Единичная матрица
        var base = self
        var currentExponent = exponent
        
        while currentExponent > 0 {
            if currentExponent % 2 == 1 {
                result = result.multiply(with: base)
            }
            base = base.multiply(with: base)
            currentExponent /= 2
        }
        
        return result
    }
}

// Использование для поиска чисел Фибоначчи O(LogN)
func fibonacciMatrix(n: Int) -> Int {
    if n == 0 { return 0 }
    
    let baseMatrix = Matrix([[1, 1], [1, 0]])
    let resultMatrix = baseMatrix.power(exponent: n - 1)
    return resultMatrix.values[0][0]
}

print(fibonacciMatrix(n: 10))  // Ожидается: 55

// 15. Алгоритм поиска простых чисел с оптимизацией (O(N * Sqrt(N) / Ln(N)))
func countPrimesOptimized(upTo n: Int) -> Int {
    if n < 2 { return 0 }
    var primes = [2]
    
    for number in 3...n where number % 2 != 0 {
        var isPrime = true
        for prime in primes where prime * prime <= number {
            if number % prime == 0 {
                isPrime = false
                break
            }
        }
        if isPrime {
            primes.append(number)
        }
    }
    
    return primes.count
}

print(countPrimesOptimized(upTo: 100))  // Ожидается: 25

// 16. Решето Эратосфена (O(N Log Log N))
func sieveOfEratosthenes(n: Int) -> [Int] {
    var isPrime = Array(repeating: true, count: n + 1)
    isPrime[0] = false
    isPrime[1] = false
    
    for i in 2...Int(sqrt(Double(n))) {
        if isPrime[i] {
            for multiple in stride(from: i * i, through: n, by: i) {
                isPrime[multiple] = false
            }
        }
    }
    
    return (2...n).filter { isPrime[$0] }
}

print(sieveOfEratosthenes(n: 100))  // Ожидается: [2, 3, 5, 7, 11, ..., 97]

// 17. Решето Эратосфена с оптимизацией памяти, используя битовую матрицу,
// сохраняя по 32 значения в одном int, хранить биты только для нечётных чисел
func sieveEratosthenesWithBitMatrix(n: Int) -> [Int] {
    guard n >= 2 else { return [] }
    
    let size = (n / 2 + 31) / 32 // Количество элементов для хранения битов
    var bitArray = [UInt32](repeating: UInt32.max, count: size) // Все биты установлены в 1
    
    let limit = Int(sqrt(Double(n)))
    
    // Начинаем с 3, так как 2 - уже известное простое число
    var number = 3
    while number * number <= n {
        if (bitArray[(number - 1) / 2 / 32] & (1 << ((number - 1) / 2 % 32))) != 0 {
            var multiple = number * number
            while multiple <= n {
                bitArray[(multiple - 1) / 2 / 32] &= ~(1 << ((multiple - 1) / 2 % 32))
                multiple += 2 * number
            }
        }
        number += 2
    }
    
    var primes = [2] // Добавляем 2 как единственное чётное простое число
    for i in stride(from: 3, through: n, by: 2) {
        if (bitArray[(i - 1) / 2 / 32] & (1 << ((i - 1) / 2 % 32))) != 0 {
            primes.append(i)
        }
    }
    
    return primes
}

print(sieveEratosthenesWithBitMatrix(n: 100))  // Ожидается: [2, 3, 5, 7, 11, ..., 97]

// 18. Решето Эратосфена со сложностью O(N)
func sieveEratosthenesO(N: Int) -> [Int] {
    guard N >= 2 else { return [] }
    
    var sieve = Array(repeating: true, count: N + 1)
    sieve[0] = false
    sieve[1] = false
    
    for i in 2...Int(sqrt(Double(N))) {
        if sieve[i] {
            for j in stride(from: i * i, through: N, by: i) {
                sieve[j] = false
            }
        }
    }
    
    return sieve.enumerated().compactMap { $1 ? $0 : nil }
}

print(sieveEratosthenesO(N: 100))  // Ожидается: [2, 3, 5, 7, 11, ..., 97]


// MARK: - УРОВЕНЬ SENIOR -

// Загрузка содержимого файла
func loadFile(named fileName: String) -> String? {
    guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "") else {
        print("Файл \(fileName) не найден.")
        return nil
    }
    
    do {
        return try String(contentsOf: fileUrl, encoding: .utf8)
    } catch {
        print("Ошибка при чтении файла \(fileName): \(error)")
        return nil
    }
}

func runPowerTests(
    prefix: String,
    algorithm: (Double, Int) -> Double,
    algorithmName: String,
    totalTests: Int = 10
) {
    print("\nАлгоритм: \(algorithmName)")
    
    for testIndex in 0..<totalTests {
        let inputFileName = "\(prefix)_test.\(testIndex).in"
        let outputFileName = "\(prefix)_test.\(testIndex).out"
        
        guard
            let input = loadFile(named: inputFileName),
            let expectedOutput = loadFile(named: outputFileName)?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            print("Ошибка загрузки файлов для теста \(testIndex)")
            continue
        }
        
        let inputComponents = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "\r", with: "")
            .split(separator: "\n")
        
        if let base = Double(inputComponents[0]),
           let exponent = Int(inputComponents[1]) {
            let result = algorithm(base, exponent)
            if let expectedDouble = Double(expectedOutput) {
                if abs(result - expectedDouble) < 0.0000001 {
                    print("Тест \(testIndex) OK: \(result)")
                } else {
                    print("Тест \(testIndex) ошибка: \(result), ожидалось: \(expectedDouble)")
                }
            } else {
                print("Ошибка в формате выходных данных для теста \(testIndex)")
            }
        } else {
            print("Ошибка в формате входных данных для теста \(testIndex)")
        }
    }
}


runPowerTests(
    prefix: "3.Power",
    algorithm: iterativePower,
    algorithmName: "1. Итеративный алгоритм возведения числа в степень (O(N))",
    totalTests: 5
)

runPowerTests(
    prefix: "3.Power",
    algorithm: powerWithMultiplication,
    algorithmName: "11. Возведение в степень через домножение (O(N/2 + LogN))"
)

runPowerTests(
    prefix: "3.Power",
    algorithm: powerBinaryExponentiation,
    algorithmName: "12. Возведение в степень через двоичное разложение (O(LogN))"
)

func runFiboTests(
    prefix: String,
    algorithm: (Int) -> Int,
    algorithmName: String,
    totalTests: Int = 6
) {
    print("\nАлгоритм: \(algorithmName)")
    
    for testIndex in 0..<totalTests {
        let inputFileName = "\(prefix)_test.\(testIndex).in"
        let outputFileName = "\(prefix)_test.\(testIndex).out"
        
        guard
            let input = loadFile(named: inputFileName),
            let expectedOutput = loadFile(named: outputFileName)?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            print("Ошибка загрузки файлов для теста \(testIndex)")
            continue
        }
        
        // Ожидаем, что входное значение будет индексом числа Фибоначчи
        if let index = Int(input.trimmingCharacters(in: .whitespacesAndNewlines)) {
            let result = algorithm(index)
            
            if let expectedInt = Int(expectedOutput) {
                if result == expectedInt {
                    print("Тест \(testIndex) OK: \(result)")
                } else {
                    print("Тест \(testIndex) ошибка: \(result), ожидалось: \(expectedInt)")
                }
            } else {
                print("Ошибка в формате выходных данных для теста \(testIndex)")
            }
        } else {
            print("Ошибка в формате входных данных для теста \(testIndex)")
        }
    }
}

runFiboTests(
    prefix: "4.Fibo",
    algorithm: recursiveFibonacci,
    algorithmName: "Алгоритм: 2.1. Рекурсивный алгоритм поиска чисел Фибоначчи (O(2^N))"
)

runFiboTests(
    prefix: "4.Fibo",
    algorithm: iterativeFibonacci,
    algorithmName: "Алгоритм: 2.2. Итеративный алгоритм поиска чисел Фибоначчи (O(N))"
)

runFiboTests(
    prefix: "4.Fibo",
    algorithm: fibonacciGoldenRatio,
    algorithmName: "Алгоритм: 13. Алгоритм чисел Фибоначчи по формуле золотого сечения"
)

runFiboTests(
    prefix: "4.Fibo",
    algorithm: fibonacciMatrix,
    algorithmName: "Алгоритм: 14. Класс для умножения матриц и алгоритм возведения матрицы в степень"
)
