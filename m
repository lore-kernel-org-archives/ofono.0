Content-Type: multipart/mixed; boundary="===============4585646434074133148=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: Reactivating context after SIM reinsertion fails sometimes (telit
 UC864G modem)
Date: Fri, 24 Aug 2012 12:10:31 +0200
Message-ID: <50375317.4080604@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4585646434074133148==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

when I remove the SIM after a valid ppp connection and insert it again, =

the activation of the primary context often fails. The data port seems =

to be inactive at that time and AT+CGDCONT=3D1,"IP","gprswap" is not sent. =

The ppp connection seems to get shut down properly though.

I compared the output after removing the SIM with the output when it =

worked and I can't see any difference. Could this be a "timing problem"? =

How can I tell if the modem is ready for +CGDCONT again, i.e. which URC =

would tell me that? In that case I could defer the sending of+CGDCONT.  =

I'm lacking knowledge and experience to solve this.



Valid ppp connection

...
...
Aug 22 09:13:13 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

106,130\r\n\r\nOK\r\n
Aug 22 09:13:13 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CRSM=3D192,2861=
8\r
Aug 22 09:13:13 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,62218205022100050183026FCAA5038001318A01058B036F060B800200058800F1010=
0\r\n\r\nOK\r\n
Aug 22 09:13:13 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 35
Aug 22 09:13:13 mx31tt01 daemon.info ofonod[969]: Aux: > =

AT+CRSM=3D178,28618,1,4,5\r
Aug 22 09:13:13 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/gprs-context.c:at_gprs_activate_primary() cid 1
Aug 22 09:13:13 mx31tt01 daemon.info ofonod[969]: Modem: > =

AT+CGDCONT=3D1,"IP","gprswap"\r
Aug 22 09:13:13 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,0000000000\r\n\r\nOK\r\n
Aug 22 09:13:13 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 5
Aug 22 09:13:13 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CRSM=3D192,2861=
7\r
Aug 22 09:13:13 mx31tt01 daemon.info ofonod[969]: Modem: < \r\nOK\r\n
Aug 22 09:13:13 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/gprs-context.c:at_cgdcont_cb() ok 1
Aug 22 09:13:13 mx31tt01 daemon.info ofonod[969]: Modem: > =

AT+CGDATA=3D"PPP",1\r
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,62218205022100040183026FC9A5038001318A01058B036F060B800200048800F1010=
0\r\n\r\nOK\r\n
Aug 22 09:13:14 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 35
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: Aux: > =

AT+CRSM=3D178,28617,1,4,4\r
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: Modem: < \r\nCONNECT\r\n
Aug 22 09:13:14 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 1
Aug 22 09:13:14 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/gprs-context.c:setup_ppp()
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: PPP: lcp: =

pppcp_generate_event: current state 0:INITIAL
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: PPP: event: 0 (Up), =

action: 2, new_state: 2 (CLOSED)
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: PPP: lcp: =

pppcp_generate_event: current state 2:CLOSED
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: PPP: event: 2 (Open), =

action: 1026, new_state: 6 (REQSENT)
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: PPP: lcp: =

pppcp_initialize_restart_count: current state 2:CLOSED
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: PPP: lcp: =

pppcp_send_configure_request: current state 2:CLOSED
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: PPP: =

gatchat/gatppp.c:ppp_enter_phase() 1
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: PPP: lcp: =

pppcp_process_configure_request: current state 6:REQSENT
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: PPP: lcp: =

pppcp_generate_event: current state 6:REQSENT
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: PPP: event: 6 (RCR+), =

action: 2008, new_state: 8 (ACKSENT)
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: PPP: lcp: =

pppcp_send_configure_ack: current state 6:REQSENT
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: PPP: lcp: =

pppcp_process_configure_ack: current state 8:ACKSENT
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: PPP: lcp: =

pppcp_generate_event: current state 8:ACKSENT
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: PPP: event: 8 (RCA), =

action: 129, new_state: 9 (OPENED)
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: PPP: lcp: =

pppcp_initialize_restart_count: current state 8:ACKSENT
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: PPP: =

gatchat/gatppp.c:ppp_enter_phase() 2
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: PPP: =

gatchat/gatppp.c:ppp_enter_phase() 3
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: PPP: ipcp: =

pppcp_generate_event: current state 0:INITIAL
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: PPP: event: 2 (Open), =

action: 401, new_state: 1 (STARTING)
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: PPP: ipcp: =

pppcp_generate_event: current state 1:STARTING
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: PPP: event: 0 (Up), =

action: 1026, new_state: 6 (REQSENT)
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: PPP: ipcp: =

pppcp_initialize_restart_count: current state 1:STARTING
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: PPP: ipcp: =

pppcp_send_configure_request: current state 1:STARTING
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,01000000\r\n\r\nOK\r\n
Aug 22 09:13:14 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 4
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CRSM=3D192,2843=
3\r
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

106,130\r\n\r\nOK\r\n
Aug 22 09:13:14 mx31tt01 daemon.debug ofonod[969]: =

src/message-waiting.c:mw_cphs_mwis_read_cb() No CPHS MWIS on SIM
Aug 22 09:13:14 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CRSM=3D192,2843=
5\r
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

106,130\r\n\r\nOK\r\n
Aug 22 09:13:15 mx31tt01 daemon.debug ofonod[969]: =

src/simfs.c:sim_fs_op_read_block() bufoff: 0, seekoff: 39, toread: 17
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CRSM=3D192,2843=
7\r
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: PPP: ipcp: =

pppcp_process_configure_request: current state 6:REQSENT
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: PPP: ipcp: =

pppcp_generate_event: current state 6:REQSENT
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: PPP: event: 6 (RCR+), =

action: 2008, new_state: 8 (ACKSENT)
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: PPP: ipcp: =

pppcp_send_configure_ack: current state 6:REQSENT
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: PPP: ipcp: =

pppcp_process_configure_reject: current state 8:ACKSENT
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: PPP: ipcp: =

pppcp_generate_event: current state 8:ACKSENT
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: PPP: event: 9 (RCN), =

action: 1028, new_state: 8 (ACKSENT)
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: PPP: ipcp: =

pppcp_initialize_restart_count: current state 8:ACKSENT
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: PPP: ipcp: =

pppcp_send_configure_request: current state 8:ACKSENT
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: PPP: ipcp: =

pppcp_process_configure_nak: current state 8:ACKSENT
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: PPP: ipcp: =

pppcp_generate_event: current state 8:ACKSENT
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: PPP: event: 9 (RCN), =

action: 1028, new_state: 8 (ACKSENT)
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: PPP: ipcp: =

pppcp_initialize_restart_count: current state 8:ACKSENT
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: PPP: ipcp: =

pppcp_send_configure_request: current state 8:ACKSENT
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: PPP: ipcp: =

pppcp_process_configure_ack: current state 8:ACKSENT
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: PPP: ipcp: =

pppcp_generate_event: current state 8:ACKSENT
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: PPP: event: 8 (RCA), =

action: 129, new_state: 9 (OPENED)
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: PPP: ipcp: =

pppcp_initialize_restart_count: current state 8:ACKSENT
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: PPP: =

gatchat/gatppp.c:ppp_enter_phase() 4
Aug 22 09:13:15 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/gprs-context.c:ppp_connect()
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: IP: 10.146.191.130
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: DNS: 213.162.69.169, =

213.162.69.170
Aug 22 09:13:15 mx31tt01 daemon.debug ofonod[969]: =

src/gprs.c:pri_activate_callback() 0x198af48
Aug 22 09:13:15 mx31tt01 daemon.debug ofonod[969]: =

plugins/udev.c:udev_event() subsystem net add
Aug 22 09:13:15 mx31tt01 daemon.debug ofonod[969]: =

plugins/udev.c:udev_event() subsystem net finished
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

106,130\r\n\r\nOK\r\n
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CRSM=3D192,2861=
5\r
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,622182050221001E0183026FC7A5038001318A01058B036F060B8002001E8800F1010=
0\r\n\r\nOK\r\n
Aug 22 09:13:15 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 35
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: Aux: > =

AT+CRSM=3D178,28615,1,4,30\r
Aug 22 09:13:15 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,542D4D6F62696C6520426F78FFFFFFFF069134762602F0FFFFFFFFFFFFFF\r\n\r\nO=
K\r\n
Aug 22 09:13:15 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 30
Aug 22 09:13:16 mx31tt01 daemon.debug ofonod[969]: =

plugins/udevng.c:check_modem_list()


Removing the SIM:

Aug 22 09:13:28 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n#QSS: 0\r\n
Aug 22 09:13:28 mx31tt01 daemon.debug ofonod[969]: =

plugins/telit.c:telit_qss_notify() 0x19812d8
Aug 22 09:13:28 mx31tt01 daemon.debug ofonod[969]: =

plugins/telit.c:switch_sim_state_status() 0x19812d8, SIM status: 0
Aug 22 09:13:28 mx31tt01 daemon.debug ofonod[969]: =

src/modem.c:modem_change_state() old state: 3, new state: 1
Aug 22 09:13:28 mx31tt01 daemon.debug ofonod[969]: =

src/modem.c:flush_atoms()
Aug 22 09:13:28 mx31tt01 daemon.debug ofonod[969]: =

src/message-waiting.c:mw_remove() atom: 0x198bf58
Aug 22 09:13:28 mx31tt01 daemon.debug ofonod[969]: =

src/call-barring.c:call_barring_remove() atom: 0x198bcc0
Aug 22 09:13:28 mx31tt01 daemon.debug ofonod[969]: =

src/call-meter.c:call_meter_remove() atom: 0x198bbb8
Aug 22 09:13:28 mx31tt01 daemon.debug ofonod[969]: =

src/call-settings.c:call_settings_remove() atom: 0x198baf8
Aug 22 09:13:28 mx31tt01 daemon.debug ofonod[969]: =

src/call-forwarding.c:call_forwarding_remove() atom: 0x198ba20
Aug 22 09:13:28 mx31tt01 daemon.debug ofonod[969]: =

src/ussd.c:ussd_remove() atom: 0x198b900
Aug 22 09:13:28 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/gprs-context.c:at_gprs_detach_shutdown() cid 1
Aug 22 09:13:28 mx31tt01 daemon.info ofonod[969]: PPP: lcp: =

pppcp_generate_event: current state 9:OPENED
Aug 22 09:13:28 mx31tt01 daemon.info ofonod[969]: PPP: event: 3 (Close), =

action: 8224, new_state: 4 (CLOSING)
Aug 22 09:13:28 mx31tt01 daemon.info ofonod[969]: PPP: lcp: =

pppcp_initialize_restart_count: current state 9:OPENED
Aug 22 09:13:28 mx31tt01 daemon.info ofonod[969]: PPP: lcp: =

pppcp_send_terminate_request: current state 9:OPENED
Aug 22 09:13:28 mx31tt01 daemon.info ofonod[969]: PPP: ipcp: =

pppcp_generate_event: current state 9:OPENED
Aug 22 09:13:28 mx31tt01 daemon.info ofonod[969]: PPP: event: 1 (Down), =

action: 201, new_state: 1 (STARTING)
Aug 22 09:13:28 mx31tt01 user.debug kernel: [ 2980.301385] PM: Removing =

info for No Bus:ppp0
Aug 22 09:13:28 mx31tt01 daemon.info ofonod[969]: PPP: =

gatchat/gatppp.c:ppp_enter_phase() 5
Aug 22 09:13:28 mx31tt01 daemon.debug ofonod[969]: =

src/sim.c:ofono_sim_remove_spn_watch() 0x195eba8
Aug 22 09:13:28 mx31tt01 daemon.debug ofonod[969]: =

src/network.c:netreg_remove() atom: 0x198b7f0
Aug 22 09:13:28 mx31tt01 daemon.debug ofonod[969]: =

src/gprs.c:gprs_context_unregister() 0x198e7e8, 0x198e528
Aug 22 09:13:28 mx31tt01 daemon.debug ofonod[969]: =

src/gprs.c:gprs_context_remove() atom: 0x198e808
Aug 22 09:13:28 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/gprs-context.c:at_gprs_context_remove()
Aug 22 09:13:28 mx31tt01 daemon.debug ofonod[969]: =

src/gprs.c:gprs_unregister() 0x198e528
Aug 22 09:13:28 mx31tt01 daemon.debug ofonod[969]: =

src/gprs.c:gprs_remove() atom: 0x197c680
Aug 22 09:13:28 mx31tt01 daemon.debug ofonod[969]: =

plugins/udevng.c:remove_device() /sys/devices/virtual/net/ppp0
Aug 22 09:13:28 mx31tt01 daemon.debug ofonod[969]: =

plugins/udev.c:udev_event() subsystem net remove
Aug 22 09:13:28 mx31tt01 daemon.debug ofonod[969]: =

plugins/udev.c:remove_modem() /devices/virtual/net/ppp0
Aug 22 09:13:28 mx31tt01 daemon.debug ofonod[969]: =

plugins/udev.c:udev_event() subsystem net finished
Aug 22 09:13:28 mx31tt01 daemon.info ofonod[969]: Modem: < =

~\377}#\300!}%}6} }$\255\316~
Aug 22 09:13:28 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CGEV: NW =

DEACT IP, 10.146.191.130, 1\r\n
Aug 22 09:13:29 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n#PSNT: 4\r\n
Aug 22 09:13:29 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CIEV: =

service,0\r\n
Aug 22 09:13:29 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CREG: 0\r\n
Aug 22 09:13:29 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CGREG: 0\r\n
Aug 22 09:13:29 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CIEV: =

roam,1\r\n
Aug 22 09:13:31 mx31tt01 daemon.info ofonod[969]: Modem: < =

~\377}#\300!}%}7} }$q\224~
Aug 22 09:13:34 mx31tt01 daemon.info ofonod[969]: Modem: < \r\nNO =

CARRIER\r\n
Aug 22 09:13:34 mx31tt01 daemon.info ofonod[969]: Modem: < \r\n+CIEV: =

service,0\r\n
Aug 22 09:13:34 mx31tt01 daemon.info ofonod[969]: Modem: < \r\n+CIEV: =

roam,1\r\n
Aug 22 09:13:34 mx31tt01 daemon.info ofonod[969]: Modem: < \r\n+CGEV: NW =

DEACT IP, 10.146.191.130, 1\r\n



Inserting the SIM again:

Aug 22 09:13:52 mx31tt01 daemon.info ofonod[969]: Modem: < \r\n#QSS: 1\r\n
Aug 22 09:13:52 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n#QSS: 1\r\n
Aug 22 09:13:52 mx31tt01 daemon.debug ofonod[969]: =

plugins/telit.c:telit_qss_notify() 0x19812d8
Aug 22 09:13:52 mx31tt01 daemon.debug ofonod[969]: =

plugins/telit.c:switch_sim_state_status() 0x19812d8, SIM status: 1
Aug 22 09:13:52 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CRSM=3D192,2859=
9\r
Aug 22 09:13:52 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,62228205022100100383026FB7A5038001318A01058B036F060680020030880108F10=
100\r\n\r\nOK\r\n
Aug 22 09:13:52 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 36
Aug 22 09:13:52 mx31tt01 daemon.err ofonod[969]: Requested file =

structure differs from SIM: 6fb7
Aug 22 09:13:52 mx31tt01 daemon.debug ofonod[969]: =

src/voicecall.c:ecc_g2_read_cb() 0
Aug 22 09:13:52 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CRSM=3D192,2859=
9\r
Aug 22 09:13:52 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,62228205022100100383026FB7A5038001318A01058B036F060680020030880108F10=
100\r\n\r\nOK\r\n
Aug 22 09:13:52 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 36
Aug 22 09:13:52 mx31tt01 daemon.info ofonod[969]: Aux: > =

AT+CRSM=3D178,28599,1,4,16\r
Aug 22 09:13:53 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF\r\n\r\nOK\r\n
Aug 22 09:13:53 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 16
Aug 22 09:13:53 mx31tt01 daemon.debug ofonod[969]: =

src/voicecall.c:ecc_g3_read_cb() 1
Aug 22 09:13:53 mx31tt01 daemon.info ofonod[969]: Aux: > =

AT+CRSM=3D178,28599,2,4,16\r
Aug 22 09:13:53 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF\r\n\r\nOK\r\n
Aug 22 09:13:53 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 16
Aug 22 09:13:53 mx31tt01 daemon.debug ofonod[969]: =

src/voicecall.c:ecc_g3_read_cb() 1
Aug 22 09:13:53 mx31tt01 daemon.info ofonod[969]: Aux: > =

AT+CRSM=3D178,28599,3,4,16\r
Aug 22 09:13:53 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF\r\n\r\nOK\r\n
Aug 22 09:13:53 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 16
Aug 22 09:13:53 mx31tt01 daemon.debug ofonod[969]: =

src/voicecall.c:ecc_g3_read_cb() 1
Aug 22 09:13:53 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CRSM=3D192,1225=
8\r
Aug 22 09:13:53 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,621F8202012183022FE2A5038001318A01058B032F06038002000A880110F10100\r\=
n\r\nOK\r\n
Aug 22 09:13:53 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 33
Aug 22 09:13:53 mx31tt01 daemon.info ofonod[969]: Aux: > =

AT+CRSM=3D176,12258,0,0,10\r
Aug 22 09:13:53 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,98343000000163500864\r\n\r\nOK\r\n
Aug 22 09:13:53 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 10
Aug 22 09:13:53 mx31tt01 daemon.debug ofonod[969]: =

src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, tocopy: 10
Aug 22 09:13:53 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CRSM=3D192,2842=
1\r
Aug 22 09:13:53 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

106,130\r\n\r\nOK\r\n
Aug 22 09:13:53 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CRSM=3D192,1203=
7\r
Aug 22 09:13:53 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,621F8202012183022F05A5038001318A01058B032F060480020008880128F10100\r\=
n\r\nOK\r\n
Aug 22 09:13:53 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 33
Aug 22 09:13:53 mx31tt01 daemon.info ofonod[969]: Aux: > =

AT+CRSM=3D176,12037,0,0,8\r
Aug 22 09:13:53 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,6465656EFFFFFFFF\r\n\r\nOK\r\n
Aug 22 09:13:53 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 8
Aug 22 09:13:53 mx31tt01 daemon.debug ofonod[969]: =

src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, tocopy: 8
Aug 22 09:13:53 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CPIN?\r
Aug 22 09:13:53 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CPIN: SIM =

PIN\r\n\r\nOK\r\n
Aug 22 09:13:53 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: SIM PIN
Aug 22 09:13:53 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_pin_retries_query()
Aug 22 09:13:53 mx31tt01 daemon.info ofonod[969]: Aux: > AT#PCT\r
Aug 22 09:13:53 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n#PCT: =

3\r\n\r\nOK\r\n
Aug 22 09:13:53 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_pct_cb() retry counter id=3D1, val=3D3
Aug 22 09:13:53 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CPIN=3D"2110"\r
Aug 22 09:13:53 mx31tt01 daemon.info ofonod[969]: Aux: < \r\nOK\r\n
Aug 22 09:13:55 mx31tt01 daemon.info ofonod[969]: Modem: < \r\n#QSS: 2\r\n
Aug 22 09:13:55 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n#QSS: 2\r\n
Aug 22 09:13:55 mx31tt01 daemon.debug ofonod[969]: =

plugins/telit.c:telit_qss_notify() 0x19812d8
Aug 22 09:13:55 mx31tt01 daemon.debug ofonod[969]: =

plugins/telit.c:switch_sim_state_status() 0x19812d8, SIM status: 2
Aug 22 09:13:55 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CPIN?\r
Aug 22 09:13:55 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CPIN: =

READY\r\n\r\nOK\r\n
Aug 22 09:13:55 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: READY
Aug 22 09:13:55 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_pin_retries_query()
Aug 22 09:13:55 mx31tt01 daemon.info ofonod[969]: Aux: > AT#PCT\r
Aug 22 09:13:55 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n#PCT: =

3\r\n\r\nOK\r\n
Aug 22 09:13:55 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_pct_cb() Note: No password required, returning =

maximum retries:
Aug 22 09:13:55 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_pct_cb() retry counter id=3D1, val=3D3
Aug 22 09:13:55 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_pct_cb() retry counter id=3D4, val=3D3
Aug 22 09:13:55 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_pct_cb() retry counter id=3D9, val=3D10
Aug 22 09:13:55 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_pct_cb() retry counter id=3D11, val=3D10
Aug 22 09:13:55 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CRSM=3D192,2859=
0\r
Aug 22 09:13:55 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CME ERROR: =

22\r\n
Aug 22 09:13:55 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CRSM=3D192,2858=
9\r
Aug 22 09:13:56 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,621F8202012183026FADA5038001318A01058B036F060680020004880118F10100\r\=
n\r\nOK\r\n
Aug 22 09:13:56 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 33
Aug 22 09:13:56 mx31tt01 daemon.info ofonod[969]: Aux: > =

AT+CRSM=3D176,28589,0,0,4\r
Aug 22 09:13:56 mx31tt01 daemon.info ofonod[969]: Modem: < \r\n+CREG: 2\r\n
Aug 22 09:13:56 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CREG: 2\r\n
Aug 22 09:13:56 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CGREG: 2\r\n
Aug 22 09:13:56 mx31tt01 daemon.info ofonod[969]: Modem: < \r\n+CGREG: 2\r\n
Aug 22 09:13:57 mx31tt01 daemon.info ofonod[969]: Modem: < \r\n+CIEV: =

service,1\r\n
Aug 22 09:13:57 mx31tt01 daemon.info ofonod[969]: Modem: < \r\n+CIEV: =

roam,0\r\n
Aug 22 09:13:59 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,00FFFF02\r\n\r\nOK\r\n
Aug 22 09:13:59 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 4
Aug 22 09:13:59 mx31tt01 daemon.debug ofonod[969]: =

src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, tocopy: 4
Aug 22 09:13:59 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CRSM=3D192,2843=
8\r
Aug 22 09:13:59 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CIEV: =

service,1\r\n
Aug 22 09:13:59 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CIEV: =

roam,0\r\n
Aug 22 09:13:59 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CREG: =

1,"EF10","022306B"\r\n
Aug 22 09:13:59 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n#PSNT: 2\r\n
Aug 22 09:14:00 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

106,130\r\n\r\nOK\r\n
Aug 22 09:14:00 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CRSM=3D192,2847=
2\r
Aug 22 09:14:00 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CGREG: =

1,"EF10","022306B"\r\n
Aug 22 09:14:00 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,621F8202012183026F38A5038001318A01058B036F060580020008880120F10100\r\=
n\r\nOK\r\n
Aug 22 09:14:00 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 33
Aug 22 09:14:00 mx31tt01 daemon.info ofonod[969]: Aux: > =

AT+CRSM=3D176,28472,0,0,8\r
Aug 22 09:14:01 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,822B170C23460800\r\n\r\nOK\r\n
Aug 22 09:14:01 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 8
Aug 22 09:14:01 mx31tt01 daemon.debug ofonod[969]: =

src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, tocopy: 8
Aug 22 09:14:01 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CRSM=3D192,2850=
2\r
Aug 22 09:14:01 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,621F8202012183026F56A5038001318A01058B036F061180020001880128F10100\r\=
n\r\nOK\r\n
Aug 22 09:14:01 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 33
Aug 22 09:14:01 mx31tt01 daemon.info ofonod[969]: Aux: > =

AT+CRSM=3D176,28502,0,0,1\r
Aug 22 09:14:02 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,00\r\n\r\nOK\r\n
Aug 22 09:14:02 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 1
Aug 22 09:14:02 mx31tt01 daemon.debug ofonod[969]: =

src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, tocopy: 1
Aug 22 09:14:02 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CIMI\r
Aug 22 09:14:02 mx31tt01 daemon.info ofonod[969]: Aux: < =

\r\n232033012792309\r\n\r\nOK\r\n
Aug 22 09:14:02 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_cimi_cb() cimi_cb: 232033012792309
Aug 22 09:14:02 mx31tt01 daemon.debug ofonod[969]: =

src/modem.c:modem_change_state() old state: 1, new state: 2
Aug 22 09:14:02 mx31tt01 daemon.debug ofonod[969]: =

plugins/telit.c:telit_post_sim() 0x19812d8
Aug 22 09:14:02 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/gprs-context.c:at_gprs_context_probe()
Aug 22 09:14:02 mx31tt01 daemon.debug ofonod[969]: =

src/modem.c:modem_change_state() old state: 2, new state: 3
Aug 22 09:14:02 mx31tt01 daemon.debug ofonod[969]: =

plugins/telit.c:telit_post_online() 0x19812d8
Aug 22 09:14:02 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CGDCONT=3D?\r
Aug 22 09:14:02 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CGDCONT: =

(1-16),"IP",,,(0-2),(0-4)\r\n+CGDCONT: =

(1-16),"PPP",,,(0-2),(0-4)\r\n+CGDCONT: =

(1-16),"IPV6",,,(0-2),(0-4)\r\n\r\nOK\r\n
Aug 22 09:14:02 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CREG=3D?\r
Aug 22 09:14:02 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CREG: =

(0-2)\r\n\r\nOK\r\n
Aug 22 09:14:02 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CSCS?\r
Aug 22 09:14:02 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CSCS: =

"IRA"\r\n\r\nOK\r\n
Aug 22 09:14:02 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CUSD=3D1\r
Aug 22 09:14:02 mx31tt01 daemon.info ofonod[969]: Aux: < \r\nOK\r\n
Aug 22 09:14:02 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CAOC=3D2\r
Aug 22 09:14:02 mx31tt01 daemon.info ofonod[969]: Aux: < \r\nOK\r\n
Aug 22 09:14:02 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CCWE=3D1\r
Aug 22 09:14:02 mx31tt01 daemon.info ofonod[969]: Aux: < \r\nERROR\r\n
Aug 22 09:14:02 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CRSM=3D192,2848=
0\r
Aug 22 09:14:03 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,622182050221001E0483026F40A5038001318A01058B036F060B800200788800F1010=
0\r\n\r\nOK\r\n
Aug 22 09:14:03 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 35
Aug 22 09:14:03 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CGREG=3D?\r
Aug 22 09:14:03 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CGREG: =

(0-2)\r\n\r\nOK\r\n
Aug 22 09:14:03 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CREG=3D2\r
Aug 22 09:14:03 mx31tt01 daemon.info ofonod[969]: Aux: < \r\nOK\r\n
Aug 22 09:14:03 mx31tt01 daemon.info ofonod[969]: Aux: > =

AT+CRSM=3D178,28480,1,4,30\r
Aug 22 09:14:03 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,456967656E65205275666E756D6D65720791347676086013FFFFFFFFFFFF\r\n\r\nO=
K\r\n
Aug 22 09:14:03 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 30
Aug 22 09:14:03 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CGREG=3D2\r
Aug 22 09:14:03 mx31tt01 daemon.info ofonod[969]: Aux: < \r\nOK\r\n
Aug 22 09:14:03 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CGAUTO=3D0\r
Aug 22 09:14:03 mx31tt01 daemon.info ofonod[969]: Aux: < \r\nERROR\r\n
Aug 22 09:14:03 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CGEREP=3D2,1\r
Aug 22 09:14:03 mx31tt01 daemon.info ofonod[969]: Aux: < \r\nOK\r\n
Aug 22 09:14:03 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CIND=3D?\r
Aug 22 09:14:03 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CIND: =

(("battchg",(0-5,99)),("signal",(0-7,99)),("service",(0,1)),("sounder",(0,1=
)),("message",(0,1)),("call",(0,1)),("roam",(0,1)),("smsfull",(0,1)),("rssi=
",(0-5,99)))\r\n\r\nOK\r\n
Aug 22 09:14:03 mx31tt01 daemon.debug ofonod[969]: =

src/sim.c:ofono_sim_add_spn_watch() 0x195eba8
Aug 22 09:14:03 mx31tt01 daemon.debug ofonod[969]: =

src/network.c:__ofono_netreg_add_status_watch() 0x197cf38
Aug 22 09:14:03 mx31tt01 daemon.info ofonod[969]: Aux: > =

AT+CRSM=3D178,28480,2,4,30\r
Aug 22 09:14:04 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF\r\n\r\nO=
K\r\n
Aug 22 09:14:04 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 30
Aug 22 09:14:04 mx31tt01 daemon.info ofonod[969]: Aux: > AT#PSNT=3D1\r
Aug 22 09:14:04 mx31tt01 daemon.info ofonod[969]: Aux: < \r\nOK\r\n
Aug 22 09:14:04 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CPSB=3D1\r
Aug 22 09:14:04 mx31tt01 daemon.info ofonod[969]: Aux: < \r\nERROR\r\n
Aug 22 09:14:04 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CMER=3D3,0,0,2\r
Aug 22 09:14:04 mx31tt01 daemon.info ofonod[969]: Aux: < \r\nOK\r\n
Aug 22 09:14:04 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CREG?\r
Aug 22 09:14:04 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CIEV: =

battchg,4\r\n\r\n+CIEV: signal,0\r\n\r\n+CIEV: service,1\r\n\r\n+CIEV: =

sounder,0\r\n\r\n+CIEV: message,1\r\n\r\n+CIEV: call,0\r\n\r\n+CIEV: =

roam,0\r\n\r\n+CIEV: smsfull,0\r\n\r\n+CIEV: rssi,1\r\n
Aug 22 09:14:04 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/network-registration.c:ciev_notify() Strength: 20
Aug 22 09:14:04 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CREG: =

2,1,"EF10","022306B"\r\n\r\nOK\r\n
Aug 22 09:14:04 mx31tt01 daemon.debug ofonod[969]: =

src/network.c:ofono_netreg_status_notify() /telit_0 status 1 tech -1
Aug 22 09:14:04 mx31tt01 daemon.debug ofonod[969]: =

src/gprs.c:netreg_status_changed() 1
Aug 22 09:14:04 mx31tt01 daemon.info ofonod[969]: Aux: > =

AT+CRSM=3D178,28480,3,4,30\r
Aug 22 09:14:04 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF\r\n\r\nO=
K\r\n
Aug 22 09:14:04 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 30
Aug 22 09:14:04 mx31tt01 daemon.info ofonod[969]: Aux: > AT+COPS=3D3,2\r
Aug 22 09:14:04 mx31tt01 daemon.info ofonod[969]: Aux: < \r\nOK\r\n
Aug 22 09:14:04 mx31tt01 daemon.info ofonod[969]: Aux: > AT+COPS?\r
Aug 22 09:14:04 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+COPS: =

0,2,"23203",2\r\n\r\nOK\r\n
Aug 22 09:14:04 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/network-registration.c:cops_numeric_cb() Cops numeric =

got mcc: 232, mnc: 03
Aug 22 09:14:04 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CIND?\r
Aug 22 09:14:04 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CIND: =

4,0,1,0,1,0,0,0,1\r\n\r\nOK\r\n
Aug 22 09:14:04 mx31tt01 daemon.debug ofonod[969]: =

src/network.c:ofono_netreg_strength_notify() strength 20
Aug 22 09:14:04 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CGATT=3D1\r
Aug 22 09:14:04 mx31tt01 daemon.info ofonod[969]: Aux: < \r\nOK\r\n
Aug 22 09:14:04 mx31tt01 daemon.debug ofonod[969]: =

src/gprs.c:gprs_attach_callback() /telit_0 error =3D 0
Aug 22 09:14:04 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CIND?\r
Aug 22 09:14:04 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CIND: =

4,0,1,0,1,0,0,0,1\r\n\r\nOK\r\n
Aug 22 09:14:04 mx31tt01 daemon.info ofonod[969]: Aux: > =

AT+CRSM=3D178,28480,4,4,30\r
Aug 22 09:14:05 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF\r\n\r\nO=
K\r\n
Aug 22 09:14:05 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 30
Aug 22 09:14:05 mx31tt01 daemon.info ofonod[969]: Aux: > AT+COPS=3D3,0\r
Aug 22 09:14:05 mx31tt01 daemon.info ofonod[969]: Aux: < \r\nOK\r\n
Aug 22 09:14:05 mx31tt01 daemon.info ofonod[969]: Aux: > AT+COPS?\r
Aug 22 09:14:05 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+COPS: =

0,0,"T-Mobile A",2\r\n\r\nOK\r\n
Aug 22 09:14:05 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/network-registration.c:cops_cb() cops_cb: T-Mobile A, =

232 03 2
Aug 22 09:14:05 mx31tt01 daemon.debug ofonod[969]: =

src/network.c:current_operator_callback() 0x197cf38, (nil)
Aug 22 09:14:05 mx31tt01 daemon.debug ofonod[969]: =

src/gprs.c:netreg_status_changed() 1
Aug 22 09:14:05 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CGREG?\r
Aug 22 09:14:05 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CGREG: =

2,1,"EF10","022306B"\r\n\r\nOK\r\n
Aug 22 09:14:05 mx31tt01 daemon.debug ofonod[969]: =

src/gprs.c:registration_status_cb() /telit_0 error 0 status 1
Aug 22 09:14:05 mx31tt01 daemon.debug ofonod[969]: =

src/gprs.c:ofono_gprs_status_notify() /telit_0 status 1
Aug 22 09:14:05 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CRSM=3D192,2848=
9\r
Aug 22 09:14:05 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

106,130\r\n\r\nOK\r\n
Aug 22 09:14:05 mx31tt01 daemon.info ofonod[969]: Aux: > AT+CRSM=3D192,2861=
8\r
Aug 22 09:14:05 mx31tt01 daemon.info ofonod[969]: Aux: < \r\n+CRSM: =

144,0,62218205022100050183026FCAA5038001318A01058B036F060B800200058800F1010=
0\r\n\r\nOK\r\n
Aug 22 09:14:05 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 35
Aug 22 09:14:05 mx31tt01 daemon.info ofonod[969]: Aux: > =

AT+CRSM=3D178,28618,1,4,5\r
Aug 22 09:14:05 mx31tt01 daemon.debug ofonod[969]: =

drivers/atmodem/gprs-context.c:at_gprs_activate_primary() cid 1
Aug 22 09:14:05 mx31tt01 daemon.debug ofonod[969]: =

src/gprs.c:pri_activate_callback() 0x198a948
Aug 22 09:14:05 mx31tt01 daemon.debug ofonod[969]: =

src/gprs.c:pri_activate_callback() Activating context failed with error: =

Unknown error type



Regards,
Christopher


--
Scanned by MailScanner.


--===============4585646434074133148==--

