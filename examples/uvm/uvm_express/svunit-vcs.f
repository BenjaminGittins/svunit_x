//###############################################################
//
//  Licensed to the Apache Software Foundation (ASF) under one
//  or more contributor license agreements.  See the NOTICE file
//  distributed with this work for additional information
//  regarding copyright ownership.  The ASF licenses this file
//  to you under the Apache License, Version 2.0 (the
//  "License"); you may not use this file except in compliance
//  with the License.  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.
//
//###############################################################

$UVM_HOME/src/uvm.sv
$SVUNIT_INSTALL/svunit_base/uvm-mock/svunit_uvm_mock_pkg.sv
$UVM_HOME/src/dpi/uvm_dpi.cc -CFLAGS -DVCS

+incdir+$UVM_HOME/src
+incdir+$SVUNIT_INSTALL/svunit_base/uvm-mock

+define+CLK_PERIOD=5
+define+UVM_NO_RELNOTES
+define+RUN_SVUNIT_WITH_UVM