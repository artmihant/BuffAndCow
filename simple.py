def guess_the_number(a,b):
    if a == b:
        print(f'Это точно {a}.')
        return a
    x = a + (b-a)//2
    res = input(f'Это {x}? ')
    if res == '>':
        return guess_the_number(x,b)
    if res == '<':
        return guess_the_number(a,x)
    if res == '=':
        return x
    print(
        '> если больше, = если равно, < если меньше \
        Попробуйте ещё раз'
    )
    return guess_the_number(a,b)
       


if __name__ == '__main__':
    min_num = 1
    max_num = 100
    print(
        f'Игра "Угадай число"! \n\
        \nЗагадайте число от {min_num} до {max_num}, а я попробую угадать \
        \nВводите > если больше, = если равно, < если меньше\n'
    )
    x = guess_the_number(min_num, max_num)
    print(f'Ура, я угадал {x}!')