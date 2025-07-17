using ProgrammaticPipetting, CSV, DataFrames, XLSX

#fname = "Yarrowia_gp_pretest_1.xlsx"
#fname = path_example_xlsx()
fname = "test-pipette-data-yarrowia1.xlsx"
df_pipette = estimate_pipette_volumes(fname)

#names(df_pipette)

#names(df_pipette)[2]

#sum(df_pipette[:, 2:end], dims = 2)


CSV.write("Yarrowia_experiment_1_stock_matrix.csv", df_pipette)

