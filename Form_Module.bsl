

&НаКлиенте
Процедура ЗагрузитьФайл(Команда)
	
	НачатьВыборФайла() 
	
КонецПроцедуры 

&НаКлиенте
АСИНХ Процедура НачатьВыборФайла()
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	
	Диалог.Заголовок = "Выбор файла с данными";
	
	Диалог.Каталог = Ждать КаталогДокументовАсинх();
	Диалог.Фильтр = "Файл с даными|*.xls, *.xlsx, |";
	
	Если Ждать  Диалог.ВыбратьАсинх()<> Неопределено Тогда 
		
		Объект.ПолноеИмяФайла = Диалог.ПолноеИмяФайла;
		
		Далее("НачатьЗагрузкуФайла", "Начининаем загрузку")	
		
	КонецЕсли;
	
КонецПроцедуры  


&НаКлиенте
Процедура Далее(ИмяМетода,ТекстОповещения = Неопределено)
	
	Если ТекстОповещения <> Неопределено Тогда 
		
		Состояние(ТекстОповещения);		
		
		//ПодключитьОбработчикОжидания(ИмяМетода,0,1,Истина)

	КонецЕсли;
		
КонецПроцедуры  


&НаКлиенте
АСИНХ Процедура НачатьЗагрузкуФайла()
	
	Ответ = Ждать ПоместитьФайлНаСерверАсинх();
	
	Если Ответ <> Неопределено Тогда   //файл загружен
			
		Объект.РазмещениеДанных = Ответ.Адрес;
		
	КонецЕсли;

КонецПроцедуры 
