% длина слова
wordlength = 8;
% бинарные комбинации для слов эталонных стихотворений
% 1 измерение - количество стихотворений
% 2 измерение - длина БК слова
% 3 измерение - количество слов в стихотворении
wordsmatrix = zeros(20, wordlength*33, 32);
% тексты стихотворений
poemstext = cell(1, 20);
for i = 1 : 20
    % сохраняем БК и тексты в массивы
    [poemstext{i}, poembk] = ...
        openpoem(['poetry/', int2str(i), '.txt'], wordlength);
    % рзбиваем БК строк на БК слов
    for k = 1 : 16
        wordsmatrix(i, :, k*2-1) = poembk{k}(1:wordlength*33);
        wordsmatrix(i, :, k*2) ...
            = poembk{k}(wordlength*33+1 : wordlength*2*33);
    end
end
% бинарные комбинации для четверостиший эталонных стихотворений
% 1 измерение - количество стихотворений
% 2 измерение - длина БК четверостишия
% 3 измерение - количество четверостиший в стихотворении
quatrainsmatrix = zeros(20, 20*8, 4);
% записываем БК
for i = 1 : 20
    for j = 1 : 8
        for k = 1 : 4
            quatrainsmatrix(i, (j-1)*20+i, k) = 1;
        end
    end
end
% бинарные комбинации стихотворений
% 1 - количество стихотворений
% 2 - общее число четверостиший
poemsmatrix = zeros(20, 20*4);
% записываем БК
for i = 1 : 20
    for j = 1 : 4
        poemsmatrix(i, (j-1)*20+i) = 1;
    end
end

% вводим стихотворение для распознавания, сохраняем БК его строк
% и порог
[linesbk, thresholds] = inputpoem(wordlength, 32);
% БК слов
testwordsmatrix = zeros(wordlength*33, 32);
% разбиваем БК строк на БК слов
for i = 1 : 16
    testwordsmatrix(:, i*2-1) = linesbk{i}(1:wordlength*33);
    testwordsmatrix(:, i*2) ...
        = linesbk{i}(wordlength*33+1 : wordlength*2*33);
end
% БК четверостиший
testquatrainsmatrix = zeros(20*8, 4);
% для каждого слова
for i = 1 : 32
    % перемножаем матрицу БК эталонных слов и тестового
    res = wordsmatrix(:, :, i) * testwordsmatrix(:, i);
    for j = 1 : length(res)
        % если совпало нужно количество букв
        if res(j) >= thresholds(i)
            % то записываем его в БК тестового четверостишия
            testquatrainsmatrix(mod(i+1,8)*20+j, ceil(i/8)) = 1;
        end
    end
end
% считаем БК проверямого стихотворения
testpoembk = quatrainslayer(quatrainsmatrix, ...
    testquatrainsmatrix, [8 8 8 8]);
% распознаем стихотворение и выводим ответ
lastlayer(poemsmatrix, testpoembk, 4, poemstext);
