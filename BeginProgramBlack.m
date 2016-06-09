function BeginProgramBlack()
%Очистка памяти перед выполнением программы
clear;

%Стратегия - полутоновые
global strategy;
strategy=3; 

%Ввод пользователем количеств оттенков красного, зеленого и синего цвета,
%которые будут участвовать в палитре
%palitra=input('Введите количество оттенков красного, зеленого и синего цвета, участвующие в палитре: ');

global palitra;
palitra=16;

%V -  массив, хранящий  изображение. Необходим для заполнения
%массива images
%Второй индекс V - номер элемента бинарной комбинации.
%Третий индекс V - цвет изображения
%Значение V - значение элемента бинарной комбинации
V = zeros(1, 10000, 1);




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

global portraitanswers;
global pictureanswers;
global ECGanswers;

[portraitimages, notpreparedportraitimages, portraitanswers] = tobk(portraitimages, notpreparedportraitimages, portraitanswers, 'Портреты/', 'Портреты (описание)/');
[pictureimages, notpreparedpictureimages, pictureanswers] = tobk(pictureimages, notpreparedpictureimages, pictureanswers, 'Картины/', 'Картины (описание)/');
[ECGimages, notpreparedECGimages, ECGanswers] = tobk(ECGimages, notpreparedECGimages, ECGanswers, 'ЭКГ/', 'ЭКГ (описание)/');
%notpreparedECGimages(10, :,: ,1)
% Описание эталонных портретов писателей 
MainMenu;
end

function [images, notpreparedimages, answers]=tobk(images, notpreparedimages, answers, imagesPath, answersPath)

	MyJpgFiles=dir([imagesPath, '*.jpg']);
	MyJpgFilesQuantity=length(MyJpgFiles);
	
	images = zeros(MyJpgFilesQuantity, 10000);
	
	notpreparedimages = zeros(MyJpgFilesQuantity, 100, 100, 1);
	
	%Работа с каждым эталонным изображением
	for i = 1 : MyJpgFilesQuantity
		%Получение набора из трех двумерных массивов, взятых из jpg-файла. Каждый массив отвечает за
		%интенсивность красного, зеленого и синего цвета каждого пикселя соответственно
		%После идет перевод изображения N*N к размеру 100*100 по методу ближайшего соседа
		MToDisplay=im2bw(imresize(imread([imagesPath, MyJpgFiles(i).name]), [100 100]), 0.5);

		%Перевод массива в вектор-строку
		V(:,:,1)=reshape(MToDisplay, 1, 10000);
		
		%Перевод вектора-строки в бинарную вектор-строку
		for m=1:1:10000
			images(i, m)=~V(1,m,1);
		end
		
		%Сохранение изображения массива для вывода (если тестовое изображение будет распознано)
		notpreparedimages(i, :, :, 1)=MToDisplay;
	end

	notpreparedimages=logical(notpreparedimages);
	
	images=double(images);
	
	answers=[];
	
	MyTxtFiles=dir([answersPath, '*.txt']);
	MyTxtFilesQuantity=length(MyTxtFiles);
	for i = 1 : MyTxtFilesQuantity
		fileID = fopen([answersPath, MyTxtFiles(i).name]);
		buf = textscan(fileID, '%s','delimiter','\n');
		answers{i} = buf{1};
		fclose(fileID);
	end
end