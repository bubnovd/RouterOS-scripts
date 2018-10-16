#Tools Netwatch
:local pppoe-iface YOUR_DYNAMIC_INTERFACE
:local ISP-chk YOUR_RECURSIVE_ROUTE_COMMENT
:log warning "Starting ISP check gateway";
:local gate0 [/ip route get [find comment=$ISP-chk ] gateway ]
:local gate1 [/ip address get value-name=network [find interface=$pppoe-iface]]
:if ( $gate0 != $gate1 ) do={
:log warning "update gateway";
/ip route set [find comment=$ISP-chk] gateway=$gate1
:log warning "Change gateway Complete!";

###########################
#System Scheduler
:local pppoe-iface YOUR_DYNAMIC_INTERFACE
:local ISP-chk YOUR_RECURSIVE_ROUTE_COMMENT
:log warning "Starting ISP check gateway";
:local gate0 [/ip route get [find comment=$ISP-chk ] gateway ]
:local gate1 [/ip address get value-name=network [find interface=$pppoe-iface]]
:if ( $gate0 != $gate1 ) do={
:local status [/tool netwatch get [ find comment=$ISP-chk ] status ]
:if ( $status != down ) do={
:local updown [ /interface get $pppoe-iface running ]
:if ( $updown = true ) do={
:log warning "update gateway";
/ip route set [find comment=$ISP-chk] gateway=$gate1
:log warning "Change gateway Complete!";
}}}