% длина слов в стихотворении
wordlength = 8;
% бинарные комбинации для четверостиший эталонных стихотворений
% 1 измерение - количество стихотворений
% 2 измерение - длина БК четверостишия
% 3 измерение - количество четверостиший в стихотворении
quatrainmatrix = zeros(20, 2*4*33*wordlength, 4);
% тексты стихотворений
poemstext = cell(1, 20);
for i = 1 : 20
    % сохраняем БК и тексты в массивы
    [poemstext{i}, poembk] = ...
        openpoem(['poetry/', int2str(i), '.txt'], wordlength);
    % объединяем БК строк в БК четверостиший
    for k = 1 : 4
        quatrainmatrix(i, :, k) ...
            = [poembk{(k-1)*4+1}, poembk{(k-1)*4+2}, ...
            poembk{(k-1)*4+3}, poembk{(k-1)*4+4}];
    end
end
% бинарные комбинации стихотворений
% 1 - количество стихотворений
% 2 - общее число четверостиший (длина БК стихотворения)
poemsmatrix = zeros(20, 20*4);
% записываем БК
for i = 1 : 20
    for j = 1 : 4
        poemsmatrix(i, (j-1)*20+i) = 1;
    end
end

% вводим стихотворение для распознавания, сохраняем БК его строк и
% пороги для четверостиший
[linesbk, thresholds] = inputpoem(wordlength, 4);
% БК четверостиший
testquatrainsbk = zeros(2*4*33*wordlength, 4);
% объединяем БК строк в БК четверостиший
for i = 1 : 4
    testquatrainsbk(:, i) = [linesbk{(i-1)*4+1}, ...
        linesbk{(i-1)*4+2}, linesbk{(i-1)*4+3}, ...
            linesbk{(i-1)*4+4}];
end
% считаем БК проверяемого стихотворения
testpoembk = quatrainslayer(quatrainmatrix, testquatrainsbk, ...
    thresholds);
% распознаем стихотворение и выводит ответ
lastlayer(poemsmatrix, testpoembk, 4, poemstext);
