
import Foundation

// MARK: - Частина 1

// Дано рядок у форматі "Student1 - Group1; Student2 - Group2; ..."

let studentsStr = "Дмитренко Олександр - ІП-84; Матвійчук Андрій - ІВ-83; Лесик Сергій - ІО-82; Ткаченко Ярослав - ІВ-83; Аверкова Анастасія - ІО-83; Соловйов Даніїл - ІО-83; Рахуба Вероніка - ІО-81; Кочерук Давид - ІВ-83; Лихацька Юлія- ІВ-82; Головенець Руслан - ІВ-83; Ющенко Андрій - ІО-82; Мінченко Володимир - ІП-83; Мартинюк Назар - ІО-82; Базова Лідія - ІВ-81; Снігурець Олег - ІВ-81; Роман Олександр - ІО-82; Дудка Максим - ІО-81; Кулініч Віталій - ІВ-81; Жуков Михайло - ІП-83; Грабко Михайло - ІВ-81; Іванов Володимир - ІО-81; Востриков Нікіта - ІО-82; Бондаренко Максим - ІВ-83; Скрипченко Володимир - ІВ-82; Кобук Назар - ІО-81; Дровнін Павло - ІВ-83; Тарасенко Юлія - ІО-82; Дрозд Світлана - ІВ-81; Фещенко Кирил - ІО-82; Крамар Віктор - ІО-83; Іванов Дмитро - ІВ-82"

// Завдання 1
// Заповніть словник, де:
// - ключ – назва групи
// - значення – відсортований масив студентів, які відносяться до відповідної групи

var studentsGroups: [String: [String]] = [:]

// Ваш код починається тут

studentsStr.split(separator: ";").map { studentStr in
    
    let studentComponents = studentStr.components(separatedBy: "- ")
    
    guard var student = studentComponents.first,
          var group = studentComponents.last else {
        return
    }
    
    student = student.trimmingCharacters(in: .whitespaces)
    group = group.trimmingCharacters(in: .whitespaces)

    let existing = studentsGroups[group] ?? []
    
    studentsGroups[group] = existing + [student]
}

studentsGroups.map { studentsGroups[$0.key] = $0.value.sorted() }

// Ваш код закінчується тут

print("Завдання 1")
print(studentsGroups)
print()

// Дано масив з максимально можливими оцінками

let points: [Int] = [12, 12, 12, 12, 12, 12, 12, 16]

// Завдання 2
// Заповніть словник, де:
// - ключ – назва групи
// - значення – словник, де:
//   - ключ – студент, який відносяться до відповідної групи
//   - значення – масив з оцінками студента (заповніть масив випадковими значеннями, використовуючи функцію `randomValue(maxValue: Int) -> Int`)

func randomValue(maxValue: Int) -> Int {
    switch(arc4random_uniform(6)) {
    case 1:
        return Int(ceil(Float(maxValue) * 0.7))
    case 2:
        return Int(ceil(Float(maxValue) * 0.9))
    case 3, 4, 5:
        return maxValue
    default:
        return 0
    }
}

var studentPoints: [String: [String: [Int]]] = [:]

// Ваш код починається тут

let maxPoints = [5, 8, 12, 12, 12, 12, 12, 12, 15]

studentsGroups.forEach { group, students in
    
    var studentsMarks = [String: [Int]]()
    
    students.forEach { student in
        var marks = [Int]()
        
        for index in 0..<9 {
            marks.append(randomValue(maxValue: maxPoints[index]))
        }
        
        studentsMarks[student] = marks
    }
    
    studentPoints[group] = studentsMarks
}


// Ваш код закінчується тут

print("Завдання 2")
print(studentPoints)
print()

// Завдання 3
// Заповніть словник, де:
// - ключ – назва групи
// - значення – словник, де:
//   - ключ – студент, який відносяться до відповідної групи
//   - значення – сума оцінок студента

var sumPoints: [String: [String: Int]] = [:]

// Ваш код починається тут

studentPoints.forEach { group, studentsPerformances in
    
    var studentsMarksSums = [String: Int]()
    
    studentsPerformances.forEach {
        studentsMarksSums[$0.key] = $0.value.reduce(0, +)
    }
    
    sumPoints[group] = studentsMarksSums
}


// Ваш код закінчується тут

print("Завдання 3")
print(sumPoints)
print()

// Завдання 4
// Заповніть словник, де:
// - ключ – назва групи
// - значення – середня оцінка всіх студентів групи

var groupAvg: [String: Float] = [:]

// Ваш код починається тут

sumPoints.forEach { group, studentsAvgs in
    let avg = Float(studentsAvgs.values.reduce(0, +)) / Float(studentsAvgs.count)
    groupAvg[group] = avg
}


// Ваш код закінчується тут

print("Завдання 4")
print(groupAvg)
print()

// Завдання 5
// Заповніть словник, де:
// - ключ – назва групи
// - значення – масив студентів, які мають >= 60 балів

var passedPerGroup: [String: [String]] = [:]

// Ваш код починається тут

sumPoints.forEach { group, studentsSums in
    passedPerGroup[group] = studentsSums.filter { $0.value >= 60 }.map { String($0.key) }
}

// Ваш код закінчується тут

print("Завдання 5")
print(passedPerGroup)

// Приклад виведення. Ваш результат буде відрізнятися від прикладу через використання функції random для заповнення масиву оцінок та через інші вхідні дані.
//
//Завдання 1
//["ІВ-73": ["Гончар Юрій", "Давиденко Костянтин", "Капінус Артем", "Науменко Павло", "Чередніченко Владислав"], "ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-71": ["Андрющенко Данило", "Гуменюк Олександр", "Корнійчук Ольга", "Музика Олександр", "Трудов Антон", "Феофанов Іван"]]
//
//Завдання 2
//["ІВ-73": ["Давиденко Костянтин": [5, 8, 9, 12, 11, 12, 0, 0, 14], "Капінус Артем": [5, 8, 12, 12, 0, 12, 12, 12, 11], "Науменко Павло": [4, 8, 0, 12, 12, 11, 12, 12, 15], "Чередніченко Владислав": [5, 8, 12, 12, 11, 12, 12, 12, 15], "Гончар Юрій": [5, 6, 0, 12, 0, 11, 12, 11, 14]], "ІВ-71": ["Корнійчук Ольга": [0, 0, 12, 9, 11, 11, 9, 12, 15], "Музика Олександр": [5, 8, 12, 0, 11, 12, 0, 9, 15], "Гуменюк Олександр": [5, 8, 12, 9, 12, 12, 11, 12, 15], "Трудов Антон": [5, 0, 0, 11, 11, 0, 12, 12, 15], "Андрющенко Данило": [5, 6, 0, 12, 12, 12, 0, 9, 15], "Феофанов Іван": [5, 8, 12, 9, 12, 9, 11, 12, 14]], "ІВ-72": ["Киба Олег": [5, 8, 12, 12, 11, 12, 0, 0, 11], "Овчарова Юстіна": [5, 8, 12, 0, 11, 12, 12, 12, 15], "Бортнік Василь": [4, 8, 12, 12, 0, 12, 9, 12, 15], "Тимко Андрій": [0, 8, 11, 0, 12, 12, 9, 12, 15]]]
//
//Завдання 3
//["ІВ-72": ["Бортнік Василь": 84, "Тимко Андрій": 79, "Овчарова Юстіна": 87, "Киба Олег": 71], "ІВ-73": ["Капінус Артем": 84, "Науменко Павло": 86, "Чередніченко Владислав": 99, "Гончар Юрій": 71, "Давиденко Костянтин": 71], "ІВ-71": ["Корнійчук Ольга": 79, "Трудов Антон": 66, "Андрющенко Данило": 71, "Гуменюк Олександр": 96, "Феофанов Іван": 92, "Музика Олександр": 72]]
//
//Завдання 4
//["ІВ-71": 79.333336, "ІВ-72": 80.25, "ІВ-73": 82.2]
//
//Завдання 5
//["ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-73": ["Давиденко Костянтин", "Капінус Артем", "Чередніченко Владислав", "Гончар Юрій", "Науменко Павло"], "ІВ-71": ["Музика Олександр", "Трудов Антон", "Гуменюк Олександр", "Феофанов Іван", "Андрющенко Данило", "Корнійчук Ольга"]]



// MARK: - Частина 2

enum Direction {
    case latitude,
         longitude
}

class CoordinateVP {
    private(set) var direction: Direction
    
    private(set) var degrees: Int
    private(set) var minutes, seconds: UInt
    
    init() {
        degrees = 0
        minutes = 0
        seconds = 0
        
        direction = .latitude
    }
    
    init?(direction: Direction, degrees: Int, minutes: UInt, seconds: UInt) {
        
        let maxDegree = direction == .latitude ? 90 : 180
        
        guard abs(degrees) <= maxDegree,
              minutes < 60,
              seconds < 60
              else {
            return nil
        }
        
        self.direction = direction
        
        self.degrees = degrees
        self.minutes = minutes
        self.seconds = seconds
    }
    
    convenience init?(direction: Direction, coordinate: Float) {
        
        self.init()
        
        let maxDegree = direction == .latitude ? Float(90) : Float(180.0)
        
        guard coordinate <= maxDegree,
              coordinate >= -maxDegree else {
            return nil
        }
        
        self.degrees = Int(floor(coordinate))
        self.minutes = UInt(60.0 * Float(coordinate - Float(degrees)))
        self.seconds = UInt(3600.0 * Float(coordinate - Float(degrees)) - 60.0 * Float(minutes))
    }
}

extension CoordinateVP {
    
    var directionLetter: String {
        if direction == .latitude {
            return degrees >= 0 ? "E" : "W"
        } else {
            return degrees >= 0 ? "N" : "S"
        }
    }
    
    func getDescriptionDegMinutes() -> String {
        "\(abs(degrees))°\(minutes)'\(seconds)\"\(directionLetter)"
    }
    
    func getDegree() -> Float {
        if degrees >= 0 {
            return Float(degrees) + Float(seconds) / 3600.0 + Float(minutes) / 60.0
        } else {
            return Float(degrees) - Float(seconds) / 3600.0 - Float(minutes) / 60.0
        }
    }
    
    func getDescriptionDeg() -> String {
        "\(directionLetter)\(abs(getDegree()))°"
    }
    
    func getMidpoint(secondCoordinate: CoordinateVP) -> CoordinateVP? {
        guard direction == secondCoordinate.direction else {
            return nil
        }
        
        let midPoint = (getDegree() + secondCoordinate.getDegree()) / 2.0
        
        return CoordinateVP(direction: direction, coordinate: midPoint)
    }
    
    static func getMidpoint(firstCoordinate: CoordinateVP, secondCoordinate: CoordinateVP) -> CoordinateVP? {
        firstCoordinate.getMidpoint(secondCoordinate: secondCoordinate)
    }
}

// Demonstration

let coordinate = CoordinateVP(direction: .latitude, degrees: 10, minutes: 23, seconds: 43)
let secondCoordinate = CoordinateVP()

if let coordinate = coordinate,
   let midCoordinate = coordinate.getMidpoint(secondCoordinate: secondCoordinate),
   let staticMidCoordinate = CoordinateVP.getMidpoint(firstCoordinate: coordinate, secondCoordinate: secondCoordinate) {

    print("\n16.a:\n\(coordinate.getDescriptionDegMinutes())")
    
    print("\n16.b:\n\(coordinate.getDescriptionDeg())")
    
    print("\n16.c:")
    print("First: \(coordinate.getDescriptionDegMinutes())")
    print("Second: \(secondCoordinate.getDescriptionDegMinutes())")
    print("Midpoint: \(midCoordinate.getDescriptionDegMinutes())")
    
    print("\n17.a:")
    print(staticMidCoordinate.getDescriptionDegMinutes())
}


