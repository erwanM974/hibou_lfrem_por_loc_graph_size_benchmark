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

from implem.constants import INTERACTIONS_FOLDER, HSF_FILE


def generate_slices(int_name,accepted_htf_name,num_slices,is_slice_wide):
    #
    acc_htf_file = os.path.join(
        INTERACTIONS_FOLDER,
        '{}_accepted'.format(int_name),
        "{}.htf".format(accepted_htf_name)
    )
    #
    parent_folder = os.path.join(INTERACTIONS_FOLDER,'{}_slices'.format(int_name))
    #
    command = [
        "./hibou_label.exe",
        "slice",
        HSF_FILE,
        acc_htf_file,
        "-p", parent_folder,
        "-k",
        "prefix",
        "-n",
        accepted_htf_name]
    #
    if num_slices != None:
        command += ["-r", str(num_slices)]
        if is_slice_wide:
            command += ["-w"]
    #
    output = check_output(command, stderr=STDOUT)
    #print(output)
    #

def generate_noise_mutant(int_name,slice_htf_name):
    #
    slice_htf_file = os.path.join(
        INTERACTIONS_FOLDER,
        '{}_slices'.format(int_name),
        "{}.htf".format(slice_htf_name)
    )
    #
    parent_folder = os.path.join(INTERACTIONS_FOLDER,'{}_noise'.format(int_name))
    #
    name = "{}_noise".format(slice_htf_name)
    command = [
        "./hibou_label.exe",
        "mutate_insert_noise",
        HSF_FILE,
        slice_htf_file,
        "-p", parent_folder,
        "-e",
        "-n", name
    ]
    #
    output = check_output(command, stderr=STDOUT)
    #print(output)
    #

def generate_swap_act_mutant(int_name, slice_htf_name):
    #
    slice_htf_file = os.path.join(
        INTERACTIONS_FOLDER,
        '{}_slices'.format(int_name),
        "{}.htf".format(slice_htf_name)
    )
    #
    parent_folder = os.path.join(INTERACTIONS_FOLDER, '{}_swap_act'.format(int_name))
    #
    name = "{}_swap_act".format(slice_htf_name)
    command = ["./hibou_label.exe", "mutate_swap_actions", HSF_FILE, slice_htf_file, "-p", parent_folder, "-n", name]
    #
    output = check_output(command, stderr=STDOUT)
    #print(output)
    #

def generate_swap_comp_mutant(int_name, slice1_htf_name, slice2_htf_name):
    #
    slice1_htf_file = os.path.join(
        INTERACTIONS_FOLDER,
        '{}_slices'.format(int_name),
        "{}.htf".format(slice1_htf_name)
    )
    slice2_htf_file = os.path.join(
        INTERACTIONS_FOLDER,
        '{}_slices'.format(int_name),
        "{}.htf".format(slice2_htf_name)
    )
    #
    parent_folder = os.path.join(INTERACTIONS_FOLDER, '{}_swap_comp'.format(int_name))
    #
    name = "{}_swap_comp".format(slice1_htf_name)
    command = ["./hibou_label.exe", "mutate_swap_components", HSF_FILE, slice1_htf_file, slice2_htf_file, "-p", parent_folder, "-n", name]
    #
    output = check_output(command, stderr=STDOUT)
    #print(output)
    #


