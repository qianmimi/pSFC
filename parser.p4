#define ETHERTYPE_IPV4 0x0800

parser start {
    return parse_ethernet;
}

parser parse_ethernet {
    extract(ethernet);
    return select(latest.etherType) {
        ETHERTYPE_IPV4 : parse_ipv4;  
        default : ingress;
    }
}
// IP.
parser parse_ipv4 {
    extract(ipv4);
    return parse_l4;
}

// TCP / UDP ports.
parser parse_l4 {
    extract(l4_ports);
    return ingress;
}
