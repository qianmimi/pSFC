#
# Simple table setup script for simple_l3.p4
#

clear_all()

# p0
p4_pd.ipv4_lpm2_table_add_with_set_egr(
    p4_pd.ipv4_lpm2_match_spec_t(ipv4Addr_to_i32("10.0.2.10"),0x0800),
    p4_pd.set_egr_action_spec_t(140))

p4_pd.ipv4_lpm2_table_add_with_set_egr(
    p4_pd.ipv4_lpm2_match_spec_t(ipv4Addr_to_i32("10.0.1.11"),0x0800),
    p4_pd.set_egr_action_spec_t(132))

conn_mgr.complete_operations()
