
% функция принимает на вход имя файла стихотворения и длину слов
% и возвращает его текст и бинарные комбинации для строк
function [poem, poembk] = openpoem(filename, wordlength)
if nargout > 2 || nargin ~= 2 || ~ischar(filename) ...
        || isempty(filename) || wordlength < 1
    error('Неверные параметры');
end
% открываем файл со стихотворением
[poemfile, err] = fopen(filename, 'rt');
if ~isempty(err)
    error([filename, ': ', err]);
end
% строки стихотворения
poem{16} = [];
% бинарные комбинации для строк
poembk{16} = [];
poem = textscan(poemfile, '%s','delimiter','\n');
for i = 1 : 16
	% записываем каждую строку в массив
    %poem{i} = fgetl(poemfile);
    % в другой массив пишем БК
    poembk{i} = tobk(poem{1}{i}, wordlength);
end
% закрываем файл
fclose(poemfile);
poem=poem{1};
