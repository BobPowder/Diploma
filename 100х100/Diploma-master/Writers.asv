%Ввод пользователем количество градаций серого цвета
palitra=input('Введите количество градаций серого');

%Создание пустых массивов
images = zeros(18, 10000*palitra);
notpreparedimages = zeros(18, 100, 100);
Buf = zeros(1, 10000);

%Работа с каждым эталонным изображением
for i = 1 : 18
    %Получение палитрового изображения 100*100 с палитрой map
    [MToDisplay, map]=gray2ind(rgb2gray(imresize(imread(['E:\MatlabWriters\Разные\', ...
        int2str(i), '.jpg']), [100 100])), palitra);
    %Сохранение изображения в папку
    imwrite(MToDisplay, map, ['E:\MatlabWriters\Палитровые\', ...
        int2str(i), '.jpg']);
    %Перевод значений массива в тип double
    MToDisplay=double(MToDisplay);
    %Сохранение изображения массива, для вывода(если тестовое изображение будет распознано) 
    notpreparedimages(i,:,:)=MToDisplay;
    %Перевод массива в вектор-строку
    Buf=reshape(MToDisplay, 1, 10000);
    %Перевод вектора-строки в бинарную вектор-строку
    for m=1:1:10000
    images(i, (m-1)*palitra + Buf(1, m) + 1)=true;
    end
end
% Перевод к типу double
images=double(images);

% Описание эталонных портретов писателей 
answers{1}  = ['1.  Барто'];
answers{2}  = ['2.  Блок'];
answers{3}  = '3.   Брюсов';
answers{4}  = '4.   Бунин';
answers{5}  = '5.   Чехов';
answers{6}  = '6.   Чернышевский';
answers{7}  = ['7.  Державин'];
answers{8}  = ['8.  Гоголь'];
answers{9}  = '9.   Карамзин';
answers{10}  = ['10.  Крылов'];
answers{11}  = ['11.  Лермонтов'];
answers{12}  = '12.   Маршак';
answers{13}  = '13.   Маяковский';
answers{14}  = '14.   Некрасов';
answers{15}  = '15.   Пастернак';
answers{16}  = ['16.  Пушкин'];
answers{17}  = ['17.  Цветаева'];
answers{18}  = '18.   Тютчев';
   

%Работа с тестовым изображением (аналогичное работе с эталонным)
Buf=reshape(gray2ind(rgb2gray(imresize(imread(['E:\MatlabWriters\Разные\test', ...
    '.jpg']), [100 100])), palitra), 10000, 1);
Buf=double(Buf);
testimage = zeros(10000*palitra, 1);
for m=1:1:10000
testimage((m-1)*palitra + Buf(m, 1) + 1, 1)=true;
end
testimage=double(testimage);


% Перемножаем эталонные и тестовую БК
res = images * testimage;
% Ищем максимаьный элемент в полученном векторе
max = 0;
imax = 0;
for i = 1 : length(res)
    if res(i) > max
        max = res(i);
        imax = i;
    end;
end
%Назначаем порог схожести
threshold=9800;

if max > threshold
    %Выводим изображение, если порог превышен
     result = zeros(100, 100);
     for i=1:1:100
         result(i, :)=notpreparedimages(imax,i,:)
     end
     imshow(result, map);
    result = answers{imax};
else
    %Иначе изображение не распознано
    result = 'не удалось распознать';
end

disp (['Ответ: ', result]);