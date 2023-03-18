# Timely
<p align="center">
<img src="https://psv4.userapi.com/c237031/u243703137/docs/d6/ce36e9c4061a/543-PhotoRoom_png-PhotoRoom.png?extra=TQl3B1-UFv2UbcIL0Yt9KHgq8cBihQj-0Jse4nuSPtQInN_Az1yXDYkcN34UX9sEzaBmA5PQPnP3YcIr83IMcibWW1inwnSY6yaXXJXiFqbQFpdB2pnKgsj_Qy2pqNb_Olt_ZLsDsAkrqyUu_Dbs3Fxu" width="250" height="250" center=true>
</p>

[![iOS](https://img.shields.io/badge/iOS-16.0+-865EFC.svg)](https://www.apple.com/ios/ios-16/)
[![Swift](https://img.shields.io/badge/Swift-5.7.3-865EFC.svg)](https://github.com/apple/swift/releases/tag/swift-5.7.3-RELEASE)
[![Xcode](https://img.shields.io/badge/Xcode-14.2+-865EFC.svg)](https://apps.apple.com/app/xcode/id497799835)

[![Alamofire](https://img.shields.io/cocoapods/v/Alamofire?label=Alamofire)](https://github.com/Alamofire/Alamofire)
[![SwiftKeychainWrapper](https://img.shields.io/cocoapods/v/SwiftKeychainWrapper?label=SwiftKeychainWrapper)](https://github.com/jrendel/SwiftKeychainWrapper)
[![SwiftUICurvedRectangleShape](https://img.shields.io/badge/Package_Manager-SwiftUICurvedRectangleShape-blue.svg)](https://github.com/CypherPoet/SwiftUICurvedRectangleShape)
---

## О проекте

Проект был сделан в качестве лабораторной работы по курсу "**Основы командной разработки**" на втором курсе обучения в ТГУ на факультете Высшая IT-школа.

Необходимо было разработать расписание для школы/университета. Расписание должно быть представлено в виде:

- [Web-приложения](https://github.com/PodsolnyX/Timely-Frontend)
- [Backend сервиса](https://github.com/Apochromat/timely-backend), представленного в форме [REST API](https://ru.wikipedia.org/wiki/REST)
- Мобильного приложения на любой из платформ. В нашей команде было разработано приложение на двух платформах:
    - [iOS](https://github.com/foolery33/Schedule-Timely) - мой проект
    - [Android](https://github.com/NikPanfilov/Timely)

---

## [Требования](https://docs.google.com/document/d/1rFMebBa6A9ATEzW6Euko2W6hNgmz1XTpk1X9miqmuRA/edit) для мобильного клиента

> Мобильный клиент - это клиент для просмотра расписания студенческих групп/преподавателей/аудиторий. Если в приложение заходит студент, то по умолчанию показывается расписание его группы, если преподаватель, то по умолчанию показывается его расписание. Если заходит пользователь, который не связан с бизнес-сущностями, то ему предлагается выбрать чье расписание его интересует

## Архитектура

Использовался архитектурный паттерн [MVVM](https://ru.wikipedia.org/wiki/Model-View-ViewModel)

<img src="https://sun9-41.userapi.com/impg/6nwbEsjHmQzqjnE5hJY9djbRp85RLrZMEDNe-g/7uHiMlAeAsA.jpg?size=2481x1182&quality=95&sign=7f24f7cd4787922bcca61dcf784dee65&type=album" width = 650>

## Дизайн экранов
| Splash Screen | Login Screen | Register Screen |
| :------------:|:-----------: | :-------------: |
| <img src="https://sun9-4.userapi.com/impg/pzRMdeuvgfJX2j6i28lx5M0wFYOm7UkkRD20zg/v38uaZ-ox8c.jpg?size=996x2160&quality=95&sign=b3db8c50410c66883c2157395890a267&type=album" width = 300>
