% функция принимает на вход длину слова
% и количество частей, на которые стихотворение будет разбито
% и возвращает БК его строк и значения порогов для частей
function [linesbk, thresholds] = inputpoem(wordlength, nbits)
% пороги для всех слов стихотворения
wordthresholds = zeros(1, 16*2);
% БК строк
linesbk{16} = [];
% просим ввести поочередно все строки стихотворения
for i = 1 : 16
    line = input(['Введите ', int2str(i), ...
        ' строку стихотворения: '], 's');
    if ~isempty(line)
        % если первое слово не пропущено, увеличиваем порог для него
        if line(1) ~= '_'
            wordthresholds(i*2-1) = wordlength;
        end
        % порог для второго слова
        if line(length(line)) ~= '_'
            wordthresholds(i*2) = wordlength;
        end
    end
    % сохраняем БК строки
    linesbk{i} = tobk(line, wordlength);
end
% пороги для частей стихотворения
thresholds = zeros(1, nbits);
% считаем пороги для частей стихотворения
for i = 1 : nbits
    % суммируем пороги входящих в текущую часть слов
    for j = 1 : 16*2 / nbits
        thresholds(i) = thresholds(i) ...
            + wordthresholds((i-1)*16*2/nbits + j);
    end
end
