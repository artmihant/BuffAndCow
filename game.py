import itertools as it
from typing import Tuple
from alg import game, iter_game
from functools import reduce

count1 = 6

set1 = map(
    lambda comb: reduce(lambda x, y: x + y, comb),
    it.permutations('12345678', count1))

res1 = [(i, j) for i in range(count1 + 1) for j in range(count1 + 1 - i)]


def check1(a: str, b: str) -> Tuple[int, int]:
    buf = len(list(
        filter(lambda l: l[0] == l[1], zip(a, b))
    ))
    cow = len(a) + len(b) - buf - len(set(a + b))
    return buf, cow


def dialog1(atempt, power):
    testanswer = reduce(lambda x, y: x + y,
                        list(map(str, range(count1, 0, -1))))
    # r = check1(atempt, testanswer)
    r = tuple(map(int,input(f'({power}) {atempt}: ').split(' ')))
    # print(r)

    if r == (count1, 0):
        return True
    return r


set2 = range(1, 1000)

res2 = [True, False]


def check2(a: int, b: int) -> bool:
    return a < b


def dialog2(atempt, count_var):
    testanswer = 777
    print(f'{atempt} ({count_var})')
    # return bool(int(input('1 если больше, 0 если меньше либо равно:')))
    return check2(atempt, testanswer)


count3 = 10

set3 = map(
    lambda comb: reduce(lambda x, y: x + y, comb),
    it.product('0123456789', repeat=count3))

res3 = range(0, count3 + 1)


def check3(a: str, b: str) -> int:
    buf = len(list(
        filter(lambda l: l[0] == l[1], zip(a, b))
    ))
    return buf


def dialog3(atempt):
    testanswer = '1123581321'
    r = check3(atempt, testanswer)
    print(f'{atempt} {r}')
    if r == count3:
        return True
    return r
    # return int(input(f'{atempt} : '))


if __name__ == '__main__':
    res = game(set1, check1, dialog1, res1)
    if res[0]:
        print(f'Ваше число {res[0]} отгадано за {res[1]} попыток!')
    else:
        print(f'Где-то ошибка...')

        # print(game(set2, check2, dialog2, res2))
