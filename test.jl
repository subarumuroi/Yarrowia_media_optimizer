using ProgrammaticPipetting, CSV, DataFrames, XLSX

fname = "test-pipette-data-yarrowia1.xlsx"

df_pipette = estimate_pipette_volumes(fname)

