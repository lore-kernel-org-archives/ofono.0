Content-Type: multipart/mixed; boundary="===============7428522589101702868=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: Re: Re-activating a context.
Date: Fri, 13 Jul 2012 12:12:27 +0200
Message-ID: <4FFFF48B.7040903@hale.at>
In-Reply-To: <4FFF3858.8000605@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7428522589101702868==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,


On 12/07/12 22:49, Denis Kenzior wrote:
> Hi Christopher,
>
> On 07/12/2012 09:50 AM, Christopher Vogl wrote:
>> Hello,
>>
>> I am trying to simulate a connection loss and after a valid ppp
>> connection I disconnect the antenna to get detached from GPRS.
>> After reconnecting the antenna everything seems to work fine just until
>> activating the context.
>>
>> Ofono seems to get stuck in
>> drivers/atmodem/gprs-context.c:at_gprs_activate_primary() and
>> AT+CGDCONT=3D1 is missing on the debug output.
>> When I retry to activate the context after some minutes with a dbus-send
>> call, I receive an operation in progress error.
>>
>> Below I have attached ofono's debug output and dbus-send calls for
>> important interfaces
>> - before removing the antenna
>> - after removing the antenna
>> - after reconnecting the antenna
>>
>> Modem in use: Telit UC864-G
>>
>> connMan in the debug output is my own simple connection manger. I am not
>> sure if I missed to set some ofono state or if there is a known issue.
>> I really would appreciate a hint in this case.
>>
>
> To me it looks like your PPP connection has not been dropped when the =

> antenna has been removed.  Today oFono assumes that the PPP connection =

> will be dropped by the modem in this case, and your modem does not do =

> this.  This leads to problems because the AT channel on which the PPP =

> connection is being run can not accept additional commands.  This is =

> why you're not seeing the CGDCONT.
>
> A while ago Guillaume posted a patch to fix this problem (we saw this =

> with Huawei PPP based devices).  The patch looked good to me but =

> needed further testing (e.g. for regressions).  Can you dig the =

> mailing archives and test that patch?
>
> Or maybe Guillaume will be nice enough to repost it to the mailing list.

Thanks Denis!
I found the patch from Guillaume and applied it (ofono 1.7 & 1.8).
The ppp connection seems to get dropped now when I remove the antenna =

but does not come up again correctly when I reconnect the antenna.


Regards,
Christopher




After disconnecting the antenna:

Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: Aux: < \r\n+CREG: 2\r\n
Jan  1 01:18:53 mx31tt01 daemon.debug ofonod[810]: =

src/network.c:ofono_netreg_status_notify() /telit_0 status 2 tech -1
Jan  1 01:18:53 mx31tt01 daemon.debug ofonod[810]: =

src/network.c:current_operator_callback() 0x1bed30, (nil)
Jan  1 01:18:53 mx31tt01 daemon.debug ofonod[810]: =

src/gprs.c:netreg_status_changed() 2
Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: Aux: > AT+CGATT=3D0\r
Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: Aux: < \r\n+CGREG: 2\r\n
Jan  1 01:18:53 mx31tt01 daemon.debug ofonod[810]: =

src/gprs.c:ofono_gprs_status_notify() /telit_0 status 2
Jan  1 01:18:53 mx31tt01 daemon.debug ofonod[810]: =

drivers/atmodem/gprs-context.c:at_gprs_release_primary() cid 1
Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

pppcp_generate_event: current state 9:OPENED
Jan  1 01:18:53 mx31tt01 user.debug connMan[803]: Got network =

registration signal Status: 'searching'
Jan  1 01:18:53 mx31tt01 user.err connMan[803]: =

checkAndSetOperatorSelection()
Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: event: 3 (Close), =

action: 8224, new_state: 4 (CLOSING)
Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

pppcp_initialize_restart_count: current state 9:OPENED
Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

pppcp_send_terminate_request: current state 9:OPENED
Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_generate_event: current state 9:OPENED
Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: event: 1 (Down), =

action: 201, new_state: 1 (STARTING)
Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: =

gatchat/gatppp.c:ppp_enter_phase() 5
Jan  1 01:18:53 mx31tt01 daemon.debug ofonod[810]: =

plugins/udevng.c:remove_device() /sys/devices/virtual/net/ppp0
Jan  1 01:18:53 mx31tt01 daemon.debug ofonod[810]: =

plugins/udev.c:udev_event() subsystem net remove
Jan  1 01:18:53 mx31tt01 daemon.debug ofonod[810]: =

plugins/udev.c:remove_modem() /devices/virtual/net/ppp0
Jan  1 01:18:53 mx31tt01 daemon.debug ofonod[810]: =

plugins/udev.c:udev_event() subsystem net finished
Jan  1 01:18:53 mx31tt01 user.debug connMan[803]: Got connection manager =

signal Attached, Val =3D false
Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

pppcp_process_terminate_ack: current state 4:CLOSING
Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

pppcp_generate_event: current state 4:CLOSING
Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: event: 11 (RTA), =

action: 802, new_state: 2 (CLOSED)
Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

pppcp_this_layer_finished: current state 2:CLOSED
Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: =

gatchat/gatppp.c:ppp_enter_phase() 0
Jan  1 01:18:53 mx31tt01 daemon.debug ofonod[810]: =

drivers/atmodem/gprs-context.c:at_gprs_deactivate_primary() cid 1
Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: =

gatchat/gatppp.c:ppp_dead()
Jan  1 01:18:53 mx31tt01 daemon.debug ofonod[810]: =

drivers/atmodem/gprs-context.c:ppp_disconnect()
Jan  1 01:18:53 mx31tt01 daemon.debug ofonod[810]: =

src/gprs.c:gprs_remove_context() Unregistering context: /telit_0/context1
Jan  1 01:18:53 mx31tt01 user.debug connMan[803]: Got connection manager =

signal Powered, Val =3D false
Jan  1 01:18:57 mx31tt01 daemon.info ofonod[810]: Aux: < \r\n+CME ERROR: =

30\r\n
Jan  1 01:18:57 mx31tt01 daemon.debug ofonod[810]: =

src/gprs.c:gprs_attach_callback() /telit_0 error =3D 1
Jan  1 01:18:57 mx31tt01 daemon.info ofonod[810]: Aux: > AT+CGREG?\r
Jan  1 01:18:57 mx31tt01 daemon.info ofonod[810]: Aux: < \r\n+CGREG: =

2,2\r\n\r\nOK\r\n
Jan  1 01:18:57 mx31tt01 daemon.debug ofonod[810]: =

src/gprs.c:registration_status_cb() /telit_0 error 0 status 2
Jan  1 01:18:57 mx31tt01 daemon.debug ofonod[810]: =

src/gprs.c:ofono_gprs_status_notify() /telit_0 status 2

Jan  1 01:19:30 mx31tt01 daemon.info ofonod[810]: Modem: < \r\nNO =

CARRIER\r\n




After reconnecting the antenna:

Jan  1 01:20:12 mx31tt01 daemon.info ofonod[810]: Modem: < \r\n+CGEV: ME =

DETACH\r\n
Jan  1 01:20:12 mx31tt01 daemon.info ofonod[810]: Aux: < \r\n+CGEV: ME =

DETACH\r\n
Jan  1 01:20:12 mx31tt01 daemon.debug ofonod[810]: =

src/gprs.c:ofono_gprs_detached_notify() /telit_0
Jan  1 01:20:12 mx31tt01 daemon.info ofonod[810]: Modem: < \r\n+CREG: =

1,"0340","C149"\r\n
Jan  1 01:20:12 mx31tt01 daemon.info ofonod[810]: Aux: < \r\n+CREG: =

1,"0340","C149"\r\n
Jan  1 01:20:12 mx31tt01 daemon.debug ofonod[810]: =

src/network.c:ofono_netreg_status_notify() /telit_0 status 1 tech 3
Jan  1 01:20:12 mx31tt01 user.debug connMan[803]: Got network =

registration signal Status: 'registered'
Jan  1 01:20:12 mx31tt01 user.err connMan[803]: =

checkAndSetOperatorSelection()
Jan  1 01:20:12 mx31tt01 daemon.debug ofonod[810]: =

src/gprs.c:netreg_status_changed() 1
Jan  1 01:20:12 mx31tt01 user.notice ttsession: void =

hale::gtk::StatusBar::on_tech_changed(const std::string&), this =3D =

0x1316000, New technology: edge
Jan  1 01:20:12 mx31tt01 daemon.info ofonod[810]: Aux: > AT+COPS=3D3,2\r
Jan  1 01:20:12 mx31tt01 daemon.info ofonod[810]: Aux: < \r\n+CGREG: 0\r\n
Jan  1 01:20:12 mx31tt01 daemon.debug ofonod[810]: =

src/gprs.c:ofono_gprs_status_notify() /telit_0 status 0
Jan  1 01:20:12 mx31tt01 daemon.info ofonod[810]: Modem: < \r\n+CGREG: =

0\r\n
Jan  1 01:20:12 mx31tt01 user.debug connMan[803]: Got network =

registration signal LocationAreaCode: uint16 832
Jan  1 01:20:12 mx31tt01 user.debug connMan[803]: Got network =

registration signal CellId: uint32 49481
Jan  1 01:20:12 mx31tt01 user.debug connMan[803]: Got network =

registration signal Technology: 'edge'
Jan  1 01:20:12 mx31tt01 user.debug connMan[803]: Got connection manager =

signal Powered, Val =3D true
Jan  1 01:20:12 mx31tt01 daemon.info ofonod[810]: Aux: < \r\nOK\r\n
Jan  1 01:20:12 mx31tt01 daemon.info ofonod[810]: Aux: > AT+COPS?\r
Jan  1 01:20:12 mx31tt01 daemon.info ofonod[810]: Aux: < \r\n+COPS: =

0,2,"26202",0\r\n\r\nOK\r\n
Jan  1 01:20:12 mx31tt01 daemon.debug ofonod[810]: =

drivers/atmodem/network-registration.c:cops_numeric_cb() Cops numeric =

got mcc: 262, mnc: 02
Jan  1 01:20:12 mx31tt01 daemon.info ofonod[810]: Aux: > AT+CIND?\r
Jan  1 01:20:12 mx31tt01 daemon.info ofonod[810]: Aux: < \r\n+CIND: =

4,99,1,0,0,0,0,0,1\r\n\r\nOK\r\n
Jan  1 01:20:12 mx31tt01 daemon.debug ofonod[810]: =

src/network.c:ofono_netreg_strength_notify() strength 20
Jan  1 01:20:12 mx31tt01 user.debug connMan[803]: Got network =

registration signal Strength: byte 0x14
Jan  1 01:20:12 mx31tt01 daemon.info ofonod[810]: Aux: > AT+CGATT=3D1\r
Jan  1 01:20:12 mx31tt01 daemon.info ofonod[810]: Aux: < \r\nOK\r\n
Jan  1 01:20:12 mx31tt01 daemon.debug ofonod[810]: =

src/gprs.c:gprs_attach_callback() /telit_0 error =3D 0
Jan  1 01:20:12 mx31tt01 daemon.info ofonod[810]: Aux: > AT+COPS=3D3,0\r
Jan  1 01:20:12 mx31tt01 daemon.info ofonod[810]: Aux: < \r\nOK\r\n
Jan  1 01:20:12 mx31tt01 daemon.info ofonod[810]: Aux: > AT+COPS?\r
Jan  1 01:20:12 mx31tt01 daemon.info ofonod[810]: Aux: < \r\n+COPS: =

0,0,"Vodafone D2",0\r\n\r\nOK\r\n
Jan  1 01:20:12 mx31tt01 daemon.debug ofonod[810]: =

drivers/atmodem/network-registration.c:cops_cb() cops_cb: Vodafone D2, =

262 02 0
Jan  1 01:20:12 mx31tt01 daemon.debug ofonod[810]: =

src/network.c:current_operator_callback() 0x1bed30, (nil)
Jan  1 01:20:12 mx31tt01 user.debug connMan[803]: Got network =

registration signal Name: 'Vodafone D2'
Jan  1 01:20:12 mx31tt01 daemon.debug ofonod[810]: =

src/gprs.c:netreg_status_changed() 1
Jan  1 01:20:12 mx31tt01 user.debug connMan[803]: Got network =

registration signal MobileCountryCode: '262'
Jan  1 01:20:12 mx31tt01 user.debug connMan[803]: Got network =

registration signal MobileNetworkCode: '02'
Jan  1 01:20:12 mx31tt01 daemon.info ofonod[810]: Aux: > AT+CGREG?\r
Jan  1 01:20:12 mx31tt01 daemon.info ofonod[810]: Aux: < \r\n+CGREG: =

2,0\r\n\r\nOK\r\n
Jan  1 01:20:12 mx31tt01 daemon.debug ofonod[810]: =

src/gprs.c:registration_status_cb() /telit_0 error 0 status 0
Jan  1 01:20:12 mx31tt01 daemon.debug ofonod[810]: =

src/gprs.c:ofono_gprs_status_notify() /telit_0 status 0
Jan  1 01:20:14 mx31tt01 daemon.info ofonod[810]: Modem: < \r\n+CGREG: =

2\r\n
Jan  1 01:20:14 mx31tt01 daemon.info ofonod[810]: Aux: < \r\n+CGREG: 2\r\n
Jan  1 01:20:14 mx31tt01 daemon.debug ofonod[810]: =

src/gprs.c:ofono_gprs_status_notify() /telit_0 status 2
Jan  1 01:20:14 mx31tt01 daemon.info ofonod[810]: Modem: < \r\n+CGREG: =

1,"0340","C149"\r\n
Jan  1 01:20:14 mx31tt01 daemon.info ofonod[810]: Aux: < \r\n+CGREG: =

1,"0340","C149"\r\n
Jan  1 01:20:14 mx31tt01 daemon.debug ofonod[810]: =

src/gprs.c:ofono_gprs_status_notify() /telit_0 status 1
Jan  1 01:20:14 mx31tt01 user.debug connMan[803]: Got connection manager =

signal Attached, Val =3D true
Jan  1 01:20:14 mx31tt01 user.debug connMan[803]: Getting first internet =

context ...
Jan  1 01:20:14 mx31tt01 user.debug connMan[803]: No internet context =

found! Adding a new internet context.
Jan  1 01:20:14 mx31tt01 daemon.debug ofonod[810]: =

src/gprs.c:add_context() Registering new context
Jan  1 01:20:14 mx31tt01 user.debug connMan[803]: Context path: =

/telit_0/context2
Jan  1 01:20:14 mx31tt01 user.debug connMan[803]: Connecting to =

org.ofono.ConnectionContext PropertyChanged signal.
Jan  1 01:20:14 mx31tt01 user.debug connMan[803]: Connecting to =

org.ofono.ConnectionContext ContextAdded signal.
Jan  1 01:20:14 mx31tt01 user.debug connMan[803]: Connecting to =

org.ofono.ConnectionContext ContextRemoved signal.
Jan  1 01:20:14 mx31tt01 user.debug connMan[803]: =

set_and_activate_context()
Jan  1 01:20:14 mx31tt01 user.debug connMan[803]: Setting and Activating =

the Internet connection context.
Jan  1 01:20:14 mx31tt01 user.debug connMan[803]: mccmnc =3D '26202', len =
=3D 5
Jan  1 01:20:15 mx31tt01 user.debug connMan[803]: Provider name '1&1'
Jan  1 01:20:15 mx31tt01 user.debug connMan[803]: Set AccessPointName: =

web.vodafone.de
Jan  1 01:20:15 mx31tt01 user.debug connMan[803]: Set Username:
Jan  1 01:20:15 mx31tt01 user.debug connMan[803]: Set Password:
Jan  1 01:20:15 mx31tt01 user.debug connMan[803]: Trying to set =

context:web.vodafone.de
Jan  1 01:20:15 mx31tt01 daemon.debug ofonod[810]: =

drivers/atmodem/gprs-context.c:at_gprs_activate_primary() cid 1
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: Modem: > =

AT+CGDCONT=3D1,"IP","web.vodafone.de"\r
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: Modem: < \r\nOK\r\n
Jan  1 01:20:15 mx31tt01 daemon.debug ofonod[810]: =

drivers/atmodem/gprs-context.c:at_cgdcont_cb() ok 1
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: Modem: > =

AT+CGDATA=3D"PPP",1\r
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: Modem: < \r\nCONNECT\r\n
Jan  1 01:20:15 mx31tt01 daemon.debug ofonod[810]: =

drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 1
Jan  1 01:20:15 mx31tt01 daemon.debug ofonod[810]: =

drivers/atmodem/gprs-context.c:setup_ppp()
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

pppcp_generate_event: current state 0:INITIAL
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: event: 0 (Up), =

action: 2, new_state: 2 (CLOSED)
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

pppcp_generate_event: current state 2:CLOSED
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: event: 2 (Open), =

action: 1026, new_state: 6 (REQSENT)
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

pppcp_initialize_restart_count: current state 2:CLOSED
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

pppcp_send_configure_request: current state 2:CLOSED
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: =

gatchat/gatppp.c:ppp_enter_phase() 1
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

pppcp_process_configure_request: current state 6:REQSENT
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

pppcp_generate_event: current state 6:REQSENT
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: event: 6 (RCR+), =

action: 2008, new_state: 8 (ACKSENT)
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

pppcp_send_configure_ack: current state 6:REQSENT
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

pppcp_process_configure_ack: current state 8:ACKSENT
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

pppcp_generate_event: current state 8:ACKSENT
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: event: 8 (RCA), =

action: 129, new_state: 9 (OPENED)
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

pppcp_initialize_restart_count: current state 8:ACKSENT
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: =

gatchat/gatppp.c:ppp_enter_phase() 2
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: =

gatchat/gatppp.c:ppp_enter_phase() 3
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_generate_event: current state 0:INITIAL
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: event: 2 (Open), =

action: 401, new_state: 1 (STARTING)
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_generate_event: current state 1:STARTING
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: event: 0 (Up), =

action: 1026, new_state: 6 (REQSENT)
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_initialize_restart_count: current state 1:STARTING
Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_send_configure_request: current state 1:STARTING
Jan  1 01:20:16 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_process_configure_nak: current state 6:REQSENT
Jan  1 01:20:16 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_generate_event: current state 6:REQSENT
Jan  1 01:20:16 mx31tt01 daemon.info ofonod[810]: PPP: event: 9 (RCN), =

action: 1026, new_state: 6 (REQSENT)
Jan  1 01:20:16 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_initialize_restart_count: current state 6:REQSENT
Jan  1 01:20:16 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_send_configure_request: current state 6:REQSENT
Jan  1 01:20:17 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_process_configure_nak: current state 6:REQSENT
Jan  1 01:20:17 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_generate_event: current state 6:REQSENT
Jan  1 01:20:17 mx31tt01 daemon.info ofonod[810]: PPP: event: 9 (RCN), =

action: 1026, new_state: 6 (REQSENT)
Jan  1 01:20:17 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_initialize_restart_count: current state 6:REQSENT
Jan  1 01:20:17 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_send_configure_request: current state 6:REQSENT
Jan  1 01:20:18 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_process_configure_nak: current state 6:REQSENT
Jan  1 01:20:18 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_generate_event: current state 6:REQSENT
Jan  1 01:20:18 mx31tt01 daemon.info ofonod[810]: PPP: event: 9 (RCN), =

action: 1026, new_state: 6 (REQSENT)
Jan  1 01:20:18 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_initialize_restart_count: current state 6:REQSENT
Jan  1 01:20:18 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_send_configure_request: current state 6:REQSENT
Jan  1 01:20:19 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_process_configure_nak: current state 6:REQSENT
Jan  1 01:20:19 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_generate_event: current state 6:REQSENT
Jan  1 01:20:19 mx31tt01 daemon.info ofonod[810]: PPP: event: 9 (RCN), =

action: 1026, new_state: 6 (REQSENT)
Jan  1 01:20:19 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_initialize_restart_count: current state 6:REQSENT
Jan  1 01:20:19 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_send_configure_request: current state 6:REQSENT
Jan  1 01:20:20 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_process_configure_nak: current state 6:REQSENT
Jan  1 01:20:20 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_generate_event: current state 6:REQSENT
Jan  1 01:20:20 mx31tt01 daemon.info ofonod[810]: PPP: event: 9 (RCN), =

action: 1026, new_state: 6 (REQSENT)
Jan  1 01:20:20 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_initialize_restart_count: current state 6:REQSENT
Jan  1 01:20:20 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_send_configure_request: current state 6:REQSENT
Jan  1 01:20:21 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_process_configure_nak: current state 6:REQSENT
Jan  1 01:20:21 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_generate_event: current state 6:REQSENT
Jan  1 01:20:21 mx31tt01 daemon.info ofonod[810]: PPP: event: 9 (RCN), =

action: 1026, new_state: 6 (REQSENT)
Jan  1 01:20:21 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_initialize_restart_count: current state 6:REQSENT
Jan  1 01:20:21 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_send_configure_request: current state 6:REQSENT
Jan  1 01:20:21 mx31tt01 daemon.info ofonod[810]: Aux: < \r\n+CGEV: ME =

DEACT IP, , 1\r\n
Jan  1 01:20:24 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_timeout: current state 6:REQSENT
Jan  1 01:20:24 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_generate_event: current state 6:REQSENT
Jan  1 01:20:24 mx31tt01 daemon.info ofonod[810]: PPP: event: 4 (TO+), =

action: 1006, new_state: 6 (REQSENT)
Jan  1 01:20:24 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_send_configure_request: current state 6:REQSENT
Jan  1 01:20:27 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_timeout: current state 6:REQSENT
Jan  1 01:20:27 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_generate_event: current state 6:REQSENT
Jan  1 01:20:27 mx31tt01 daemon.info ofonod[810]: PPP: event: 4 (TO+), =

action: 1006, new_state: 6 (REQSENT)
Jan  1 01:20:27 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_send_configure_request: current state 6:REQSENT
Jan  1 01:20:30 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_timeout: current state 6:REQSENT
Jan  1 01:20:30 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_generate_event: current state 6:REQSENT
Jan  1 01:20:30 mx31tt01 daemon.info ofonod[810]: PPP: event: 4 (TO+), =

action: 1006, new_state: 6 (REQSENT)
Jan  1 01:20:30 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_send_configure_request: current state 6:REQSENT
Jan  1 01:20:33 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_timeout: current state 6:REQSENT
Jan  1 01:20:33 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_generate_event: current state 6:REQSENT
Jan  1 01:20:33 mx31tt01 daemon.info ofonod[810]: PPP: event: 4 (TO+), =

action: 1006, new_state: 6 (REQSENT)
Jan  1 01:20:33 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_send_configure_request: current state 6:REQSENT
Jan  1 01:20:36 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_timeout: current state 6:REQSENT
Jan  1 01:20:36 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_generate_event: current state 6:REQSENT
Jan  1 01:20:36 mx31tt01 daemon.info ofonod[810]: PPP: event: 4 (TO+), =

action: 1006, new_state: 6 (REQSENT)
Jan  1 01:20:36 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_send_configure_request: current state 6:REQSENT
Jan  1 01:20:39 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_timeout: current state 6:REQSENT
Jan  1 01:20:39 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_generate_event: current state 6:REQSENT
Jan  1 01:20:39 mx31tt01 daemon.info ofonod[810]: PPP: event: 4 (TO+), =

action: 1006, new_state: 6 (REQSENT)
Jan  1 01:20:39 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_send_configure_request: current state 6:REQSENT
Jan  1 01:20:40 mx31tt01 user.debug connMan[803]: Got connection context =

signal AccessPointName, Val =3D 'web.vodafone.de'
Jan  1 01:20:40 mx31tt01 user.info connMan[803]: APN: web.vodafone.de
Jan  1 01:20:42 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_timeout: current state 6:REQSENT
Jan  1 01:20:42 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_generate_event: current state 6:REQSENT
Jan  1 01:20:42 mx31tt01 daemon.info ofonod[810]: PPP: event: 4 (TO+), =

action: 1006, new_state: 6 (REQSENT)
Jan  1 01:20:42 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_send_configure_request: current state 6:REQSENT
Jan  1 01:20:45 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_timeout: current state 6:REQSENT
Jan  1 01:20:45 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_generate_event: current state 6:REQSENT
Jan  1 01:20:45 mx31tt01 daemon.info ofonod[810]: PPP: event: 4 (TO+), =

action: 1006, new_state: 6 (REQSENT)
Jan  1 01:20:45 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_send_configure_request: current state 6:REQSENT
Jan  1 01:20:48 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_timeout: current state 6:REQSENT
Jan  1 01:20:48 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_generate_event: current state 6:REQSENT
Jan  1 01:20:48 mx31tt01 daemon.info ofonod[810]: PPP: event: 4 (TO+), =

action: 1006, new_state: 6 (REQSENT)
Jan  1 01:20:48 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_send_configure_request: current state 6:REQSENT
Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_timeout: current state 6:REQSENT
Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_generate_event: current state 6:REQSENT
Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: event: 5 (TO-), =

action: 803, new_state: 3 (STOPPED)
Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_this_layer_finished: current state 3:STOPPED
Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_generate_event: current state 3:STOPPED
Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: event: 3 (Close), =

action: 2, new_state: 2 (CLOSED)
Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

pppcp_generate_event: current state 9:OPENED
Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: event: 3 (Close), =

action: 8224, new_state: 4 (CLOSING)
Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

pppcp_initialize_restart_count: current state 9:OPENED
Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

pppcp_send_terminate_request: current state 9:OPENED
Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

pppcp_generate_event: current state 2:CLOSED
Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: event: 1 (Down), =

action: 0, new_state: 0 (INITIAL)
Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: =

gatchat/gatppp.c:ppp_enter_phase() 5
Jan  1 01:20:54 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

pppcp_timeout: current state 4:CLOSING
Jan  1 01:20:54 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

pppcp_generate_event: current state 4:CLOSING
Jan  1 01:20:54 mx31tt01 daemon.info ofonod[810]: PPP: event: 4 (TO+), =

action: 8004, new_state: 4 (CLOSING)
Jan  1 01:20:54 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

pppcp_send_terminate_request: current state 4:CLOSING
Jan  1 01:20:57 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

pppcp_timeout: current state 4:CLOSING
Jan  1 01:20:57 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

pppcp_generate_event: current state 4:CLOSING
Jan  1 01:20:57 mx31tt01 daemon.info ofonod[810]: PPP: event: 5 (TO-), =

action: 802, new_state: 2 (CLOSED)
Jan  1 01:20:57 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

pppcp_this_layer_finished: current state 2:CLOSED
Jan  1 01:20:57 mx31tt01 daemon.info ofonod[810]: PPP: =

gatchat/gatppp.c:ppp_enter_phase() 0
Jan  1 01:20:57 mx31tt01 daemon.info ofonod[810]: PPP: =

gatchat/gatppp.c:ppp_dead()
Jan  1 01:20:57 mx31tt01 daemon.debug ofonod[810]: =

drivers/atmodem/gprs-context.c:ppp_disconnect()
Jan  1 01:20:57 mx31tt01 daemon.debug ofonod[810]: =

src/gprs.c:pri_activate_callback() 0x1ce500
Jan  1 01:20:57 mx31tt01 daemon.debug ofonod[810]: =

src/gprs.c:pri_activate_callback() Activating context failed with error: =

Unknown error type





--
Scanned by MailScanner.


--===============7428522589101702868==--

