
% функция принимает предложение и длину слов
% и возвращает бинарную комбинацию
function [bk] = tobk(sentence, wordlength)
if nargout ~= 1 || nargin ~= 2 || ~ischar(sentence) ... 
    || wordlength < 1
    error('Неверные параметры');
end
% бинарная комбинация
bk = zeros(1, 33*wordlength*2);
% если строка пуста, то ее БК состоит из нулей
if isempty(sentence)
    return;
end
% разделяем предложение на слова

words = tokenizeString(sentence, ' ,–-—!?"():;.…');
%words = textscan(sentence, ['%', int2str(2*wordlength), 's'], ...
%    'Delimiter', ' ,–-—!?"():;.…');

for i = 1 : length(words)
    % один символ _ заменяем на целое слово из _
    if ~isempty(words{i}) && words{i}(1) == '_'
        for j = 2 : wordlength
            words{i}(j) = '_';
        end
    end
    % если слово слишком длинное, выводим ошибку
    if length(words(i)) > wordlength
		
        error(['Слишком длинное слово: ', words(i)]);
    end
end
% новая строка со сгруппированными и дополненными словами
result = '';
% текущая максимальная длина новой строки
linelength = wordlength;
% пытаемся объединить слова в группы не более wordlength букв
% и дополняем их знаками ъ
for i = 1 : length(words)
    if length(result) + length(words{i}) > linelength
        for j = length(result) + 1 : linelength
            result(j) = 'ъ';
        end
        linelength = linelength + wordlength;
    end
    result = strcat(result, words{i});
end
% если строка получилась слишком длинной, выводим ошибку
if length(result) > wordlength*2
	result
	length(result)
    error(['Слишком длинная строка: ', sentence]);
end
% дополняем строку до нужной длины
for j = length(result) + 1 : wordlength*2
    result(j) = 'ъ';
end
% переводим предложение в бинарную комбинацию
for i = 1 : 2*wordlength
    if (result(i) >= 'а' && result(i) <= 'е')
        bk(33*(i-1)+result(i)-'а'+1) = 1;
    elseif (result(i) == 'ё')
        bk(33*(i-1)+8) = 1;
    elseif (result(i) >= 'ж' && result(i) <= 'я')
        bk(33*(i-1)+result(i)-'а'+2) = 1;
    elseif (result(i) >= 'А' && result(i) <= 'Е')
        bk(33*(i-1)+result(i)-'А'+1) = 1;
    elseif (result(i) == 'Ё')
        bk(33*(i-1)+8) = 1;
    elseif (result(i) >= 'Ж' && result(i) <= 'Я')
        bk(33*(i-1)+result(i)-'А'+2) = 1;
    elseif (result(i) == 'р' || result(i) == 'Р')
        bk(33*(i-1)+18) = 1;
    end
end
