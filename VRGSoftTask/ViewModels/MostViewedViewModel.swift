//
//  MostViewedViewModel.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 07.02.2025.
//

import Foundation

class MostViewedViewModel {
    // Свойство mostViewed, хранящее динамический массив статей
    var mostViewed = Dynamic<Array<ArticleStruct>>([]) // Изначально массив статей пуст

    // Метод getMostViewedArticles запрашивает данные о самых отправляемых статьях
    func getMostViewedArticles () {
        // Выполняем сетевой запрос через RequestFactory
        // Адрес для запроса - это 'mostViewed', и период - 'month'
        RequestFactory.request(address: .mostViewed, period: .month) { (response: Result<ArticleResultStruct, Error>) in
            // Обрабатываем ответ на запрос
            switch response {
            case .success(let success):
                // Если запрос успешен, обновляем значение mostViewed с полученными результатами
                self.mostViewed.value = success.results
            case .failure(let error):
                // Если произошла ошибка, выводим ее в консоль
                print(error)
            }
        }
    }
}
