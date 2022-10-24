from copy import deepcopy
from itertools import permutations
from functools import  reduce
import random

def knut_maxmin(check, all_hiddens, results, cur_hiddens):
    if attempts == 0:
        return next(iter(cur_hiddens))

    return max(
        [(a,min(
            [sum(1 for _ in 
                filter(lambda c: check(a, c) != r, 
                    list(cur_hiddens)),
            ) for r in results]
        )) for a in list(all_hiddens)], 
        key = lambda p: p[1] )[0]

def knut_cur_maxmin(check, all_hiddens, results, cur_hiddens):
    if attempts == 0:
        return next(iter(cur_hiddens))

    return max(
        [(a,min(
            [sum(1 for _ in 
                filter(lambda c: check(a, c) != r, 
                    list(cur_hiddens)),
            ) for r in results]
        )) for a in list(cur_hiddens)], 
        key = lambda p: p[1] )[0]

def next_strategy(cur_hiddens):
    return next(iter(cur_hiddens))

def iter_game(all_hiddens, results, check, dialog, cur_hiddens):
    atempt = knut_cur_maxmin(check, all_hiddens, results, cur_hiddens)
    # atempt = next_strategy(cur_hiddens)

    result = dialog(atempt)
    if result is True:
        return atempt

    cur_hiddens = filter(
        lambda c: result == check(c, atempt),
        deepcopy(cur_hiddens)
    )
    return iter_game(all_hiddens, results, check, dialog, cur_hiddens)


if __name__ == '__main__':
    length = 4
    hiddens = map(
        lambda comb: reduce(lambda x, y: x + y, comb),
        permutations('0123456789', length)
    )
    hiddens = list(hiddens)
    answer = random.choices(hiddens)[0]
    print(answer)
    attempts = 0

    def check(hidden, answer):
        if hidden == answer:
            return True
        buf = len(list(
            filter(lambda l: l[0] == l[1], zip(hidden, answer))
        ))
        cow = len(hidden) + len(answer) - buf - len(set(hidden + answer))
        return buf, cow

    def dialog(atempt):
        global attempts
        attempts += 1
        res = input(f'{attempts}) {atempt}? ')
        try:
            res = tuple(map(int, res.split(' ')))
            assert len(res) == 2
            assert 0<=res[0]
            assert 0<=res[1]
            assert res[0]+res[1]<=length
        except (ValueError, AssertionError):
            print('Попробуйте ещё раз')
            return dialog(atempt)
        if res == (length,0):
            return True
        return res

    
    # def dialog(atempt):
    #     global attempts
    #     attempts += 1
    #     print(atempt)
    #     return check(atempt,answer)
  

    results = [(i, j) for i in range(length + 1) for j in range(length + 1 - i)]

    print(
        f'Игра "Быки и коровы"! \n\
        \nЗагадайте число, а я попробую угадать'
    )

    x = iter_game(hiddens, results, check, dialog, deepcopy(hiddens))
    print(f'Ура, я угадал {x} за {attempts} попыток!')
