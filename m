Content-Type: multipart/mixed; boundary="===============8239875774758678418=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH v2 00/13] Add support for BlueZ 5 Profile1 API to dundee
Date: Mon, 18 Mar 2013 10:55:53 +0100
Message-ID: <5146E4A9.8060306@monom.org>
In-Reply-To: <1363267974-13518-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8239875774758678418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paulo,

I have tested this version and it seems to work. I say 'seems' because I wa=
s not able
keep open the connection. All phones I have tested open the connection and =
close
them right after. I am not sure if just my setup is broken. Testing against=
 bluez4
gave the same behaviour. So I don't think your patches are causing this.

If Denis or Marcel do not speak up now, I'll apply them (fixing the compile=
 glitch on
on patch #13, no need to resend the series.)

cheers,
daniel


dundee[1081]: dundee/device.c:set_property_active() 0x1e78960 path /device0
dundee[1081]: dundee/bluez5.c:bluetooth_device_connect() /org/bluez/hci0/de=
v_A0_4E_04_F6_F5_05
dundee[1081]: plugins/bluez5.c:device_send_message() Bluetooth: sending Con=
nectProfile for 00001103-0000-1000-8000-00805f9b34fb on /org/bluez/hci0/dev=
_A0_4E_04_F6_F5_05
dundee[1081]: dundee/bluez5.c:profile_new_connection() /org/bluez/hci0/dev_=
A0_4E_04_F6_F5_05 8
dundee[1081]: dundee/device.c:connect_callback() 0x1e78960
dundee[1081]: dundee/device.c:debug() Control: > ATD*99#\r
dundee[1081]: dundee/bluez5.c:bluetooth_device_connect_callback() Success
dundee[1081]: dundee/device.c:debug() Control: < ATD*99#\r
dundee[1081]: dundee/device.c:debug() Control: < \r\nCONNECT\r\n
dundee[1081]: dundee/device.c:debug() PPP: lcp: pppcp_generate_event: curre=
nt state 0:INITIAL
dundee[1081]: dundee/device.c:debug() PPP: event: 0 (Up), action: 2, new_st=
ate: 2 (CLOSED)
dundee[1081]: dundee/device.c:debug() PPP: lcp: pppcp_generate_event: curre=
nt state 2:CLOSED
dundee[1081]: dundee/device.c:debug() PPP: event: 2 (Open), action: 1026, n=
ew_state: 6 (REQSENT)
dundee[1081]: dundee/device.c:debug() PPP: lcp: pppcp_initialize_restart_co=
unt: current state 2:CLOSED
dundee[1081]: dundee/device.c:debug() PPP: lcp: pppcp_send_configure_reques=
t: current state 2:CLOSED
dundee[1081]: dundee/device.c:debug() PPP: gatchat/gatppp.c:ppp_enter_phase=
() 1
dundee[1081]: dundee/device.c:debug() PPP: lcp: pppcp_process_configure_req=
uest: current state 6:REQSENT
dundee[1081]: dundee/device.c:debug() PPP: lcp: pppcp_generate_event: curre=
nt state 6:REQSENT
dundee[1081]: dundee/device.c:debug() PPP: event: 7 (RCR-), action: 4006, n=
ew_state: 6 (REQSENT)
dundee[1081]: dundee/device.c:debug() PPP: lcp: pppcp_send_configure_nak: c=
urrent state 6:REQSENT
dundee[1081]: dundee/device.c:debug() PPP: lcp: pppcp_process_configure_ack=
: current state 6:REQSENT
dundee[1081]: dundee/device.c:debug() PPP: lcp: pppcp_generate_event: curre=
nt state 6:REQSENT
dundee[1081]: dundee/device.c:debug() PPP: event: 8 (RCA), action: 27, new_=
state: 7 (ACKRCVD)
dundee[1081]: dundee/device.c:debug() PPP: lcp: pppcp_initialize_restart_co=
unt: current state 6:REQSENT
dundee[1081]: dundee/device.c:debug() PPP: lcp: pppcp_process_configure_req=
uest: current state 7:ACKRCVD
dundee[1081]: dundee/device.c:debug() PPP: lcp: pppcp_generate_event: curre=
nt state 7:ACKRCVD
dundee[1081]: dundee/device.c:debug() PPP: event: 6 (RCR+), action: 2109, n=
ew_state: 9 (OPENED)
dundee[1081]: dundee/device.c:debug() PPP: lcp: pppcp_send_configure_ack: c=
urrent state 7:ACKRCVD
dundee[1081]: dundee/device.c:debug() PPP: gatchat/gatppp.c:ppp_enter_phase=
() 2
dundee[1081]: dundee/device.c:debug() PPP: gatchat/gatppp.c:ppp_enter_phase=
() 3
dundee[1081]: dundee/device.c:debug() PPP: ipcp: pppcp_generate_event: curr=
ent state 0:INITIAL
dundee[1081]: dundee/device.c:debug() PPP: event: 2 (Open), action: 401, ne=
w_state: 1 (STARTING)
dundee[1081]: dundee/device.c:debug() PPP: ipcp: pppcp_generate_event: curr=
ent state 1:STARTING
dundee[1081]: dundee/device.c:debug() PPP: event: 0 (Up), action: 1026, new=
_state: 6 (REQSENT)
dundee[1081]: dundee/device.c:debug() PPP: ipcp: pppcp_initialize_restart_c=
ount: current state 1:STARTING
dundee[1081]: dundee/device.c:debug() PPP: ipcp: pppcp_send_configure_reque=
st: current state 1:STARTING
dundee[1081]: dundee/device.c:debug() PPP: ipcp: pppcp_process_configure_re=
quest: current state 6:REQSENT
dundee[1081]: dundee/device.c:debug() PPP: ipcp: pppcp_generate_event: curr=
ent state 6:REQSENT
dundee[1081]: dundee/device.c:debug() PPP: event: 6 (RCR+), action: 2008, n=
ew_state: 8 (ACKSENT)
dundee[1081]: dundee/device.c:debug() PPP: ipcp: pppcp_send_configure_ack: =
current state 6:REQSENT
dundee[1081]: dundee/device.c:debug() PPP: ipcp: pppcp_process_configure_re=
ject: current state 8:ACKSENT
dundee[1081]: dundee/device.c:debug() PPP: ipcp: pppcp_generate_event: curr=
ent state 8:ACKSENT
dundee[1081]: dundee/device.c:debug() PPP: event: 9 (RCN), action: 1028, ne=
w_state: 8 (ACKSENT)
dundee[1081]: dundee/device.c:debug() PPP: ipcp: pppcp_initialize_restart_c=
ount: current state 8:ACKSENT
dundee[1081]: dundee/device.c:debug() PPP: ipcp: pppcp_send_configure_reque=
st: current state 8:ACKSENT
dundee[1081]: dundee/device.c:debug() PPP: ipcp: pppcp_process_configure_na=
k: current state 8:ACKSENT
dundee[1081]: dundee/device.c:debug() PPP: ipcp: pppcp_generate_event: curr=
ent state 8:ACKSENT
dundee[1081]: dundee/device.c:debug() PPP: event: 9 (RCN), action: 1028, ne=
w_state: 8 (ACKSENT)
dundee[1081]: dundee/device.c:debug() PPP: ipcp: pppcp_initialize_restart_c=
ount: current state 8:ACKSENT
dundee[1081]: dundee/device.c:debug() PPP: ipcp: pppcp_send_configure_reque=
st: current state 8:ACKSENT
dundee[1081]: dundee/device.c:debug() PPP: ipcp: pppcp_process_configure_ac=
k: current state 8:ACKSENT
dundee[1081]: dundee/device.c:debug() PPP: ipcp: pppcp_generate_event: curr=
ent state 8:ACKSENT
dundee[1081]: dundee/device.c:debug() PPP: event: 8 (RCA), action: 129, new=
_state: 9 (OPENED)
dundee[1081]: dundee/device.c:debug() PPP: ipcp: pppcp_initialize_restart_c=
ount: current state 8:ACKSENT
dundee[1081]: dundee/device.c:debug() PPP: lcp: pppcp_generate_event: curre=
nt state 9:OPENED
dundee[1081]: dundee/device.c:debug() PPP: event: 3 (Close), action: 8224, =
new_state: 4 (CLOSING)
dundee[1081]: dundee/device.c:debug() PPP: lcp: pppcp_initialize_restart_co=
unt: current state 9:OPENED
dundee[1081]: dundee/device.c:debug() PPP: lcp: pppcp_send_terminate_reques=
t: current state 9:OPENED
dundee[1081]: dundee/device.c:debug() PPP: ipcp: pppcp_generate_event: curr=
ent state 9:OPENED
dundee[1081]: dundee/device.c:debug() PPP: event: 1 (Down), action: 201, ne=
w_state: 1 (STARTING)
dundee[1081]: dundee/device.c:debug() PPP: gatchat/gatppp.c:ppp_enter_phase=
() 5
dundee[1081]: dundee/device.c:debug() PPP: lcp: pppcp_process_terminate_ack=
: current state 4:CLOSING
dundee[1081]: dundee/device.c:debug() PPP: lcp: pppcp_generate_event: curre=
nt state 4:CLOSING
dundee[1081]: dundee/device.c:debug() PPP: event: 11 (RTA), action: 802, ne=
w_state: 2 (CLOSED)
dundee[1081]: dundee/device.c:debug() PPP: lcp: pppcp_this_layer_finished: =
current state 2:CLOSED
dundee[1081]: dundee/device.c:debug() PPP: gatchat/gatppp.c:ppp_enter_phase=
() 0
dundee[1081]: dundee/device.c:debug() PPP: gatchat/gatppp.c:ppp_dead() =

dundee[1081]: dundee/device.c:ppp_disconnect() 0x1e78960
dundee[1081]: dundee/device.c:ppp_disconnect() PPP Link down: 3
dundee[1081]: dundee/bluez5.c:bluetooth_device_disconnect() /org/bluez/hci0=
/dev_A0_4E_04_F6_F5_05
dundee[1081]: dundee/device.c:dundee_device_disconnect() /device0
dundee[1081]: dundee/bluez5.c:bluetooth_device_disconnect() /org/bluez/hci0=
/dev_A0_4E_04_F6_F5_05
dundee[1081]: dundee/device.c:dundee_device_disconnect() /device0


--===============8239875774758678418==--

