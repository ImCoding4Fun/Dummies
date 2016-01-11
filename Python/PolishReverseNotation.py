# a simple reverse-polish notation calculator
#
# shouldn't be too hard to extend this--variables seem like a natural progression

import operator

def error_string(token, values):
    plural = ''
    if values > 1:
        plural = 's'

    return 'Error: %s takes %d value%s.' % (token, values, plural)

stack = []
operators = {
        '+': [operator.add, 2],
        '-': [operator.sub, 2],
        '*': [operator.mul, 2],
        '/': [operator.truediv, 2],
        '^': [operator.pow, 2],
        '%': [operator.mod, 2],
        '_': [lambda x: -x, 1],
        }

if __name__ == '__main__':
    while True:
        expression = input('# ')
        
        if expression in ('q', 'quit', 'exit', ''):
            break
        
        for token in expression.split():
            if token in operators:
                try:
                    if operators[token][1] == 1:
                        stack.append(operators[token][0](stack.pop()))
                    elif operators[token][1] == 2:
                        stack.append(operators[token][0](stack.pop(-2), stack.pop()))
                except:
                    error_string(token, operators[token][1])
            else:
                try:
                    stack.append(float(token))
                except ValueError:
                    print ('Error: only real numbers or %s.' % ''.join(operators.keys()))

        if len(stack) == 1:
            print(str(stack.pop()))
        else:
            print('Error: badly formed.')