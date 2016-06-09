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
% БК стихотворения
testbk = zeros(wordlength*33*32, 1);
% объединяем БК строк в БК стихотворения
for i = 1 : 16
    testbk((i-1)*wordlength*2*33+1 : i*wordlength*2*33) ...
        = linesbk{i};
end
% распознаем стихотворение и выводим ответ
lastlayer(poemsmatrix, testbk, threshold, poemstext);
