
&НаКлиенте
Процедура ЗагрузитьФайл(Команда)
	
	НачатьВыборФайла() 
	
КонецПроцедуры 

&НаКлиенте
АСИНХ Процедура НачатьВыборФайла()
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	
	Диалог.Заголовок = "Выбор файла с данными";
	Диалог.Каталог = Ждать КаталогДокументовАсинх();
	Диалог.Фильтр = "Файл с даными|*.xls; *.xlsx";
	
	Если Ждать  Диалог.ВыбратьАсинх()<> Неопределено Тогда 
		
		Объект.ПолноеИмяФайла = Диалог.ПолноеИмяФайла;
		
		Далее("НачатьЗагрузкуФайла", "Начининаем загрузку")	
		
	КонецЕсли;
	
КонецПроцедуры  


&НаКлиенте
Процедура Далее(ИмяМетода,ТекстОповещения = Неопределено)
	
	Если ТекстОповещения <> Неопределено Тогда 		
		Состояние(ТекстОповещения);				
	КонецЕсли;
	
	ПодключитьОбработчикОжидания(ИмяМетода,0.1,Истина)
	
КонецПроцедуры  


&НаКлиенте
АСИНХ Процедура НачатьЗагрузкуФайла()
	
	
	ПрогрессЗагрузки = Новый ОписаниеОповещения("ВывестиПрогрессЗагрузкиФайла",ЭтотОбъект);
	
	Ответ = Ждать ПоместитьФайлНаСерверАсинх(ПрогрессЗагрузки, , , Объект.ПолноеИмяФайла,ЭтотОбъект.УникальныйИдентификатор);
	
	Если Ответ <> Неопределено Тогда   //файл загружен
		
		Объект.РазмещениеДанных = Ответ.Адрес;
		Далее("НачатьПреобразованиеДанных", "Преобразование данных");
		
	КонецЕсли;
	
КонецПроцедуры       


&НаКлиенте
Процедура ВывестиПрогрессЗагрузкиФайла(ПомещаемыйФайл,Помещено,ОтказОтПомещенияФайла, ДополнительныеПараметры) Экспорт 
	
	Состояние("Загрузка файла",Помещено);  
	
КонецПроцедуры           


&НаКлиенте
Процедура НачатьПреобразованиеДанных()
	
	// Процедура Модуля Объекта
	ВыполнитьДействие("ПреобразованиеДанных", Ложь);
	// получение Списка Листов
	Далее("НачатьАнализДанных", "Анализ Данных");
	
КонецПроцедуры   

&НаКлиенте
Процедура НачатьАнализДанных()
	
	// Процедура Модуля Объекта
	ВыполнитьДействие("АнализДанных");
	Элементы.ВыбранныйЛист.СписокВыбора.ЗагрузитьЗначения(Объект.ДоступныеЛисты.ВыгрузитьЗначения());
	
КонецПроцедуры


&НаКлиенте
Процедура ВыбранныйЛистПриИзменении(Элемент)
	
	Если НЕ ПустаяСтрока(Объект.ВыбранныйЛист)  Тогда		
		Далее("НачатьЧтениеЛиста", "Чтение данных Листа");			
	КонецЕсли;
	
КонецПроцедуры  

&НаКлиенте
Процедура НачатьЧтениеЛиста()
	
	ВыполнитьДействие("ПрочитатьДанныеЛиста");		
	
КонецПроцедуры 


&НаКлиенте
Процедура ОпределитьРазмер(Команда)
	
	ВыполнитьДействие("ПолучитьРазмерЛиста");
	ПредупреждениеАсинх(Объект.ТекстСообщения);
	
КонецПроцедуры


&НаСервере
Процедура ВыполнитьДействие(ЗНАЧ ИмяМетодаМодуляОбъекта, ЗНАЧ ТребуетсяОбновление = Истина)   
	
	// Создание Экземпляра Обработки
	Обработка = РеквизитФормыВЗначение("Объект");   	
	
	// Для перехода в Модуль Объекта
	СтрокаВызова = "Обработка." + ИмяМетодаМодуляОбъекта + "()" ; 
	
	// Переход В Модуль Объекта  
	Выполнить(СтрокаВызова);
	
	Если ТребуетсяОбновление Тогда 	
		// → обновление Формы 
		ЗначениеВРеквизитФормы(Обработка, "Объект"); 	
	КонецЕсли;	
КонецПроцедуры     




