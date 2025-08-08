import gurobipy as gp
from gurobipy import GRB

model = gp.Model("test")
x = model.addVar(name="x")
y = model.addVar(name="y")
model.setObjective(x + y, GRB.MAXIMIZE)
model.addConstr(x + 2*y <= 4, "c0")
model.optimize()

for v in model.getVars():
    print(f"{v.varName} = {v.x}")
print(f"Objective Value = {model.objVal}")
