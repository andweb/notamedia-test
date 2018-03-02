# Задание
Описать самую лучшую, по вашему мнению, схему реализации аутентификации rest api для мобильного приложения. 
# Решение
Для аутентификации мобильного приложения в rest api предлагаю использовать access token + refresh token + expires.
> access token - содержит информацию для доступа к ресурсу
refresh token - содержит информацию для получения новых access token и refresh token
expires - время жизни access token в секундах

Делаем два метода аутентификации: 
> https://example.com/v1/authorize - для получение токена
https://example.com/v1/token - для обновления токена

Алгоритм следующий:

1. Приложение делает post запрос на https://example.com/v1/authorize с помощью пары логин/пароль.
2. Сервер создает access token + refresh token + expires и отправляет приложению.
3. Приложение сохраняет их и каждый последующий запрос к api подписывает с помощью access token.
4. Перед каждым запросом приложение проверяем expires и если оно истекло то отправляет post запрос с refresh token на https://example.com/v1/token, сервер создает новую связку access token + refresh token + expires и отправляет приложению.
5. Если при проверке на сервере access token невалиден, то приложение должно обновить токен, если refresh token тоже невалиден, 
