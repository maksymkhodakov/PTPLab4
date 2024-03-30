% Факти залишаються незмінними
mushroom(lactarius, gilled, edible, red).
mushroom(leccinum, tubular, edible, green).
mushroom(lepiota, gilled, poisonous, red).
mushroom(lentinus, gilled, edible, green).
mushroom(lyophyllum, gilled, edible, blue).
mushroom(laccaria, gilled, edible, green).
mushroom(limacella, gilled, poisonous, green).
mushroom(lycoperdon, tubular, poisonous, blue).

% Правила
find_mushroom :-
    write('Enter mushroom type (gilled/tubular): '), read(Type),
    write('Is it edible or poisonous? '), read(Edibility),
    write('Enter cap color (red/green/blue): '), read(CapColor),
    mushroom(Name, Type, Edibility, CapColor),
    write('The mushroom you are looking for might be: '), write(Name), nl.

% Якщо немає відповідностей
find_mushroom :-
    write('No mushrooms found matching those characteristics.'), nl.
