//###########################################################################
//
//  Copyright 2011 The SVUnit Authors.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//###########################################################################

/*
  Class: svunit_testcase
  Base class for the unit test case
*/
class svunit_testcase extends svunit_base;

  /*
    uint: test_count
    Counter for number of tests
  */
  local int unsigned test_count = 0;


  /*
    uint: error_count
    Counter for number of errors
  */
  local int unsigned error_count = 0;


  /*
    Variable: running
    1 is somewhere between setup and teardown, 0 otherwise
  */
  local bit running = 0;

  local junit_xml::TestCase current_junit_test_case;
  local junit_xml::TestCase junit_test_cases[$];


  /*
    Interface
  */
  extern function new(input string name);

  extern task wait_for_error();
  extern function integer get_error_count();
  extern task give_up();

  extern function bit fail(input string c, input logic b, input string s, input string f, input int l, input string d = "");

  extern function void start();
  extern function void stop();
  extern function bit  is_running();
  extern task __wait_until_started();

  extern function void update_exit_status();
  extern function void report();

  extern virtual task setup();
  extern virtual task teardown();


  function void add_junit_test_case(input string name);
    current_junit_test_case = new(name, get_name());
    junit_test_cases.push_back(current_junit_test_case);
  endfunction


  // This needs to be declared as a dynamic array[$] (not a static array[] with a fixed length)
  /* local */ typedef junit_xml::TestCase array_of_junit_test_cases[$];

  function array_of_junit_test_cases as_junit_test_cases();
    return junit_test_cases;
  endfunction

endclass


/*
  Constructor: new
  Initializes the test case

  Parameters:
    name - instance name of the test case

*/
function svunit_testcase::new(input string name);
  super.new(name);
endfunction


/*
  Method: wait_for_error
  Blocks until the error_count changes
*/
task svunit_testcase::wait_for_error();
  @(error_count);
endtask


/*
  Method: get_error_count
  Returns the error count
*/
function integer svunit_testcase::get_error_count();
  return error_count;
endfunction


/*
  Method: give_up
  Blocks indefinitely (Should only be called by `FAIL_IF)
*/
task svunit_testcase::give_up();
`ifndef VERILATOR
  event never;
  @(never);
`else
  bit never_true = 0;
  wait (never_true);
`endif
endtask


/*
  Method: fail
  If expression fails, increments error count, displays a message
  and returns the results

  Parameters:
    c - calling function
    b - evaluation of expression (0 - false, 1 - true)
    s - string to pass to pass or fail task
    f - file name of the failure
    l - line number of the failure
    d - user specified debug info

    return 1 if fail else 0
*/
function bit svunit_testcase::fail(input string c, input logic b, input string s, input string f, input int l, input string d = "");
  string _d;
  if (b !== 0) begin
    error_count++;
    if (d != "") begin
      $sformat(_d, "[ %s ] ", d);
    end
    current_junit_test_case.add_failure($sformatf("%s: %s %s(at %s line:%0d)",c,s,_d,f,l));
    `ERROR($sformatf("%s: %s %s(at %s line:%0d)",c,s,_d,f,l));
    return 1;
  end
  else begin
    return 0;
  end
endfunction


/*
  Method: start
  Changes the execution status of the test to running and increment the test count
*/
function void svunit_testcase::start();
  running = 1;
  test_count++;
endfunction


/*
  Method: stop
  Changes the execution status of the test to stopped
*/
function void svunit_testcase::stop();
  running = 0;
endfunction


/*
  Method: is_running
  Returns the execution status of the test
*/
function bit svunit_testcase::is_running();
  return running;
endfunction

/*
  Method: __wait_until_started
  Returns when this test is running
*/
task svunit_testcase::__wait_until_started();
  wait(running);
endtask

/*
  Methos: update_exit_status
  Updates the results of this testcase
*/
function void svunit_testcase::update_exit_status();
  if (error_count == 0)
    success = PASS;
  else
    success = FAIL;
endfunction


/*
  Method: report
  This task reports the results for the unit tests
*/
function void svunit_testcase::report();
  string success_str = (success)? "PASSED":"FAILED";

  `INFO($sformatf("%0s (%0d of %0d tests passing)",
    success_str,
    test_count-error_count,
    test_count));
endfunction


/*
  Method: setup
  Only required if using VCS since pure virtual functions are not implemented
*/
task svunit_testcase::setup();
endtask


/*
  Method: teardown
  House cleaning after each test
*/
task svunit_testcase::teardown();
endtask

