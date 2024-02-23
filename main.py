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
import random

from implem.analyze import run_analyses
from implem.constants import INTERACTIONS_FOLDER, get_graph_analysis_methods, HCF_EXPLO
from implem.gen_ints import generate_interactions
from implem.gen_mutants import generate_slices, generate_swap_act_mutant, generate_noise_mutant, generate_swap_comp_mutant
from implem.gen_traces import generate_accepted


def get_tracegen_folders(int_name):
    return [
        ("ACPT",os.path.join(INTERACTIONS_FOLDER, int_name + "_accepted")),
        ("PREF",os.path.join(INTERACTIONS_FOLDER, int_name + "_slices")),
        ("NOIS",os.path.join(INTERACTIONS_FOLDER, int_name + "_noise")),
        ("SACT",os.path.join(INTERACTIONS_FOLDER, int_name + "_swap_act")),
        ("SCMP",os.path.join(INTERACTIONS_FOLDER, int_name + "_swap_comp"))
    ]

def generate_all_traces(int_name, hcf_explo, num_slices, is_slice_wide):
    print("generating accepted traces for : " + int_name)
    accepted_folder = generate_accepted(int_name, hcf_explo)

    print("generating trace slices for : " + int_name)
    for htf in os.listdir(accepted_folder):
        if htf.endswith(".htf"):
            htf_name = htf[:-4]
            generate_slices(int_name,htf_name,num_slices,is_slice_wide)

    print("generating mutant traces for : " + int_name)
    slices_folder = os.path.join(INTERACTIONS_FOLDER, int_name + "_slices")
    all_slices_names = [slice_htf_file_name[:-4] for slice_htf_file_name in os.listdir(slices_folder)]
    for i in range(0, len(all_slices_names)):
        slice_htf_file_name = all_slices_names[i]
        #
        generate_noise_mutant(int_name, slice_htf_file_name)
        generate_swap_act_mutant(int_name, slice_htf_file_name)
        #
        other_to_swap_with = None
        while ((other_to_swap_with == None) or (other_to_swap_with == slice_htf_file_name)):
            other_to_swap_with = random.choice(all_slices_names)
        #
        generate_swap_comp_mutant(int_name, slice_htf_file_name, other_to_swap_with)




def experiment(num_tries,timeout_in_secs):
    # parameterization
    analysis_methods = get_graph_analysis_methods()
    number_of_interactions = 100
    initial_term_depth = 6
    final_min_num_symbols = 20
    num_slices = 1
    is_slice_wide = False
    symbols_probas = "conservative"
    # output
    results_filename = "results_graph.csv"
    f = open(results_filename, "w")
    f.truncate(0) # empty file
    # ***
    columns = ["hif",
               "trace_kind",
               "htf",
               "trace_length",
               "verdict"]

    for method_name in analysis_methods:
        columns += [method_name + '_graph_size']
        columns += [method_name + '_time']
    f.write(";".join(columns) + "\n")
    f.flush()
    #
    print("generating interactions")
    generate_interactions(number_of_interactions, symbols_probas, initial_term_depth, final_min_num_symbols)
    #
    for hif in os.listdir(INTERACTIONS_FOLDER):
        if hif.endswith(".hif"):
            hif_name = hif[:-4]
            hif_path = os.path.join(INTERACTIONS_FOLDER, hif)
            generate_all_traces(hif_name, HCF_EXPLO, num_slices, is_slice_wide)

            print("analyzing traces for : " + hif_name)
            for (trace_kind,trace_folder) in get_tracegen_folders(hif_name):
                for htf in os.listdir(trace_folder):
                    if htf.endswith(".htf"):
                        htf_name = htf[:-4]
                        htf_path = os.path.join(trace_folder,htf)
                        ana_dict = run_analyses(hif_path,htf_path,analysis_methods,num_tries,timeout_in_secs)
                        if ana_dict != None:
                            row = [
                                hif_name,
                                trace_kind,
                                htf_name,
                                str(ana_dict['trace_length']),
                                str(ana_dict['verdict'])
                            ]
                            for method_name in analysis_methods:
                                row += [str(ana_dict.get(method_name + '_graph_size'))]
                                row += [str(ana_dict.get(method_name + '_time'))]
                            print(row)
                            line = ";".join(row) + "\n"
                            f.write(line)
                            f.flush()


if __name__ == "__main__":
    experiment(3,3)

