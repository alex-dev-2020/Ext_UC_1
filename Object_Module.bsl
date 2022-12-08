

Процедура ПреобразованиеДанных() Экспорт 
	
	// генерим параметры	
	Файл = Новый Файл(ПолноеИмяФайла);
	ИмяФайла  = ПолучитьИмяВременногоФайла(Файл.Расширение);  
	
	// получаем & записываем  из Временного Хранилища	
	ПолучитьИзВременногоХранилища(РазмещениеДанных).Записать(ИмяФайла); 
	
	// читаем
	ТабДок.Прочитать(ИмяФайла,СпособЧтенияЗначенийТабличногоДокумента.Значение); 
	
	
КонецПроцедуры  


Процедура АнализДанных() Экспорт
	
	// страхуемся от возможного перевыбора Документа-источника
	ДоступныеЛисты.Очистить();  
	
	// Список Листов → ДоступныеЛисты
	Для каждого Лист Из ТабДок.Области Цикл
		
		ДоступныеЛисты.Добавить(Лист.Имя);	
		
	КонецЦикла;
	
	
КонецПроцедуры


Процедура ПрочитатьДанныеЛиста()Экспорт
	
	ДанныеЛиста = ТабДок.ПолучитьОбласть(ВыбранныйЛист);
	
КонецПроцедуры


Процедура ПолучитьРазмерЛиста()Экспорт
	
	ТекстСообщения= СтрШаблон("Количество строк :  %1
	|Количество колонок : %2",
	ДанныеЛиста.ПолучитьРазмерОбластиДанныхПоВертикали(),
	ДанныеЛиста.ПолучитьРазмерОбластиДанныхПоГоризонтали());
	
	
КонецПроцедуры    


Процедура ПолучитьДоступныеЛистыИзФайла() Экспорт 
	
	ТекстСообщения = "Доступные листы : " + Символы.ПС;
	
	ДанныеФайла = ПолучитьИзВременногоХранилища(РазмещениеДанных);
	ПотокДанных = ДанныеФайла.ОткрытьПотокДляЧтения();
	
	Архиватор = Новый ЧтениеZipФайла(ПотокДанных);
	
	Элемент = Архиватор.Элементы.Найти("workbook.xml");
	Архиватор.Извлечь(Элемент,КаталогВременныхФайлов(),РежимВосстановленияПутейФайловZIP.НеВосстанавливать);
	
	// извлекаем из workbook.xml информацию по листам
	Файл = Новый ЧтениеXML;
	Файл.ОткрытьФайл(КаталогВременныхФайлов()+ ПолучитьРазделительПути()+ Элемент.Имя);	
		
	Пока Файл.Прочитать() Цикл 	
		Если НРег(Файл.Имя)<> "sheet"  Тогда // ищем секцию с описанием Листов
			Продолжить;							
		КонецЕсли;
		
		Если Файл.ТипУзла = ТипУзлаXML.НачалоЭлемента Тогда 
			// читаем атрибуты
			Пока Файл.ПрочитатьАтрибут() Цикл
				Если НРег(Файл.Имя) = "name" Тогда
					ТекстСообщения = ТекстСообщения + Файл.Значение + Символы.ПС;			
				КонецЕсли;
			КонецЦикла;	
		КонецЕсли;		
	КонецЦикла;    
	
	Файл.Закрыть();
	
КонецПроцедуры


