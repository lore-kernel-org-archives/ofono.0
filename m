Content-Type: multipart/mixed; boundary="===============6380760729983793612=="
MIME-Version: 1.0
From: rakespani@gmail.com
Subject: Unable to establish ppp connection with Huawei dongle
Date: Thu, 27 Aug 2020 04:26:40 +0000
Message-ID: <20200827042640.2753.53584@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6380760729983793612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi ,

I am trying to enable lte connection with huawei dongle , but I am getting =
below error log for activat/context. =


Aug 26 11:36:28 raspberrypi3 daemon.info ofonod[147]: Modem: > AT+CGDCONT=
=3D1,"IP","airtelgprs.com"\r
Aug 26 11:36:28 raspberrypi3 daemon.info ofonod[147]: Modem: < \r\nOK\r\n
Aug 26 11:36:28 raspberrypi3 daemon.debug ofonod[147]: ../ofono-1.24/driver=
s/atmodem/gprs-context.c:at_cgdcont_cb() ok 1
Aug 26 11:36:28 raspberrypi3 daemon.info ofonod[147]: Modem: > AT+CGDATA=3D=
"PPP",1\r
Aug 26 11:36:28 raspberrypi3 daemon.info ofonod[147]: Modem: < \r\nCONNECT =
100000000\r\n
Aug 26 11:36:28 raspberrypi3 daemon.debug ofonod[147]: ../ofono-1.24/driver=
s/atmodem/gprs-context.c:at_cgdata_cb() ok 1
Aug 26 11:36:28 raspberrypi3 daemon.debug ofonod[147]: ../ofono-1.24/driver=
s/atmodem/gprs-context.c:setup_ppp()
Aug 26 11:36:28 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_gener=
ate_event: current state 0:INITIAL
Aug 26 11:36:28 raspberrypi3 daemon.info ofonod[147]: PPP: event: 0 (Up), a=
ction: 2, new_state: 2 (CLOSED)
Aug 26 11:36:28 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_gener=
ate_event: current state 2:CLOSED
Aug 26 11:36:28 raspberrypi3 daemon.info ofonod[147]: PPP: event: 2 (Open),=
 action: 1026, new_state: 6 (REQSENT)
Aug 26 11:36:28 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_initi=
alize_restart_count: current state 2:CLOSED
Aug 26 11:36:28 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_send_=
configure_request: current state 2:CLOSED
Aug 26 11:36:28 raspberrypi3 daemon.info ofonod[147]: PPP: ../ofono-1.24/ga=
tchat/gatppp.c:ppp_enter_phase() 1
Aug 26 11:36:29 raspberrypi3 daemon.info ofonod[147]: PCUI: < \r\n^BOOT:111=
3056,0,0,0,99\r\n
Aug 26 11:36:30 raspberrypi3 daemon.info ofonod[147]: PCUI: < \r\n^RSSI:31\=
r\n
Aug 26 11:36:30 raspberrypi3 daemon.info ofonod[147]: PCUI: < \r\n^LTERSRP:=
-76,-6\r\n
Aug 26 11:36:31 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_timeo=
ut: current state 6:REQSENT
Aug 26 11:36:31 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_gener=
ate_event: current state 6:REQSENT
Aug 26 11:36:31 raspberrypi3 daemon.info ofonod[147]: PPP: event: 4 (TO+), =
action: 1006, new_state: 6 (REQSENT)
Aug 26 11:36:31 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_send_=
configure_request: current state 6:REQSENT
Aug 26 11:36:33 raspberrypi3 daemon.info ofonod[147]: PCUI: < \r\n^RSSI:31\=
r\n
Aug 26 11:36:33 raspberrypi3 daemon.info ofonod[147]: PCUI: < \r\n^LTERSRP:=
-76,-6\r\n
Aug 26 11:36:34 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_timeo=
ut: current state 6:REQSENT
Aug 26 11:36:34 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_gener=
ate_event: current state 6:REQSENT
Aug 26 11:36:34 raspberrypi3 daemon.info ofonod[147]: PPP: event: 4 (TO+), =
action: 1006, new_state: 6 (REQSENT)
Aug 26 11:36:34 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_send_=
configure_request: current state 6:REQSENT
Aug 26 11:36:36 raspberrypi3 daemon.info ofonod[147]: PCUI: < \r\n^RSSI:31\=
r\n
Aug 26 11:36:36 raspberrypi3 daemon.info ofonod[147]: PCUI: < \r\n^LTERSRP:=
-76,-6\r\n
Aug 26 11:36:37 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_timeo=
ut: current state 6:REQSENT
Aug 26 11:36:37 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_gener=
ate_event: current state 6:REQSENT
Aug 26 11:36:37 raspberrypi3 daemon.info ofonod[147]: PPP: event: 4 (TO+), =
action: 1006, new_state: 6 (REQSENT)
Aug 26 11:36:37 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_send_=
configure_request: current state 6:REQSENT
Aug 26 11:36:39 raspberrypi3 daemon.info ofonod[147]: PCUI: < \r\n^RSSI:31\=
r\n\r\n^LTERSRP:-76,-6\r\n
Aug 26 11:36:40 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_timeo=
ut: current state 6:REQSENT
Aug 26 11:36:40 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_gener=
ate_event: current state 6:REQSENT
Aug 26 11:36:40 raspberrypi3 daemon.info ofonod[147]: PPP: event: 4 (TO+), =
action: 1006, new_state: 6 (REQSENT)
Aug 26 11:36:40 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_send_=
configure_request: current state 6:REQSENT
Aug 26 11:36:42 raspberrypi3 daemon.info ofonod[147]: PCUI: < \r\n^RSSI:31\=
r\n
Aug 26 11:36:42 raspberrypi3 daemon.info ofonod[147]: PCUI: < \r\n^LTERSRP:=
-76,-6\r\n
Aug 26 11:36:43 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_timeo=
ut: current state 6:REQSENT
Aug 26 11:36:43 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_gener=
ate_event: current state 6:REQSENT
Aug 26 11:36:43 raspberrypi3 daemon.info ofonod[147]: PPP: event: 4 (TO+), =
action: 1006, new_state: 6 (REQSENT)
Aug 26 11:36:43 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_send_=
configure_request: current state 6:REQSENT
Aug 26 11:36:45 raspberrypi3 daemon.info ofonod[147]: PCUI: < \r\n^RSSI:31\=
r\n
Aug 26 11:36:45 raspberrypi3 daemon.info ofonod[147]: PCUI: < \r\n^LTERSRP:=
-76,-6\r\n
Aug 26 11:36:46 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_timeo=
ut: current state 6:REQSENT
Aug 26 11:36:46 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_gener=
ate_event: current state 6:REQSENT
Aug 26 11:36:46 raspberrypi3 daemon.info ofonod[147]: PPP: event: 4 (TO+), =
action: 1006, new_state: 6 (REQSENT)
Aug 26 11:36:46 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_send_=
configure_request: current state 6:REQSENT
Aug 26 11:36:48 raspberrypi3 daemon.info ofonod[147]: PCUI: < \r\n^RSSI:31\=
r\n
Aug 26 11:36:48 raspberrypi3 daemon.info ofonod[147]: PCUI: < \r\n^LTERSRP:=
-76,-6\r\n
Aug 26 11:36:49 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_timeo=
ut: current state 6:REQSENT
Aug 26 11:36:49 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_gener=
ate_event: current state 6:REQSENT
Aug 26 11:36:49 raspberrypi3 daemon.info ofonod[147]: PPP: event: 4 (TO+), =
action: 1006, new_state: 6 (REQSENT)
Aug 26 11:36:49 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_send_=
configure_request: current state 6:REQSENT
Aug 26 11:36:51 raspberrypi3 daemon.info ofonod[147]: PCUI: < \r\n^RSSI:31\=
r\n
Aug 26 11:36:51 raspberrypi3 daemon.info ofonod[147]: PCUI: < \r\n^LTERSRP:=
-76,-6\r\n
Aug 26 11:36:52 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_timeo=
ut: current state 6:REQSENT
Aug 26 11:36:52 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_gener=
ate_event: current state 6:REQSENT
Aug 26 11:36:52 raspberrypi3 daemon.info ofonod[147]: PPP: event: 4 (TO+), =
action: 1006, new_state: 6 (REQSENT)
Aug 26 11:36:52 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_send_=
configure_request: current state 6:REQSENT
Aug 26 11:36:54 raspberrypi3 daemon.info ofonod[147]: PCUI: < \r\n^RSSI:31\=
r\n
Aug 26 11:36:54 raspberrypi3 daemon.info ofonod[147]: PCUI: < \r\n^LTERSRP:=
-76,-9\r\n
Aug 26 11:36:55 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_timeo=
ut: current state 6:REQSENT
Aug 26 11:36:55 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_gener=
ate_event: current state 6:REQSENT
Aug 26 11:36:55 raspberrypi3 daemon.info ofonod[147]: PPP: event: 4 (TO+), =
action: 1006, new_state: 6 (REQSENT)
Aug 26 11:36:55 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_send_=
configure_request: current state 6:REQSENT
Aug 26 11:36:57 raspberrypi3 daemon.info ofonod[147]: PCUI: < \r\n^RSSI:31\=
r\n
Aug 26 11:36:57 raspberrypi3 daemon.info ofonod[147]: PCUI: < \r\n^LTERSRP:=
-76,-7\r\n
Aug 26 11:36:58 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_timeo=
ut: current state 6:REQSENT
Aug 26 11:36:58 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_gener=
ate_event: current state 6:REQSENT
Aug 26 11:36:58 raspberrypi3 daemon.info ofonod[147]: PPP: event: 5 (TO-), =
action: 803, new_state: 3 (STOPPED)
Aug 26 11:36:58 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_this_=
layer_finished: current state 3:STOPPED
Aug 26 11:36:58 raspberrypi3 daemon.info ofonod[147]: PPP: ../ofono-1.24/ga=
tchat/gatppp.c:ppp_enter_phase() 0
Aug 26 11:36:58 raspberrypi3 daemon.info ofonod[147]: PPP: ../ofono-1.24/ga=
tchat/gatppp.c:ppp_dead()
Aug 26 11:36:58 raspberrypi3 daemon.debug ofonod[147]: ../ofono-1.24/driver=
s/atmodem/gprs-context.c:ppp_disconnect() Reason: 0
Aug 26 11:36:58 raspberrypi3 daemon.debug ofonod[147]: ../ofono-1.24/src/gp=
rs.c:pri_activate_callback() 0x165b9a8
Aug 26 11:36:58 raspberrypi3 daemon.debug ofonod[147]: ../ofono-1.24/src/gp=
rs.c:pri_activate_callback() Activating context failed with error: Unknown =
error type
--===============6380760729983793612==--

