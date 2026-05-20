# Mathematics Reference & Packages Guide

Welcome to your Neovim Mathematics environment guide. This guide explains how to use your LaTeX snippets and Python packages (`sympy`, `numpy`, `scipy`, `matplotlib`) for your math courses: **Linear Algebra, Differential Equations, and Calculus (1-4)**.

---

## 🧮 How to Use LaTeX Math Snippets

Your snippets are configured as **autosnippets** in `luasnip`. They will trigger automatically as you type, but they **must be inside a LaTeX math zone** (between `$...$`, `$$...$$`, or within environments like `\begin{equation}`).

### 1. Limits & Derivatives
*   `lim` $\to$ `\lim_{x \to \infty}`
*   `df` $\to$ `\dx{x}` (differential term)
*   `der` $\to$ Choice node:
    1. `\der{f(x)}{x}` $\to \frac{df(x)}{dx}$
    2. `\Der{f(x)}{x}` $\to \frac{\text{d}f(x)}{\text{d}x}$
*   `ndr` $\to$ Choice node for $n$-th derivatives: `\ndr{n}{f}{x}` $\to \frac{d^n f}{dx^n}$
*   `pdr` $\to$ Partial derivative: `\pdr{f}{x}` $\to \frac{\partial f}{\partial x}$
*   `npd` $\to$ $n$-th partial derivative: `\npd{n}{f}{x}` $\to \frac{\partial^n f}{\partial x^n}$

### 2. Integrals
*   `itn` $\to$ Standard integral `\int` or line integral `\oint`
*   `its` $\to$ Subscript integral `\int_{a}`
*   `itd` $\to$ Definite integral `\int_{a}^{b}`
*   `itbn` / `itbs` $\to$ Double integrals `\iint` or `\iint_{D}`
*   `ittn` / `itts` $\to$ Triple integrals `\iiint` or `\iiint_{V}`
*   `itmn` / `itms` $\to$ Multiple integrals `\idotsint` or `\idotsint_{V}`

### 3. Calculus 3 & Linear Algebra Specialties
*   `jac` $\to$ **Jacobian Determinant**:
    $$\det \mathbf{J} = \frac{\partial(x, y, z)}{\partial(u, v, w)}$$
*   `divth` $\to$ **Divergence Theorem**:
    $$\iiint_{V} (\nabla \cdot \mathbf{F}) \, dV = \iint_{\partial V} \mathbf{F} \cdot d\mathbf{S}$$
*   `stokes` $\to$ **Stokes' Theorem**:
    $$\iint_{\Sigma} (\nabla \times \mathbf{F}) \cdot d\mathbf{S} = \oint_{\partial \Sigma} \mathbf{F} \cdot d\mathbf{r}$$
*   `vv` $\to$ **Vector Formatting**: Choice of `\vv{x}` or `\vec{x}`.

### 4. Differential Equations
*   `laplace` $\to$ **Laplace Transform** definition:
    $$\mathcal{L}\{f(t)\} = \int_{0}^{\infty} f(t) e^{-st} \, dt$$

---

## 🐍 Python Math Packages Quick Reference

When you create a new Math file using `<leader>n` (or `:NewFile`), the script initializes with the following environment:
```python
import numpy as np
import sympy as sp
import matplotlib.pyplot as plt
from scipy import integrate, optimize, linalg

sp.init_printing(use_unicode=True)
x, y, z, t = sp.symbols('x y z t')
f, g, h = sp.symbols('f g h', cls=sp.Function)
```

Here is how to use these packages for each of your classes:

---

### 📐 Calculus 1 & 2 (Single-Variable)

#### Limits (SymPy)
Calculate $\lim_{x \to 0} \frac{\sin(x)}{x}$:
```python
sp.limit(sp.sin(x)/x, x, 0)
# Output: 1
```

#### Analytical Differentiation (SymPy)
Find the derivative of $\ln(x) \cdot e^x$:
```python
expr = sp.log(x) * sp.exp(x)
sp.diff(expr, x)
# Output: exp(x)/x + exp(x)*log(x)
```

#### Analytical Integration (SymPy)
Find the indefinite integral of $\int x^2 \cos(x) \, dx$:
```python
expr = x**2 * sp.cos(x)
sp.integrate(expr, x)
# Output: x**2*sin(x) + 2*x*cos(x) - 2*sin(x)
```

Evaluate definite integral $\int_0^\pi \sin(x) \, dx$:
```python
sp.integrate(sp.sin(x), (x, 0, sp.pi))
# Output: 2
```

#### Numerical Integration (SciPy)
For complex functions that cannot be integrated analytically, use `scipy.integrate.quad`:
```python
# Integrate e^(-x^2) from 0 to infinity
val, err = integrate.quad(lambda x: np.exp(-x**2), 0, np.inf)
print(f"Result: {val} (error estimate: {err})")
```

---

### 🌊 Calculus 3 (Multivariable & Vector)

#### Partial Derivatives (SymPy)
Find partial derivative of $f(x, y) = x^2 y + \sin(xy)$ with respect to $x$:
```python
expr = x**2 * y + sp.sin(x * y)
sp.diff(expr, x)
# Output: 2*x*y + y*cos(x*y)
```

#### Gradient, Divergence, and Curl (SymPy Vector)
```python
from sympy.vector import CoordSys3D
C = CoordSys3D('C')
# C.x, C.y, C.z are coordinates; C.i, C.j, C.k are unit vectors

# Find gradient of f = x*y^2*z
f = C.x * C.y**2 * C.z
grad_f = sp.vector.gradient(f)
```

#### Multiple Integrals (SciPy Numerical)
Evaluate double integral $\int_{0}^{1} \int_{0}^{2} (x^2 + y) \, dy \, dx$:
```python
# syntax: dblquad(func, x_lower, x_upper, y_lower_func, y_upper_func)
val, err = integrate.dblquad(lambda y, x: x**2 + y, 0, 1, lambda x: 0, lambda x: 2)
```

---

### 🤖 Linear Algebra

#### Matrix Definition & Operations (SymPy for Symbolics, NumPy for Numerical)
```python
# Symbolic Matrix (SymPy)
A = sp.Matrix([[1, 2], [3, 4]])

# Determinant & Inverse
det_A = A.det()
inv_A = A.inv()

# Eigenvalues & Eigenvectors
A.eigenvals()    # Returns {val: multiplicity}
A.eigenvects()   # Returns eigenvalues, multiplicities, and eigenspaces
```

```python
# Numerical Matrix (NumPy)
B = np.array([[1, 2], [3, 4]])

# Eigenvalues and Eigenvectors (NumPy)
eigenvalues, eigenvectors = np.linalg.eig(B)
```

#### Solving Linear Systems $A \mathbf{x} = \mathbf{b}$
Solve:
$$x + 2y = 5$$
$$3x + 4y = 11$$

```python
# SymPy (Symbolic)
A = sp.Matrix([[1, 2], [3, 4]])
b = sp.Matrix([5, 11])
x_sol = A.LUsolve(b) # Or A.solve(b)
```

```python
# NumPy (Numerical)
A_num = np.array([[1, 2], [3, 4]])
b_num = np.array([5, 11])
x_sol_num = np.linalg.solve(A_num, b_num)
```

---

### 📈 Differential Equations (Calc 4 / ODEs)

#### Analytical Solutions (SymPy)
Solve the first-order ODE: $y'(t) + y(t) = e^{-t}$ with $y(0) = 1$:
```python
# Define equation: y'(t) + y(t) - e^(-t) = 0
ode = sp.Eq(f(t).diff(t) + f(t), sp.exp(-t))

# General solution
gen_sol = sp.dsolve(ode, f(t))

# Particular solution with Initial Condition y(0) = 1
particular_sol = sp.dsolve(ode, f(t), ics={f(0): 1})
print(particular_sol)
# Output: Eq(f(t), (t + 1)*exp(-t))
```

#### Numerical Solutions (SciPy)
Solve the system of ODEs (e.g., Simple Harmonic Oscillator):
$$y'' + \omega^2 y = 0 \implies \begin{cases} y'_1 = y_2 \\ y'_2 = -\omega^2 y_1 \end{cases}$$

```python
omega = 2.0

def system(t, y):
    y1, y2 = y
    return [y2, -omega**2 * y1]

# Solve from t=0 to t=10, with initial condition y(0)=[1, 0]
t_span = (0, 10)
y0 = [1.0, 0.0]
sol = integrate.solve_ivp(system, t_span, y0, t_eval=np.linspace(0, 10, 100))

# Plot the results
plt.plot(sol.t, sol.y[0], label='Position (y1)')
plt.plot(sol.t, sol.y[1], label='Velocity (y2)')
plt.legend()
plt.grid(True)
plt.title("Harmonic Oscillator Numerical Solution")
plt.show()
```
