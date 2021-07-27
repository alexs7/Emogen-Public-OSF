# EmoGen tool configuration file

# SELECT MODEL: MALE OR FEMALE
model="MALE"

# DO NOT ALTER THE FOLLOWING:
# ******************************************************
NEUTRAL_FILE=$PWD/data/$model"/neutral.obj"    
if [ $model = "MALE" ]; then
   TEXTURE_FILE=$PWD/data/$model"/diffuse.bmp"
elif [ $model = "FEMALE" ]; then
   TEXTURE_FILE=$PWD/data/$model"/diffuse.png"
else  
   echo "Unknown model specified in the configuration file." 
   exit
fi
DIRECTORY=$PWD/data/$model"/"                  
orderOfblendshapes_FILE=$PWD/data/shapes.txt              
SHADER_DIRECTORY=$PWD/EmoGen_tool/common/
barycentrics_new_model=$PWD/data/target_points.txt                    
initialisation_new_model=$PWD/data/initialisation.csv                                         
neutral_in_updated_position=$PWD/data/$model"/new_model_neutral.obj"                                        
collision_anchors=$PWD/data/collision_anchors_upper_lip.txt                 
teeth_collision_anchors=$PWD/data/UpperTeeth_polygons.txt              
lower_lip_anchors=$PWD/data/lowLip_polygons_extended.txt
numberofblendshapes=150
# ******************************************************

# MAKE YOUR PARAMETER SELECTIONS BELOW
# ******************************************************
# PLESE NOTE: NO SPACES BETWEEN THE EQUAL SIGN (=) AND PARAMETER NAME/PARAMETER VALUE
maximum_number_of_generations=10

OUTPUT_FOLDER=$PWD/user_output/

# TEST_SESSION_ID format: [model]*[Free choice: e.g. participant name, date etc]_[TARGET_EMOTION] (end string)
# The participant will see the following display: "Target expression: [TARGET_EMOTION]
TEST_SESSION_ID=$model"*""Fredie_angry"

# protocol_generated_initialisation [true/false] - 10 faces generated by a protocol. Currently, happy/angry/sad/fearful 2 each, 1 neutral and one random
# reinit_after_reset [true/false] - decide what the algorithm should do if the session is reset: generate a new init. set by protocol [true] or reuse the previous [false]
protocol_generated_initialisation=true
reinit_after_reset=true

# read initialisation from .csv file [N x 10]
# (only relevant if protocol_generated_initialisation is false) 
# random_pick_from_file - whether the choice of the initialisations from file is automatically randomised [true/false]; after session reset the choice will be random again
# init_nr - when it is not, choose the preferred initialisation [1,2,3...N]
random_pick_from_file=false
init_nr=3

eye_pupil_motion=false
eye_lid_motion=true

# for fixed number of selections [1-10] choose the same minimum and maximum
minimum_number_of_selections=1
maximum_number_of_selections=10

#resolution of the main screen to adjust openGL:
# assuming rectangular screens 
# single screen:  run xdpyinfo | grep "dimensions:"
# single or dual screen: run xrandr and take the primary's dimensions
screen_width=2048
screen_height=1152
# ******************************************************

$PWD/EmoGen_tool/build/run_tool $DIRECTORY $orderOfblendshapes_FILE $NEUTRAL_FILE $SHADER_DIRECTORY $TEST_SESSION_ID $OUTPUT_FOLDER $maximum_number_of_generations $barycentrics_new_model $initialisation_new_model $TEXTURE_FILE $neutral_in_updated_position $collision_anchors $teeth_collision_anchors $lower_lip_anchors $random_pick_from_file $init_nr false $eye_pupil_motion $eye_lid_motion $protocol_generated_initialisation $reinit_after_reset $minimum_number_of_selections $maximum_number_of_selections $numberofblendshapes $screen_width $screen_height

