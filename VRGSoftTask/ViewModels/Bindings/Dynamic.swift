//
//  Dynamic.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 05.02.2025.
//

import Foundation

// Класс Dynamic позволяет отслеживать изменения значения типа T
class Dynamic<T> {
    // Определяем тип Listener, который представляет собой замыкание, принимающее значение типа T и ничего не возвращающее
    typealias Listener = (T) -> Void
    // При private var listener? хранит текущий слушатель для отслеживания изменений
    private var listener: Listener?
    
    // Функция bind принимает слушателя и сохраняет его
    func bind(_ listener: Listener?) {
        self.listener = listener // Сохраняем слушателя
    }
    
    // Свойство value, которое будет отслеживаться
    var value: T {
        didSet {
            // При изменении значения value вызываем слушателя, если он установлен
            listener?(value)
        }
    }
    
    // Инициализатор, который принимает начальное значение для value
    init(_ v: T) {
        value = v // Устанавливаем начальное значение
    }
}
