# Документація до мобільного додатка "The New York Times"
## Вступ
Додаток створено на основі __The New York Times__ API, в якому відображаются дані про `most emailed`, `most shared`, `most viewed` статті з можливістю зберігати їх в список `Favorite`, котрих зберігаєтся на пристрої. Це дає можливість в режимі offline дивитися збережені юзером статті.
## User story
`User story` цього додатку можна знайти за цим посиланням: [The New York Times user story](https://docs.google.com/document/d/1GYE5A0oPFktLQ9K1H2A2F48Vsf4ZWpvRoBfrfwlucDE/edit?usp=sharing).
## Архітектура додатку

1. Основні технології

- __Swift__: Мова програмування, що використовується для розробки мобільного додатку. Swift є сучасною та безпечною мовою, яка забезпечує високу продуктивність.
- __CoreData__: Використовується для зберігання, додавання і видалення улюблених статей у локальному сховищі. CoreData дозволяє ефективно управляти об'єктами даних і виконувати запити до бази даних.
- __CocoaPods__: Менеджер залежностей, що полегшує інтеграцію сторонніх бібліотек. Завдяки CocoaPods можна легко додавати та оновлювати бібліотеки у проекті.
- __Alamofire__: Бібліотека для виконання мережевих запитів, що спрощує роботу з HTTP-запитами. Alamofire дозволяє легко здійснювати запити до API та обробляти відповіді в форматі JSON.

2. Архітектурний патерн - __MVVM__

Додаток реалізовано за патерном `MVVM (Model-View-ViewModel)`, що забезпечує чіткий розподіл обов'язків та спрощує тестування.
- __Model__:
Моделі можуть включати структури, що представляють статті, з інформацією про їхні атрибути (назва, опис, URL тощо).
CoreData використовується для зберігання улюблених статей, управління їх додаванням і видаленням у локальному сховищі.
- __View__:
Інтерфейс користувача, реалізований за допомогою `UIKit`. `UIViewController` відповідає за представлення даних, отриманих від ViewModel.
Views беруть участь у відображенні улюблених статей, але не містять бізнес-логіки.
- __ViewModel__:
ViewModel взаємодіє з моделями, щоб отримати дані для відображення у Views.
Використовує `Alamofire` для здійснення мережевих запитів до API для завантаження статей та їхньої інформації.
Manage статті (додавання до улюблених, видалення) через `CoreData`, а також робить дані доступними для Views.

3. Взаємодія компонентів

- __Мережеві запити__:
Коли користувач взаємодіє з інтерфейсом, ViewModel здійснює мережеві запити через `Alamofire`, щоб отримати інформацію про статті.
Отримані дані парсяться в JSON-форматі та передаються View для відображення.
- __Зберігання даних__:
Користувач може додавати статті до улюблених. `ViewModel` обробляє цю взаємодію і викликає методи для збереження статей в CoreData.
CoreData дозволяє виконувати запити для отримання списку улюблених статей для подальшого відображення у Views.
- __Интеграція з `CocoaPods`__:
CocoaPods використовуються для управління бібліотекою `Alamofire`, що забезпечує просту інтеграцію та оновлення сторонніх бібліотек.
