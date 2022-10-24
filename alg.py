import random


def knut_maxmin(cur_variables, check, res_variables):
    points = [(s,
       min([
           len(list(
               filter(lambda x: check(s, x) != r, cur_variables)
           ))
           for r in res_variables
       ]))
    for s in cur_variables]
    return max(points, key = lambda p: p[1])[0]


def iter_game(all_variables, check, dialog):
    i = 0
    cur_variables = all_variables
    while True:

        try:
            atempt = next(cur_variables)
        except StopIteration:
            return (None, i)

        i += 1

        res = dialog(atempt)
        if res is True:
            return (atempt, i)

        cur_variables = filter(
            lambda answer: res == check(atempt, answer),
            cur_variables
        )


def game(all_variables, check, dialog, res_variables):
    i = 0
    cur_variables = list(all_variables)
    while True:
        if len(cur_variables) <= 0:
            return (None, i)
        elif len(cur_variables) == 1:
            return (cur_variables[0], i)

        i += 1

        if len(cur_variables)**2 > 10**6:
            atempt = random.choice(cur_variables)
        else:
            atempt = knut_maxmin(cur_variables, check, res_variables)
        res = dialog(atempt, len(cur_variables))

        cur_variables = list(filter(
            lambda answer: res == check(atempt, answer),
            cur_variables
        ))
