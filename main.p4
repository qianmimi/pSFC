#include "includes/headers.p4"
#include "includes/parser.p4"
#include <tofino/intrinsic_metadata.p4>
#include <tofino/constants.p4>
#include "tofino/stateful_alu_blackbox.p4"


header_type sfkeyinfo_t {
    fields {
        hashVal5: 16;
        hashVal2: 16;
        rR1 : 16;
        rR2 :16;
    }
}

metadata sfkeyinfo_t sfkeyinfo;


field_list flKeyFields_5 {
    ipv4.srcAddr;
    ipv4.dstAddr;
    l4_ports.ports;
    ipv4.protocol;
}

field_list_calculation flowKeyHashCalc5 {
    input { flKeyFields_5; }
    algorithm : crc16;
    output_width : 16;
}

field_list flKeyFields_2 {
    ipv4.srcAddr;
    ipv4.dstAddr;
}

field_list_calculation flowKeyHashCalc2 {
    input { flKeyFields_2; }
    algorithm : crc16;
    output_width : 16;
}

table ACL_table1 {
    reads {
        ipv4.srcAddr : ternary;
        ipv4.dstAddr : ternary;
        l4_ports.ports : ternary;
        ipv4.protocol : ternary;
    }
    actions {
        aiNoOp;
    }
    default_action: drop();
    size : 128;
}
table ACL_table2 {
    reads {
        ipv4.srcAddr : ternary;
        ipv4.dstAddr : ternary;
        l4_ports.ports : ternary;
        ipv4.protocol : ternary;
    }
    actions {
        aiNoOp;
    }
    default_action: drop();
    size : 128;
}
table ACL_table3 {
    reads {
        ipv4.srcAddr : ternary;
        ipv4.dstAddr : ternary;
        l4_ports.ports : ternary;
        ipv4.protocol : ternary;
    }
    actions {
        aiNoOp;
    }
    default_action: drop();
    size : 128;
}

table sflow_ingress {
    reads {
        ipv4.srcAddr : ternary;
        ipv4.dstAddr : ternary;
        l4_ports.ports : ternary;
        ipv4.protocol : ternary;
    }
    actions {
        aiNoOp;
    }
    default_action: drop();
    size : 128;
}

table sflow_ing_take_sample {
    reads {
        ipv4.srcAddr : ternary;
        ipv4.dstAddr : ternary;
        l4_ports.ports : ternary;
        ipv4.protocol : ternary;
    }
    actions {
        aiNoOp;
    }
    default_action: drop();
    size : 128;
}

table hash_5tuple {
    actions {
        calchash5;
    }
    default_action: calchash5();
    size : 128;
}

action calchash5() {  
    modify_field_with_hash_based_offset(sfkeyinfo.hashVal5, 0, flowKeyHashCalc5, 65536);
}

table hash_2tuple {
    actions {
        calchash2;
    }
    default_action: calchash2();
    size : 128;
}

action calchash2() {  
    modify_field_with_hash_based_offset(sfkeyinfo.hashVal2, 0, flowKeyHashCalc2, 65536);
}


table flow_size_action_1 {
    actions {
        aflowsize_1;
    }
    default_action: aflowsize_1();
    size : 128;
}

action aflowsize_1() {  
    rwR1.execute_stateful_alu(sfkeyinfo.hashVal);
}

blackbox stateful_alu rwR1 {
    reg : rR1;
    update_lo_1_value : register_lo + 1;
    output_dst : sfkeyinfo.rR1;
    output_value : register_lo;
}

register rR1 {
    width : 16;
    instance_count : 16384;
}

table flow_size_action_2 {
    actions {
        aflowsize_2;
    }
    default_action: aflowsize_2();
    size : 128;
}

action aflowsize_2() {  
    rwR2.execute_stateful_alu(sfkeyinfo.hashVal);
}

blackbox stateful_alu rwR2 {
    reg : rR2;
    update_lo_1_value : register_lo + 1;
    output_dst : sfkeyinfo.rR2;
    output_value : register_lo;
}

register rR2 {
    width : 16;
    instance_count : 16384;
}


table UDP_flood_action_1 {
    actions {
        aflowsize_3;
    }
    default_action: aflowsize_3();
    size : 128;
}

action aflowsize_3() {  
    rwR1.execute_stateful_alu(sfkeyinfo.hashVal);
}

blackbox stateful_alu rwR3 {
    reg : rR3;
    update_lo_1_value : register_lo + 1;
    output_dst : sfkeyinfo.rR1;
    output_value : register_lo;
}

register rR3 {
    width : 16;
    instance_count : 16384;
}



table UDP_flood_action_2 {
    actions {
        aflowsize_4;
    }
    default_action: aflowsize_4();
    size : 128;
}

action aflowsize_4() {  
    rwR1.execute_stateful_alu(sfkeyinfo.hashVal);
}

blackbox stateful_alu rwR4 {
    reg : rR4;
    update_lo_1_value : register_lo + 1;
    output_dst : sfkeyinfo.rR4;
    output_value : register_lo;
}

register rR4 {
    width : 16;
    instance_count : 16384;
}



table spread_action_1 {
    actions {
        aflowsize_5;
    }
    default_action: aflowsize_5();
    size : 128;
}

action aflowsize_5() {  
    rwR1.execute_stateful_alu(sfkeyinfo.hashVal);
}

blackbox stateful_alu rwR5 {
    reg : rR5;
    update_lo_1_value : register_lo + 1;
    output_dst : sfkeyinfo.rR5;
    output_value : register_lo;
}

register rR5 {
    width : 16;
    instance_count : 16384;
}



table spread_action_2 {
    actions {
        aflowsize_6;
    }
    default_action: aflowsize_6();
    size : 128;
}

action aflowsize_6() {  
    rwR1.execute_stateful_alu(sfkeyinfo.hashVal);
}

blackbox stateful_alu rwR6 {
    reg : rR6;
    update_lo_1_value : register_lo + 1;
    output_dst : sfkeyinfo.rR6;
    output_value : register_lo;
}

register rR6 {
    width : 16;
    instance_count : 16384;
}


table spread_action_3 {
    actions {
        aiNoOp;
    }
    default_action: _drop();
    size : 128;
}

action set_egr(egress_spec) {
    modify_field(ig_intr_md_for_tm.ucast_egress_port,egress_spec); 
}

table ipv4_lpm2{
    reads {
		    ipv4.dstAddr : ternary;
		    ethernet.etherType : ternary;
    }
    actions {
        set_egr;
	      aiNoOp;
    }
    default_action : aiNoOp();
}




action _drop() {
    drop();
}
action aiNoOp() {
    no_op();
}
control ingress {
 
  
}

control egress {

}
