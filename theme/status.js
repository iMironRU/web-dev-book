document.addEventListener('DOMContentLoaded', function () {
    var host = document.querySelector('main');
    if (!host) return;
    var b = document.createElement('div');
    b.className = 'book-status book-status--stub';
    b.textContent = "Это пока заготовка. Структура книги есть, текст ещё не написан — смотреть имеет смысл только оглавление.";
    host.insertBefore(b, host.firstChild);
});
