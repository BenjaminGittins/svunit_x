import svunit_pkg::*;

`include "svunit_defines.svh"
`include "test_if.sv"
typedef class c_test_if_unit_test;

module test_if_unit_test;
  c_test_if_unit_test unittest;
  string name = "test_if_ut";

  test_if my_test_if();

  function void setup();
    unittest = new(name, my_test_if);
  endfunction
endmodule

class c_test_if_unit_test extends svunit_testcase;

  virtual test_if my_test_if;

  //===================================
  // Constructor
  //===================================
  function new(string name,
               virtual test_if my_test_if);
    super.new(name);

    this.my_test_if = my_test_if;
  endfunction


  //===================================
  // Setup for running the Unit Tests
  //===================================
  task setup();
    super.setup();
    /* Place Setup Code Here */
  endtask


  //===================================
  // Here we deconstruct anything we 
  // need after running the Unit Tests
  //===================================
  task teardown();
    super.teardown();
    /* Place Teardown Code Here */
  endtask


  //===================================
  // All tests are defined between the
  // SVUNIT_TESTS_BEGIN/END macros
  //
  // Each individual test must be
  // defined between `SVTEST(_NAME_)
  // `SVTEST_END(_NAME_)
  //
  // i.e.
  //   `SVTEST(mytest)
  //     <test code>
  //   `SVTEST_END(mytest)
  //===================================
  `SVUNIT_TESTS_BEGIN



  `SVUNIT_TESTS_END

endclass

