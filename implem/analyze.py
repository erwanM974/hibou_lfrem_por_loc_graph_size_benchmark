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


import statistics
from subprocess import STDOUT, check_output, TimeoutExpired, CalledProcessError

from implem.constants import HSF_FILE


def parse_hibou_output(outwrap):
    #
    verdict = None
    length = None
    node_count = None
    elapsed_time = None
    #
    for line in outwrap.decode("utf-8").splitlines():
        if "verdict" in line:
            if "WeakPass" in line:
                verdict = "Pass"
            elif "Pass" in line:
                verdict = "Pass"
            elif "WeakFail" in line:
                verdict = "Fail"
            elif "Fail" in line:
                verdict = "Fail"
            elif "Inconc" in line:
                verdict = "Inconc"
            else:
                print(line)
                raise Exception("some other verdict ?")
        # ***
        if "of length" in line:
            length = int(line.split(" ")[-1].strip()[1:-1])
        # ***
        if "node count" in line:
            node_count = int(line.split(" ")[-1].strip())
        # ***
        if "elapsed" in line:
            elapsed_time = float(line.split(" ")[-1].strip())
        # ***
    #
    mydict = {
        'node_count': node_count,
        'length': length,
        'verdict': verdict,
        'elapsed_time': elapsed_time
    }
    return mydict






def run_analyses(hif_path,htf_path,analysis_methods,num_tries,timeout_in_secs):
    # run the analysis num_tries times for each method

    one_method_at_least_below_timeout = False
    out_dict = {}
    for method_name in analysis_methods:
        command = ["./hibou_label.exe", "analyze", HSF_FILE, hif_path, htf_path, method_name + ".hcf"]
        time_trials = []
        got_timeout = False
        for i in range(0,num_tries):
            try:
                output = check_output(command, stderr=STDOUT, timeout=timeout_in_secs)
            except TimeoutExpired as exc:
                #print("Command timed out: {}".format(exc))
                got_timeout = True
                break
            except CalledProcessError as exc:
                #print("Other error: {}".format(exc))
                pass
            else:
                #print(output.decode("utf-8"))
                parsed = parse_hibou_output(output)
                time_trials += [ parsed.get('elapsed_time') ]
                out_dict['trace_length'] = parsed.get('length')
                if 'verdict' in out_dict:
                    if out_dict['verdict'] != parsed['verdict']:
                        msg = "ERROR : methods return different verdicts :"+\
                              "\n for hif : " + hif_path + \
                              "\n and htf : " + htf_path +\
                              "\n via " + method_name + " : " + parsed['verdict'] +\
                              "\n via " + out_dict['verdict_obtained_by_method'] + " : " + out_dict['verdict']
                        print(msg)
                        raise Exception(msg)
                else:
                    if parsed['verdict'] != None:
                        out_dict['verdict'] = parsed['verdict']
                        out_dict['verdict_obtained_by_method'] = method_name
                out_dict[method_name + '_graph_size'] = parsed.get('node_count')
        if got_timeout:
            print("got timeout for " + hif_path + " " + htf_path + " " + method_name)
        if not got_timeout and len(time_trials) > 0:
            #print(time_trials)
            one_method_at_least_below_timeout = True
            t_total = statistics.median(time_trials)
            #print(" " + hif_path + " " + htf_path + " " + method_name + " median of " + str(len(time_trials)) + " values : " + str(t_total))
            out_dict[method_name + '_time'] = t_total
        else:
            out_dict[method_name + '_time'] = 'TIMEOUT'

    if one_method_at_least_below_timeout:
        return out_dict
    else:
        return None
