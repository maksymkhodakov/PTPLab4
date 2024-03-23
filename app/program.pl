% Перевірка, чи всі правила з одним нетерміналом починаються з різних терміналів.
is_korenyak_grammar(Nonterminals) :-
    check_rules(Nonterminals).

% Для кожного нетерміналу перевірити правила.
check_rules([]).
check_rules([N | Rest]) :-
    findall(FirstSymbol, (rule(N, [FirstSymbol | _]), terminal(FirstSymbol)), FirstSymbols),
    all_unique(FirstSymbols),
    check_rules(Rest).

% Перевірка на унікальність перших символів.
all_unique([]).
all_unique([X | Xs]) :-
    \+ member(X, Xs),
    all_unique(Xs).

% Функція для користувацького вводу.
iskorenyak(Nonterminals, Terminals, Rules) :-
    assert_nonterminals(Nonterminals),
    assert_terminals(Terminals),
    assert_rules(Rules),
    is_korenyak_grammar(Nonterminals),
    retract_rules(Rules),
    retract_nonterminals(Nonterminals),
    retract_terminals(Terminals).

% Додавання нетерміналів до бази даних.
assert_nonterminals([]).
assert_nonterminals([N | Rest]) :-
    assertz(nonterminal(N)),
    assert_nonterminals(Rest).

% Додавання терміналів до бази даних.
assert_terminals([]).
assert_terminals([T | Rest]) :-
    assertz(terminal(T)),
    assert_terminals(Rest).

% Додавання правил до бази даних.
assert_rules([]).
assert_rules([N -> R | Rest]) :-
    assertz(rule(N, R)),
    assert_rules(Rest).

% Видалення нетерміналів з бази даних.
retract_nonterminals([]).
retract_nonterminals([N | Rest]) :-
    retract(nonterminal(N)),
    retract_nonterminals(Rest).

% Видалення терміналів з бази даних.
retract_terminals([]).
retract_terminals([T | Rest]) :-
    retract(terminal(T)),
    retract_terminals(Rest).

% Видалення правил з бази даних.
retract_rules([]).
retract_rules([N -> R | Rest]) :-
    retract(rule(N, R)),
    retract_rules(Rest).
