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


def generate_interactions(number_of_interactions, symbols_probas, initial_term_depth, final_min_num_symbols):
    try:
        os.mkdir(INTERACTIONS_FOLDER)
    except Exception as e:
        print(e)
        pass
    command = ["./hibou_label.exe",
               "rng_gen_interactions",
               HSF_FILE,
               "-f", INTERACTIONS_FOLDER,
               "-i", str(number_of_interactions),
               "-p", symbols_probas,
               "-d", str(initial_term_depth),
               "-x", str(final_min_num_symbols),
               "-s", "0"]

    try:
        output = check_output(command, stderr=STDOUT)
        print(output.decode("utf-8"))
    except Exception as e:
        print(e)





