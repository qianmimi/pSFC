#
# Simple table setup script for simple_l3.p4
#

clear_all()

# ACL_table1
p4_pd.ACL_table1_table_add_with_aiNoOp(
    p4_pd.ACL_table1_match_spec_t(ipv4Addr_to_i32("10.0.1.13"),ipv4Addr_to_i32("10.0.1.11"),32000,8))

# ACL_table2
p4_pd.ACL_table2_table_add_with_aiNoOp(
    p4_pd.ACL_table2_match_spec_t(ipv4Addr_to_i32("10.0.1.13"),ipv4Addr_to_i32("10.0.1.11"),32000,8))

# ACL_table3
p4_pd.ACL_table3_table_add_with_aiNoOp(
    p4_pd.ACL_table3_match_spec_t(ipv4Addr_to_i32("10.0.1.13"),ipv4Addr_to_i32("10.0.1.11"),32000,8))

# sflow_ingress
p4_pd.sflow_ingress_table_add_with_aiNoOp(
    p4_pd.sflow_ingress_match_spec_t(ipv4Addr_to_i32("10.0.1.13"),ipv4Addr_to_i32("10.0.1.11"),32000,8))

# sflow_ing_take_sample
p4_pd.sflow_ing_take_sample_table_add_with_aiNoOp(
    p4_pd.sflow_ing_take_sample_match_spec_t(ipv4Addr_to_i32("10.0.1.13"),ipv4Addr_to_i32("10.0.1.11"),32000,8))

#hash_5tuple
p4_pd.hash_5tuple_set_default_action_calchash5()

#hash_2tuple
p4_pd.hash_2tuple_set_default_action_calchash2()

#flow_size_action_1
p4_pd.flow_size_action_1_set_default_action_aflowsize_1()


#flow_size_action_2
p4_pd.flow_size_action_2_set_default_action_aflowsize_2()


#UDP_flood_action_1
p4_pd.UDP_flood_action_1_set_default_action_aflowsize_3()


#UDP_flood_action_2
p4_pd.UDP_flood_action_2_set_default_action_aflowsize_4()


#drop_table2
p4_pd.drop_table2_set_default_action_aiNoOp()

#drop_table3
p4_pd.drop_table3_set_default_action_aiNoOp()

#drop_table1
p4_pd.drop_table1_set_default_action_aiNoOp()

#drop_table
p4_pd.drop_table_set_default_action_aiNoOp()

#spread_action_1
p4_pd.spread_action_1_set_default_action_aflowsize_5()

#spread_action_2
p4_pd.spread_action_2_set_default_action_aflowsize_6()

# ipv4_lpm2
p4_pd.ipv4_lpm_table_add_with_send(
    p4_pd.ipv4_lpm_match_spec_t(ipv4Addr_to_i32("10.0.1.13"), 24),
    p4_pd.send_action_spec_t(140))

conn_mgr.complete_operations()
