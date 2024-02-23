#
# Copyright 2023 Erwan Mahe (github.com/erwanM974)
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

import os
from subprocess import STDOUT, check_output

from implem.constants import HSF_FILE, INTERACTIONS_FOLDER


def generate_accepted(int_name, hcf_explo):
    hif_file = os.path.join(INTERACTIONS_FOLDER, "{}.hif".format(int_name))
    #
    command = [
        "./hibou_label.exe",
        "explore",
        HSF_FILE,
        hif_file,
        hcf_explo
    ]

    output = check_output(command, stderr=STDOUT)
    #print(output)

    gen_folder = "tracegen_l1"
    renamed_folder = os.path.join(INTERACTIONS_FOLDER, int_name + "_accepted")
    os.rename(gen_folder, renamed_folder)

    return renamed_folder