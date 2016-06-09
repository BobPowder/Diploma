%Очистка памяти перед выполнением программы
clear;

%Стратегия - полноцветные
global strategy;
strategy=1; 

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

%portraitimages - массив эталонных изображений, переведенных в бинарную комбинацию.
%Первый индекс - номер изображения.
%Второй индекс - индекс бинарной комбинации, характеризующей данное изображение
%Значение массива - значение элемента данной бинарной комбинации, характеризующей данное изображение
global portraitimages;
portraitimages = zeros(MyJpgPortraitsFilesQuantity, 10000*palitra*3);
global pictureimages;
pictureimages = zeros(MyJpgPicturesFilesQuantity, 10000*palitra*3);

%notpreparedimages - массив палитровых изображений, готовых к отображению на экране в качестве ответа
%Первая координата - номер изображения
%Вторая и третья координаты - координаты пикселя данного изображения
%Значение массива - цвет данного пикселя данного изображения
global notpreparedportraitimages;
notpreparedportraitimages = zeros(MyJpgPortraitsFilesQuantity, 100, 100, 3);
global notpreparedpictureimages;
notpreparedpictureimages = zeros(MyJpgPicturesFilesQuantity, 100, 100, 3);

%V -  массив, хранящий  изображение. Необходим для заполнения
%массива portraitimages
%Второй индекс V - номер элемента бинарной комбинации.
%Третий индекс V - цвет изображения
%Значение V - значение элемента бинарной комбинации
V = zeros(1, 10000, 3);
%V = double(V);



%Работа с каждым эталонным изображением
for i = 1 : MyJpgPortraitsFilesQuantity
	%Получение набора из трех двумерных массивов, взятых из jpg-файла. Каждый массив отвечает за
	%интенсивность красного, зеленого и синего цвета каждого пикселя соответственно
	%После идет перевод изображения N*N к размеру 100*100 по методу ближайшего соседа
    MToDisplay=imresize(imread(['Портреты/', MyJpgPortraitsFiles(i).name]), [100 100]);

    %Сохранение изображений в папку, чтобы убедиться, что все полноветные изображения приведены к палитровым
    %imwrite(MToDisplay, ['Палитровые\', int2str(i), '.jpg']);
		
    %Перевод значений массива из типа uint8 в тип double
    %MToDisplay=double(MToDisplay);
	
   
    %Перевод массива в вектор-строку
    for x = 1 : 3
        V(:,:,x)=reshape(MToDisplay(:, :, x), 1, 10000);
    end
	
    %Перевод вектора-строки в бинарную вектор-строку
    for j = 1:3
        for k=1:10000
            portraitimages(i,palitra*3*(k-1) + fix(V(1, k, j)/(256/palitra)) + palitra*(j-1) + 1) = true;
        end
    end

    %Сохранение изображения массива для вывода (если тестовое изображение будет распознано) 
    for j = 1:3
        for k=1:100
            for l=1:100
                notpreparedportraitimages(i,k,l,j)=fix(MToDisplay(k, l, j)/(256/palitra))*fix(256/palitra);
            end
        end
    end
end

%Работа с каждым эталонным изображением
for i = 1 : MyJpgPicturesFilesQuantity
	%Получение набора из трех двумерных массивов, взятых из jpg-файла. Каждый массив отвечает за
	%интенсивность красного, зеленого и синего цвета каждого пикселя соответственно
	%После идет перевод изображения N*N к размеру 100*100 по методу ближайшего соседа
    MToDisplay=imresize(imread(['Картины/', MyJpgPicturesFiles(i).name]), [100 100]);

    %Сохранение изображений в папку, чтобы убедиться, что все полноветные изображения приведены к палитровым
    %imwrite(MToDisplay, ['Палитровые\', int2str(i), '.jpg']);
		
    %Перевод значений массива из типа uint8 в тип double
    %MToDisplay=double(MToDisplay);
	
   
    %Перевод массива в вектор-строку
    for x = 1 : 3
        V(:,:,x)=reshape(MToDisplay(:, :, x), 1, 10000);
    end
	
    %Перевод вектора-строки в бинарную вектор-строку
    for j = 1:3
        for k=1:10000
            pictureimages(i,palitra*3*(k-1) + fix(V(1, k, j)/(256/palitra)) + palitra*(j-1) + 1) = true;
        end
    end

    %Сохранение изображения массива для вывода (если тестовое изображение будет распознано) 
    for j = 1:3
        for k=1:100
            for l=1:100
                notpreparedpictureimages(i,k,l,j)=fix(MToDisplay(k, l, j)/(256/palitra))*fix(256/palitra);
            end
        end
    end
end


% Перевод images к типу double
portraitimages=double(portraitimages);
pictureimages=double(pictureimages);

%pictureimages(1:100)

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