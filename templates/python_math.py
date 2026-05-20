# Mathematics & Calculus Script
# Created on {{DATE}}

import numpy as np
import sympy as sp
import matplotlib.pyplot as plt
from scipy import integrate, optimize, linalg

# Enable pretty printing for SymPy symbols
sp.init_printing(use_unicode=True)

# Define common SymPy symbols
x, y, z, t = sp.symbols('x y z t')
f, g, h = sp.symbols('f g h', cls=sp.Function)

print('--- Mathematics Environment Loaded ---')
