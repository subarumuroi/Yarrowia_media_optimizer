using ProgrammaticPipetting, CSV, DataFrames, XLSX

#fname = path_example_xlsx()

fname = "Yarrowia_gp_pretest_1.xlsx"

#fname = "test-pipette-data-yarrowia1.xlsx"
df_pipette = estimate_pipette_volumes(fname)

#names(df_pipette)

#names(df_pipette)[2]

#sum(df_pipette[:, 2:end], dims = 2)


#CSV.write("Yarrowia_experiment_1_stock_matrix.csv", df_pipette)

# Load flowbot deck layout
fname1 = "deck_yarrow_1.csv"
df_deck = load_flowbot_deck(fname1)

# Replicates
replicates = 3

# Dead volume (make a bit more media than required in df_pipette)
#dead_vol_ml = (sum(df_pipette[1, 2:end]) - 2500 * replicates) / 1000

# df_1: flowbot instructions for stocks to pooled replicates
# df_2: flowbot instructions for pooled replicates to individual replicates
# Maps: mapping of stocks/pooled replicates/individual wells on the plates
df_1, df_2, maps, map_names = make_flowbot_protocol_001(#
    df_pipette,
    df_deck,
    well_vol_ml = 2.5, # final volume in 24-well plates
    dead_vol_ml = 0.0; # deprecated
    tip_min_vol_μl = 100.0,
    tip_max_vol_μl = 1000.0,
    replicates = replicates
)

df_1b, df_2b, maps_b, map_names_b = make_flowbot_protocol_001(#
    df_pipette,
    df_deck,
    well_vol_ml = 0.3, # final volume in 24-well plates
    dead_vol_ml = 0.0; # deprecated
    tip_min_vol_μl = 100.0,
    tip_max_vol_μl = 1000.0,
    replicates = replicates
)


# Export dataframes to CSV file
CSV.write("flowtest1_1.csv", df_1)
CSV.write("flowtest1_2.csv", df_2)

# Export a mapping of the plates and the positions of the stocks/replicates
write_flowbot_maps("flowtest1.xlsx", maps, map_names)