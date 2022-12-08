### Онлайн уроки Учебный центр № 1 

- Минимальная версия Платформмы 8.3.18 
    - используется Асинхронная функция
##### Реализуем Загрузку Файла сразделителями из  `*.csv`  файла

- Интерфейс:  
    - создана Форма:
        - Команды  Формы
            - Загрузка Файла
            - Определение Области Документа-источника  
        - Поля Формы
            - Выбор Листа Документа-источника (режим Выбора из списка)
            - Область Предпросмотра (поле Табличного Документа)
- Код (Модуль Формы)
    - Клиент:
        - `ЗагрузитьФайл `
        - `НачатьВыборФайла` - получение пути к файлу-источнику
        - `ВывестиПрогрессЗагрузкиФайла` -  добавлено отображение Прогреса  загрузки файла
    - Сервер 
       - Данные формы  →
       - *собираем*  Имя Метода Модуля  Объекта
       - выполняем собранную строку вызова
            - Модуль Объекта 
       - → Данные формы (обновляем)   
- Модуль Объекта
    - добавляем Реквизит `ТабДок` Тип `Табличный Документ`
    - генерим Параметры работы с Временным Хранилищем
        - Имя файла
        - Расширение  
    - получаем & записываем из Временного Хранилища
        - пример значения `ИмяФайла`
    ```
    ИмяФайла	"C:\Users\Desktop_New\AppData\Local\Temp\v8_93CA_9.xls"	Строка
    ```
    - читаем в созданный Ревизит `ТабДок`
- Отладка существующего функционала 
    - если лист пустой = > его **НЕ ВИДНО** в Отладчике в Областях Объекта `ТабДок`
- Отображение Содержимого Листа,  выбранного в Поле `ВыбранныйЛист`
- Обработчик События Поля Формы `ПриИзменении` 
    - Модуль Формы
        - Обработчик нажатия 
        - проверяем,  что Поле Выбора заполнено
        - пилим процедуру для последующего вызова Процедуры Чтения из Модуля объекта 
           - *(по аналогии с уже реализованным функционалом)* 
    - Модуль Объекта
            - читаем Данные из Области `ВыбранныйЛист` Объекта `ТабДок`
- Реализация Функционала Определения Области Документа-источника 
     - Модуль Формы
        - Обработчик нажатия Кнопки `ОпределитьРазмер`
        - пилим Процедуру для:
            - последующего вызова `ПолучитьРазмерОбластиДанныхПо..` из Модуля объекта 
            - отображкения сообщения о количестве заполненных Строк / Колонок на листе в Документ-источнике
    - Модуль Объекта
        - получаем Размеры Области Данных  
            - *(по аналогии с уже реализованным функционалом)* 
        - формирования текста сообщения о количестве заполненных Строк / Колонок на листе в Документ-источнике     


    - tb ctnd
