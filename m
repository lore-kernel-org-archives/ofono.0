Content-Type: multipart/mixed; boundary="===============1161820776349759771=="
MIME-Version: 1.0
From: Schroeter Nicolas <Nicolas.Schroeter@hefr.ch>
Subject: Unable to establish a complete PPP link on Sagem Hilo GPRS modem
Date: Mon, 20 Aug 2012 07:55:38 +0000
Message-ID: <2F3DAB62ECFFCE41A6C553644B76A1AF0106718B@HEFRMBX01.sofr.hefr.lan>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1161820776349759771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I am developing a plugin for the Sagem Hilo GPRS modem. I use the ofono ver=
sion 1.10.
When I activate the GPRS context, I never get a complete established PPP li=
nk. The PPP debug is:


Jan  2 16:24:36 109656587698 daemon.info ofonod[600]: Aux: > AT+CGATT=3D1\r
Jan  2 16:24:39 109656587698 daemon.info ofonod[600]: Aux: < \r\nOK\r\n\r\n=
+CGREG:
Jan  2 16:24:39 109656587698 daemon.info ofonod[600]: Aux: <  1,"00CA","1
Jan  2 16:24:39 109656587698 daemon.info ofonod[600]: Aux: < 7A6"\r\n\r\n+C=
IEV:
Jan  2 16:24:39 109656587698 daemon.debug ofonod[600]: src/gprs.c:gprs_atta=
ch_callback() /hilo_0 error =3D 0
Jan  2 16:24:39 109656587698 daemon.debug ofonod[600]: src/gprs.c:ofono_gpr=
s_status_notify() /hilo_0 status 1
Jan  2 16:24:39 109656587698 daemon.info ofonod[600]: Aux: > AT+COPS=3D3,0\r
Jan  2 16:24:39 109656587698 daemon.info ofonod[600]: Aux: < 2,1 \r\n\r\n+C=
IEV: 1,2\r\n
Jan  2 16:24:39 109656587698 daemon.debug ofonod[600]: src/network.c:ofono_=
netreg_strength_notify() strength 25
Jan  2 16:24:40 109656587698 daemon.info ofonod[600]: Aux: < \r\nOK\r\n
Jan  2 16:24:40 109656587698 daemon.info ofonod[600]: Aux: > AT+COPS?\r
Jan  2 16:24:40 109656587698 daemon.info ofonod[600]: Aux: < \r\n+COPS: 0,0=
,"SWISS"\r\n\r\nOK\r\n
Jan  2 16:24:40 109656587698 daemon.debug ofonod[600]: drivers/atmodem/netw=
ork-registration.c:cops_cb() cops_cb: SWISS, 228 01 0
Jan  2 16:24:40 109656587698 daemon.debug ofonod[600]: src/network.c:curren=
t_operator_callback() 0x382bf0, (nil)
Jan  2 16:24:40 109656587698 daemon.debug ofonod[600]: src/gprs.c:netreg_st=
atus_changed() 1
Jan  2 16:24:40 109656587698 daemon.info ofonod[600]: Aux: > AT+CGREG?\rJan=
  2 16:24:40 109656587698 daemon.info ofonod[600]: Aux: < \r\n+CGREG: 2,1,"=
00CA","17A6"\r\n\r\nOK\r\n
Jan  2 16:24:40 109656587698 daemon.debug ofonod[600]: src/gprs.c:registrat=
ion_status_cb() /hilo_0 error 0 status 1
Jan  2 16:24:40 109656587698 daemon.debug ofonod[600]: src/gprs.c:ofono_gpr=
s_status_notify() /hilo_0 status 1
Jan  2 16:24:40 109656587698 daemon.info ofonod[600]: Aux: < \r\n+CIEV: 1,3=
\r\n
Jan  2 16:25:14 109656587698 daemon.debug ofonod[600]: drivers/atmodem/gprs=
-context.c:at_gprs_activate_primary() cid 1
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: Aux: > AT+CGDCONT=3D1=
,"IP","gprs.swisscom.ch","",0,0\r
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: Aux: < \r\nOK\r\n
Jan  2 16:25:14 109656587698 daemon.debug ofonod[600]: drivers/atmodem/gprs=
-context.c:at_cgdcont_cb() ok 1
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: Aux: > AT&FE0Q0V1\r
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: Aux: < \r\nOK\r\n

Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: Aux: > ATD*99***1#\r
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: Aux: < \r\nCONNECT\r\n
Jan  2 16:25:14 109656587698 daemon.debug ofonod[600]: drivers/atmodem/gprs=
-context.c:at_cgdata_cb() ok 1
Jan  2 16:25:14 109656587698 daemon.debug ofonod[600]: drivers/atmodem/gprs=
-context.c:setup_ppp()
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_gener=
ate_event: current state 0:INITIAL
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: event: 0 (Up), a=
ction: 2, new_state: 2 (CLOSED)
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_gener=
ate_event: current state 2:CLOSED
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: event: 2 (Open),=
 action: 1026, new_state: 6 (REQSENT)
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_initi=
alize_restart_count: current state 2:CLOSED
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_send_=
configure_request: current state 2:CLOSED

Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: gatchat/gatppp.c=
:ppp_enter_phase() 1
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_proce=
ss_configure_ack: current state 6:REQSENT
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_gener=
ate_event: current state 6:REQSENT
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: event: 8 (RCA), =
action: 27, new_state: 7 (ACKRCVD)
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_initi=
alize_restart_count: current state 6:REQSENT

Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_proce=
ss_configure_request: current state 7:ACKRCVD
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_gener=
ate_event: current state 7:ACKRCVD
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: event: 7 (RCR-),=
 action: 4007, new_state: 7 (ACKRCVD)

Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_send_=
configure_nak: current state 7:ACKRCVD
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_proce=
ss_configure_request: current state 7:ACKRCVD
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_gener=
ate_event: current state 7:ACKRCVD
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: event: 6 (RCR+),=
 action: 2109, new_state: 9 (OPENED)

Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_send_=
configure_ack: current state 7:ACKRCVD
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: gatchat/gatppp.c=
:ppp_enter_phase() 2
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: gatchat/gatppp.c=
:ppp_enter_phase() 3
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_gene=
rate_event: current state 0:INITIAL
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: event: 2 (Open),=
 action: 401, new_state: 1 (STARTING)

Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_gene=
rate_event: current state 1:STARTING
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: event: 0 (Up), a=
ction: 1026, new_state: 6 (REQSENT)
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_init=
ialize_restart_count: current state 1:STARTING
Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_send=
_configure_request: current state 1:STARTING
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_time=
out: current state 6:REQSENT

Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_gene=
rate_event: current state 6:REQSENT


Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: event: 4 (TO+), =
action: 1006, new_state: 6 (REQSENT)
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_send=
_configure_request: current state 6:REQSENT
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_proc=
ess_configure_request: current state 6:REQSENT
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_gene=
rate_event: current state 6:REQSENT
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: event: 6 (RCR+),=
 action: 2008, new_state: 8 (ACKSENT)
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_send=
_configure_ack: current state 6:REQSENT
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_proc=
ess_configure_reject: current state 8:ACKSENT
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_gene=
rate_event: current state 8:ACKSENT
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: event: 9 (RCN), =
action: 1028, new_state: 8 (ACKSENT)
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_init=
ialize_restart_count: current state 8:ACKSENT
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_send=
_configure_request: current state 8:ACKSENT
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_proc=
ess_configure_nak: current state 8:ACKSENT
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_gene=
rate_event: current state 8:ACKSENT
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: event: 9 (RCN), =
action: 1028, new_state: 8 (ACKSENT)
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_init=
ialize_restart_count: current state 8:ACKSENT
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_send=
_configure_request: current state 8:ACKSENT
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_proc=
ess_configure_ack: current state 8:ACKSENT
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_gene=
rate_event: current state 8:ACKSENT
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: event: 8 (RCA), =
action: 129, new_state: 9 (OPENED)
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_init=
ialize_restart_count: current state 8:ACKSENT
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_gener=
ate_event: current state 9:OPENED
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: event: 3 (Close)=
, action: 8224, new_state: 4 (CLOSING)
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_initi=
alize_restart_count: current state 9:OPENED
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_send_=
terminate_request: current state 9:OPENED
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_gene=
rate_event: current state 9:OPENED
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: event: 1 (Down),=
 action: 201, new_state: 1 (STARTING)
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: gatchat/gatppp.c=
:ppp_enter_phase() 5
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_proce=
ss_terminate_ack: current state 4:CLOSING
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_gener=
ate_event: current state 4:CLOSING
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: event: 11 (RTA),=
 action: 802, new_state: 2 (CLOSED)
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_this_=
layer_finished: current state 2:CLOSED
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: gatchat/gatppp.c=
:ppp_enter_phase() 0
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: gatchat/gatppp.c=
:ppp_dead()
Jan  2 16:25:18 109656587698 daemon.debug ofonod[600]: drivers/atmodem/gprs=
-context.c:ppp_disconnect()
Jan  2 16:25:18 109656587698 daemon.debug ofonod[600]: src/gprs.c:pri_activ=
ate_callback() 0x37f040
Jan  2 16:25:18 109656587698 daemon.debug ofonod[600]: src/gprs.c:pri_activ=
ate_callback() Activating context failed with error: Unknown error type
Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: Aux: < \r\n+CGEV: NW =
DETACH\r\n
Jan  2 16:25:18 109656587698 daemon.debug ofonod[600]: src/gprs.c:ofono_gpr=
s_detached_notify() /hilo_0


Could please anybody here give me some advice how to solve the problem?

best regards
Nicolas



--===============1161820776349759771==--

