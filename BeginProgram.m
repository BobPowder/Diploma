function BeginProgram()
%Очистка памяти перед выполнением программы
clear;

%Стратегия - полноцветные
global strategy;
strategy=1; 

%palitra - количество оттенков красного, зеленого и синего цвета,
%которые будут участвовать в палитре
global palitra;
palitra=16;

%Создание пустых массивов

%images - массив эталонных полноветных изображений, переведенных в бинарную комбинацию.
%Первый индекс - номер изображения.
%Второй индекс - индекс бинарной комбинации, характеризующей данное изображение
%Значение массива - значение элемента данной бинарной комбинации, характеризующей данное изображение
global portraitimages;
global pictureimages;

%notpreparedimages - массив эталонных полноветных изображений, готовых к отображению на экране в качестве ответа
%Первая координата - номер изображения
%Вторая и третья координаты - координаты пикселя данного изображения
%Четвертая - номер цвета (1 - красный, 2 - зеленый, 3 - синий)
%Значение массива - цвет данного пикселя данного изображения
global notpreparedportraitimages;
global notpreparedpictureimages;

%V -  массив, хранящий  изображение. Необходим для заполнения
%массива portraitimages
%Второй индекс V - номер элемента бинарной комбинации.
%Третий индекс V - цвет изображения
%Значение V - значение элемента бинарной комбинации
V = zeros(1, 10000, 3);

global portraitanswers;
global pictureanswers;

[portraitimages, notpreparedportraitimages, pictureanswers]=tobk(palitra, portraitimages, notpreparedportraitimages, pictureanswers, 'Портреты/', 'Портреты (описание)/');
[pictureimages, notpreparedpictureimages, pictureanswers]=tobk(palitra, pictureimages, notpreparedpictureimages, pictureanswers, 'Картины/', 'Картины (описание)/');

transposedimages=pictureimages.';
mat=pictureimages*transposedimages;

[x,y]=meshgrid(1:1:30, 1:1:30);
surf(x,y,mat);

%MainMenu;
end

function [images, notpreparedimages, answers]=tobk(palitra, images, notpreparedimages, answers, imagesPath, answersPath)
	% поиск jpg-файлов в директории imagesPath
	% и вычисление кол-ва найденных файлов
	MyJpgFiles=dir([imagesPath, '*.jpg']);
	MyJpgFilesQuantity=length(MyJpgFiles);
	
	%Заполнение массивов images и notpreparedimages нулями
	images = zeros(MyJpgFilesQuantity, 10000*palitra*3);
	notpreparedimages = zeros(MyJpgFilesQuantity, 100, 100, 3);
	
	
	%Работа с каждым эталонным изображением
	for i = 1 : MyJpgFilesQuantity
		%Получение набора из трех двумерных массивов, взятых из jpg-файла. Каждый массив отвечает за
		%интенсивность красного, зеленого и синего цвета каждого пикселя соответственно
		%После идет перевод изображения N*N к размеру 100*100 по методу ближайшего соседа
		MToDisplay=imresize(imread([imagesPath, MyJpgFiles(i).name]), [100 100]);
			
		%Перевод значений массива из типа uint8 в тип double
		MToDisplay=double(MToDisplay);
	   
		%Перевод массива в вектор-строку
		for x = 1 : 3
			V(:,:,x)=reshape(MToDisplay(:, :, x), 1, 10000);
		end
		
		%Перевод вектора-строки в бинарную вектор-строку
		for j = 1:3
			for k=1:10000
				images(i,palitra*3*(k-1) + fix(V(1, k, j)/(256/palitra)) + palitra*(j-1) + 1) = true;
			end
		end

		%Сохранение изображения массива для вывода (если тестовое изображение будет распознано) 
		for j = 1:3
			for k=1:100
				for l=1:100
					notpreparedimages(i,k,l,j)=fix(MToDisplay(k, l, j)/(256/palitra))*fix(256/palitra);
				end
			end
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