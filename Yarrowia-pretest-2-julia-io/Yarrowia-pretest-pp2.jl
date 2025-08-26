### ----------------------------------------------------------------------------
## USER PARAMETERS
# Input spreadsheet of concentrations for the pipetting program to
# estimate the required stock solutions and construct the volume matrix
fname_concs = "./Yarrowia-pretest-2-julia-io/Yarrowia_gp_pretest_2.xlsx"

# Input deck layouts. The only difference is purpose == 3 for 24/96 well position
fname_24 = "./Yarrowia-pretest-2-julia-io/deck-yarrow-24-well.csv"
fname_96 = "./Yarrowia-pretest-2-julia-io/deck-yarrow-96-well.csv"

# Output files names

fname_pipette  = "./Yarrowia-pretest-2-julia-io/yarrowia-pretest-conc-volume-matrix.csv"
fname_part1    = "./Yarrowia-pretest-2-julia-io/yarrowia-pretest-flowbot-part-1-pooled.csv"
fname_part2_24 = "./Yarrowia-pretest-2-julia-io/yarrowia-pretest-flowbot-part-2-24well.csv"
fname_part2_96 = "./Yarrowia-pretest-2-julia-io/yarrowia-pretest-flowbot-part-2-96well.csv"
fname_deck_24  = "./Yarrowia-pretest-2-julia-io/yarrowia-pretest-flowbot-deck-tube-layout-24well.xlsx"
fname_deck_96  = "./Yarrowia-pretest-2-julia-io/yarrowia-pretest-flowbot-deck-tube-layout-96well.xlsx"

### ----------------------------------------------------------------------------

### -----------------------------------------------------------------------------
## DO NOT MODIFY
# Load required packages
using ProgrammaticPipetting, CSV, DataFrames

# Compute required stock solutions and volumes to make a given concentration
# of pooled media
df_pipette, df_names = estimate_pipette_volumes(fname_concs)

# Load flowbot decks for 24/96 well plate
df_deck_24 = load_flowbot_deck(fname_24)
df_deck_96 = load_flowbot_deck(fname_96)

# df_1: flowbot instructions for stocks to pooled replicates
# df_2: flowbot instructions for pooled replicates to individual wells
# Maps: mapping of stocks/pooled replicates/individual wells on the plates
df_1_24, df_2_24, maps_24, map_names_24 = make_flowbot_protocol_001(#
    df_pipette,
    df_deck_24,
    df_names,
    well_vol_ml = 2.5, # final volume in 24-well plates
    dead_vol_ml = 0.0, # deprecated
    tip_min_vol_μl = 100.0,
    tip_max_vol_μl = 1000.0,
    replicates = 3
)

df_1_96, df_2_96, maps_96, map_names_96 = make_flowbot_protocol_001(#
    df_pipette,
    df_deck_96,
    well_vol_ml = 0.3, # final volume in 24-well plates
    dead_vol_ml = 0.0; # deprecated
    tip_min_vol_μl = 100.0,
    tip_max_vol_μl = 1000.0,
    replicates = 3
)

# Sanity check that the part 1 stock to pooled media step is identical
df_1_24 == df_1_96

# Export dataframes to CSV file
CSV.write(fname_pipette,  df_pipette)
CSV.write(fname_part1,    df_1_24)
CSV.write(fname_part2_24, df_2_24)
CSV.write(fname_part2_96, df_2_96)
write_flowbot_maps(fname_deck_24, maps_24, map_names_24)
write_flowbot_maps(fname_deck_96, maps_96, map_names_96)
### ----------------------------------------------------------------------------



