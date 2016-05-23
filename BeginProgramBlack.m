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
MyJpgPortraitsFiles=dir('Портреты/*.jpg');
MyJpgPortraitsFilesQuantity=length(MyJpgPortraitsFiles);
MyJpgPicturesFiles=dir('Картины/*.jpg');
MyJpgPicturesFilesQuantity=length(MyJpgPicturesFiles);

%Создание пустых массивов

%images - массив эталонных изображений, переведенных в бинарную комбинацию.
%Первый индекс - номер изображения.
%Второй индекс - индекс бинарной комбинации, характеризующей данное изображение
%Значение массива - значение элемента данной бинарной комбинации, характеризующей данное изображение
global portraitimages;
portraitimages = zeros(MyJpgPortraitsFilesQuantity, 10000);
global pictureimages;
pictureimages = zeros(MyJpgPicturesFilesQuantity, 10000);


%notpreparedimages - массив палитровых изображений, готовых к отображению на экране в качестве ответа
%Первая координата - номер изображения
%Вторая и третья координаты - координаты пикселя данного изображения
%Значение массива - цвет данного пикселя данного изображения
global notpreparedportraitimages;
notpreparedportraitimages = zeros(MyJpgPortraitsFilesQuantity, 100, 100, 1);
global notpreparedpictureimages;
notpreparedpictureimages = zeros(MyJpgPicturesFilesQuantity, 100, 100, 1);

%V -  массив, хранящий  изображение. Необходим для заполнения
%массива images
%Второй индекс V - номер элемента бинарной комбинации.
%Третий индекс V - цвет изображения
%Значение V - значение элемента бинарной комбинации
V = zeros(1, 10000, 1);
%V = double(V);



%Работа с каждым эталонным изображением
for i = 1 : MyJpgPortraitsFilesQuantity
	%Получение набора из трех двумерных массивов, взятых из jpg-файла. Каждый массив отвечает за
	%интенсивность красного, зеленого и синего цвета каждого пикселя соответственно
	%После идет перевод изображения N*N к размеру 100*100 по методу ближайшего соседа
    MToDisplay=im2bw(imresize(imread(['Портреты/', MyJpgPortraitsFiles(i).name]), [100 100]), 0.5);

		
    %Перевод значений массива из типа uint8 в тип double
    %MToDisplay=double(MToDisplay);
	
   
    %Перевод массива в вектор-строку
    V(:,:,1)=reshape(MToDisplay, 1, 10000);
    
	
    %Перевод вектора-строки в бинарную вектор-строку
	for m=1:1:10000
		portraitimages(i, m)=~V(1,m,1);
    end
	
	%for j = 1:3
    %    for k=1:10000
    %        images(i,palitra*3*(k-1) + fix(V(1, k, j)/(256/palitra)) + palitra*(j-1) + 1) = true;
    %    end
    %end
	
    %Сохранение изображения массива для вывода (если тестовое изображение будет распознано)
	notpreparedportraitimages(i, :, :, 1)=MToDisplay;
end

notpreparedportraitimages=logical(notpreparedportraitimages);

%Работа с каждым эталонным изображением
for i = 1 : MyJpgPicturesFilesQuantity
	%Получение набора из трех двумерных массивов, взятых из jpg-файла. Каждый массив отвечает за
	%интенсивность красного, зеленого и синего цвета каждого пикселя соответственно
	%После идет перевод изображения N*N к размеру 100*100 по методу ближайшего соседа
    MToDisplay=im2bw(imresize(imread(['Картины/', MyJpgPicturesFiles(i).name]), [100 100]), 0.5);

		
    %Перевод значений массива из типа uint8 в тип double
    %MToDisplay=double(MToDisplay);
	
   
    %Перевод массива в вектор-строку
    V(:,:,1)=reshape(MToDisplay, 1, 10000);
    
	
    %Перевод вектора-строки в бинарную вектор-строку
	for m=1:1:10000
		pictureimages(i, m)=~V(1,m,1);
    end
	
	%for j = 1:3
    %    for k=1:10000
    %        images(i,palitra*3*(k-1) + fix(V(1, k, j)/(256/palitra)) + palitra*(j-1) + 1) = true;
    %    end
    %end
	
    %Сохранение изображения массива для вывода (если тестовое изображение будет распознано)
	notpreparedpictureimages(i, :, :, 1)=MToDisplay;
end

notpreparedpictureimages=logical(notpreparedpictureimages);


% Перевод images к типу double
portraitimages=double(portraitimages);
pictureimages=double(pictureimages);

% Описание эталонных портретов писателей и картин
global portraitanswers;
portraitanswers=[];
global pictureanswers;
pictureanswers=[];


MyTxtPortraitFiles=dir('Портреты (описание)/*.txt');
MyTxtPortraitFilesQuantity=length(MyTxtPortraitFiles);
for i = 1 : MyTxtPortraitFilesQuantity
	fileID = fopen(['Портреты (описание)/', MyTxtPortraitFiles(i).name]);
	buf = textscan(fileID, '%s','delimiter','\n');
	portraitanswers{i} = buf{1};
	fclose(fileID);
end

MyTxtPictureFiles=dir('Картины (описание)/*.txt');
MyTxtPictureFilesQuantity=length(MyTxtPictureFiles);
for i = 1 : MyTxtPictureFilesQuantity
	fileID = fopen(['Картины (описание)/', MyTxtPictureFiles(i).name]);
	buf = textscan(fileID, '%s','delimiter','\n');
	pictureanswers{i} = buf{1};
	fclose(fileID);
end


% Описание эталонных портретов писателей 

MainMenu;