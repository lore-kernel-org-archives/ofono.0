Content-Type: multipart/mixed; boundary="===============2204083455802355471=="
MIME-Version: 1.0
From: =?unknown-8bit?b?6buE5Y+26Z2S?= <hyqzyf@163.com>
Subject: ppp issue
Date: Wed, 26 Jan 2011 16:27:59 +0800
Message-ID: <29f226e1.10f38.12dc16fb51f.Coremail.hyqzyf@163.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2204083455802355471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,
I have some issue at ppp phrase from huawei EM560.
Here is the log, does anyony have any idea or give me some correct log to m=
e to compare with. Thanks!

[root(a)localhost gatchat]# ./gsmdial -l -a cmnet -c 1 -n /dev/ttyACM0 -m /=
dev/ttyACM2
Control: /dev/ttyACM0
Modem: /dev/ttyACM2
fd=3D3 by hyqfd=3D4 by hyqAPN: cmnet
CID: 1
Modem: < \r\n*PHBI: 0,1\r\n
Control: > ATE0Q0V1\r
Modem: < \r\n^MODE: 15\r\n
Modem: < \r\n+CREG: 1,"0007","0D0A"\r\n
Control: < ATE0Q0V1\r
Modem: < \r\n+CGREG: 2\r\n
Modem: < \r\n+CGREG: 1,"0007","0D0A"\r\n
Control: < \r\nOK\r\n
Control: > AT+CFUN?\r
Control: < \r\n+CFUN: 1\r\n
Control: < \r\nOK\r\n
Current modem mode is 1
Control: > AT+CPIN?\r
Control: < \r\n+CPIN: READY\r\n
Control: < \r\nOK\r\n
Control: > AT+CREG=3D2\r
Control: < \r\nOK\r\n
Control: > AT+CGREG=3D2\r
Control: < \r\nOK\r\n
Control: > AT+COPS=3D0\r
Control: < \r\nOK\r\n
Waiting for network registration...
Control: > AT+CREG?\r
Modem: < \r\n+CREG: 1,"0007","0D0A"\r\n
Control: < \r\n+CREG: 1,"0007","0D0A"\r\n
Control: < \r\n+CREG: 2,1,"0007","0D0A"\r\n
Control: < \r\nOK\r\n
Registered to network, roaming=3Dfalse
Activating GPRS network...
Control: > AT+CGATT=3D1\r
Control: < \r\nOK\r\n
Control: > AT+CGREG?\r
Control: < \r\n+CGREG: 2,1,"0007","0D0A"\r\n
Control: < \r\nOK\r\n
Registered to GPRS network, roaming=3Dfalse
Control: > AT+CGDCONT=3D1,"IP","cmnet"\r
Control: < \r\nOK\r\n
Modem: > ATD*99***1#\r
Modem: < ATD*99***1#\r
Modem: < \r\nCONNECT 2800000\r\n
Entering new phase: 1
PPP: lcp: pppcp_generate_event: current state 0:INITIAL
PPP: event: 0 (Up), action: 2, new_state: 2 (CLOSED)
new_state=3D2
PPP: lcp: pppcp_generate_event: current state 2:CLOSED
PPP: event: 2 (Open), action: 1026, new_state: 6 (REQSENT)
new_state=3D6
PPP: lcp: pppcp_initialize_restart_count: current state 2:CLOSED
PPP: lcp: pppcp_send_configure_request: current state 2:CLOSED
ppp_receive protocol=3Dc021
PPP: lcp: pppcp_process_configure_request: current state 6:REQSENT
ppp_option_iter_get_type =3Dsaohuo:ppp_option_iter_get_type =3Ddddddddddddd=
AUTH_PROTO:PPP: lcp: pppcp_generate_event: current state 6:REQSENT
PPP: event: 7 (RCR-), action: 4006, new_state: 6 (REQSENT)
new_state=3D6
PPP: lcp: pppcp_send_configure_nak: current state 6:REQSENT
ppp_receive protocol=3Dc021
PPP: lcp: pppcp_process_configure_ack: current state 6:REQSENT
PPP: lcp: pppcp_generate_event: current state 6:REQSENT
PPP: event: 8 (RCA), action: 27, new_state: 7 (ACKRCVD)
new_state=3D7
PPP: lcp: pppcp_initialize_restart_count: current state 6:REQSENT
ppp_receive protocol=3Dc021
PPP: lcp: pppcp_process_configure_request: current state 7:ACKRCVD
ppp_option_iter_get_type =3Dsaohuo:ppp_option_iter_get_type=3DAUTH_PROTO: p=
roto =3D=3D CHAP_PROTOCOLppp_option_iter_get_type =3DACCM:ppp_option_iter_g=
et_type =3DAUTH_PROTO:Entering ppp_set_auth
PPP: lcp: pppcp_generate_event: current state 7:ACKRCVD
PPP: event: 6 (RCR+), action: 2109, new_state: 9 (OPENED)
new_state=3D9
PPP: lcp: pppcp_send_configure_ack: current state 7:ACKRCVD
Entering new phase: 2
ppp_drop_packet ppp->phase=3DPPP_PHASE_AUTHENTICATION:ppp_drop_packet ppp->=
phase=3DPPP_PHASE_AUTHENTICATION:c223=3Dprotocol
ppp_receive protocol=3Dc223
ppp_drop_packet ppp->phase=3DPPP_PHASE_AUTHENTICATION:ppp_drop_packet ppp->=
phase=3DPPP_PHASE_AUTHENTICATION:c223=3Dprotocol
ppp_receive protocol=3Dc223
Entering new phase: 3
ppp_auth_notify asdfasdfasdfsuccess
PPP: ipcp: pppcp_generate_event: current state 0:INITIAL
PPP: event: 2 (Open), action: 401, new_state: 1 (STARTING)
new_state=3D1
PPP: ipcp: pppcp_generate_event: current state 1:STARTING

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^
PPP: event: 0 (Up), action: 1026, new_state: 6 (REQSENT)
new_state=3D6
PPP: ipcp: pppcp_initialize_restart_count: current state 1:STARTING
PPP: ipcp: pppcp_send_configure_request: current state 1:STARTING
Control: < \r\n+CGREG: 1,"0007","0D0A"\r\n
Control: < \r\n*PHBI: 0,2\r\n
PPP: ipcp: pppcp_timeout: current state 6:REQSENT
PPP: ipcp: pppcp_generate_event: current state 6:REQSENT
PPP: event: 4 (TO+), action: 1006, new_state: 6 (REQSENT)
new_state=3D6
PPP: ipcp: pppcp_send_configure_request: current state 6:REQSENT
ppp_drop_packet ppp->phase=3DPPP_PHASE_NETWORK: protocol=3D8021
ppp_receive protocol=3D8021
PPP: ipcp: pppcp_process_configure_request: current state 6:REQSENT
PPP: ipcp: pppcp_generate_event: current state 6:REQSENT
PPP: event: 6 (RCR+), action: 2008, new_state: 8 (ACKSENT)
new_state=3D8
PPP: ipcp: pppcp_send_configure_ack: current state 6:REQSENT
PPP: ipcp: pppcp_timeout: current state 8:ACKSENT
PPP: ipcp: pppcp_generate_event: current state 8:ACKSENT
PPP: event: 4 (TO+), action: 1008, new_state: 8 (ACKSENT)
new_state=3D8
PPP: ipcp: pppcp_send_configure_request: current state 8:ACKSENT
ppp_drop_packet ppp->phase=3DPPP_PHASE_NETWORK: protocol=3D8021
ppp_receive protocol=3D8021
PPP: ipcp: pppcp_process_configure_request: current state 8:ACKSENT
PPP: ipcp: pppcp_generate_event: current state 8:ACKSENT
PPP: event: 6 (RCR+), action: 2008, new_state: 8 (ACKSENT)
new_state=3D8
PPP: ipcp: pppcp_send_configure_ack: current state 8:ACKSENT
PPP: ipcp: pppcp_timeout: current state 8:ACKSENT
PPP: ipcp: pppcp_generate_event: current state 8:ACKSENT
PPP: event: 4 (TO+), action: 1008, new_state: 8 (ACKSENT)
new_state=3D8
PPP: ipcp: pppcp_send_configure_request: current state 8:ACKSENT
ppp_drop_packet ppp->phase=3DPPP_PHASE_NETWORK: protocol=3D8021
ppp_receive protocol=3D8021
PPP: ipcp: pppcp_process_configure_request: current state 8:ACKSENT
PPP: ipcp: pppcp_generate_event: current state 8:ACKSENT
PPP: event: 6 (RCR+), action: 2008, new_state: 8 (ACKSENT)
new_state=3D8
PPP: ipcp: pppcp_send_configure_ack: current state 8:ACKSENT
PPP: ipcp: pppcp_timeout: current state 8:ACKSENT
PPP: ipcp: pppcp_generate_event: current state 8:ACKSENT
PPP: event: 4 (TO+), action: 1008, new_state: 8 (ACKSENT)
new_state=3D8
PPP: ipcp: pppcp_send_configure_request: current state 8:ACKSENT
ppp_drop_packet ppp->phase=3DPPP_PHASE_NETWORK: protocol=3D8021
ppp_receive protocol=3D8021
PPP: ipcp: pppcp_process_configure_request: current state 8:ACKSENT
PPP: ipcp: pppcp_generate_event: current state 8:ACKSENT
PPP: event: 6 (RCR+), action: 2008, new_state: 8 (ACKSENT)
new_state=3D8
PPP: ipcp: pppcp_send_configure_ack: current state 8:ACKSENT
PPP: ipcp: pppcp_timeout: current state 8:ACKSENT
PPP: ipcp: pppcp_generate_event: current state 8:ACKSENT
PPP: event: 4 (TO+), action: 1008, new_state: 8 (ACKSENT)
new_state=3D8
PPP: ipcp: pppcp_send_configure_request: current state 8:ACKSENT
ppp_drop_packet ppp->phase=3DPPP_PHASE_NETWORK: protocol=3D8021
ppp_receive protocol=3D8021
PPP: ipcp: pppcp_process_configure_request: current state 8:ACKSENT
PPP: ipcp: pppcp_generate_event: current state 8:ACKSENT
PPP: event: 6 (RCR+), action: 2008, new_state: 8 (ACKSENT)
new_state=3D8
PPP: ipcp: pppcp_send_configure_ack: current state 8:ACKSENT
PPP: ipcp: pppcp_timeout: current state 8:ACKSENT
PPP: ipcp: pppcp_generate_event: current state 8:ACKSENT
PPP: event: 4 (TO+), action: 1008, new_state: 8 (ACKSENT)
new_state=3D8
PPP: ipcp: pppcp_send_configure_request: current state 8:ACKSENT
ppp_drop_packet ppp->phase=3DPPP_PHASE_NETWORK: protocol=3D8021
ppp_receive protocol=3D8021
PPP: ipcp: pppcp_process_configure_request: current state 8:ACKSENT
PPP: ipcp: pppcp_generate_event: current state 8:ACKSENT
PPP: event: 6 (RCR+), action: 2008, new_state: 8 (ACKSENT)
new_state=3D8
PPP: ipcp: pppcp_send_configure_ack: current state 8:ACKSENT
PPP: ipcp: pppcp_timeout: current state 8:ACKSENT
PPP: ipcp: pppcp_generate_event: current state 8:ACKSENT
PPP: event: 4 (TO+), action: 1008, new_state: 8 (ACKSENT)
new_state=3D8
PPP: ipcp: pppcp_send_configure_request: current state 8:ACKSENT
ppp_drop_packet ppp->phase=3DPPP_PHASE_NETWORK: protocol=3D8021
ppp_receive protocol=3D8021
PPP: ipcp: pppcp_process_configure_request: current state 8:ACKSENT
PPP: ipcp: pppcp_generate_event: current state 8:ACKSENT
PPP: event: 6 (RCR+), action: 2008, new_state: 8 (ACKSENT)
new_state=3D8
PPP: ipcp: pppcp_send_configure_ack: current state 8:ACKSENT
PPP: ipcp: pppcp_timeout: current state 8:ACKSENT
PPP: ipcp: pppcp_generate_event: current state 8:ACKSENT
PPP: event: 4 (TO+), action: 1008, new_state: 8 (ACKSENT)
new_state=3D8
PPP: ipcp: pppcp_send_configure_request: current state 8:ACKSENT
ppp_drop_packet ppp->phase=3DPPP_PHASE_NETWORK: protocol=3D8021
ppp_receive protocol=3D8021
PPP: ipcp: pppcp_process_configure_request: current state 8:ACKSENT
PPP: ipcp: pppcp_generate_event: current state 8:ACKSENT
PPP: event: 6 (RCR+), action: 2008, new_state: 8 (ACKSENT)
new_state=3D8
PPP: ipcp: pppcp_send_configure_ack: current state 8:ACKSENT
PPP: ipcp: pppcp_timeout: current state 8:ACKSENT
PPP: ipcp: pppcp_generate_event: current state 8:ACKSENT
PPP: event: 4 (TO+), action: 1008, new_state: 8 (ACKSENT)
new_state=3D8
PPP: ipcp: pppcp_send_configure_request: current state 8:ACKSENT
ppp_drop_packet ppp->phase=3DPPP_PHASE_NETWORK: protocol=3D8021
ppp_receive protocol=3D8021
PPP: ipcp: pppcp_process_configure_request: current state 8:ACKSENT
PPP: ipcp: pppcp_generate_event: current state 8:ACKSENT
PPP: event: 6 (RCR+), action: 2008, new_state: 8 (ACKSENT)
new_state=3D8
PPP: ipcp: pppcp_send_configure_ack: current state 8:ACKSENT
PPP: ipcp: pppcp_timeout: current state 8:ACKSENT
PPP: ipcp: pppcp_generate_event: current state 8:ACKSENT
PPP: event: 5 (TO-), action: 803, new_state: 3 (STOPPED)
new_state=3D3
actions TLF
PPP: ipcp: pppcp_this_layer_finished: current state 3:STOPPED
PPP: ipcp: pppcp_generate_event: current state 3:STOPPED
PPP: event: 3 (Close), action: 2, new_state: 2 (CLOSED)
new_state=3D2
PPP: lcp: pppcp_generate_event: current state 9:OPENED
PPP: event: 3 (Close), action: 8224, new_state: 4 (CLOSING)
new_state=3D4
PPP: lcp: pppcp_initialize_restart_count: current state 9:OPENED
PPP: lcp: pppcp_send_terminate_request: current state 9:OPENED
actions TLD
PPP: ipcp: pppcp_generate_event: current state 2:CLOSED
PPP: event: 1 (Down), action: 0, new_state: 0 (INITIAL)
new_state=3D0
Entering new phase: 5
ppp_receive protocol=3Dc021
PPP: lcp: pppcp_process_terminate_ack: current state 4:CLOSING
PPP: lcp: pppcp_generate_event: current state 4:CLOSING
PPP: event: 11 (RTA), action: 802, new_state: 2 (CLOSED)
new_state=3D2
actions TLF
PPP: lcp: pppcp_this_layer_finished: current state 2:CLOSED
Entering new phase: 0
PPP Link down: 2
Modem: < \r\nNO CARRIER\r\n
Control: > AT+CFUN=3D0\r
Control: < \r\nOK\r\n



--------

Regards!

--===============2204083455802355471==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgQWxsLCA8YnI+SSBoYXZlIHNvbWUgaXNzdWUgYXQgcHBwIHBocmFzZSBmcm9tIGh1YXdlaSBF
TTU2MC48YnI+SGVyZSBpcyB0aGUgbG9nLCBkb2VzIGFueW9ueSBoYXZlIGFueSBpZGVhIG9yIGdp
dmUgbWUgc29tZSBjb3JyZWN0IGxvZyB0byBtZSB0byBjb21wYXJlIHdpdGguIFRoYW5rcyE8YnI+
PGJyPltyb290QGxvY2FsaG9zdCBnYXRjaGF0XSMgLi9nc21kaWFsIC1sIC1hIGNtbmV0IC1jIDEg
LW4gL2Rldi90dHlBQ00wIC1tIC9kZXYvdHR5QUNNMiA8YnI+Q29udHJvbDogL2Rldi90dHlBQ00w
PGJyPk1vZGVtOiAvZGV2L3R0eUFDTTI8YnI+ZmQ9MyBieSBoeXFmZD00IGJ5IGh5cUFQTjogY21u
ZXQ8YnI+Q0lEOiAxPGJyPk1vZGVtOiAmbHQ7IFxyXG4qUEhCSTogMCwxXHJcbjxicj5Db250cm9s
OiAmZ3Q7IEFURTBRMFYxXHI8YnI+TW9kZW06ICZsdDsgXHJcbl5NT0RFOiAxNVxyXG48YnI+TW9k
ZW06ICZsdDsgXHJcbitDUkVHOiAxLCIwMDA3IiwiMEQwQSJcclxuPGJyPkNvbnRyb2w6ICZsdDsg
QVRFMFEwVjFccjxicj5Nb2RlbTogJmx0OyBcclxuK0NHUkVHOiAyXHJcbjxicj5Nb2RlbTogJmx0
OyBcclxuK0NHUkVHOiAxLCIwMDA3IiwiMEQwQSJcclxuPGJyPkNvbnRyb2w6ICZsdDsgXHJcbk9L
XHJcbjxicj5Db250cm9sOiAmZ3Q7IEFUK0NGVU4/XHI8YnI+Q29udHJvbDogJmx0OyBcclxuK0NG
VU46IDFcclxuPGJyPkNvbnRyb2w6ICZsdDsgXHJcbk9LXHJcbjxicj5DdXJyZW50IG1vZGVtIG1v
ZGUgaXMgMTxicj5Db250cm9sOiAmZ3Q7IEFUK0NQSU4/XHI8YnI+Q29udHJvbDogJmx0OyBcclxu
K0NQSU46IFJFQURZXHJcbjxicj5Db250cm9sOiAmbHQ7IFxyXG5PS1xyXG48YnI+Q29udHJvbDog
Jmd0OyBBVCtDUkVHPTJccjxicj5Db250cm9sOiAmbHQ7IFxyXG5PS1xyXG48YnI+Q29udHJvbDog
Jmd0OyBBVCtDR1JFRz0yXHI8YnI+Q29udHJvbDogJmx0OyBcclxuT0tcclxuPGJyPkNvbnRyb2w6
ICZndDsgQVQrQ09QUz0wXHI8YnI+Q29udHJvbDogJmx0OyBcclxuT0tcclxuPGJyPldhaXRpbmcg
Zm9yIG5ldHdvcmsgcmVnaXN0cmF0aW9uLi4uPGJyPkNvbnRyb2w6ICZndDsgQVQrQ1JFRz9ccjxi
cj5Nb2RlbTogJmx0OyBcclxuK0NSRUc6IDEsIjAwMDciLCIwRDBBIlxyXG48YnI+Q29udHJvbDog
Jmx0OyBcclxuK0NSRUc6IDEsIjAwMDciLCIwRDBBIlxyXG48YnI+Q29udHJvbDogJmx0OyBcclxu
K0NSRUc6IDIsMSwiMDAwNyIsIjBEMEEiXHJcbjxicj5Db250cm9sOiAmbHQ7IFxyXG5PS1xyXG48
YnI+UmVnaXN0ZXJlZCB0byBuZXR3b3JrLCByb2FtaW5nPWZhbHNlPGJyPkFjdGl2YXRpbmcgR1BS
UyBuZXR3b3JrLi4uPGJyPkNvbnRyb2w6ICZndDsgQVQrQ0dBVFQ9MVxyPGJyPkNvbnRyb2w6ICZs
dDsgXHJcbk9LXHJcbjxicj5Db250cm9sOiAmZ3Q7IEFUK0NHUkVHP1xyPGJyPkNvbnRyb2w6ICZs
dDsgXHJcbitDR1JFRzogMiwxLCIwMDA3IiwiMEQwQSJcclxuPGJyPkNvbnRyb2w6ICZsdDsgXHJc
bk9LXHJcbjxicj5SZWdpc3RlcmVkIHRvIEdQUlMgbmV0d29yaywgcm9hbWluZz1mYWxzZTxicj5D
b250cm9sOiAmZ3Q7IEFUK0NHRENPTlQ9MSwiSVAiLCJjbW5ldCJccjxicj5Db250cm9sOiAmbHQ7
IFxyXG5PS1xyXG48YnI+TW9kZW06ICZndDsgQVREKjk5KioqMSNccjxicj5Nb2RlbTogJmx0OyBB
VEQqOTkqKioxI1xyPGJyPk1vZGVtOiAmbHQ7IFxyXG5DT05ORUNUIDI4MDAwMDBcclxuPGJyPkVu
dGVyaW5nIG5ldyBwaGFzZTogMTxicj5QUFA6IGxjcDogcHBwY3BfZ2VuZXJhdGVfZXZlbnQ6IGN1
cnJlbnQgc3RhdGUgMDpJTklUSUFMPGJyPlBQUDogZXZlbnQ6IDAgKFVwKSwgYWN0aW9uOiAyLCBu
ZXdfc3RhdGU6IDIgKENMT1NFRCk8YnI+bmV3X3N0YXRlPTI8YnI+UFBQOiBsY3A6IHBwcGNwX2dl
bmVyYXRlX2V2ZW50OiBjdXJyZW50IHN0YXRlIDI6Q0xPU0VEPGJyPlBQUDogZXZlbnQ6IDIgKE9w
ZW4pLCBhY3Rpb246IDEwMjYsIG5ld19zdGF0ZTogNiAoUkVRU0VOVCk8YnI+bmV3X3N0YXRlPTY8
YnI+UFBQOiBsY3A6IHBwcGNwX2luaXRpYWxpemVfcmVzdGFydF9jb3VudDogY3VycmVudCBzdGF0
ZSAyOkNMT1NFRDxicj5QUFA6IGxjcDogcHBwY3Bfc2VuZF9jb25maWd1cmVfcmVxdWVzdDogY3Vy
cmVudCBzdGF0ZSAyOkNMT1NFRDxicj5wcHBfcmVjZWl2ZSBwcm90b2NvbD1jMDIxPGJyPlBQUDog
bGNwOiBwcHBjcF9wcm9jZXNzX2NvbmZpZ3VyZV9yZXF1ZXN0OiBjdXJyZW50IHN0YXRlIDY6UkVR
U0VOVDxicj5wcHBfb3B0aW9uX2l0ZXJfZ2V0X3R5cGUgPXNhb2h1bzpwcHBfb3B0aW9uX2l0ZXJf
Z2V0X3R5cGUgPWRkZGRkZGRkZGRkZEFVVEhfUFJPVE86UFBQOiBsY3A6IHBwcGNwX2dlbmVyYXRl
X2V2ZW50OiBjdXJyZW50IHN0YXRlIDY6UkVRU0VOVDxicj5QUFA6IGV2ZW50OiA3IChSQ1ItKSwg
YWN0aW9uOiA0MDA2LCBuZXdfc3RhdGU6IDYgKFJFUVNFTlQpPGJyPm5ld19zdGF0ZT02PGJyPlBQ
UDogbGNwOiBwcHBjcF9zZW5kX2NvbmZpZ3VyZV9uYWs6IGN1cnJlbnQgc3RhdGUgNjpSRVFTRU5U
PGJyPnBwcF9yZWNlaXZlIHByb3RvY29sPWMwMjE8YnI+UFBQOiBsY3A6IHBwcGNwX3Byb2Nlc3Nf
Y29uZmlndXJlX2FjazogY3VycmVudCBzdGF0ZSA2OlJFUVNFTlQ8YnI+UFBQOiBsY3A6IHBwcGNw
X2dlbmVyYXRlX2V2ZW50OiBjdXJyZW50IHN0YXRlIDY6UkVRU0VOVDxicj5QUFA6IGV2ZW50OiA4
IChSQ0EpLCBhY3Rpb246IDI3LCBuZXdfc3RhdGU6IDcgKEFDS1JDVkQpPGJyPm5ld19zdGF0ZT03
PGJyPlBQUDogbGNwOiBwcHBjcF9pbml0aWFsaXplX3Jlc3RhcnRfY291bnQ6IGN1cnJlbnQgc3Rh
dGUgNjpSRVFTRU5UPGJyPnBwcF9yZWNlaXZlIHByb3RvY29sPWMwMjE8YnI+UFBQOiBsY3A6IHBw
cGNwX3Byb2Nlc3NfY29uZmlndXJlX3JlcXVlc3Q6IGN1cnJlbnQgc3RhdGUgNzpBQ0tSQ1ZEPGJy
PnBwcF9vcHRpb25faXRlcl9nZXRfdHlwZSA9c2FvaHVvOnBwcF9vcHRpb25faXRlcl9nZXRfdHlw
ZT1BVVRIX1BST1RPOiBwcm90byA9PSBDSEFQX1BST1RPQ09McHBwX29wdGlvbl9pdGVyX2dldF90
eXBlID1BQ0NNOnBwcF9vcHRpb25faXRlcl9nZXRfdHlwZSA9QVVUSF9QUk9UTzpFbnRlcmluZyBw
cHBfc2V0X2F1dGg8YnI+UFBQOiBsY3A6IHBwcGNwX2dlbmVyYXRlX2V2ZW50OiBjdXJyZW50IHN0
YXRlIDc6QUNLUkNWRDxicj5QUFA6IGV2ZW50OiA2IChSQ1IrKSwgYWN0aW9uOiAyMTA5LCBuZXdf
c3RhdGU6IDkgKE9QRU5FRCk8YnI+bmV3X3N0YXRlPTk8YnI+UFBQOiBsY3A6IHBwcGNwX3NlbmRf
Y29uZmlndXJlX2FjazogY3VycmVudCBzdGF0ZSA3OkFDS1JDVkQ8YnI+RW50ZXJpbmcgbmV3IHBo
YXNlOiAyPGJyPnBwcF9kcm9wX3BhY2tldCBwcHAtJmd0O3BoYXNlPVBQUF9QSEFTRV9BVVRIRU5U
SUNBVElPTjpwcHBfZHJvcF9wYWNrZXQgcHBwLSZndDtwaGFzZT1QUFBfUEhBU0VfQVVUSEVOVElD
QVRJT046YzIyMz1wcm90b2NvbDxicj5wcHBfcmVjZWl2ZSBwcm90b2NvbD1jMjIzPGJyPnBwcF9k
cm9wX3BhY2tldCBwcHAtJmd0O3BoYXNlPVBQUF9QSEFTRV9BVVRIRU5USUNBVElPTjpwcHBfZHJv
cF9wYWNrZXQgcHBwLSZndDtwaGFzZT1QUFBfUEhBU0VfQVVUSEVOVElDQVRJT046YzIyMz1wcm90
b2NvbDxicj5wcHBfcmVjZWl2ZSBwcm90b2NvbD1jMjIzPGJyPkVudGVyaW5nIG5ldyBwaGFzZTog
Mzxicj5wcHBfYXV0aF9ub3RpZnkgYXNkZmFzZGZhc2Rmc3VjY2VzcyA8YnI+UFBQOiBpcGNwOiBw
cHBjcF9nZW5lcmF0ZV9ldmVudDogY3VycmVudCBzdGF0ZSAwOklOSVRJQUw8YnI+UFBQOiBldmVu
dDogMiAoT3BlbiksIGFjdGlvbjogNDAxLCBuZXdfc3RhdGU6IDEgKFNUQVJUSU5HKTxicj5uZXdf
c3RhdGU9MTxicj5QUFA6IGlwY3A6IHBwcGNwX2dlbmVyYXRlX2V2ZW50OiBjdXJyZW50IHN0YXRl
IDE6U1RBUlRJTkc8YnI+PGJyPl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5e
Xl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXjxicj5Q
UFA6IGV2ZW50OiAwIChVcCksIGFjdGlvbjogMTAyNiwgbmV3X3N0YXRlOiA2IChSRVFTRU5UKTxi
cj5uZXdfc3RhdGU9Njxicj5QUFA6IGlwY3A6IHBwcGNwX2luaXRpYWxpemVfcmVzdGFydF9jb3Vu
dDogY3VycmVudCBzdGF0ZSAxOlNUQVJUSU5HPGJyPlBQUDogaXBjcDogcHBwY3Bfc2VuZF9jb25m
aWd1cmVfcmVxdWVzdDogY3VycmVudCBzdGF0ZSAxOlNUQVJUSU5HPGJyPkNvbnRyb2w6ICZsdDsg
XHJcbitDR1JFRzogMSwiMDAwNyIsIjBEMEEiXHJcbjxicj5Db250cm9sOiAmbHQ7IFxyXG4qUEhC
STogMCwyXHJcbjxicj5QUFA6IGlwY3A6IHBwcGNwX3RpbWVvdXQ6IGN1cnJlbnQgc3RhdGUgNjpS
RVFTRU5UPGJyPlBQUDogaXBjcDogcHBwY3BfZ2VuZXJhdGVfZXZlbnQ6IGN1cnJlbnQgc3RhdGUg
NjpSRVFTRU5UPGJyPlBQUDogZXZlbnQ6IDQgKFRPKyksIGFjdGlvbjogMTAwNiwgbmV3X3N0YXRl
OiA2IChSRVFTRU5UKTxicj5uZXdfc3RhdGU9Njxicj5QUFA6IGlwY3A6IHBwcGNwX3NlbmRfY29u
ZmlndXJlX3JlcXVlc3Q6IGN1cnJlbnQgc3RhdGUgNjpSRVFTRU5UPGJyPnBwcF9kcm9wX3BhY2tl
dCBwcHAtJmd0O3BoYXNlPVBQUF9QSEFTRV9ORVRXT1JLOiBwcm90b2NvbD04MDIxPGJyPnBwcF9y
ZWNlaXZlIHByb3RvY29sPTgwMjE8YnI+UFBQOiBpcGNwOiBwcHBjcF9wcm9jZXNzX2NvbmZpZ3Vy
ZV9yZXF1ZXN0OiBjdXJyZW50IHN0YXRlIDY6UkVRU0VOVDxicj5QUFA6IGlwY3A6IHBwcGNwX2dl
bmVyYXRlX2V2ZW50OiBjdXJyZW50IHN0YXRlIDY6UkVRU0VOVDxicj5QUFA6IGV2ZW50OiA2IChS
Q1IrKSwgYWN0aW9uOiAyMDA4LCBuZXdfc3RhdGU6IDggKEFDS1NFTlQpPGJyPm5ld19zdGF0ZT04
PGJyPlBQUDogaXBjcDogcHBwY3Bfc2VuZF9jb25maWd1cmVfYWNrOiBjdXJyZW50IHN0YXRlIDY6
UkVRU0VOVDxicj5QUFA6IGlwY3A6IHBwcGNwX3RpbWVvdXQ6IGN1cnJlbnQgc3RhdGUgODpBQ0tT
RU5UPGJyPlBQUDogaXBjcDogcHBwY3BfZ2VuZXJhdGVfZXZlbnQ6IGN1cnJlbnQgc3RhdGUgODpB
Q0tTRU5UPGJyPlBQUDogZXZlbnQ6IDQgKFRPKyksIGFjdGlvbjogMTAwOCwgbmV3X3N0YXRlOiA4
IChBQ0tTRU5UKTxicj5uZXdfc3RhdGU9ODxicj5QUFA6IGlwY3A6IHBwcGNwX3NlbmRfY29uZmln
dXJlX3JlcXVlc3Q6IGN1cnJlbnQgc3RhdGUgODpBQ0tTRU5UPGJyPnBwcF9kcm9wX3BhY2tldCBw
cHAtJmd0O3BoYXNlPVBQUF9QSEFTRV9ORVRXT1JLOiBwcm90b2NvbD04MDIxPGJyPnBwcF9yZWNl
aXZlIHByb3RvY29sPTgwMjE8YnI+UFBQOiBpcGNwOiBwcHBjcF9wcm9jZXNzX2NvbmZpZ3VyZV9y
ZXF1ZXN0OiBjdXJyZW50IHN0YXRlIDg6QUNLU0VOVDxicj5QUFA6IGlwY3A6IHBwcGNwX2dlbmVy
YXRlX2V2ZW50OiBjdXJyZW50IHN0YXRlIDg6QUNLU0VOVDxicj5QUFA6IGV2ZW50OiA2IChSQ1Ir
KSwgYWN0aW9uOiAyMDA4LCBuZXdfc3RhdGU6IDggKEFDS1NFTlQpPGJyPm5ld19zdGF0ZT04PGJy
PlBQUDogaXBjcDogcHBwY3Bfc2VuZF9jb25maWd1cmVfYWNrOiBjdXJyZW50IHN0YXRlIDg6QUNL
U0VOVDxicj5QUFA6IGlwY3A6IHBwcGNwX3RpbWVvdXQ6IGN1cnJlbnQgc3RhdGUgODpBQ0tTRU5U
PGJyPlBQUDogaXBjcDogcHBwY3BfZ2VuZXJhdGVfZXZlbnQ6IGN1cnJlbnQgc3RhdGUgODpBQ0tT
RU5UPGJyPlBQUDogZXZlbnQ6IDQgKFRPKyksIGFjdGlvbjogMTAwOCwgbmV3X3N0YXRlOiA4IChB
Q0tTRU5UKTxicj5uZXdfc3RhdGU9ODxicj5QUFA6IGlwY3A6IHBwcGNwX3NlbmRfY29uZmlndXJl
X3JlcXVlc3Q6IGN1cnJlbnQgc3RhdGUgODpBQ0tTRU5UPGJyPnBwcF9kcm9wX3BhY2tldCBwcHAt
Jmd0O3BoYXNlPVBQUF9QSEFTRV9ORVRXT1JLOiBwcm90b2NvbD04MDIxPGJyPnBwcF9yZWNlaXZl
IHByb3RvY29sPTgwMjE8YnI+UFBQOiBpcGNwOiBwcHBjcF9wcm9jZXNzX2NvbmZpZ3VyZV9yZXF1
ZXN0OiBjdXJyZW50IHN0YXRlIDg6QUNLU0VOVDxicj5QUFA6IGlwY3A6IHBwcGNwX2dlbmVyYXRl
X2V2ZW50OiBjdXJyZW50IHN0YXRlIDg6QUNLU0VOVDxicj5QUFA6IGV2ZW50OiA2IChSQ1IrKSwg
YWN0aW9uOiAyMDA4LCBuZXdfc3RhdGU6IDggKEFDS1NFTlQpPGJyPm5ld19zdGF0ZT04PGJyPlBQ
UDogaXBjcDogcHBwY3Bfc2VuZF9jb25maWd1cmVfYWNrOiBjdXJyZW50IHN0YXRlIDg6QUNLU0VO
VDxicj5QUFA6IGlwY3A6IHBwcGNwX3RpbWVvdXQ6IGN1cnJlbnQgc3RhdGUgODpBQ0tTRU5UPGJy
PlBQUDogaXBjcDogcHBwY3BfZ2VuZXJhdGVfZXZlbnQ6IGN1cnJlbnQgc3RhdGUgODpBQ0tTRU5U
PGJyPlBQUDogZXZlbnQ6IDQgKFRPKyksIGFjdGlvbjogMTAwOCwgbmV3X3N0YXRlOiA4IChBQ0tT
RU5UKTxicj5uZXdfc3RhdGU9ODxicj5QUFA6IGlwY3A6IHBwcGNwX3NlbmRfY29uZmlndXJlX3Jl
cXVlc3Q6IGN1cnJlbnQgc3RhdGUgODpBQ0tTRU5UPGJyPnBwcF9kcm9wX3BhY2tldCBwcHAtJmd0
O3BoYXNlPVBQUF9QSEFTRV9ORVRXT1JLOiBwcm90b2NvbD04MDIxPGJyPnBwcF9yZWNlaXZlIHBy
b3RvY29sPTgwMjE8YnI+UFBQOiBpcGNwOiBwcHBjcF9wcm9jZXNzX2NvbmZpZ3VyZV9yZXF1ZXN0
OiBjdXJyZW50IHN0YXRlIDg6QUNLU0VOVDxicj5QUFA6IGlwY3A6IHBwcGNwX2dlbmVyYXRlX2V2
ZW50OiBjdXJyZW50IHN0YXRlIDg6QUNLU0VOVDxicj5QUFA6IGV2ZW50OiA2IChSQ1IrKSwgYWN0
aW9uOiAyMDA4LCBuZXdfc3RhdGU6IDggKEFDS1NFTlQpPGJyPm5ld19zdGF0ZT04PGJyPlBQUDog
aXBjcDogcHBwY3Bfc2VuZF9jb25maWd1cmVfYWNrOiBjdXJyZW50IHN0YXRlIDg6QUNLU0VOVDxi
cj5QUFA6IGlwY3A6IHBwcGNwX3RpbWVvdXQ6IGN1cnJlbnQgc3RhdGUgODpBQ0tTRU5UPGJyPlBQ
UDogaXBjcDogcHBwY3BfZ2VuZXJhdGVfZXZlbnQ6IGN1cnJlbnQgc3RhdGUgODpBQ0tTRU5UPGJy
PlBQUDogZXZlbnQ6IDQgKFRPKyksIGFjdGlvbjogMTAwOCwgbmV3X3N0YXRlOiA4IChBQ0tTRU5U
KTxicj5uZXdfc3RhdGU9ODxicj5QUFA6IGlwY3A6IHBwcGNwX3NlbmRfY29uZmlndXJlX3JlcXVl
c3Q6IGN1cnJlbnQgc3RhdGUgODpBQ0tTRU5UPGJyPnBwcF9kcm9wX3BhY2tldCBwcHAtJmd0O3Bo
YXNlPVBQUF9QSEFTRV9ORVRXT1JLOiBwcm90b2NvbD04MDIxPGJyPnBwcF9yZWNlaXZlIHByb3Rv
Y29sPTgwMjE8YnI+UFBQOiBpcGNwOiBwcHBjcF9wcm9jZXNzX2NvbmZpZ3VyZV9yZXF1ZXN0OiBj
dXJyZW50IHN0YXRlIDg6QUNLU0VOVDxicj5QUFA6IGlwY3A6IHBwcGNwX2dlbmVyYXRlX2V2ZW50
OiBjdXJyZW50IHN0YXRlIDg6QUNLU0VOVDxicj5QUFA6IGV2ZW50OiA2IChSQ1IrKSwgYWN0aW9u
OiAyMDA4LCBuZXdfc3RhdGU6IDggKEFDS1NFTlQpPGJyPm5ld19zdGF0ZT04PGJyPlBQUDogaXBj
cDogcHBwY3Bfc2VuZF9jb25maWd1cmVfYWNrOiBjdXJyZW50IHN0YXRlIDg6QUNLU0VOVDxicj5Q
UFA6IGlwY3A6IHBwcGNwX3RpbWVvdXQ6IGN1cnJlbnQgc3RhdGUgODpBQ0tTRU5UPGJyPlBQUDog
aXBjcDogcHBwY3BfZ2VuZXJhdGVfZXZlbnQ6IGN1cnJlbnQgc3RhdGUgODpBQ0tTRU5UPGJyPlBQ
UDogZXZlbnQ6IDQgKFRPKyksIGFjdGlvbjogMTAwOCwgbmV3X3N0YXRlOiA4IChBQ0tTRU5UKTxi
cj5uZXdfc3RhdGU9ODxicj5QUFA6IGlwY3A6IHBwcGNwX3NlbmRfY29uZmlndXJlX3JlcXVlc3Q6
IGN1cnJlbnQgc3RhdGUgODpBQ0tTRU5UPGJyPnBwcF9kcm9wX3BhY2tldCBwcHAtJmd0O3BoYXNl
PVBQUF9QSEFTRV9ORVRXT1JLOiBwcm90b2NvbD04MDIxPGJyPnBwcF9yZWNlaXZlIHByb3RvY29s
PTgwMjE8YnI+UFBQOiBpcGNwOiBwcHBjcF9wcm9jZXNzX2NvbmZpZ3VyZV9yZXF1ZXN0OiBjdXJy
ZW50IHN0YXRlIDg6QUNLU0VOVDxicj5QUFA6IGlwY3A6IHBwcGNwX2dlbmVyYXRlX2V2ZW50OiBj
dXJyZW50IHN0YXRlIDg6QUNLU0VOVDxicj5QUFA6IGV2ZW50OiA2IChSQ1IrKSwgYWN0aW9uOiAy
MDA4LCBuZXdfc3RhdGU6IDggKEFDS1NFTlQpPGJyPm5ld19zdGF0ZT04PGJyPlBQUDogaXBjcDog
cHBwY3Bfc2VuZF9jb25maWd1cmVfYWNrOiBjdXJyZW50IHN0YXRlIDg6QUNLU0VOVDxicj5QUFA6
IGlwY3A6IHBwcGNwX3RpbWVvdXQ6IGN1cnJlbnQgc3RhdGUgODpBQ0tTRU5UPGJyPlBQUDogaXBj
cDogcHBwY3BfZ2VuZXJhdGVfZXZlbnQ6IGN1cnJlbnQgc3RhdGUgODpBQ0tTRU5UPGJyPlBQUDog
ZXZlbnQ6IDQgKFRPKyksIGFjdGlvbjogMTAwOCwgbmV3X3N0YXRlOiA4IChBQ0tTRU5UKTxicj5u
ZXdfc3RhdGU9ODxicj5QUFA6IGlwY3A6IHBwcGNwX3NlbmRfY29uZmlndXJlX3JlcXVlc3Q6IGN1
cnJlbnQgc3RhdGUgODpBQ0tTRU5UPGJyPnBwcF9kcm9wX3BhY2tldCBwcHAtJmd0O3BoYXNlPVBQ
UF9QSEFTRV9ORVRXT1JLOiBwcm90b2NvbD04MDIxPGJyPnBwcF9yZWNlaXZlIHByb3RvY29sPTgw
MjE8YnI+UFBQOiBpcGNwOiBwcHBjcF9wcm9jZXNzX2NvbmZpZ3VyZV9yZXF1ZXN0OiBjdXJyZW50
IHN0YXRlIDg6QUNLU0VOVDxicj5QUFA6IGlwY3A6IHBwcGNwX2dlbmVyYXRlX2V2ZW50OiBjdXJy
ZW50IHN0YXRlIDg6QUNLU0VOVDxicj5QUFA6IGV2ZW50OiA2IChSQ1IrKSwgYWN0aW9uOiAyMDA4
LCBuZXdfc3RhdGU6IDggKEFDS1NFTlQpPGJyPm5ld19zdGF0ZT04PGJyPlBQUDogaXBjcDogcHBw
Y3Bfc2VuZF9jb25maWd1cmVfYWNrOiBjdXJyZW50IHN0YXRlIDg6QUNLU0VOVDxicj5QUFA6IGlw
Y3A6IHBwcGNwX3RpbWVvdXQ6IGN1cnJlbnQgc3RhdGUgODpBQ0tTRU5UPGJyPlBQUDogaXBjcDog
cHBwY3BfZ2VuZXJhdGVfZXZlbnQ6IGN1cnJlbnQgc3RhdGUgODpBQ0tTRU5UPGJyPlBQUDogZXZl
bnQ6IDQgKFRPKyksIGFjdGlvbjogMTAwOCwgbmV3X3N0YXRlOiA4IChBQ0tTRU5UKTxicj5uZXdf
c3RhdGU9ODxicj5QUFA6IGlwY3A6IHBwcGNwX3NlbmRfY29uZmlndXJlX3JlcXVlc3Q6IGN1cnJl
bnQgc3RhdGUgODpBQ0tTRU5UPGJyPnBwcF9kcm9wX3BhY2tldCBwcHAtJmd0O3BoYXNlPVBQUF9Q
SEFTRV9ORVRXT1JLOiBwcm90b2NvbD04MDIxPGJyPnBwcF9yZWNlaXZlIHByb3RvY29sPTgwMjE8
YnI+UFBQOiBpcGNwOiBwcHBjcF9wcm9jZXNzX2NvbmZpZ3VyZV9yZXF1ZXN0OiBjdXJyZW50IHN0
YXRlIDg6QUNLU0VOVDxicj5QUFA6IGlwY3A6IHBwcGNwX2dlbmVyYXRlX2V2ZW50OiBjdXJyZW50
IHN0YXRlIDg6QUNLU0VOVDxicj5QUFA6IGV2ZW50OiA2IChSQ1IrKSwgYWN0aW9uOiAyMDA4LCBu
ZXdfc3RhdGU6IDggKEFDS1NFTlQpPGJyPm5ld19zdGF0ZT04PGJyPlBQUDogaXBjcDogcHBwY3Bf
c2VuZF9jb25maWd1cmVfYWNrOiBjdXJyZW50IHN0YXRlIDg6QUNLU0VOVDxicj5QUFA6IGlwY3A6
IHBwcGNwX3RpbWVvdXQ6IGN1cnJlbnQgc3RhdGUgODpBQ0tTRU5UPGJyPlBQUDogaXBjcDogcHBw
Y3BfZ2VuZXJhdGVfZXZlbnQ6IGN1cnJlbnQgc3RhdGUgODpBQ0tTRU5UPGJyPlBQUDogZXZlbnQ6
IDQgKFRPKyksIGFjdGlvbjogMTAwOCwgbmV3X3N0YXRlOiA4IChBQ0tTRU5UKTxicj5uZXdfc3Rh
dGU9ODxicj5QUFA6IGlwY3A6IHBwcGNwX3NlbmRfY29uZmlndXJlX3JlcXVlc3Q6IGN1cnJlbnQg
c3RhdGUgODpBQ0tTRU5UPGJyPnBwcF9kcm9wX3BhY2tldCBwcHAtJmd0O3BoYXNlPVBQUF9QSEFT
RV9ORVRXT1JLOiBwcm90b2NvbD04MDIxPGJyPnBwcF9yZWNlaXZlIHByb3RvY29sPTgwMjE8YnI+
UFBQOiBpcGNwOiBwcHBjcF9wcm9jZXNzX2NvbmZpZ3VyZV9yZXF1ZXN0OiBjdXJyZW50IHN0YXRl
IDg6QUNLU0VOVDxicj5QUFA6IGlwY3A6IHBwcGNwX2dlbmVyYXRlX2V2ZW50OiBjdXJyZW50IHN0
YXRlIDg6QUNLU0VOVDxicj5QUFA6IGV2ZW50OiA2IChSQ1IrKSwgYWN0aW9uOiAyMDA4LCBuZXdf
c3RhdGU6IDggKEFDS1NFTlQpPGJyPm5ld19zdGF0ZT04PGJyPlBQUDogaXBjcDogcHBwY3Bfc2Vu
ZF9jb25maWd1cmVfYWNrOiBjdXJyZW50IHN0YXRlIDg6QUNLU0VOVDxicj5QUFA6IGlwY3A6IHBw
cGNwX3RpbWVvdXQ6IGN1cnJlbnQgc3RhdGUgODpBQ0tTRU5UPGJyPlBQUDogaXBjcDogcHBwY3Bf
Z2VuZXJhdGVfZXZlbnQ6IGN1cnJlbnQgc3RhdGUgODpBQ0tTRU5UPGJyPlBQUDogZXZlbnQ6IDUg
KFRPLSksIGFjdGlvbjogODAzLCBuZXdfc3RhdGU6IDMgKFNUT1BQRUQpPGJyPm5ld19zdGF0ZT0z
PGJyPmFjdGlvbnMgVExGPGJyPlBQUDogaXBjcDogcHBwY3BfdGhpc19sYXllcl9maW5pc2hlZDog
Y3VycmVudCBzdGF0ZSAzOlNUT1BQRUQ8YnI+UFBQOiBpcGNwOiBwcHBjcF9nZW5lcmF0ZV9ldmVu
dDogY3VycmVudCBzdGF0ZSAzOlNUT1BQRUQ8YnI+UFBQOiBldmVudDogMyAoQ2xvc2UpLCBhY3Rp
b246IDIsIG5ld19zdGF0ZTogMiAoQ0xPU0VEKTxicj5uZXdfc3RhdGU9Mjxicj5QUFA6IGxjcDog
cHBwY3BfZ2VuZXJhdGVfZXZlbnQ6IGN1cnJlbnQgc3RhdGUgOTpPUEVORUQ8YnI+UFBQOiBldmVu
dDogMyAoQ2xvc2UpLCBhY3Rpb246IDgyMjQsIG5ld19zdGF0ZTogNCAoQ0xPU0lORyk8YnI+bmV3
X3N0YXRlPTQ8YnI+UFBQOiBsY3A6IHBwcGNwX2luaXRpYWxpemVfcmVzdGFydF9jb3VudDogY3Vy
cmVudCBzdGF0ZSA5Ok9QRU5FRDxicj5QUFA6IGxjcDogcHBwY3Bfc2VuZF90ZXJtaW5hdGVfcmVx
dWVzdDogY3VycmVudCBzdGF0ZSA5Ok9QRU5FRDxicj5hY3Rpb25zIFRMRDxicj5QUFA6IGlwY3A6
IHBwcGNwX2dlbmVyYXRlX2V2ZW50OiBjdXJyZW50IHN0YXRlIDI6Q0xPU0VEPGJyPlBQUDogZXZl
bnQ6IDEgKERvd24pLCBhY3Rpb246IDAsIG5ld19zdGF0ZTogMCAoSU5JVElBTCk8YnI+bmV3X3N0
YXRlPTA8YnI+RW50ZXJpbmcgbmV3IHBoYXNlOiA1PGJyPnBwcF9yZWNlaXZlIHByb3RvY29sPWMw
MjE8YnI+UFBQOiBsY3A6IHBwcGNwX3Byb2Nlc3NfdGVybWluYXRlX2FjazogY3VycmVudCBzdGF0
ZSA0OkNMT1NJTkc8YnI+UFBQOiBsY3A6IHBwcGNwX2dlbmVyYXRlX2V2ZW50OiBjdXJyZW50IHN0
YXRlIDQ6Q0xPU0lORzxicj5QUFA6IGV2ZW50OiAxMSAoUlRBKSwgYWN0aW9uOiA4MDIsIG5ld19z
dGF0ZTogMiAoQ0xPU0VEKTxicj5uZXdfc3RhdGU9Mjxicj5hY3Rpb25zIFRMRjxicj5QUFA6IGxj
cDogcHBwY3BfdGhpc19sYXllcl9maW5pc2hlZDogY3VycmVudCBzdGF0ZSAyOkNMT1NFRDxicj5F
bnRlcmluZyBuZXcgcGhhc2U6IDA8YnI+UFBQIExpbmsgZG93bjogMjxicj5Nb2RlbTogJmx0OyBc
clxuTk8gQ0FSUklFUlxyXG48YnI+Q29udHJvbDogJmd0OyBBVCtDRlVOPTBccjxicj5Db250cm9s
OiAmbHQ7IFxyXG5PS1xyXG48YnI+PGJyPjxicj48YnI+LS0tLS0tLS08YnI+PGJyPlJlZ2FyZHMh
PGJyPiAgICAgICAgCjxicj48YnI+PHNwYW4gdGl0bGU9Im5ldGVhc2Vmb290ZXIiPjxzcGFuIGlk
PSJuZXRlYXNlX21haWxfZm9vdGVyIj48L3NwYW4+PC9zcGFuPg==
--===============2204083455802355471==--

