# Copyright (c) 2019, NVIDIA CORPORATION.  All rights reserved.
# 
# Licensed under the Apache License, Version 2.0 (the "License")
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

source ../../nvhls_exec.tcl

proc nvhls::set_input_files {SRC_PATH TOP_NAME} {
    set DESIGN_FILES [list $SRC_PATH/$TOP_NAME/$TOP_NAME.h]
    set TB_FILES [list $SRC_PATH/Adder3/testbench.cpp]

    foreach design_file $DESIGN_FILES {
        solution file add $design_file -type SYSTEMC
    }
    foreach tb_file $TB_FILES {
        solution file add $tb_file -type SYSTEMC -exclude true
    }
}

proc nvhls::usercmd_post_assembly {} {
    upvar TOP_NAME TOP_NAME
    directive set /$TOP_NAME/run/while -PIPELINE_INIT_INTERVAL 1
    directive set /$TOP_NAME/run/while -PIPELINE_STALL_MODE flush
}

nvhls::run
