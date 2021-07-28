#include "includes/headers.p4"
#include "includes/parser.p4"
#include <tofino/intrinsic_metadata.p4>
#include <tofino/constants.p4>
#include "tofino/stateful_alu_blackbox.p4"


#define width_vlan 8

header_type sfkeyinfo_t {
    fields {
        hashVal5: width_vlan;
        hashVal2: width_vlan;
        srR1 : width_vlan;
        srR2 : width_vlan;
	srR3 : width_vlan;
        srR4 : width_vlan;
	srR5 : width_vlan;
        srR6 : width_vlan;
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
    output_width : width_vlan;
}

field_list flKeyFields_2 {
    ipv4.srcAddr;
    ipv4.dstAddr;
}

field_list_calculation flowKeyHashCalc2 {
    input { flKeyFields_2; }
    algorithm : crc16;
    output_width : width_vlan;
}
@pragma stage 0
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
    default_action: aiNoOp();
    size : 128;
}
@pragma stage 1
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
    default_action: aiNoOp();
    size : 128;
}
@pragma stage 2
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
    default_action: aiNoOp();
    size : 128;
}
@pragma stage 3
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
    default_action: aiNoOp();
    size : 128;
}
@pragma stage 4
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
    default_action: aiNoOp();
    size : 128;
}
@pragma stage 4
table hash_5tuple {
    actions {
        calchash5;
    }
    default_action: calchash5();
    size : 128;
}

action calchash5() {  
    modify_field_with_hash_based_offset(sfkeyinfo.hashVal5, 0, flowKeyHashCalc5, 256);
}
@pragma stage 6
table hash_2tuple {
    actions {
        calchash2;
    }
    default_action: calchash2();
    size : 128;
}

action calchash2() {  
    modify_field_with_hash_based_offset(sfkeyinfo.hashVal2, 0, flowKeyHashCalc2, 256);
}

@pragma stage 5
table flow_size_action_1 {
    actions {
        aflowsize_1;
    }
    default_action: aflowsize_1();
    size : 128;
}

action aflowsize_1() {  
    rwR1.execute_stateful_alu(sfkeyinfo.hashVal5);
}

blackbox stateful_alu rwR1 {
    reg : rR1;
    update_lo_1_value : register_lo + 1;
    output_dst : sfkeyinfo.srR1;
    output_value : register_lo;
}

register rR1 {
    width : width_vlan;
    instance_count : 16384;
}
@pragma stage 6
table flow_size_action_2 {
    actions {
        aflowsize_2;
    }
    default_action: aflowsize_2();
    size : 128;
}

action aflowsize_2() {  
    rwR2.execute_stateful_alu(sfkeyinfo.hashVal5);
}

blackbox stateful_alu rwR2 {
    reg : rR2;
    update_lo_1_value : register_lo + 1;
    output_dst : sfkeyinfo.srR2;
    output_value : register_lo;
}

register rR2 {
    width : width_vlan;
    instance_count : 16384;
}

@pragma stage 7
table UDP_flood_action_1 {
    actions {
        aflowsize_3;
    }
    default_action: aflowsize_3();
    size : 128;
}

action aflowsize_3() {  
    rwR3.execute_stateful_alu(sfkeyinfo.hashVal5);
}

blackbox stateful_alu rwR3 {
    reg : rR3;
    update_lo_1_value : register_lo + 1;
    output_dst : sfkeyinfo.srR3;
    output_value : register_lo;
}

register rR3 {
    width : width_vlan;
    instance_count : 16384;
}

@pragma stage 8
table drop_table2 {
    actions {
        aiNoOp;
    }
    default_action: aiNoOp();
    size : 128;
}

@pragma stage 8
table UDP_flood_action_2 {
    actions {
        aflowsize_4;
    }
    default_action: aflowsize_4();
    size : 128;
}

action aflowsize_4() {  
    rwR4.execute_stateful_alu(sfkeyinfo.hashVal5);
}

blackbox stateful_alu rwR4 {
    reg : rR4;
    update_lo_1_value : register_lo + 1;
    output_dst : sfkeyinfo.srR4;
    output_value : register_lo;
}

register rR4 {
    width : width_vlan;
    instance_count : 16384;
}
@pragma stage 9
table drop_table {
    actions {
        aiNoOp;
    }
    default_action: aiNoOp();
    size : 128;
}

@pragma stage 9
table spread_action_1 {
    actions {
        aflowsize_5;
    }
    default_action: aflowsize_5();
    size : 128;
}

action aflowsize_5() {  
    rwR5.execute_stateful_alu(sfkeyinfo.hashVal5);
}

blackbox stateful_alu rwR5 {
    reg : rR5;
    update_lo_1_value : register_lo + 1;
    output_dst : sfkeyinfo.srR5;
    output_value : register_lo;
}

register rR5 {
    width : width_vlan;
    instance_count : 16384;
}
@pragma stage 10
table drop_table1 {
    actions {
        aiNoOp;
    }
    default_action: aiNoOp();
    size : 128;
}

@pragma stage 10
table spread_action_2 {
    actions {
        aflowsize_6;
    }
    default_action: aflowsize_6();
    size : 128;
}

action aflowsize_6() {  
    rwR6.execute_stateful_alu(sfkeyinfo.hashVal5);
}

blackbox stateful_alu rwR6 {
    reg : rR6;
    update_lo_1_value : register_lo + 1;
    output_dst : sfkeyinfo.srR6;
    output_value : register_lo;
}

register rR6 {
    width : width_vlan;
    instance_count : 16384;
}

@pragma stage 11
table drop_table3 {
    actions {
        aiNoOp;
    }
    default_action: aiNoOp();
    size : 128;
}

action set_egr(egress_spec) {
    modify_field(ig_intr_md_for_tm.ucast_egress_port,egress_spec); 
}
@pragma stage 11
table ipv4_lpm2{
    reads {
		    ipv4.dstAddr : exact;
		    ethernet.etherType : exact;
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
 	apply(ACL_table1);
	apply(ACL_table2);
	apply(ACL_table3);
	apply(sflow_ingress);
	apply(sflow_ing_take_sample);
	apply(hash_5tuple);
	apply(flow_size_action_1);
	if(sfkeyinfo.srR1>100){
	    apply(flow_size_action_2);
	}
	else{
	    apply(hash_2tuple);
	
	}
	apply(UDP_flood_action_1);
	if(sfkeyinfo.srR3>100){
	    apply(UDP_flood_action_2);
	}
	else{
	    apply(drop_table2);
	
	}
	if(sfkeyinfo.srR4>100){
	    	apply(drop_table);
	}
	else{
	       apply(spread_action_1);
	}
	if(sfkeyinfo.srR5>100){
	      apply(spread_action_2);
	}
	else{
	      apply(drop_table1);
	}
	if(sfkeyinfo.srR6>100){
	      apply(drop_table3);
	}
	else{
	      apply(ipv4_lpm2);
	}
	
}

control egress {

}
