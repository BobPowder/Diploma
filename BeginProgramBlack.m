function BeginProgramBlack()
%Очистка памяти перед выполнением программы
clear;

%Стратегия - полутоновые
global strategy;
strategy=3; 

%V -  массив, хранящий  изображение. Необходим для заполнения
%массива images
%Второй индекс V - номер элемента бинарной комбинации.
%Третий индекс V - цвет изображения
%Значение V - значение элемента бинарной комбинации
V = zeros(1, 10000);


%Создание пустых массивов

%images - массив эталонных изображений, переведенных в бинарную комбинацию.
%Первый индекс - номер изображения.
%Второй индекс - индекс бинарной комбинации, характеризующей данное изображение
%Значение массива - значение элемента данной бинарной комбинации, характеризующей данное изображение
global portraitimages;
global pictureimages;
global ECGimages;


%notpreparedimages - массив палитровых изображений, готовых к отображению на экране в качестве ответа
%Первая координата - номер изображения
%Вторая и третья координаты - координаты пикселя данного изображения
%Значение массива - цвет данного пикселя данного изображения
global notpreparedportraitimages;
global notpreparedpictureimages;
global notpreparedECGimages;


%answers - массив, хранящий описание соответствующего изображения в виде строки.
%индекс - номер эталонного изображения
%значение - строка описания изображения
global portraitanswers;
global pictureanswers;
global ECGanswers;

%Заполнение массивов images, notpreparedimages и portraitanswers
[portraitimages, notpreparedportraitimages, portraitanswers] = tobk(portraitimages, notpreparedportraitimages, portraitanswers, 'Портреты/', 'Портреты (описание)/');
[pictureimages, notpreparedpictureimages, pictureanswers] = tobk(pictureimages, notpreparedpictureimages, pictureanswers, 'Картины/', 'Картины (описание)/');
[ECGimages, notpreparedECGimages, ECGanswers] = tobk(ECGimages, notpreparedECGimages, ECGanswers, 'ЭКГ/', 'ЭКГ (описание)/');

MainMenu;
end

function [images, notpreparedimages, answers]=tobk(images, notpreparedimages, answers, imagesPath, answersPath)
	% поиск jpg-файлов в директории imagesPath
	% и вычисление кол-ва найденных файлов
	MyJpgFiles=dir([imagesPath, '*.jpg']);
	MyJpgFilesQuantity=length(MyJpgFiles);
	
	%Заполнение массивов images и notpreparedimages нулями
	images = zeros(MyJpgFilesQuantity, 10000);
	notpreparedimages = zeros(MyJpgFilesQuantity, 100, 100);
	
	%Работа с каждым эталонным изображением
	for i = 1 : MyJpgFilesQuantity
		%Получение двумерных массивов, взятых из jpg-файла. Каждый массив отвечает за
		%наличие/отсутствие белого цвета каждого пикселя соответственно.
		%После идет перевод изображения N*N к размеру 100*100 по методу ближайшего соседа.
		MToDisplay=im2bw(imresize(imread([imagesPath, MyJpgFiles(i).name]), [100 100]), 0.5);

		%Перевод массива в вектор-строку
		V(:,:)=reshape(MToDisplay, 1, 10000);
		
		%Перевод вектора-строки в бинарную вектор-строку 
		for m=1:1:10000
			images(i, m)=~V(1,m);
		end
		
		%Сохранение изображения массива для вывода (если тестовое изображение будет распознано)
		notpreparedimages(i, :, :)=MToDisplay;
	end

	notpreparedimages=logical(notpreparedimages);
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