% длина слов в стихотворении
wordlength = 9;
% бинарные комбинации эталонных стихотворений
% 1 измерение - количество стихотворений
% 2 измерение - длина БК стихотворения
poemsmatrix = zeros(20, wordlength*33*32);
% тексты стихотворений
poemstext = cell(1, 20);
for i = 1 : 20
    % сохраняем тексты и БК в массивы
    [poemstext{i}, poembk] = ...
        openpoem(['poetry/', int2str(i), '.txt'], wordlength);
    % составляем БК стихотворения из БК строк
    for j = 1 : 16
        poemsmatrix(i, ...
            (j-1)*wordlength*2*33+1 : j*wordlength*2*33) ...
                = poembk{j};
    end
end

% вводим стихотворение для распознавания, сохраняем БК его строк
% и порог
[linesbk, threshold] = inputpoem(wordlength, 1);

% Найдем первую ненулевую строку
for first = 1 : 16
	if  sum(linesbk{first})~=0
		break
	end
end
first
% Найдем последнюю ненулевую строку
for last = 1 : 16
	if  sum(linesbk{16-last+1})~=0
		break
	end
end
last=16-last+1

% БК стихотворения
testbk = zeros(wordlength*33*32, 1);
% объединяем БК строк в БК стихотворения
for i = 1 : 16
    testbk((i-1)*wordlength*2*33+1 : i*wordlength*2*33) ...
        = linesbk{i};
end

% Пробуем передивигать тестовое стихотворение
a=1;
while a<=16-(last-first)
	testbk = zeros(wordlength*33*32, 1);
	i=1;
	while i<=(last-first+1)
%		linesbk{first+i-a}
		testbk((i+a-2)*wordlength*2*33+1 : (i+a-1)*wordlength*2*33) ...
			= linesbk{first+i-1};
		i=i+1;
	end
	% распознаем стихотворение и выводим ответ
	result=lastlayer(poemsmatrix, testbk, threshold, poemstext);
	if (result==true)
		break;
	end;
	a=a+1;
end

if (result==false)
   disp('Стихотворение отсутствует в базе');
end


