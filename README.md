# gitHubUsers !!!
Перед запуском кода убедитесь в наличии Personal Access Token для GitHub API, который следует добавить в значение переменной 'apiToken' в файле lib/gh_users/api_service/networking.dart ЛИБО закомментировать/удалить строку с 'headers' для fetchUsers() и fetchProfile() в указанном файле.

GitHub Users

Создать приложение на Flutter для Android/iOS, состоящее с нескольких экранов.

Главный экран:

Users (список всех Github пользователей). Использовать API           https://developer.github.com/v3/users/#get-all-users                                               - 1,5-2 h

В элементе списка отрисовать avatar, login (title), id (subtitle)                               - 25-30 min

По нажатию на элемент списка реализовать переход на UserDetails                 - 2-5 min

Реализовать pagination и Pull-to-refresh                                                                  - 1-1,5 h

UserDetails (экран с информацией о пользователе):

Использовать API https://developer.github.com/v3/users/#get-a-single-user         - 1,5-2 h 

Поля: Avatar, Name, Email, Organization (если есть), Following count, Followers count, Дата создания аккаунта                                                                                                                     - 30-35 min

(опционально) Сохранить в локальное хранилище и отображать на главном экране при отсутствии 
соединения к сети                                                                                                     - 1 h

Требования:
Код на Dart 2.0 с использованием null safety.
Структурированный код (архитектурный паттерн на усмотрение кандидата)
Код поместить в репозиторий на GitHub/GitLab
Создать документ с информацией про то сколько примерно времени ушло на каждую задачу.
Неоднозначности задания трактуются на усмотрение разработчика
Будет плюсом:
Unit тесты.
Golden тесты
