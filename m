Content-Type: multipart/mixed; boundary="===============7135067433256552038=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: Re-activating a context.
Date: Thu, 12 Jul 2012 16:50:49 +0200
Message-ID: <4FFEE449.7080902@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7135067433256552038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I am trying to simulate a connection loss and after a valid ppp =

connection I disconnect the antenna to get detached from GPRS.
After reconnecting the antenna everything seems to work fine just until =

activating the context.

Ofono seems to get stuck in =

drivers/atmodem/gprs-context.c:at_gprs_activate_primary() and =

AT+CGDCONT=3D1 is missing on the debug output.
When I retry to activate the context after some minutes with a dbus-send =

call, I receive an operation in progress error.

Below I have attached ofono's debug output and dbus-send calls for =

important interfaces
  - before removing the antenna
  - after removing the antenna
  - after reconnecting the antenna

Modem in use: Telit UC864-G

connMan in the debug output is my own simple connection manger. I am not =

sure if I missed to set some ofono state or if there is a known issue.
I really would appreciate a hint in this case.

Thanks!


Greetings,

Christopher Vogl


...
Jan  1 07:56:39 mx31tt01 daemon.info ofonod[408]: PPP: ipcp: =

pppcp_initialize_restart_count: current state 6:REQSENT
Jan  1 07:56:39 mx31tt01 daemon.info ofonod[408]: PPP: ipcp: =

pppcp_send_configure_request: current state 6:REQSENT
Jan  1 07:56:39 mx31tt01 daemon.info ofonod[408]: PPP: ipcp: =

pppcp_process_configure_request: current state 6:REQSENT
Jan  1 07:56:39 mx31tt01 daemon.info ofonod[408]: PPP: ipcp: =

pppcp_generate_event: current state 6:REQSENT
Jan  1 07:56:39 mx31tt01 daemon.info ofonod[408]: PPP: event: 6 (RCR+), =

action: 2008, new_state: 8 (ACKSENT)
Jan  1 07:56:39 mx31tt01 daemon.info ofonod[408]: PPP: ipcp: =

pppcp_send_configure_ack: current state 6:REQSENT
Jan  1 07:56:39 mx31tt01 daemon.info ofonod[408]: PPP: ipcp: =

pppcp_process_configure_reject: current state 8:ACKSENT
Jan  1 07:56:39 mx31tt01 daemon.info ofonod[408]: PPP: ipcp: =

pppcp_generate_event: current state 8:ACKSENT
Jan  1 07:56:39 mx31tt01 daemon.info ofonod[408]: PPP: event: 9 (RCN), =

action: 1028, new_state: 8 (ACKSENT)
Jan  1 07:56:39 mx31tt01 daemon.info ofonod[408]: PPP: ipcp: =

pppcp_initialize_restart_count: current state 8:ACKSENT
Jan  1 07:56:39 mx31tt01 daemon.info ofonod[408]: PPP: ipcp: =

pppcp_send_configure_request: current state 8:ACKSENT
Jan  1 07:56:39 mx31tt01 daemon.info ofonod[408]: PPP: ipcp: =

pppcp_process_configure_nak: current state 8:ACKSENT
Jan  1 07:56:39 mx31tt01 daemon.info ofonod[408]: PPP: ipcp: =

pppcp_generate_event: current state 8:ACKSENT
Jan  1 07:56:39 mx31tt01 daemon.info ofonod[408]: PPP: event: 9 (RCN), =

action: 1028, new_state: 8 (ACKSENT)
Jan  1 07:56:39 mx31tt01 daemon.info ofonod[408]: PPP: ipcp: =

pppcp_initialize_restart_count: current state 8:ACKSENT
Jan  1 07:56:39 mx31tt01 daemon.info ofonod[408]: PPP: ipcp: =

pppcp_send_configure_request: current state 8:ACKSENT
Jan  1 07:56:39 mx31tt01 daemon.info ofonod[408]: PPP: ipcp: =

pppcp_process_configure_ack: current state 8:ACKSENT
Jan  1 07:56:39 mx31tt01 daemon.info ofonod[408]: PPP: ipcp: =

pppcp_generate_event: current state 8:ACKSENT
Jan  1 07:56:39 mx31tt01 daemon.info ofonod[408]: PPP: event: 8 (RCA), =

action: 129, new_state: 9 (OPENED)
Jan  1 07:56:39 mx31tt01 daemon.info ofonod[408]: PPP: ipcp: =

pppcp_initialize_restart_count: current state 8:ACKSENT
Jan  1 07:56:39 mx31tt01 daemon.info ofonod[408]: PPP: =

gatchat/gatppp.c:ppp_enter_phase() 4
Jan  1 07:56:39 mx31tt01 daemon.debug ofonod[408]: =

drivers/atmodem/gprs-context.c:ppp_connect()
Jan  1 07:56:39 mx31tt01 daemon.info ofonod[408]: IP: 2.200.229.88
Jan  1 07:56:39 mx31tt01 daemon.info ofonod[408]: DNS: 139.7.30.126, =

139.7.30.125
Jan  1 07:56:39 mx31tt01 daemon.debug ofonod[408]: =

src/gprs.c:pri_activate_callback() 0x1b7dde0
Jan  1 07:56:39 mx31tt01 user.debug connMan[371]: Got connection context =

signal Settings, Val =3D {'Interface': <'ppp0'>, 'Method': <'static'>, =

'Address': <'2.200.229.88'>, 'Netmask': <'255.255.255.255'>, 'Do
mainNameServers': <['139.7.30.126', '139.7.30.125']>}
Jan  1 07:56:39 mx31tt01 daemon.debug ofonod[408]: =

plugins/udev.c:udev_event() subsystem net add
Jan  1 07:56:39 mx31tt01 daemon.debug ofonod[408]: =

plugins/udev.c:udev_event() subsystem net finished
Jan  1 07:56:39 mx31tt01 user.debug connMan[371]: Got connection context =

signal Active, Val =3D true
Jan  1 07:56:39 mx31tt01 user.debug connMan[371]: Method is a string static
Jan  1 07:56:39 mx31tt01 user.info connMan[371]: Set up ip ip addr add =

2.200.229.88/32 dev ppp0
Jan  1 07:56:39 mx31tt01 user.info connMan[371]: Domain name servers:
Jan  1 07:56:39 mx31tt01 user.info connMan[371]: 139.7.30.126
Jan  1 07:56:39 mx31tt01 user.info connMan[371]: Adding route ip route =

add 139.7.30.126/32 dev ppp0
Jan  1 07:56:39 mx31tt01 user.info connMan[371]: 139.7.30.125
Jan  1 07:56:39 mx31tt01 user.info connMan[371]: Adding route ip route =

add 139.7.30.125/32 dev ppp0
Jan  1 07:56:39 mx31tt01 user.info connMan[371]: resolv.conf file will =

look like this:
Jan  1 07:56:39 mx31tt01 user.info connMan[371]: nameserver 139.7.30.126 =

nameserver 139.7.30.125
Jan  1 07:56:39 mx31tt01 user.info connMan[371]: Writing resolv.conf
Jan  1 07:56:39 mx31tt01 user.info connMan[371]: Setting default route =

for interface ppp0
Jan  1 07:56:39 mx31tt01 user.info connMan[371]: Adding default route =

route add default gw 2.200.229.88 ppp0
Jan  1 07:56:40 mx31tt01 daemon.debug ofonod[408]: =

plugins/udevng.c:check_modem_list()


dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.ofono =

/telit_0 org.ofono.NetworkRegistration.GetProperties
method return sender=3D:1.5 -> dest=3D:1.16 reply_serial=3D2
    array [
       dict entry(
          string "Status"
          variant             string "registered"
       )
       dict entry(
          string "Mode"
          variant             string "auto"
       )
       dict entry(
          string "LocationAreaCode"
          variant             uint16 832
       )
       dict entry(
          string "CellId"
          variant             uint32 49481
       )
       dict entry(
          string "Name"
          variant             string ""
       )
       dict entry(
          string "Strength"
          variant             byte 100
       )
    ]

dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.ofono =

/telit_0 org.ofono.ConnectionManager.GetProperties
method return sender=3D:1.5 -> dest=3D:1.17 reply_serial=3D2
    array [
       dict entry(
          string "Attached"
          variant             boolean true
       )
       dict entry(
          string "Bearer"
          variant             string "none"
       )
       dict entry(
          string "RoamingAllowed"
          variant             boolean true
       )
       dict entry(
          string "Powered"
          variant             boolean true
       )
       dict entry(
          string "Suspended"
          variant             boolean false
       )
    ]

dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.ofono =

/telit_0 org.ofono.ConnectionManager.GetContexts
method return sender=3D:1.5 -> dest=3D:1.18 reply_serial=3D2
    array [
       struct {
          object path "/telit_0/context2"
          array [
             dict entry(
                string "Name"
                variant                   string "Internet"
             )
             dict entry(
                string "Active"
                variant                   boolean true
             )
             dict entry(
                string "Type"
                variant                   string "internet"
             )
             dict entry(
                string "Protocol"
                variant                   string "ip"
             )
             dict entry(
                string "AccessPointName"
                variant                   string "web.vodafone.de"
             )
             dict entry(
                string "Username"
                variant                   string ""
             )
             dict entry(
                string "Password"
                variant                   string ""
             )
             dict entry(
                string "Settings"
                variant                   array [
                      dict entry(
                         string "Interface"
                         variant                            string "ppp0"
                      )
                      dict entry(
                         string "Method"
                         variant                            string "static"
                      )
                      dict entry(
                         string "Address"
                         variant                            string =

"2.200.229.88"
                      )
                      dict entry(
                         string "Netmask"
                         variant                            string =

"255.255.255.255"
                      )
                      dict entry(
                         string "DomainNameServers"
                         variant                            array [
                               string "139.7.30.126"
                               string "139.7.30.125"
                            ]
                      )
                   ]
             )
             dict entry(
                string "IPv6.Settings"
                variant                   array [
                   ]
             )
          ]
       }
    ]



After disconnecting the antenna:

Jan  1 08:02:25 mx31tt01 daemon.info ofonod[408]: Aux: < \r\n+CREG: 2\r\n
Jan  1 08:02:25 mx31tt01 daemon.debug ofonod[408]: =

src/network.c:ofono_netreg_status_notify() /telit_0 status 2 tech -1
Jan  1 08:02:25 mx31tt01 daemon.debug ofonod[408]: =

src/network.c:current_operator_callback() 0x1b79df8, 0x1b80eb0
Jan  1 08:02:25 mx31tt01 daemon.debug ofonod[408]: =

src/gprs.c:netreg_status_changed() 2
Jan  1 08:02:25 mx31tt01 daemon.debug ofonod[408]: =

src/gprs.c:netreg_status_changed() 2
Jan  1 08:02:25 mx31tt01 user.debug connMan[371]: Got network =

registration signal Status: 'searching'
Jan  1 08:02:25 mx31tt01 user.err connMan[371]: =

checkAndSetOperatorSelection()
Jan  1 08:02:25 mx31tt01 daemon.info ofonod[408]: Aux: > AT+CGATT=3D0\r
Jan  1 08:02:25 mx31tt01 daemon.info ofonod[408]: Aux: < \r\n+CGREG: 2\r\n
Jan  1 08:02:25 mx31tt01 daemon.debug ofonod[408]: =

src/gprs.c:ofono_gprs_status_notify() /telit_0 status 2
Jan  1 08:02:25 mx31tt01 user.debug connMan[371]: Got network =

registration signal Name: ''
Jan  1 08:02:25 mx31tt01 user.debug connMan[371]: Got connection context =

signal Settings, Val =3D @a{sv} {}
Jan  1 08:02:25 mx31tt01 user.debug connMan[371]: Got connection context =

signal Active, Val =3D false
Jan  1 08:02:25 mx31tt01 user.info connMan[371]: Connection context has =

been deactivated.
Jan  1 08:02:25 mx31tt01 user.debug connMan[371]: Got connection manager =

signal Attached, Val =3D false
Jan  1 08:02:25 mx31tt01 user.info connMan[371]: Detached - all contexts =

have been deactivated
Jan  1 08:02:25 mx31tt01 daemon.debug ofonod[408]: =

src/gprs.c:gprs_remove_context() Unregistering context: /telit_0/context2
Jan  1 08:02:25 mx31tt01 user.debug connMan[371]: Got connection manager =

signal Powered, Val =3D false
Jan  1 08:02:28 mx31tt01 daemon.info ofonod[408]: Aux: < \r\n+CME ERROR: =

30\r\n
Jan  1 08:02:28 mx31tt01 daemon.debug ofonod[408]: =

src/gprs.c:gprs_attach_callback() /telit_0 error =3D 1
Jan  1 08:02:28 mx31tt01 daemon.info ofonod[408]: Aux: > AT+CGREG?\r
Jan  1 08:02:28 mx31tt01 daemon.info ofonod[408]: Aux: < \r\n+CGREG: =

2,2\r\n\r\nOK\r\n
Jan  1 08:02:28 mx31tt01 daemon.debug ofonod[408]: =

src/gprs.c:registration_status_cb() /telit_0 error 0 status 2
Jan  1 08:02:28 mx31tt01 daemon.debug ofonod[408]: =

src/gprs.c:ofono_gprs_status_notify() /telit_0 status 2



dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.ofono =

/telit_0 org.ofono.NetworkRegistration.GetProperties
method return sender=3D:1.5 -> dest=3D:1.21 reply_serial=3D2
    array [
       dict entry(
          string "Status"
          variant             string "searching"
       )
       dict entry(
          string "Mode"
          variant             string "auto"
       )
       dict entry(
          string "Name"
          variant             string ""
       )
    ]


dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.ofono =

/telit_0 org.ofono.ConnectionManager.GetProperties
method return sender=3D:1.5 -> dest=3D:1.22 reply_serial=3D2
    array [
       dict entry(
          string "Attached"
          variant             boolean false
       )
       dict entry(
          string "RoamingAllowed"
          variant             boolean true
       )
       dict entry(
          string "Powered"
          variant             boolean false
       )
    ]

dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.ofono =

/telit_0 org.ofono.ConnectionManager.GetContexts
method return sender=3D:1.5 -> dest=3D:1.23 reply_serial=3D2
    array [
    ]



After reconnecting the antenna:

Jan  1 08:08:48 mx31tt01 daemon.info ofonod[408]: Aux: < \r\n+CGEV: ME =

DETACH\r\n
Jan  1 08:08:48 mx31tt01 daemon.debug ofonod[408]: =

src/gprs.c:ofono_gprs_detached_notify() /telit_0
Jan  1 08:08:48 mx31tt01 daemon.info ofonod[408]: Aux: < \r\n+CREG: =

1,"0340","143D"\r\n
Jan  1 08:08:48 mx31tt01 daemon.debug ofonod[408]: =

src/network.c:ofono_netreg_status_notify() /telit_0 status 1 tech -1
Jan  1 08:08:48 mx31tt01 daemon.debug ofonod[408]: =

src/gprs.c:netreg_status_changed() 1
Jan  1 08:08:48 mx31tt01 user.debug connMan[371]: Got network =

registration signal Status: 'registered'
Jan  1 08:08:48 mx31tt01 user.debug connMan[371]: Got network =

registration signal LocationAreaCode: uint16 832
Jan  1 08:08:48 mx31tt01 user.err connMan[371]: =

checkAndSetOperatorSelection()
Jan  1 08:08:48 mx31tt01 daemon.info ofonod[408]: Aux: > AT+COPS=3D3,2\r
Jan  1 08:08:48 mx31tt01 daemon.info ofonod[408]: Aux: < \r\n+CGREG: 0\r\n
Jan  1 08:08:48 mx31tt01 daemon.debug ofonod[408]: =

src/gprs.c:ofono_gprs_status_notify() /telit_0 status 0
Jan  1 08:08:48 mx31tt01 daemon.info ofonod[408]: Aux: < \r\nOK\r\n
Jan  1 08:08:48 mx31tt01 daemon.info ofonod[408]: Aux: > AT+COPS?\r
Jan  1 08:08:48 mx31tt01 daemon.info ofonod[408]: Aux: < \r\n+COPS: =

0,2,"26202",0\r\n\r\nOK\r\n
Jan  1 08:08:48 mx31tt01 daemon.debug ofonod[408]: =

drivers/atmodem/network-registration.c:cops_numeric_cb() Cops numeric =

got mcc: 262, mnc: 02
Jan  1 08:08:48 mx31tt01 daemon.info ofonod[408]: Aux: > AT+CIND?\r
Jan  1 08:08:48 mx31tt01 daemon.info ofonod[408]: Aux: < \r\n+CIND: =

4,99,1,0,0,0,0,0,2\r\n\r\nOK\r\n
Jan  1 08:08:48 mx31tt01 user.debug connMan[371]: Got network =

registration signal CellId: uint32 5181
Jan  1 08:08:48 mx31tt01 user.debug connMan[371]: Got connection manager =

signal Powered, Val =3D true
Jan  1 08:08:48 mx31tt01 daemon.debug ofonod[408]: =

src/network.c:ofono_netreg_strength_notify() strength 40
Jan  1 08:08:48 mx31tt01 daemon.info ofonod[408]: Aux: > AT+COPS=3D3,0\r
Jan  1 08:08:48 mx31tt01 daemon.info ofonod[408]: Aux: < \r\nOK\r\n
Jan  1 08:08:48 mx31tt01 daemon.info ofonod[408]: Aux: > AT+COPS?\r
Jan  1 08:08:48 mx31tt01 user.debug connMan[371]: Got network =

registration signal Strength: byte 0x28
Jan  1 08:08:48 mx31tt01 daemon.info ofonod[408]: Aux: < \r\n+COPS: =

0,0,"Vodafone D2",0\r\n\r\nOK\r\n
Jan  1 08:08:48 mx31tt01 daemon.debug ofonod[408]: =

drivers/atmodem/network-registration.c:cops_cb() cops_cb: Vodafone D2, =

262 02 0
Jan  1 08:08:48 mx31tt01 daemon.debug ofonod[408]: =

src/network.c:current_operator_callback() 0x1b79df8, (nil)
Jan  1 08:08:48 mx31tt01 user.debug connMan[371]: Got network =

registration signal Name: 'Vodafone D2'
Jan  1 08:08:48 mx31tt01 daemon.debug ofonod[408]: =

src/gprs.c:netreg_status_changed() 1
Jan  1 08:08:48 mx31tt01 daemon.info ofonod[408]: Aux: > AT+CGATT=3D1\r
Jan  1 08:08:48 mx31tt01 user.debug connMan[371]: Got network =

registration signal MobileCountryCode: '262'
Jan  1 08:08:48 mx31tt01 user.debug connMan[371]: Got network =

registration signal MobileNetworkCode: '02'
Jan  1 08:08:48 mx31tt01 daemon.info ofonod[408]: Aux: < \r\nOK\r\n
Jan  1 08:08:48 mx31tt01 daemon.debug ofonod[408]: =

src/gprs.c:gprs_attach_callback() /telit_0 error =3D 0
Jan  1 08:08:48 mx31tt01 daemon.info ofonod[408]: Aux: > AT+CGREG?\r
Jan  1 08:08:48 mx31tt01 daemon.info ofonod[408]: Aux: < \r\n+CGREG: =

2,0\r\n\r\nOK\r\n
Jan  1 08:08:48 mx31tt01 daemon.debug ofonod[408]: =

src/gprs.c:registration_status_cb() /telit_0 error 0 status 0
Jan  1 08:08:48 mx31tt01 daemon.debug ofonod[408]: =

src/gprs.c:ofono_gprs_status_notify() /telit_0 status 0
Jan  1 08:08:57 mx31tt01 daemon.info ofonod[408]: Aux: < \r\n+CGREG: 2\r\n
Jan  1 08:08:57 mx31tt01 daemon.debug ofonod[408]: =

src/gprs.c:ofono_gprs_status_notify() /telit_0 status 2
Jan  1 08:08:57 mx31tt01 daemon.info ofonod[408]: Aux: < \r\n+CGREG: =

1,"0340","143D"\r\n
Jan  1 08:08:57 mx31tt01 daemon.debug ofonod[408]: =

src/gprs.c:ofono_gprs_status_notify() /telit_0 status 1
Jan  1 08:08:57 mx31tt01 user.debug connMan[371]: Got connection manager =

signal Attached, Val =3D true
Jan  1 08:08:57 mx31tt01 user.info connMan[371]: Attached
Jan  1 08:08:57 mx31tt01 user.debug connMan[371]: Getting first internet =

context ...
Jan  1 08:08:57 mx31tt01 user.debug connMan[371]: No internet context =

found! Adding a new internet context.
Jan  1 08:08:57 mx31tt01 daemon.debug ofonod[408]: =

src/gprs.c:add_context() Registering new context
Jan  1 08:08:57 mx31tt01 user.debug connMan[371]: Context path: =

/telit_0/context3
Jan  1 08:08:57 mx31tt01 user.debug connMan[371]: Connecting to =

org.ofono.ConnectionContext PropertyChanged signal.
Jan  1 08:08:58 mx31tt01 user.debug connMan[371]: Connecting to =

org.ofono.ConnectionContext ContextAdded signal.
Jan  1 08:08:58 mx31tt01 user.debug connMan[371]: Connecting to =

org.ofono.ConnectionContext ContextRemoved signal.
Jan  1 08:08:58 mx31tt01 user.debug connMan[371]: set_and_activate_context()
Jan  1 08:08:58 mx31tt01 user.debug connMan[371]: Setting and Activating =

the Internet connection context.
Jan  1 08:08:58 mx31tt01 user.debug connMan[371]: mccmnc =3D '26202', len =
=3D 5
Jan  1 08:08:58 mx31tt01 user.debug connMan[371]: Provider name '1&1'
Jan  1 08:08:58 mx31tt01 user.debug connMan[371]: Set AccessPointName: =

web.vodafone.de
Jan  1 08:08:58 mx31tt01 user.debug connMan[371]: Set Username:
Jan  1 08:08:58 mx31tt01 user.debug connMan[371]: Set Password:
Jan  1 08:08:58 mx31tt01 user.debug connMan[371]: Trying to set =

context:web.vodafone.de
Jan  1 08:08:58 mx31tt01 daemon.debug ofonod[408]: =

drivers/atmodem/gprs-context.c:at_gprs_activate_primary() cid 1
Jan  1 08:09:18 mx31tt01 daemon.info ofonod[408]: Aux: < \r\n+CREG: =

1,"0340","C149"\r\n
Jan  1 08:09:18 mx31tt01 daemon.debug ofonod[408]: =

src/network.c:ofono_netreg_status_notify() /telit_0 status 1 tech -1
Jan  1 08:09:18 mx31tt01 daemon.debug ofonod[408]: =

src/gprs.c:netreg_status_changed() 1
Jan  1 08:09:18 mx31tt01 daemon.info ofonod[408]: Aux: > AT+COPS=3D3,2\r
Jan  1 08:09:18 mx31tt01 daemon.info ofonod[408]: Aux: < \r\n+CGREG: =

1,"0340","C149"\r\n
Jan  1 08:09:18 mx31tt01 daemon.debug ofonod[408]: =

src/gprs.c:ofono_gprs_status_notify() /telit_0 status 1
Jan  1 08:09:18 mx31tt01 daemon.info ofonod[408]: Aux: < \r\nOK\r\n
Jan  1 08:09:18 mx31tt01 daemon.info ofonod[408]: Aux: > AT+COPS?\r
Jan  1 08:09:18 mx31tt01 daemon.info ofonod[408]: Aux: < \r\n+COPS: =

0,2,"26202",0\r\n\r\nOK\r\n
Jan  1 08:09:18 mx31tt01 daemon.debug ofonod[408]: =

drivers/atmodem/network-registration.c:cops_numeric_cb() Cops numeric =

got mcc: 262, mnc: 02
Jan  1 08:09:18 mx31tt01 daemon.info ofonod[408]: Aux: > AT+CIND?\r
Jan  1 08:09:18 mx31tt01 daemon.info ofonod[408]: Aux: < \r\n+CIND: =

4,99,1,0,0,0,0,0,2\r\n\r\nOK\r\n
Jan  1 08:09:18 mx31tt01 daemon.info ofonod[408]: Aux: > AT+COPS=3D3,0\r
Jan  1 08:09:18 mx31tt01 daemon.info ofonod[408]: Aux: < \r\nOK\r\n
Jan  1 08:09:18 mx31tt01 daemon.info ofonod[408]: Aux: > AT+COPS?\r
Jan  1 08:09:18 mx31tt01 daemon.info ofonod[408]: Aux: < \r\n+COPS: =

0,0,"Vodafone D2",0\r\n\r\nOK\r\n
Jan  1 08:09:18 mx31tt01 daemon.debug ofonod[408]: =

drivers/atmodem/network-registration.c:cops_cb() cops_cb: Vodafone D2, =

262 02 0
Jan  1 08:09:18 mx31tt01 daemon.debug ofonod[408]: =

src/network.c:current_operator_callback() 0x1b79df8, 0x1b80eb0
Jan  1 08:09:23 mx31tt01 user.debug connMan[371]: Got connection context =

signal AccessPointName, Val =3D 'web.vodafone.de'
Jan  1 08:09:23 mx31tt01 user.info connMan[371]: APN: web.vodafone.de
Jan  1 08:09:23 mx31tt01 user.debug connMan[371]: Got network =

registration signal CellId: uint32 49481


dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.ofono =

/telit_0 org.ofono.NetworkRegistration.GetProperties
method return sender=3D:1.5 -> dest=3D:1.24 reply_serial=3D2
    array [
       dict entry(
          string "Status"
          variant             string "registered"
       )
       dict entry(
          string "Mode"
          variant             string "auto"
       )
       dict entry(
          string "LocationAreaCode"
          variant             uint16 832
       )
       dict entry(
          string "CellId"
          variant             uint32 49481
       )
       dict entry(
          string "MobileCountryCode"
          variant             string "262"
       )
       dict entry(
          string "MobileNetworkCode"
          variant             string "02"
       )
       dict entry(
          string "Name"
          variant             string "Vodafone D2"
       )
       dict entry(
          string "Strength"
          variant             byte 40
       )
    ]

dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.ofono =

/telit_0 org.ofono.ConnectionManager.GetProperties
method return sender=3D:1.5 -> dest=3D:1.25 reply_serial=3D2
    array [
       dict entry(
          string "Attached"
          variant             boolean true
       )
       dict entry(
          string "RoamingAllowed"
          variant             boolean true
       )
       dict entry(
          string "Powered"
          variant             boolean true
       )
       dict entry(
          string "Suspended"
          variant             boolean false
       )
    ]

dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.ofono =

/telit_0 org.ofono.ConnectionManager.GetContexts
method return sender=3D:1.5 -> dest=3D:1.26 reply_serial=3D2
    array [
       struct {
          object path "/telit_0/context3"
          array [
             dict entry(
                string "Name"
                variant                   string "Internet"
             )
             dict entry(
                string "Active"
                variant                   boolean false
             )
             dict entry(
                string "Type"
                variant                   string "internet"
             )
             dict entry(
                string "Protocol"
                variant                   string "ip"
             )
             dict entry(
                string "AccessPointName"
                variant                   string "web.vodafone.de"
             )
             dict entry(
                string "Username"
                variant                   string ""
             )
             dict entry(
                string "Password"
                variant                   string ""
             )
             dict entry(
                string "Settings"
                variant                   array [
                      dict entry(
                         string "Method"
                         variant                            string "dhcp"
                      )
                   ]
             )
             dict entry(
                string "IPv6.Settings"
                variant                   array [
                   ]
             )
          ]
       }
    ]


--
Scanned by MailScanner.


--===============7135067433256552038==--

