//
//  MostEmailedViewModel.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 05.02.2025.
//

import Foundation

// Класс MostEmailedViewModel отвечает за управление данными о самых отправляемых статьях
class MostEmailedViewModel {
    // Свойство mostEmailed, хранящее динамический массив статей
    var mostEmailed = Dynamic<Array<ArticleStruct>>([]) // Изначально массив статей пуст

    // Метод getMostEmailedArticles запрашивает данные о самых отправляемых статьях
    func getMostEmailedArticles () {
        // Выполняем сетевой запрос через RequestFactory
        // Адрес для запроса - это 'mostEmailed', и период - 'month'
        RequestFactory.request(address: .mostEmailed, period: .month) { (response: Result<ArticleResultStruct, Error>) in
            // Обрабатываем ответ на запрос
            switch response {
            case .success(let success):
                // Если запрос успешен, обновляем значение mostEmailed с полученными результатами
                self.mostEmailed.value = success.results
            case .failure(let error):
                // Если произошла ошибка, выводим ее в консоль
                print(error)
            }
        }
    }
}
