//
//  MostSharedViewModel.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 07.02.2025.
//

import Foundation

class MostSharedViewModel {
    // Свойство mostShared, хранящее динамический массив статей
    var mostShared = Dynamic<Array<ArticleStruct>>([]) // Изначально массив статей пуст

    // Метод getMostSharedArticles запрашивает данные о самых отправляемых статьях
    func getMostSharedArticles () {
        // Выполняем сетевой запрос через RequestFactory
        // Адрес для запроса - это 'mostEmailed', и период - 'month'
        RequestFactory.request(address: .mostShared) { (response: Result<ArticleResultStruct, Error>) in
            // Обрабатываем ответ на запрос
            switch response {
            case .success(let success):
                // Если запрос успешен, обновляем значение mostShared с полученными результатами
                self.mostShared.value = success.results
            case .failure(let error):
                // Если произошла ошибка, выводим ее в консоль
                print(error)
            }
        }
    }
}
