from copy import deepcopy

def knut_maxmin(check, all_hiddens, results, cur_hiddens):
    return max(
        [(a,min(
            [sum(1 for _ in 
                filter(lambda c: check(a, c) != r, 
                    deepcopy(cur_hiddens)),
            ) for r in results]
        )) for a in all_hiddens], 
        key = lambda p: p[1] )[0]


def iter_game(all_hiddens, results, check, dialog, cur_hiddens):
    atempt = knut_maxmin(check, all_hiddens, results, cur_hiddens)

    result = dialog(atempt)
    if result is True:
        return atempt

    cur_hiddens = filter(
        lambda c: result == check(c, atempt),
        cur_hiddens
    )
    return iter_game(all_hiddens, results, check, dialog, cur_hiddens)


if __name__ == '__main__':


    min_num = 1
    max_num = 100
    hiddens = range(min_num, max_num+1)
    results = ['>', '<']

    def check(hidden, answer):
        if hidden == answer:
            return True
        if hidden > answer:
            return '>'
        if hidden < answer:
            return '<'

    def dialog(atempt):
        res = input(f'Это {atempt}? ')
        if res == '=':
            return True
        if res in ('>','<'):
            return res
        print(
            '> если больше, = если равно, < если меньше \
            Попробуйте ещё раз'
        )
        return dialog(atempt)
    
    print(
        f'Игра "Угадай число"! \n\
        \nЗагадайте число от {min_num} до {max_num}, а я попробую угадать \
        \nВводите > если больше, = если равно, < если меньше\n'
    )

    x = iter_game(hiddens, results, check, dialog, hiddens)
    print(f'Ура, я угадал {x}!')
