function BegimProgramGrey()
%Очистка памяти перед выполнением программы
clear;

%Стратегия - полутоновые
global strategy;
strategy=2; 

%Ввод пользователем количеств оттенков серого цвета,
%которые будут участвовать в палитре
global palitra;
palitra=16;

%Создание пустых массивов

%images - массив эталонных полутоновых изображений, переведенных в бинарную комбинацию.
%Первый индекс - номер изображения.
%Второй индекс - индекс бинарной комбинации, характеризующей данное изображение
%Значение массива - значение элемента данной бинарной комбинации, характеризующей данное изображение
global portraitimages;
global pictureimages;

%notpreparedimages - массив эталонных полутоновых изображений, готовых к отображению на экране в качестве ответа
%Первая координата - номер изображения
%Вторая и третья координаты - координаты пикселя данного изображения
%Значение массива - цвет данного пикселя данного изображения
global notpreparedportraitimages;
global notpreparedpictureimages;

%V -  массив, хранящий  изображение. Необходим для заполнения
%массива images
%Второй индекс V - номер элемента бинарной комбинации.
%Значение V - значение элемента бинарной комбинации
V = zeros(1, 10000);

% Описание эталонных портретов писателей и картин
global portraitanswers;
global pictureanswers;

[portraitimages, notpreparedportraitimages, pictureanswers]=tobk(palitra, portraitimages, notpreparedportraitimages, pictureanswers, 'Портреты/', 'Портреты (описание)/');
[pictureimages, notpreparedpictureimages, pictureanswers]=tobk(palitra, pictureimages, notpreparedpictureimages, pictureanswers, 'Картины/', 'Картины (описание)/');

MainMenu;
end

function [images, notpreparedimages, answers]=tobk(palitra, images, notpreparedimages, answers, imagesPath, answersPath)
	% поиск jpg-файлов в директории imagesPath
	% и вычисление кол-ва найденных файлов
	MyJpgFiles=dir([imagesPath, '*.jpg']);
	MyJpgFilesQuantity=length(MyJpgFiles);
	
	%Заполнение массивов images и notpreparedimages нулями
	images = zeros(MyJpgFilesQuantity, 10000*palitra);
	notpreparedimages = zeros(MyJpgFilesQuantity, 100, 100);
	
	%Работа с каждым эталонным изображением
	for i = 1 : MyJpgFilesQuantity
		%Получение двумерных массивов, взятых из jpg-файла. Массив отвечает за
		%интенсивность серого цвета каждого пикселя соответственно
		%После идет перевод изображения N*N к размеру 100*100 по методу ближайшего соседа
		MToDisplay=rgb2gray(imresize(imread([imagesPath, MyJpgFiles(i).name]), [100 100]));
	   
		%Перевод значений массива из типа uint8 в тип double
		MToDisplay=double(MToDisplay);
		
		%Перевод массива в вектор-строку
		 V(:,:)=reshape(MToDisplay, 1, 10000);
		
		%Перевод вектора-строки в бинарную вектор-строку
		for m=1:1:10000
			images(i, (m-1)*palitra + fix(V(1, m, 1)/(256/palitra)) + 1)=true;
		end

		%Сохранение изображения массива для вывода (если тестовое изображение будет распознано) 
		for k=1:100
			for l=1:100
				notpreparedimages(i,k,l)=fix(MToDisplay(k, l, 1)/(256/palitra))*fix(256/palitra);
			end
		end

		images=double(images);
		answers=[];
		
		% поиск txt-файлов в директории answersPath
		% и вычисление кол-ва найденных файлов
		MyTxtFiles=dir([answersPath, '*.txt']);
		MyTxtFilesQuantity=length(MyTxtFiles);
		%Работа с каждым описанием эталонных изображений
		for i = 1 : MyTxtFilesQuantity
			%Взятие первой строки из файла и копирование в соответствующую ячейку массива
			fileID = fopen([answersPath, MyTxtFiles(i).name]);
			buf = textscan(fileID, '%s','delimiter','\n');
			answers{i} = buf{1};
			fclose(fileID);
		end
	end
end