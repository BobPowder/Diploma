%Очистка памяти перед выполнением программы
clear;
%Ввод пользователем количество градаций серого цвета
palitra=input('Введите количество оттенков красного, зеленого и синего цвета, участвующие в палитре: ');

%Создание палитры
map=zeros(palitra^3, 3);
for k=1:palitra
    for j=1:palitra
        for i=1:palitra
            map((k-1)*palitra^2+(j-1)*palitra+i, 1)=double((i-1)/(palitra-1));
            map((k-1)*palitra^2+(j-1)*palitra+i, 2)=double((j-1)/(palitra-1));
            map((k-1)*palitra^2+(j-1)*palitra+i, 3)=double((k-1)/(palitra-1));
        end
    end
end


%Создание пустых массивов
images = zeros(38, 10000);
notpreparedimages = zeros(38, 100, 100);


%Работа с каждым эталонным изображением
for i = 1 : 38
    %Получение палитрового изображения 100*100 с палитрой map
    MToDisplay=rgb2ind(imresize(imread(['E:\MatlabWriters\Разные\', ...
        int2str(i), '.jpg']), [100 100]), map, 'nodither' );

    %Сохранение изображений в папку 
    imwrite(MToDisplay, map, ['E:\MatlabWriters\Палитровые\', ...
        int2str(i), '.jpg']);
    %Сохранение изображения массива, для вывода(если тестовое изображение будет распознано) 
    notpreparedimages(i,:,:)=MToDisplay(:, :);
    %Перевод массива в вектор-строку
    images(i,:)=reshape(MToDisplay, 1, 10000);
end

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
answers{19}  = '19.   Ушинский';
answers{20}  = '20.   Некрасов';
answers{21}  = '21.   Пушкин';
answers{22}  = '22.   Куприн';
answers{23}  = '23.   Варламов';
answers{24}  = '24.   Островский';
answers{25}  = '25.   Ахматова';
answers{26}  = '26.   Маяковский';
answers{27}  = '27.   Блок';
answers{28}  = '28.   Державин';
answers{29}  = '29.   Лермонтов';
answers{30}  = '30.   Есенин';
answers{31}  = '31.   Цветаева';
answers{32}  = '32.   Суриков';
answers{33}  = '33.   Лермонтов';
answers{34}  = '34.   Крылов';
answers{35}  = '35.   Бунин';
answers{36}  = '36.   Тютчев';
answers{37}  = '37.   Ершов';
answers{38}  = '38.   Толстой';
   
%transposedimages=images.'
%mat=images*transposedimages;
%[x,y]=meshgrid(1:1:38, 1:1:38);
%surf(x,y,mat);

%Работа с тестовым изображением (аналогичное работе с эталонным)
testimage=reshape(rgb2ind(imresize(imread(['E:\MatlabWriters\Разные\test', ...
    '.jpg']), [100 100]), map, 'nodither' ), 10000, 1);

% Вычисляем степень соответствия эталонных изображений тестовому
res = zeros(10000, 1);
for i = 1 : 38
    for j = 1 : length(testimage)
        if (images(i, j) == testimage(j,1)) 
            res(i, 1) =  res(i, 1) + 1;
        end
    end 
end

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