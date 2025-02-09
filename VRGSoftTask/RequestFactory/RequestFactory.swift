//
//  RequestFactory.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 06.02.2025.
//

import Foundation
import Alamofire

// MARK: Enum для периода
/// Перечисление для временных периодов для получения данных.
enum Period: Int {
    case day = 1   // 1 день
    case week = 7  // 1 неделя
    case month = 30 // 1 месяц
}

// MARK: Enum для URL-адресов
/// Перечисление для различных конечных точек API.
enum Endpoints: String {
    case mostEmailed = "https://api.nytimes.com/svc/mostpopular/v2/emailed/"
    case mostViewed = "https://api.nytimes.com/svc/mostpopular/v2/viewed/"
    case mostShared = "https://api.nytimes.com/svc/mostpopular/v2/shared/"
}

class RequestFactory {
    private static var period: Period = Period.month
    
    static func setPeriod(period: Period) {
        self.period = period
    }
    
    /// Генерическая функция для выполнения сетевого запроса к указанной конечной точке API.
    /// - Parameters:
    ///   - address: Конечная точка API для запроса данных.
    ///   - completion: Замыкание для обработки результата.
    static func request<T: Codable>(address: Endpoints, completion: @escaping (Result<T, Error>) -> ()) {
        // Составляем URL, добавляя период к конечной точке
        let url: String = "\(address.rawValue)\(self.period.rawValue).json"
        
        // Выполняем сетевой запрос с помощью Alamofire
        AF.request(
            url,
            method: .get,
            parameters: ["api-key": "\(ProcessInfo.processInfo.environment["apiKey"] ?? "")"],
            encoding: URLEncoding.default)
        .validate() // Проверяем код статуса ответа
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let result):
                // Вызываем замыкание для успешного случая
                completion(.success(result))
            case .failure(let error):
                // Печатаем ошибку для отладки
                print("Запрос завершился ошибкой: \(error)")
                // Вызываем замыкание для случая ошибки
                completion(.failure(error))
            }
        }
    }
}
