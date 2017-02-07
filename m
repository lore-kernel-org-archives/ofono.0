Content-Type: multipart/mixed; boundary="===============2834726437446647050=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Andr=C3=A9?= Draszik <git@andred.net>
Subject: telit modem NW DETACH
Date: Tue, 07 Feb 2017 11:49:02 +0000
Message-ID: <1486468142.20825.22.camel@andred.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2834726437446647050==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I am looking for advise for how to implement the TODO item in
ofono_gprs_detached_notify() in src/gprs.c

Using my Telit UE910-EU modem, the modem always reports a network initiated
detach after closing the data connection (by disconnecting the service via
connman), and oFono ends up ofono_gprs_detached_notify(). It is my
understanding that this is unusual behaviour, and that other people are
seeing the same, e.g.
https://lists.01.org/pipermail/ofono/2015-May/015765.html

I can get around that by disabling/re-enabling the modem, but I would like
to avoid that...

As a further point, whenever the modem reports that it has been disconnected
but then the CellID changes, it magically reconnects, so I believe I should
be looking to set oFono's state machine back to trying to reconnect and
eventually issue the correct AT command to do so forcefully. See 2nd part of
the log below.


Cheers,
Andre'


----- snip   disconnect & detach -----


connmand[22516]: ../connman-1.33/plugins/ofono.c:network_disconnect() /teli=
t_0 network 0x56451280
connmand[22516]: ../connman-1.33/plugins/ofono.c:get_context_with_network()=
 network 0x56451280
connmand[22516]: ../connman-1.33/plugins/ofono.c:context_set_active() /teli=
t_0 active 0
connmand[22516]: ../connman-1.33/plugins/ofono.c:set_property() /telit_0 pa=
th /telit_0/context2 org.ofono.ConnectionContext.Active
connmand[22516]: rp_filter restored to 2
connmand[22516]: rp_filter set to 2 (loose mode routing), old value was 2
ofonod[23391]: ../ofono-1.19/drivers/atmodem/gprs-context.c:at_gprs_deactiv=
ate_primary() cid 1
ofonod[23391]: PPP: lcp: pppcp_generate_event: current state 9:OPENED
method call time=3D1482938882.207935 sender=3D:1.0 -> destination=3Dorg.ofo=
no serial=3D103 path=3D/telit_0/context2; interface=3Dorg.ofono.ConnectionC=
ontext; member=3DSetProperty
   string "Active"
   variant       boolean false
signal time=3D1482938882.208839 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D104 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
   string "Timeservers"
   variant       array [
      ]
signal time=3D1482938882.210060 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D105 path=3D/; interface=3Dnet.connman.Manager; member=3DPro=
pertyChanged
   string "State"
   variant       string "ready"
signal time=3D1482938882.211533 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D106 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
   string "State"
   variant       string "disconnect"
signal time=3D1482938882.212497 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D107 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
   string "Timeservers"
   variant       array [
      ]
ofonod[23391]: PPP: event: 3 (Close), action: 8224, new_state: 4 (CLOSING)
signal time=3D1482938882.213705 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D108 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
   string "Nameservers"
   variant       array [
      ]
signal time=3D1482938882.214861 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D109 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
   string "Domains"
   variant       array [
      ]
signal time=3D1482938882.216439 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D110 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
   string "Proxy"
   variant       array [
      ]
ofonod[23391]: PPP: lcp: pppcp_initialize_restart_count: current state 9:OP=
ENED
[...]
signal time=3D1482938882.218801 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D112 path=3D/net/connman/technology/cellular; interface=3Dne=
t.connman.Technology; member=3DPropertyChanged
   string "Connected"
   variant       boolean false
ofonod[23391]: PPP: lcp: pppcp_send_terminate_request: current state 9:OPEN=
ED
ofonod[23391]: PPP: ipcp: pppcp_generate_event: current state 9:OPENED
ofonod[23391]: PPP: event: 1 (Down), action: 201, new_state: 1 (STARTING)
signal time=3D1482938882.233873 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D113 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
   string "Timeservers"
   variant       array [
      ]
ofonod[23391]: PPP: ../ofono-1.19/gatchat/gatppp.c:ppp_enter_phase() 5
signal time=3D1482938882.239141 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D114 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
   string "State"
   variant       string "idle"
signal time=3D1482938882.243882 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D115 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
   string "IPv4"
   variant       array [
      ]
signal time=3D1482938882.247113 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D116 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
   string "IPv6"
   variant       array [
      ]
method return time=3D1482938882.585180 sender=3D:1.0 -> destination=3D:1.4 =
serial=3D117 reply_serial=3D2
connmand[22516]: (null) {del} route 0.0.0.0 gw 0.0.0.0 scope 253 <LINK>
ofonod[23391]: ../ofono-1.19/plugins/udevng.c:remove_device() /sys/devices/=
virtual/net/ppp0
[...]
signal time=3D1482938882.592443 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D119 path=3D/; interface=3Dnet.connman.Manager; member=3DSer=
vicesChanged
   array [
      struct {
         object path "/net/connman/service/ethernet_020000a01401_067_cable"
         array [
         ]
      }
      struct {
         object path "/net/connman/service/cellular_272032050058871_context=
2"
         array [
         ]
      }
   ]
   array [
   ]
ofonod[23391]: ../ofono-1.19/plugins/udev.c:udev_event() subsystem net remo=
ve
connmand[22516]: (null) {del} route 159.134.0.11 gw 0.0.0.0 scope 253 <LINK>
ofonod[23391]: ../ofono-1.19/plugins/udev.c:remove_modem() /devices/virtual=
/net/ppp0
connmand[22516]: (null) {del} route 159.134.0.12 gw 0.0.0.0 scope 253 <LINK>
connmand[22516]: (null) {del} address 100.94.48.26/32 label ppp0
ofonod[23391]: ../ofono-1.19/plugins/udev.c:udev_event() subsystem net fini=
shed
connmand[22516]: (null) {RX} 14 packets 1260 bytes
connmand[22516]: (null) {TX} 15 packets 1169 bytes
connmand[22516]: (null) {update} flags 4240 <DOWN>
connmand[22516]: ppp0 {newlink} index 15 address 00:00:00:00:00:00 mtu 1500
connmand[22516]: ppp0 {newlink} index 15 operstate 2 <DOWN>
connmand[22516]: ppp0 {dellink} index 15 operstate 2 <DOWN>
connmand[22516]: (null) {RX} 14 packets 1260 bytes
connmand[22516]: (null) {TX} 15 packets 1169 bytes
connmand[22516]: (null) {remove} index 15
ofonod[23391]: PPP: lcp: pppcp_process_terminate_ack: current state 4:CLOSI=
NG
connmand[22516]: lan-p3 {add} route 82.165.8.211 gw 10.32.234.254 scope 0 <=
UNIVERSE>
ofonod[23391]: PPP: lcp: pppcp_generate_event: current state 4:CLOSING
ofonod[23391]: PPP: event: 11 (RTA), action: 802, new_state: 2 (CLOSED)
ofonod[23391]: PPP: lcp: pppcp_this_layer_finished: current state 2:CLOSED
ofonod[23391]: PPP: ../ofono-1.19/gatchat/gatppp.c:ppp_enter_phase() 0
ofonod[23391]: PPP: ../ofono-1.19/gatchat/gatppp.c:ppp_dead() =

ofonod[23391]: ../ofono-1.19/drivers/atmodem/gprs-context.c:ppp_disconnect(=
) Reason: 6
connmand[22516]: ../connman-1.33/plugins/ofono.c:set_property_reply() /teli=
t_0 path /telit_0/context2 org.ofono.ConnectionContext.Active
connmand[22516]: ../connman-1.33/plugins/ofono.c:context_set_active_reply()=
 /telit_0/context2
method return time=3D1482938882.620585 sender=3D:1.2 -> destination=3D:1.0 =
serial=3D66 reply_serial=3D103
signal time=3D1482938882.622771 sender=3D:1.2 -> destination=3D(null destin=
ation) serial=3D67 path=3D/telit_0/context2; interface=3Dorg.ofono.Connecti=
onContext; member=3DPropertyChanged
   string "Settings"
   variant       array [
      ]
connmand[22516]: ../connman-1.33/plugins/ofono.c:context_changed() context_=
path /telit_0/context2
connmand[22516]: ../connman-1.33/plugins/ofono.c:get_context_with_path() pa=
th /telit_0/context2
connmand[22516]: ../connman-1.33/plugins/ofono.c:context_changed() /telit_0=
 Settings
connmand[22516]: ../connman-1.33/plugins/ofono.c:context_changed() context_=
path /telit_0/context2
connmand[22516]: ../connman-1.33/plugins/ofono.c:get_context_with_path() pa=
th /telit_0/context2
connmand[22516]: ../connman-1.33/plugins/ofono.c:context_changed() /telit_0=
 Active 0
connmand[22516]: ../connman-1.33/plugins/ofono.c:set_disconnected() /telit_=
0/context2
signal time=3D1482938882.640299 sender=3D:1.2 -> destination=3D(null destin=
ation) serial=3D68 path=3D/telit_0/context2; interface=3Dorg.ofono.Connecti=
onContext; member=3DPropertyChanged
   string "Active"
   variant       boolean false
[...]
signal time=3D1482938882.980342 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D123 path=3D/; interface=3Dnet.connman.Manager; member=3DSer=
vicesChanged
   array [
      struct {
         object path "/net/connman/service/ethernet_020000a01401_067_cable"
         array [
         ]
      }
      struct {
         object path "/net/connman/service/cellular_272032050058871_context=
2"
         array [
         ]
      }
   ]
   array [
   ]
ofonod[23391]: Modem: < \r\nNO CARRIER\r\n
ofonod[23391]: Aux: < \r\n
ofonod[23391]: Aux: < +CGEV: ME DEACT IP, "100.94.48.26", 1\r\n
ofonod[23391]: Aux: < \r\n
ofonod[23391]: Aux: < +CGREG: 0\r\n\r\n+CGEV: NW DETACH\r\n
ofonod[23391]: ../ofono-1.19/src/gprs.c:ofono_gprs_status_notify() /telit_0=
 status 0
ofonod[23391]: ../ofono-1.19/src/gprs.c:gprs_attached_update() gprs->attach=
ed/attached/gprs->driver_attached/gprs->status: 1/0/1/0
ofonod[23391]: ../ofono-1.19/src/gprs.c:gprs_attached_update() step A
ofonod[23391]: ../ofono-1.19/src/gprs.c:gprs_set_attached_property() gprs: =
attached current/new: 0x567cc8d0 1/0
connmand[22516]: ../connman-1.33/plugins/ofono.c:cm_update_attached() /teli=
t_0 Attached 0
connmand[22516]: ../connman-1.33/plugins/ofono.c:remove_network() /telit_0
connmand[22516]: ../connman-1.33/plugins/ofono.c:remove_network() network 0=
x56451280
connmand[22516]: Deleting host route failed (No such device)
connmand[22516]: Deleting host route failed (No such device)
connmand[22516]: ../connman-1.33/plugins/ofono.c:network_remove() /telit_0 =
network 0x56451280
signal time=3D1482938885.402960 sender=3D:1.2 -> destination=3D(null destin=
ation) serial=3D69 path=3D/telit_0; interface=3Dorg.ofono.ConnectionManager=
; member=3DPropertyChanged
   string "Attached"
   variant       boolean false
ofonod[23391]: ../ofono-1.19/src/gprs.c:gprs_attached_update() out
ofonod[23391]: ../ofono-1.19/src/gprs.c:ofono_gprs_detached_notify() /telit=
_0
ofonod[23391]: ../ofono-1.19/src/gprs.c:gprs_attached_update() gprs->attach=
ed/attached/gprs->driver_attached/gprs->status: 0/0/0/0
signal time=3D1482938885.504189 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D124 path=3D/; interface=3Dnet.connman.Manager; member=3DSer=
vicesChanged
   array [
      struct {
         object path "/net/connman/service/ethernet_020000a01401_067_cable"
         array [
         ]
      }
   ]
   array [
      object path "/net/connman/service/cellular_272032050058871_context2"
   ]

----- snap   disconnect & detach -----




----- snip=C2=A0=C2=A0=C2=A0auto re-connect     -----

root(a)tgm-r2:~# ofonod[23391]: Aux: < \r\n
ofonod[23391]: Aux: < +CGREG: 0\r\n\r\n+CREG: 1,"75AA","00C21B9",2\r\n
ofonod[23391]: ../ofono-1.19/src/gprs.c:ofono_gprs_status_notify() /telit_0=
 status 0
ofonod[23391]: ../ofono-1.19/src/gprs.c:gprs_attached_update() gprs->attach=
ed/attached/gprs->driver_attached/gprs->status: 0/0/0/0
ofonod[23391]: ../ofono-1.19/src/network.c:ofono_netreg_status_notify() /te=
lit_0 status 1 tech 2
signal time=3D1482939111.500577 sender=3D:1.2 -> destination=3D(null destin=
ation) serial=3D70 path=3D/telit_0; interface=3Dorg.ofono.NetworkRegistrati=
on; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "CellId"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint32 7=
95065
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat/g=
id/cmd/prefix_list/flags: 0x567c73e0/3/AT+COPS=3D3,2/0x563e91c0/0x0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat->=
command_queue/next_cmd_id: 0x77aa6e90/94,
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common()=C2=A0=
=C2=A0=C2=A0=C2=A0c: 0x567cd110
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat/g=
id/cmd/prefix_list/flags: 0x567c73e0/3/AT+COPS?/0x563ddc70/0x0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat->=
command_queue/next_cmd_id: 0x77aa6e90/95,
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common()=C2=A0=
=C2=A0=C2=A0=C2=A0c: 0x567d02c0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat/g=
id/cmd/prefix_list/flags: 0x567c73e0/3/AT+CIND?/0x563ddc60/0x0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat->=
command_queue/next_cmd_id: 0x77aa6e90/96,
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common()=C2=A0=
=C2=A0=C2=A0=C2=A0c: 0x567d04b0
ofonod[23391]: ../ofono-1.19/src/gprs.c:netreg_status_changed() 1
ofonod[23391]: ../ofono-1.19/src/gprs.c:gprs_netreg_update() attach: 1, dri=
ver_attached: 0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat/g=
id/cmd/prefix_list/flags: 0x567c73e0/10/AT+CGATT=3D1/0x563e9240/0x0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat->=
command_queue/next_cmd_id: 0x77aa6e90/97,
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common()=C2=A0=
=C2=A0=C2=A0=C2=A0c: 0x567cfe80
ofonod[23391]: Aux: > AT+COPS=3D3,2\r
ofonod[23391]: Aux: < \r\nOK\r\n
ofonod[23391]: Aux: > AT+COPS?\r
ofonod[23391]: Aux: < \r\n
ofonod[23391]: Aux: < +COPS: 0,2,"27203",2\r\n\r\nOK\r\n
ofonod[23391]: ../ofono-1.19/drivers/atmodem/network-registration.c:cops_nu=
meric_cb() Cops numeric got mcc: 272, mnc: 03
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat/g=
id/cmd/prefix_list/flags: 0x567c73e0/3/AT+COPS=3D3,0/0x563e91c0/0x0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat->=
command_queue/next_cmd_id: 0x77aa6e90/98,
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common()=C2=A0=
=C2=A0=C2=A0=C2=A0c: 0x567cd110k
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat/g=
id/cmd/prefix_list/flags: 0x567c73e0/3/AT+COPS?/0x563ddc70/0x0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat->=
command_queue/next_cmd_id: 0x77aa6e90/99,
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common()=C2=A0=
=C2=A0=C2=A0=C2=A0c: 0x567d3100
ofonod[23391]: Aux: > AT+CIND?\r
ofonod[23391]: Aux: < \r\n+CIND: 0,2,1,0,0,0,0,0,3\r\n\r\nOK\r\n
ofonod[23391]: Aux: > AT+CGATT=3D1\r
ofonod[23391]: Aux: < \r\nOK\r\n
ofonod[23391]: Aux: < \r\n+CGREG: 1,"75AA","00C21B9",2,"01"\r\n\r\n+CIEV: r=
ssi,5\r\n
ofonod[23391]: ../ofono-1.19/src/gprs.c:gprs_attach_callback() /telit_0 err=
or =3D 0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat/g=
id/cmd/prefix_list/flags: 0x567c73e0/10/AT+CGREG?/0x563ddf1c/0x0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat->=
command_queue/next_cmd_id: 0x77aa6e90/100,
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common()=C2=A0=
=C2=A0=C2=A0=C2=A0c: 0x567d02c0
ofonod[23391]: ../ofono-1.19/src/gprs.c:ofono_gprs_status_notify() /telit_0=
 status 1
ofonod[23391]: ../ofono-1.19/src/network.c:ofono_netreg_strength_notify() s=
trength 100
connmand[22516]: ../connman-1.33/plugins/ofono.c:netreg_update_strength() /=
telit_0 Strength 100
signal time=3D1482939112.767814 sender=3D:1.2 -> destination=3D(null destin=
ation) serial=3D71 path=3D/telit_0; interface=3Dorg.ofono.NetworkRegistrati=
on; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "Strength"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0byte 100
ofonod[23391]: Aux: > AT+COPS=3D3,0\r
ofonod[23391]: Aux: < \r\nOK\r\n
ofonod[23391]: Aux: > AT+COPS?\r
ofonod[23391]: Aux: < \r\n
ofonod[23391]: Aux: < +COPS: 0,0,"eir",2\r\n\r\nOK\r\n
ofonod[23391]: ../ofono-1.19/drivers/atmodem/network-registration.c:cops_cb=
() cops_cb: eir, 272 03 2
ofonod[23391]: ../ofono-1.19/src/network.c:current_operator_callback() 0x56=
7c64f0, 0x567d0430
ofonod[23391]: Aux: > AT+CGREG?\r
ofonod[23391]: Aux: < \r\n
ofonod[23391]: Aux: < +CGREG: 2,1,"75AA","00C21B9",2,"01"\r\n\r\nOK\r\n
ofonod[23391]: ../ofono-1.19/src/gprs.c:registration_status_cb() /telit_0 e=
rror 0 status 1
ofonod[23391]: ../ofono-1.19/src/gprs.c:ofono_gprs_status_notify() /telit_0=
 status 1
ofonod[23391]: ../ofono-1.19/src/gprs.c:gprs_attached_update() gprs->attach=
ed/attached/gprs->driver_attached/gprs->status: 0/1/1/1
ofonod[23391]: ../ofono-1.19/src/gprs.c:gprs_set_attached_property() gprs: =
attached current/new: 0x567cc8d0 0/1
connmand[22516]: ../connman-1.33/plugins/ofono.c:cm_update_attached() /teli=
t_0 Attached 1
connmand[22516]: ../connman-1.33/plugins/ofono.c:get_properties() /telit_0 =
path /telit_0 org.ofono.NetworkRegistration
signal time=3D1482939112.830363 sender=3D:1.2 -> destination=3D(null destin=
ation) serial=3D72 path=3D/telit_0; interface=3Dorg.ofono.ConnectionManager=
; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "Attached"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0boolean =
true
method call time=3D1482939112.831631 sender=3D:1.0 -> destination=3Dorg.ofo=
no serial=3D125 path=3D/telit_0; interface=3Dorg.ofono.NetworkRegistration;=
 member=3DGetProperties
ofonod[23391]: ../ofono-1.19/src/gprs.c:gprs_attached_update() out
connmand[22516]: ../connman-1.33/plugins/ofono.c:get_properties_reply() /te=
lit_0 path /telit_0 org.ofono.NetworkRegistration
connmand[22516]: ../connman-1.33/plugins/ofono.c:netreg_properties_reply() =
/telit_0
connmand[22516]: ../connman-1.33/plugins/ofono.c:netreg_update_regdom() /te=
lit_0 MobileContryCode 272
connmand[22516]: ../connman-1.33/plugins/ofono.c:netreg_update_name() /teli=
t_0 Name eir
connmand[22516]: ../connman-1.33/plugins/ofono.c:netreg_update_strength() /=
telit_0 Strength 100
connmand[22516]: ../connman-1.33/plugins/ofono.c:add_network() /telit_0
connmand[22516]: ../connman-1.33/plugins/ofono.c:add_network() network 0x56=
452a20
connmand[22516]: ../connman-1.33/plugins/ofono.c:network_probe() /telit_0 n=
etwork 0x56452a20
connmand[22516]: ../connman-1.33/plugins/ofono.c:network_probe() /telit_0 n=
etwork 0x56452a20
method return time=3D1482939112.840127 sender=3D:1.2 -> destination=3D:1.0 =
serial=3D73 reply_serial=3D125
=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "Status"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "r=
egistered"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "Mode"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "a=
uto"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "LocationAreaC=
ode"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint16 30=
122
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "CellId"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint32 79=
5065
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "Technology"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "u=
mts"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "MobileCountry=
Code"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "2=
72"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "MobileNetwork=
Code"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "0=
3"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "Name"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "e=
ir"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "Strength"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0byte 100
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0]
signal time=3D1482939112.942121 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D126 path=3D/; interface=3Dnet.connman.Manager; member=3DSer=
vicesChanged
=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0object path "/net/con=
nman/service/ethernet_020000a01401_067_cable"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0object path "/net/con=
nman/service/cellular_272032050058871_context2"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dic=
t entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0string "Type"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "cell=
ular"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dic=
t entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0string "Security"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dic=
t entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0string "State"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "idle"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dic=
t entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0string "Strength"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0byte 100
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dic=
t entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0string "Favorite"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0boolean true
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dic=
t entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0string "Immutable"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0boolean false
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dic=
t entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0string "AutoConnect"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0boolean true
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dic=
t entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0string "Name"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "eir"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dic=
t entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0string "Roaming"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0boolean false
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dic=
t entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0string "Ethernet"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string=
 "Method"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0varian=
t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0string "auto"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dic=
t entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0string "IPv4"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dic=
t entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0string "IPv4.Configuration"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string=
 "Method"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0varian=
t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0string "fixed"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string=
 "Address"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0varian=
t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0string "100.94.48.26"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string=
 "Netmask"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0varian=
t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0string "255.255.255.255"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dic=
t entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0string "IPv6"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dic=
t entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0string "IPv6.Configuration"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string=
 "Method"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0varian=
t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0string "off"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dic=
t entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0string "Nameservers"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dic=
t entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0string "Nameservers.Configuration"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dic=
t entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0string "Timeservers"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dic=
t entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0string "Timeservers.Configuration"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dic=
t entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0string "Domains"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dic=
t entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0string "Domains.Configuration"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dic=
t entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0string "Proxy"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dic=
t entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0string "Proxy.Configuration"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dic=
t entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0string "Provider"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0]
connmand[22516]: Skipping disconnect of /telit_0/context2, network is conne=
cting.
connmand[22516]: ../connman-1.33/plugins/ofono.c:network_connect() /telit_0=
 network 0x56452a20
connmand[22516]: ../connman-1.33/plugins/ofono.c:get_context_with_network()=
 network 0x56452a20
connmand[22516]: ../connman-1.33/plugins/ofono.c:context_set_active() /teli=
t_0 active 1
connmand[22516]: ../connman-1.33/plugins/ofono.c:set_property() /telit_0 pa=
th /telit_0/context2 org.ofono.ConnectionContext.Active
connmand[22516]: ipconfig state 2 ipconfig method 1
method call time=3D1482939113.290993 sender=3D:1.0 -> destination=3Dorg.ofo=
no serial=3D127 path=3D/telit_0/context2; interface=3Dorg.ofono.ConnectionC=
ontext; member=3DSetProperty
=C2=A0=C2=A0=C2=A0string "Active"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0boolean =
true
signal time=3D1482939113.291173 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D128 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "Timeservers"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
signal time=3D1482939113.291303 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D129 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "State"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "=
association"
signal time=3D1482939113.629315 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D130 path=3D/; interface=3Dnet.connman.Manager; member=3DSer=
vicesChanged
=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0object path "/net/con=
nman/service/ethernet_020000a01401_067_cable"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0object path "/net/con=
nman/service/cellular_272032050058871_context2"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0]
ofonod[23391]: ../ofono-1.19/drivers/atmodem/gprs-context.c:at_gprs_activat=
e_primary() cid 1
ofonod[23391]: ../ofono-1.19/drivers/atmodem/gprs-context.c:at_gprs_activat=
e_primary() ctx->auth_method 0 chap
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat/g=
id/cmd/prefix_list/flags: 0x567c78c0/1/AT+CGDCONT=3D1,"IP","data.eircom.ie"=
/0x563e9250/0x0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat->=
command_queue/next_cmd_id: 0x77aa6eb0/5,
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common()=C2=A0=
=C2=A0=C2=A0=C2=A0c: 0x567d02b0
ofonod[23391]: Modem: > AT+CGDCONT=3D1,"IP","data.eircom.ie"\r
ofonod[23391]: Modem: < \r\nOK\r\n
ofonod[23391]: ../ofono-1.19/drivers/atmodem/gprs-context.c:at_cgdcont_cb()=
 ok 1
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat/g=
id/cmd/prefix_list/flags: 0x567c78c0/1/AT+CGDATA=3D"PPP",1/0x563e9250/0x0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat->=
command_queue/next_cmd_id: 0x77aa6eb0/6,
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common()=C2=A0=
=C2=A0=C2=A0=C2=A0c: 0x567cd110
ofonod[23391]: Modem: > AT+CGDATA=3D"PPP",1\r
ofonod[23391]: Modem: < \r\nCONNECT\r\n
ofonod[23391]: ../ofono-1.19/drivers/atmodem/gprs-context.c:at_cgdata_cb() =
ok 1
ofonod[23391]: ../ofono-1.19/drivers/atmodem/gprs-context.c:setup_ppp()=C2=
=A0
ofonod[23391]: PPP: lcp: pppcp_generate_event: current state 0:INITIAL
ofonod[23391]: PPP: event: 0 (Up), action: 2, new_state: 2 (CLOSED)
ofonod[23391]: PPP: lcp: pppcp_generate_event: current state 2:CLOSED
ofonod[23391]: PPP: event: 2 (Open), action: 1026, new_state: 6 (REQSENT)
ofonod[23391]: PPP: lcp: pppcp_initialize_restart_count: current state 2:CL=
OSED
ofonod[23391]: PPP: lcp: pppcp_send_configure_request: current state 2:CLOS=
ED
ofonod[23391]: PPP: ../ofono-1.19/gatchat/gatppp.c:ppp_enter_phase() 1
ofonod[23391]: PPP: lcp: pppcp_process_configure_request: current state 6:R=
EQSENT
ofonod[23391]: PPP: lcp: pppcp_generate_event: current state 6:REQSENT
ofonod[23391]: PPP: event: 6 (RCR+), action: 2008, new_state: 8 (ACKSENT)
ofonod[23391]: PPP: lcp: pppcp_send_configure_ack: current state 6:REQSENT
ofonod[23391]: PPP: lcp: pppcp_process_configure_ack: current state 8:ACKSE=
NT
ofonod[23391]: PPP: lcp: pppcp_generate_event: current state 8:ACKSENT
ofonod[23391]: PPP: event: 8 (RCA), action: 129, new_state: 9 (OPENED)
ofonod[23391]: PPP: lcp: pppcp_initialize_restart_count: current state 8:AC=
KSENT
ofonod[23391]: PPP: ../ofono-1.19/gatchat/gatppp.c:ppp_enter_phase() 3
ofonod[23391]: PPP: ipcp: pppcp_generate_event: current state 0:INITIAL
ofonod[23391]: PPP: event: 2 (Open), action: 401, new_state: 1 (STARTING)
ofonod[23391]: PPP: ipcp: pppcp_generate_event: current state 1:STARTING
ofonod[23391]: PPP: event: 0 (Up), action: 1026, new_state: 6 (REQSENT)
ofonod[23391]: PPP: ipcp: pppcp_initialize_restart_count: current state 1:S=
TARTING
ofonod[23391]: PPP: ipcp: pppcp_send_configure_request: current state 1:STA=
RTING
ofonod[23391]: PPP: ipcp: pppcp_timeout: current state 6:REQSENT
ofonod[23391]: PPP: ipcp: pppcp_generate_event: current state 6:REQSENT
ofonod[23391]: PPP: event: 4 (TO+), action: 1006, new_state: 6 (REQSENT)
ofonod[23391]: PPP: ipcp: pppcp_send_configure_request: current state 6:REQ=
SENT
ofonod[23391]: PPP: ipcp: pppcp_process_configure_request: current state 6:=
REQSENT
ofonod[23391]: PPP: ipcp: pppcp_generate_event: current state 6:REQSENT
ofonod[23391]: PPP: event: 6 (RCR+), action: 2008, new_state: 8 (ACKSENT)
ofonod[23391]: PPP: ipcp: pppcp_send_configure_ack: current state 6:REQSENT
ofonod[23391]: PPP: ipcp: pppcp_process_configure_reject: current state 8:A=
CKSENT
ofonod[23391]: PPP: ipcp: pppcp_generate_event: current state 8:ACKSENT
ofonod[23391]: PPP: event: 9 (RCN), action: 1028, new_state: 8 (ACKSENT)
ofonod[23391]: PPP: ipcp: pppcp_initialize_restart_count: current state 8:A=
CKSENT
ofonod[23391]: PPP: ipcp: pppcp_send_configure_request: current state 8:ACK=
SENT
ofonod[23391]: PPP: ipcp: pppcp_process_configure_nak: current state 8:ACKS=
ENT
ofonod[23391]: PPP: ipcp: pppcp_generate_event: current state 8:ACKSENT
ofonod[23391]: PPP: event: 9 (RCN), action: 1028, new_state: 8 (ACKSENT)
ofonod[23391]: PPP: ipcp: pppcp_initialize_restart_count: current state 8:A=
CKSENT
ofonod[23391]: PPP: ipcp: pppcp_send_configure_request: current state 8:ACK=
SENT
ofonod[23391]: Aux: < \r\n#PSNT: 3\r\n
signal time=3D1482939117.037235 sender=3D:1.2 -> destination=3D(null destin=
ation) serial=3D74 path=3D/telit_0; interface=3Dorg.ofono.ConnectionManager=
; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "Bearer"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "=
hsdpa"
ofonod[23391]: PPP: ipcp: pppcp_process_configure_ack: current state 8:ACKS=
ENT
ofonod[23391]: PPP: ipcp: pppcp_generate_event: current state 8:ACKSENT
ofonod[23391]: PPP: event: 8 (RCA), action: 129, new_state: 9 (OPENED)
ofonod[23391]: PPP: ipcp: pppcp_initialize_restart_count: current state 8:A=
CKSENT
connmand[22516]: ppp0 {create} index 16 type 65534 <NONE>
connmand[22516]: ppp0 {update} flags 4240 <DOWN>
connmand[22516]: ppp0 {newlink} index 16 address 00:00:00:00:00:00 mtu 1500
connmand[22516]: ppp0 {newlink} index 16 operstate 2 <DOWN>
ofonod[23391]: PPP: ../ofono-1.19/gatchat/gatppp.c:ppp_enter_phase() 4
ofonod[23391]: ../ofono-1.19/drivers/atmodem/gprs-context.c:ppp_connect()=
=C2=A0
ofonod[23391]: IP: 100.94.6.59
ofonod[23391]: PTP: 0.0.0.0
ofonod[23391]: DNS: 159.134.0.11, 159.134.0.12
ofonod[23391]: ../ofono-1.19/src/gprs.c:pri_activate_callback() 0x567ceeb0
connmand[22516]: ../connman-1.33/plugins/ofono.c:set_property_reply() /teli=
t_0 path /telit_0/context2 org.ofono.ConnectionContext.Active
connmand[22516]: ../connman-1.33/plugins/ofono.c:context_set_active_reply()=
 /telit_0/context2
method return time=3D1482939117.089099 sender=3D:1.2 -> destination=3D:1.0 =
serial=3D75 reply_serial=3D127
connmand[22516]: ppp0 {update} flags 69841 <UP,RUNNING,LOWER_UP>
connmand[22516]: ppp0 {newlink} index 16 address 00:00:00:00:00:00 mtu 1500
connmand[22516]: ppp0 {newlink} index 16 operstate 0 <UNKNOWN>
signal time=3D1482939117.094404 sender=3D:1.2 -> destination=3D(null destin=
ation) serial=3D76 path=3D/telit_0/context2; interface=3Dorg.ofono.Connecti=
onContext; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "Settings"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0str=
ing "Interface"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var=
iant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0string "ppp0"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0str=
ing "Method"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var=
iant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0string "static"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0str=
ing "Address"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var=
iant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0string "100.94.6.59"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0str=
ing "Netmask"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var=
iant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0string "255.255.255.255"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0str=
ing "DomainNameServers"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var=
iant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "159.134.0.11"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "159.134.0.12"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
connmand[22516]: ../connman-1.33/plugins/ofono.c:context_changed() context_=
path /telit_0/context2
connmand[22516]: ../connman-1.33/plugins/ofono.c:get_context_with_path() pa=
th /telit_0/context2
connmand[22516]: ../connman-1.33/plugins/ofono.c:context_changed() /telit_0=
 Settings
connmand[22516]: ../connman-1.33/plugins/ofono.c:extract_ipv4_settings() In=
terface ppp0
connmand[22516]: ../connman-1.33/plugins/ofono.c:extract_ipv4_settings() in=
dex 16
connmand[22516]: ../connman-1.33/plugins/ofono.c:extract_ipv4_settings() Me=
thod static
connmand[22516]: ../connman-1.33/plugins/ofono.c:extract_ipv4_settings() Ad=
dress 100.94.6.59
connmand[22516]: ../connman-1.33/plugins/ofono.c:extract_ipv4_settings() Ne=
tmask 255.255.255.255
connmand[22516]: ../connman-1.33/plugins/ofono.c:extract_ipv4_settings() Na=
meservers 159.134.0.11 159.134.0.12
signal time=3D1482939117.100696 sender=3D:1.2 -> destination=3D(null destin=
ation) serial=3D77 path=3D/telit_0/context2; interface=3Dorg.ofono.Connecti=
onContext; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "Active"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0boolean =
true
connmand[22516]: ../connman-1.33/plugins/ofono.c:context_changed() context_=
path /telit_0/context2
connmand[22516]: ../connman-1.33/plugins/ofono.c:get_context_with_path() pa=
th /telit_0/context2
connmand[22516]: ../connman-1.33/plugins/ofono.c:context_changed() /telit_0=
 Active 1
connmand[22516]: ../connman-1.33/plugins/ofono.c:set_connected() /telit_0
signal time=3D1482939117.106322 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D131 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "Timeservers"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
signal time=3D1482939117.443707 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D132 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "State"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "=
configuration"
signal time=3D1482939117.443860 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D133 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "Ethernet"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0str=
ing "Method"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var=
iant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0string "auto"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0str=
ing "Interface"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var=
iant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0string "ppp0"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0str=
ing "Address"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var=
iant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0string "00:00:00:00:00:00"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0str=
ing "MTU"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var=
iant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0uint16 1500
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
ofonod[23391]: ../ofono-1.19/plugins/udev.c:udev_event() subsystem net add
connmand[22516]: Adding host route failed (Invalid argument)
connmand[22516]: Adding host route failed (Invalid argument)
signal time=3D1482939117.449166 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D134 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "Timeservers"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
ofonod[23391]: ../ofono-1.19/plugins/udev.c:udev_event() subsystem net fini=
shed
signal time=3D1482939117.452321 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D135 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "State"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "=
ready"
signal time=3D1482939117.463933 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D136 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "Nameservers"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "159.134.0.11"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "159.134.0.12"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
signal time=3D1482939117.465312 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D137 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "Domains"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
signal time=3D1482939117.466694 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D138 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "Proxy"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0str=
ing "Method"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var=
iant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0string "direct"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
signal time=3D1482939117.468090 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D139 path=3D/net/connman/technology/cellular; interface=3Dne=
t.connman.Technology; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "Connected"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0boolean =
true
connmand[22516]: ipconfig state 3 ipconfig method 1
connmand[22516]: ppp0 {add} address 100.94.6.59/32 label ppp0 family 2
signal time=3D1482939117.471525 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D140 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "IPv4"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0str=
ing "Method"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var=
iant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0string "fixed"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0str=
ing "Address"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var=
iant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0string "100.94.6.59"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0str=
ing "Netmask"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var=
iant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0string "255.255.255.255"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
signal time=3D1482939117.473153 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D141 path=3D/; interface=3Dnet.connman.Manager; member=3DSer=
vicesChanged
=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0object path "/net/con=
nman/service/ethernet_020000a01401_067_cable"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0object path "/net/con=
nman/service/cellular_272032050058871_context2"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0]
connmand[22516]: ppp0 {add} route 100.94.6.59 gw 0.0.0.0 scope 253 <LINK>
connmand[22516]: ppp0 {add} route 159.134.0.11 gw 0.0.0.0 scope 253 <LINK>
connmand[22516]: ppp0 {add} route 159.134.0.12 gw 0.0.0.0 scope 253 <LINK>
ofonod[23391]: ../ofono-1.19/plugins/udevng.c:check_modem_list()=C2=A0
signal time=3D1482939118.643066 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D142 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "Timeservers"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
signal time=3D1482939118.644373 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D143 path=3D/; interface=3Dnet.connman.Manager; member=3DPro=
pertyChanged
=C2=A0=C2=A0=C2=A0string "State"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "=
ready"
signal time=3D1482939118.645685 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D144 path=3D/net/connman/service/ethernet_020000a01401_067_c=
able; interface=3Dnet.connman.Service; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "State"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "=
ready"
signal time=3D1482939118.648141 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D145 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "Timeservers"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
signal time=3D1482939118.651379 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D146 path=3D/net/connman/service/ethernet_020000a01401_067_c=
able; interface=3Dnet.connman.Service; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "Timeservers"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
signal time=3D1482939118.654578 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D147 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "Timeservers"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
signal time=3D1482939118.656642 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D148 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "State"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "=
online"
signal time=3D1482939118.658276 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D149 path=3D/; interface=3Dnet.connman.Manager; member=3DPro=
pertyChanged
=C2=A0=C2=A0=C2=A0string "State"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "=
online"
signal time=3D1482939118.662615 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D150 path=3D/net/connman/service/ethernet_020000a01401_067_c=
able; interface=3Dnet.connman.Service; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "IPv4"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0str=
ing "Method"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var=
iant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0string "dhcp"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0str=
ing "Address"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var=
iant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0string "10.32.234.98"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0str=
ing "Netmask"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var=
iant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0string "255.255.255.0"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
connmand[22516]: lan-p3 {del} route 0.0.0.0 gw 10.32.234.254 scope 0 <UNIVE=
RSE>
connmand[22516]: ppp0 {add} route 0.0.0.0 gw 0.0.0.0 scope 253 <LINK>
signal time=3D1482939118.759317 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D151 path=3D/; interface=3Dnet.connman.Manager; member=3DSer=
vicesChanged
=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0object path "/net/con=
nman/service/cellular_272032050058871_context2"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0object path "/net/con=
nman/service/ethernet_020000a01401_067_cable"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0]
signal time=3D1482939119.274598 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D152 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "Timeservers"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
ofonod[23391]: Aux: < \r\n
ofonod[23391]: Aux: < #PSNT: 2\r\n
signal time=3D1482939127.025764 sender=3D:1.2 -> destination=3D(null destin=
ation) serial=3D78 path=3D/telit_0; interface=3Dorg.ofono.ConnectionManager=
; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "Bearer"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "=
umts"
ofonod[23391]: Aux: < \r\n+CGREG: 1,"75AA","00CCB55",2,"01"\r\n\r\n+CREG: 1=
,"75AA","00CCB55",2\r\n
ofonod[23391]: ../ofono-1.19/src/gprs.c:ofono_gprs_status_notify() /telit_0=
 status 1
ofonod[23391]: ../ofono-1.19/src/gprs.c:gprs_attached_update() gprs->attach=
ed/attached/gprs->driver_attached/gprs->status: 1/1/1/1
ofonod[23391]: ../ofono-1.19/src/network.c:ofono_netreg_status_notify() /te=
lit_0 status 1 tech 2
signal time=3D1482939146.702388 sender=3D:1.2 -> destination=3D(null destin=
ation) serial=3D79 path=3D/telit_0; interface=3Dorg.ofono.NetworkRegistrati=
on; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "CellId"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint32 8=
38485
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat/g=
id/cmd/prefix_list/flags: 0x567c73e0/3/AT+COPS=3D3,2/0x563e91c0/0x0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat->=
command_queue/next_cmd_id: 0x77aa6e90/101,
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common()=C2=A0=
=C2=A0=C2=A0=C2=A0c: 0x567d3eb0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat/g=
id/cmd/prefix_list/flags: 0x567c73e0/3/AT+COPS?/0x563ddc70/0x0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat->=
command_queue/next_cmd_id: 0x77aa6e90/102,
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common()=C2=A0=
=C2=A0=C2=A0=C2=A0c: 0x567d3fb0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat/g=
id/cmd/prefix_list/flags: 0x567c73e0/3/AT+CIND?/0x563ddc60/0x0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat->=
command_queue/next_cmd_id: 0x77aa6e90/103,
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common()=C2=A0=
=C2=A0=C2=A0=C2=A0c: 0x567cf600
ofonod[23391]: ../ofono-1.19/src/gprs.c:netreg_status_changed() 1
ofonod[23391]: ../ofono-1.19/src/gprs.c:gprs_netreg_update() attach: 1, dri=
ver_attached: 1
ofonod[23391]: Aux: > AT+COPS=3D3,2\r
ofonod[23391]: Aux: < \r\nOK\r\n
ofonod[23391]: Aux: > AT+COPS?\r
ofonod[23391]: Aux: < \r\n
ofonod[23391]: Aux: < +COPS: 0,2,"27203",2\r\n\r\nOK\r\n
ofonod[23391]: ../ofono-1.19/drivers/atmodem/network-registration.c:cops_nu=
meric_cb() Cops numeric got mcc: 272, mnc: 03
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat/g=
id/cmd/prefix_list/flags: 0x567c73e0/3/AT+COPS=3D3,0/0x563e91c0/0x0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat->=
command_queue/next_cmd_id: 0x77aa6e90/104,
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common()=C2=A0=
=C2=A0=C2=A0=C2=A0c: 0x567d3f50
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat/g=
id/cmd/prefix_list/flags: 0x567c73e0/3/AT+COPS?/0x563ddc70/0x0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat->=
command_queue/next_cmd_id: 0x77aa6e90/105,
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common()=C2=A0=
=C2=A0=C2=A0=C2=A0c: 0x567cf690
ofonod[23391]: Aux: > AT+CIND?\r
ofonod[23391]: Aux: < \r\n
ofonod[23391]: Aux: < +CIND: 0,4,1,0,0,0,0,0,5\r\n\r\nOK\r\n
ofonod[23391]: Aux: > AT+COPS=3D3,0\r
ofonod[23391]: Aux: < \r\nOK\r\n
ofonod[23391]: Aux: > AT+COPS?\r
ofonod[23391]: Aux: < \r\n
ofonod[23391]: Aux: < +COPS: 0,0,"eir",2\r\n\r\nOK\r\n
ofonod[23391]: ../ofono-1.19/drivers/atmodem/network-registration.c:cops_cb=
() cops_cb: eir, 272 03 2
ofonod[23391]: ../ofono-1.19/src/network.c:current_operator_callback() 0x56=
7c64f0, 0x567d0430
ofonod[23391]: Aux: < \r\n+CIEV: rssi,3\r\n
ofonod[23391]: ../ofono-1.19/src/network.c:ofono_netreg_strength_notify() s=
trength 60
connmand[22516]: ../connman-1.33/plugins/ofono.c:netreg_update_strength() /=
telit_0 Strength 60
signal time=3D1482939147.027769 sender=3D:1.2 -> destination=3D(null destin=
ation) serial=3D80 path=3D/telit_0; interface=3Dorg.ofono.NetworkRegistrati=
on; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "Strength"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0byte 60
signal time=3D1482939147.028856 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D153 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "Strength"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0byte 60
signal time=3D1482939147.128997 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D154 path=3D/; interface=3Dnet.connman.Manager; member=3DSer=
vicesChanged
=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0object path "/net/con=
nman/service/cellular_272032050058871_context2"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0object path "/net/con=
nman/service/ethernet_020000a01401_067_cable"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0]
ofonod[23391]: Aux: < \r\n
ofonod[23391]: Aux: < +CGREG: 1,"75AA","00C21B9",2,"01"\r\n\r\n+CREG: 1,"75=
AA","00C21B9",2\r\n
ofonod[23391]: ../ofono-1.19/src/gprs.c:ofono_gprs_status_notify() /telit_0=
 status 1
ofonod[23391]: ../ofono-1.19/src/gprs.c:gprs_attached_update() gprs->attach=
ed/attached/gprs->driver_attached/gprs->status: 1/1/1/1
ofonod[23391]: ../ofono-1.19/src/network.c:ofono_netreg_status_notify() /te=
lit_0 status 1 tech 2
signal time=3D1482940398.545425 sender=3D:1.2 -> destination=3D(null destin=
ation) serial=3D81 path=3D/telit_0; interface=3Dorg.ofono.NetworkRegistrati=
on; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "CellId"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint32 7=
95065
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat/g=
id/cmd/prefix_list/flags: 0x567c73e0/3/AT+COPS=3D3,2/0x563e91c0/0x0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat->=
command_queue/next_cmd_id: 0x77aa6e90/106,
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common()=C2=A0=
=C2=A0=C2=A0=C2=A0c: 0x567d3eb0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat/g=
id/cmd/prefix_list/flags: 0x567c73e0/3/AT+COPS?/0x563ddc70/0x0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat->=
command_queue/next_cmd_id: 0x77aa6e90/107,
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common()=C2=A0=
=C2=A0=C2=A0=C2=A0c: 0x567d3fb0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat/g=
id/cmd/prefix_list/flags: 0x567c73e0/3/AT+CIND?/0x563ddc60/0x0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat->=
command_queue/next_cmd_id: 0x77aa6e90/108,
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common()=C2=A0=
=C2=A0=C2=A0=C2=A0c: 0x567cf600
ofonod[23391]: ../ofono-1.19/src/gprs.c:netreg_status_changed() 1
ofonod[23391]: ../ofono-1.19/src/gprs.c:gprs_netreg_update() attach: 1, dri=
ver_attached: 1
ofonod[23391]: Aux: > AT+COPS=3D3,2\r
ofonod[23391]: Aux: < \r\nOK\r\n
ofonod[23391]: Aux: > AT+COPS?\r
ofonod[23391]: Aux: < \r\n
ofonod[23391]: Aux: < +COPS: 0,2,"27203",2\r\n\r\nOK\r\n
ofonod[23391]: ../ofono-1.19/drivers/atmodem/network-registration.c:cops_nu=
meric_cb() Cops numeric got mcc: 272, mnc: 03
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat/g=
id/cmd/prefix_list/flags: 0x567c73e0/3/AT+COPS=3D3,0/0x563e91c0/0x0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat->=
command_queue/next_cmd_id: 0x77aa6e90/109,
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common()=C2=A0=
=C2=A0=C2=A0=C2=A0c: 0x567d3f50
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat/g=
id/cmd/prefix_list/flags: 0x567c73e0/3/AT+COPS?/0x563ddc70/0x0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat->=
command_queue/next_cmd_id: 0x77aa6e90/110,
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common()=C2=A0=
=C2=A0=C2=A0=C2=A0c: 0x567cf690
ofonod[23391]: Aux: > AT+CIND?\r
ofonod[23391]: Aux: < \r\n
ofonod[23391]: Aux: < +CIND: 0,3,1,0,0,0,0,0,3\r\n\r\nOK\r\n
ofonod[23391]: Aux: > AT+COPS=3D3,0\r
ofonod[23391]: Aux: < \r\nOK\r\n
ofonod[23391]: Aux: > AT+COPS?\r
ofonod[23391]: Aux: < \r\n
ofonod[23391]: Aux: < +COPS: 0,0,"eir",2\r\n\r\nOK\r\n
ofonod[23391]: ../ofono-1.19/drivers/atmodem/network-registration.c:cops_cb=
() cops_cb: eir, 272 03 2
ofonod[23391]: ../ofono-1.19/src/network.c:current_operator_callback() 0x56=
7c64f0, 0x567d0430
ofonod[23391]: Aux: < \r\n
ofonod[23391]: Aux: < +CGREG: 1,"75AA","00CCB55",2,"01"\r\n\r\n+CREG: 1,"75=
AA","00CCB55",2\r\n
ofonod[23391]: ../ofono-1.19/src/gprs.c:ofono_gprs_status_notify() /telit_0=
 status 1
ofonod[23391]: ../ofono-1.19/src/gprs.c:gprs_attached_update() gprs->attach=
ed/attached/gprs->driver_attached/gprs->status: 1/1/1/1
ofonod[23391]: ../ofono-1.19/src/network.c:ofono_netreg_status_notify() /te=
lit_0 status 1 tech 2
signal time=3D1482940401.744378 sender=3D:1.2 -> destination=3D(null destin=
ation) serial=3D82 path=3D/telit_0; interface=3Dorg.ofono.NetworkRegistrati=
on; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "CellId"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint32 8=
38485
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat/g=
id/cmd/prefix_list/flags: 0x567c73e0/3/AT+COPS=3D3,2/0x563e91c0/0x0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat->=
command_queue/next_cmd_id: 0x77aa6e90/111,
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common()=C2=A0=
=C2=A0=C2=A0=C2=A0c: 0x567d3eb0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat/g=
id/cmd/prefix_list/flags: 0x567c73e0/3/AT+COPS?/0x563ddc70/0x0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat->=
command_queue/next_cmd_id: 0x77aa6e90/112,
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common()=C2=A0=
=C2=A0=C2=A0=C2=A0c: 0x567d3fb0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat/g=
id/cmd/prefix_list/flags: 0x567c73e0/3/AT+CIND?/0x563ddc60/0x0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat->=
command_queue/next_cmd_id: 0x77aa6e90/113,
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common()=C2=A0=
=C2=A0=C2=A0=C2=A0c: 0x567cf600
ofonod[23391]: ../ofono-1.19/src/gprs.c:netreg_status_changed() 1
ofonod[23391]: ../ofono-1.19/src/gprs.c:gprs_netreg_update() attach: 1, dri=
ver_attached: 1
ofonod[23391]: Aux: > AT+COPS=3D3,2\r
ofonod[23391]: Aux: < \r\nOK\r\n
ofonod[23391]: Aux: < \r\n+CIEV: rssi,4\r\n
ofonod[23391]: ../ofono-1.19/src/network.c:ofono_netreg_strength_notify() s=
trength 80
connmand[22516]: ../connman-1.33/plugins/ofono.c:netreg_update_strength() /=
telit_0 Strength 80
signal time=3D1482940401.793832 sender=3D:1.2 -> destination=3D(null destin=
ation) serial=3D83 path=3D/telit_0; interface=3Dorg.ofono.NetworkRegistrati=
on; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "Strength"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0byte 80
signal time=3D1482940401.794866 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D155 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "Strength"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0byte 80
ofonod[23391]: Aux: > AT+COPS?\r
ofonod[23391]: Aux: < \r\n
ofonod[23391]: Aux: < +COPS: 0,2,"27203",2\r\n\r\nOK\r\n
ofonod[23391]: ../ofono-1.19/drivers/atmodem/network-registration.c:cops_nu=
meric_cb() Cops numeric got mcc: 272, mnc: 03
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat/g=
id/cmd/prefix_list/flags: 0x567c73e0/3/AT+COPS=3D3,0/0x563e91c0/0x0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat->=
command_queue/next_cmd_id: 0x77aa6e90/114,
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common()=C2=A0=
=C2=A0=C2=A0=C2=A0c: 0x567d3f50
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat/g=
id/cmd/prefix_list/flags: 0x567c73e0/3/AT+COPS?/0x563ddc70/0x0
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common() chat->=
command_queue/next_cmd_id: 0x77aa6e90/115,
ofonod[23391]: ../ofono-1.19/gatchat/gatchat.c:at_chat_send_common()=C2=A0=
=C2=A0=C2=A0=C2=A0c: 0x567cf690
ofonod[23391]: Aux: > AT+CIND?\r
ofonod[23391]: Aux: < \r\n
ofonod[23391]: Aux: < +CIND: 0,4,1,0,0,0,0,0,4\r\n\r\nOK\r\n
ofonod[23391]: Aux: > AT+COPS=3D3,0\r
ofonod[23391]: Aux: < \r\nOK\r\n
ofonod[23391]: Aux: > AT+COPS?\r
ofonod[23391]: Aux: < \r\n
ofonod[23391]: Aux: < +COPS: 0,0,"eir",2\r\n\r\nOK\r\n
ofonod[23391]: ../ofono-1.19/drivers/atmodem/network-registration.c:cops_cb=
() cops_cb: eir, 272 03 2
ofonod[23391]: ../ofono-1.19/src/network.c:current_operator_callback() 0x56=
7c64f0, 0x567d0430
signal time=3D1482940401.895081 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D156 path=3D/; interface=3Dnet.connman.Manager; member=3DSer=
vicesChanged
=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0object path "/net/con=
nman/service/cellular_272032050058871_context2"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0object path "/net/con=
nman/service/ethernet_020000a01401_067_cable"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0]
ofonod[23391]: Aux: < \r\n
ofonod[23391]: Aux: < +CIEV: rssi,3\r\n
ofonod[23391]: ../ofono-1.19/src/network.c:ofono_netreg_strength_notify() s=
trength 60
connmand[22516]: ../connman-1.33/plugins/ofono.c:netreg_update_strength() /=
telit_0 Strength 60
signal time=3D1482940406.794630 sender=3D:1.2 -> destination=3D(null destin=
ation) serial=3D84 path=3D/telit_0; interface=3Dorg.ofono.NetworkRegistrati=
on; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "Strength"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0byte 60
signal time=3D1482940406.795715 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D157 path=3D/net/connman/service/cellular_272032050058871_co=
ntext2; interface=3Dnet.connman.Service; member=3DPropertyChanged
=C2=A0=C2=A0=C2=A0string "Strength"
=C2=A0=C2=A0=C2=A0variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0byte 60
signal time=3D1482940406.895874 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D158 path=3D/; interface=3Dnet.connman.Manager; member=3DSer=
vicesChanged
=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0object path "/net/con=
nman/service/cellular_272032050058871_context2"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0object path "/net/con=
nman/service/ethernet_020000a01401_067_cable"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
=C2=A0=C2=A0=C2=A0]
=C2=A0=C2=A0=C2=A0array [
=C2=A0=C2=A0=C2=A0]

----- snap=C2=A0=C2=A0=C2=A0auto re-connect     -----


--===============2834726437446647050==--

