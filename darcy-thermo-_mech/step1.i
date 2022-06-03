[Mesh]
  type = GeneratedMesh # Can generate simple lines, rectangles, and rectangular prisms
  dim = 2 #
  nx = 100 #
  ny = 10 #
  xmax = 0.304 #
  ymax = 0.0257 #
[]

[Variables]
  [pressure]
    # Adds a Linear Lagrange variable by default
  []
[]

[Kernels]
  [diffusion]
    type = ADDiffusion # Lapplacian opperator using automatic differentiation
    vairable = pressure # Operate on teh "pressure" variable from above
  []
[]

[BCs]
  [inlet]
  type = DirichletBC # Simple u=value BC
  variable = pressure # Variable to be set
  boundary = left # Name of sideset in the mesh
  value = 4000 # (Pa) From Figure 2 from paper. First data point for 1mm spheres
  []
  [outlet]
    type = DirichletBC
    variable = pressure
    boundary = right
    value = 0 # (Pa) Gives the correct pressure dop from Figure 2 for 1mm spheres
  []
[]

[Problem]
  type = FEProblem # This is the default type of Finite element Problem in MOOSE
  coord_type = RZ # Axisymmetric RZ, this is a change from the default
  rz_coord_axis = X # Which axis the symmetry is around
[]

[Executioner]
  type = Steady # Steady state problem
  solve_type = NEWTON # Perform a Newton solve, uses AD to compute Jacobian terms
  petsc_options_iname = '-pc_type -pc_hypre_type' # PETSc option pairs with values below
  petsc_options_value = 'hypre boomeramg'
[]

[Outputs]
  exodus = true # Output Exodus format
[]