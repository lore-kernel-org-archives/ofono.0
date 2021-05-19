Content-Type: multipart/mixed; boundary="===============0118657148409806703=="
MIME-Version: 1.0
From: Sergei Golubtsov <s.e.golubtsov@gmail.com>
Subject: Quectel EC200T USB: Problems with context activation in chineese
 networks
Date: Wed, 19 May 2021 08:44:28 +0200
Message-ID: <CAFiQ677HmB5QAVeC9yd+sim7SJq=9SR0Y+YS6M2zU-xGWtVYvQ@mail.gmail.com>
In-Reply-To: <CAFiQ675+H9QndW030-WkV2oivkVVChzcOTnKbaj+4VzW4k9P6w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0118657148409806703==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis and all,

I have some problems with the context activation on Quectel EC200T USB in
chinese network although in russian networks the modem works fine.

I have the following during the activation:

2021-05-18T23:35:50.624972+03:00 ofonod[999]: [info] Modem: <
\r\nCONNECT\r\n
2021-05-18T23:35:50.625854+03:00 ofonod[999]: [debug]
../git/ofono/drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 1
2021-05-18T23:35:50.626564+03:00 ofonod[999]: [debug]
../git/ofono/drivers/atmodem/gprs-context.c:setup_ppp()
2021-05-18T23:35:50.627463+03:00 ofonod[999]: [info] PPP: lcp:
pppcp_generate_event: current state 0:INITIAL
2021-05-18T23:35:50.628216+03:00 ofonod[999]: [info] PPP: event: 0 (Up),
action: 2, new_state: 2 (CLOSED)
2021-05-18T23:35:50.628884+03:00 ofonod[999]: [info] PPP: lcp:
pppcp_generate_event: current state 2:CLOSED
2021-05-18T23:35:50.629521+03:00 ofonod[999]: [info] PPP: event: 2 (Open),
action: 1026, new_state: 6 (REQSENT)
2021-05-18T23:35:50.630234+03:00 ofonod[999]: [info] PPP: lcp:
pppcp_initialize_restart_count: current state 2:CLOSED
2021-05-18T23:35:50.630876+03:00 ofonod[999]: [info] PPP: lcp:
pppcp_send_configure_request: current state 2:CLOSED
2021-05-18T23:35:50.631641+03:00 ofonod[999]: [info] PPP:
../git/ofono/gatchat/gatppp.c:ppp_enter_phase() 1
2021-05-18T23:35:50.634253+03:00 ofonod[999]: [info] PPP: lcp:
pppcp_process_configure_request: current state 6:REQSENT
2021-05-18T23:35:50.635270+03:00 ofonod[999]: [info] PPP: lcp:
pppcp_generate_event: current state 6:REQSENT
2021-05-18T23:35:50.635423+03:00 ofonod[999]: [info] PPP: event: 7 (RCR-),
action: 4006, new_state: 6 (REQSENT)
2021-05-18T23:35:50.635544+03:00 ofonod[999]: [info] PPP: lcp:
pppcp_send_configure_nak: current state 6:REQSENT
2021-05-18T23:35:50.636566+03:00 ofonod[999]: [info] PPP: lcp:
pppcp_process_configure_ack: current state 6:REQSENT
2021-05-18T23:35:50.636696+03:00 ofonod[999]: [info] PPP: lcp:
pppcp_generate_event: current state 6:REQSENT
2021-05-18T23:35:50.637067+03:00 ofonod[999]: [info] PPP: event: 8 (RCA),
action: 27, new_state: 7 (ACKRCVD)
2021-05-18T23:35:50.637187+03:00 ofonod[999]: [info] PPP: lcp:
pppcp_initialize_restart_count: current state 6:REQSENT
2021-05-18T23:35:50.637187+03:00 ofonod[999]: [info] PPP: lcp:
pppcp_initialize_restart_count: current state 6:REQSENT
2021-05-18T23:35:50.637597+03:00 ofonod[999]: [info] PPP: lcp:
pppcp_process_configure_request: current state 7:ACKRCVD
2021-05-18T23:35:50.637715+03:00 ofonod[999]: [info] PPP: lcp:
pppcp_generate_event: current state 7:ACKRCVD
2021-05-18T23:35:50.637826+03:00 ofonod[999]: [info] PPP: event: 7 (RCR-),
action: 4007, new_state: 7 (ACKRCVD)
2021-05-18T23:35:50.637929+03:00 ofonod[999]: [info] PPP: lcp:
pppcp_send_configure_nak: current state 7:ACKRCVD
2021-05-18T23:35:50.639907+03:00 ofonod[999]: [info] PPP: lcp:
pppcp_process_configure_request: current state 7:ACKRCVD
2021-05-18T23:35:50.640246+03:00 ofonod[999]: [info] PPP: lcp:
pppcp_generate_event: current state 7:ACKRCVD
2021-05-18T23:35:50.640992+03:00 ofonod[999]: [info] PPP: event: 7 (RCR-),
action: 4007, new_state: 7 (ACKRCVD)

So, the following lines repeats infinitely, context is not activated and
ofono uses ~90% of the CPU until I stop it:

2021-05-18T23:35:50.637929+03:00 ofonod[999]: [info] PPP: lcp:
pppcp_send_configure_nak: current state 7:ACKRCVD
2021-05-18T23:35:50.639907+03:00 ofonod[999]: [info] PPP: lcp:
pppcp_process_configure_request: current state 7:ACKRCVD
2021-05-18T23:35:50.640246+03:00 ofonod[999]: [info] PPP: lcp:
pppcp_generate_event: current state 7:ACKRCVD
2021-05-18T23:35:50.640992+03:00 ofonod[999]: [info] PPP: event: 7 (RCR-),
action: 4007, new_state: 7 (ACKRCVD)

Could someone shed a light on what is going on there and how to solve that?

Thanks in advance.
Have a nice day.

Yours sincerely,
Sergei Golubtsov.

--===============0118657148409806703==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtc2l6
ZTpzbWFsbCI+SGkgRGVuaXMgYW5kIGFsbCw8YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfcXVv
dGUiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgc3R5bGU9ImZvbnQtc2l6ZTpz
bWFsbCI+PGJyPjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZTpzbWFsbCI+SSBoYXZlIHNvbWUg
cHJvYmxlbXMgd2l0aCB0aGUgY29udGV4dCBhY3RpdmF0aW9uIG9uwqBRdWVjdGVsIEVDMjAwVCBV
U0IgaW4gY2hpbmVzZcKgbmV0d29yayBhbHRob3VnaCBpbiBydXNzaWFuIG5ldHdvcmtzIHRoZSBt
b2RlbSB3b3JrcyBmaW5lLjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZTpzbWFsbCI+PGJyPjwv
ZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZTpzbWFsbCI+SSBoYXZlIHRoZSBmb2xsb3dpbmcgZHVy
aW5nIHRoZSBhY3RpdmF0aW9uOjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZTpzbWFsbCI+PGJy
PjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZTpzbWFsbCI+MjAyMS0wNS0xOFQyMzozNTo1MC42
MjQ5NzIrMDM6MDAgb2Zvbm9kWzk5OV06IFtpbmZvXSBNb2RlbTogJmx0OyBcclxuQ09OTkVDVFxy
XG48YnI+MjAyMS0wNS0xOFQyMzozNTo1MC42MjU4NTQrMDM6MDAgb2Zvbm9kWzk5OV06IFtkZWJ1
Z10gLi4vZ2l0L29mb25vL2RyaXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRleHQuYzphdF9jZ2RhdGFf
Y2IoKSBvayAxPGJyPjIwMjEtMDUtMThUMjM6MzU6NTAuNjI2NTY0KzAzOjAwIG9mb25vZFs5OTld
OiBbZGVidWddIC4uL2dpdC9vZm9uby9kcml2ZXJzL2F0bW9kZW0vZ3Bycy1jb250ZXh0LmM6c2V0
dXBfcHBwKCk8YnI+MjAyMS0wNS0xOFQyMzozNTo1MC42Mjc0NjMrMDM6MDAgb2Zvbm9kWzk5OV06
IFtpbmZvXSBQUFA6IGxjcDogcHBwY3BfZ2VuZXJhdGVfZXZlbnQ6IGN1cnJlbnQgc3RhdGUgMDpJ
TklUSUFMPGJyPjIwMjEtMDUtMThUMjM6MzU6NTAuNjI4MjE2KzAzOjAwIG9mb25vZFs5OTldOiBb
aW5mb10gUFBQOiBldmVudDogMCAoVXApLCBhY3Rpb246IDIsIG5ld19zdGF0ZTogMiAoQ0xPU0VE
KTxicj4yMDIxLTA1LTE4VDIzOjM1OjUwLjYyODg4NCswMzowMCBvZm9ub2RbOTk5XTogW2luZm9d
IFBQUDogbGNwOiBwcHBjcF9nZW5lcmF0ZV9ldmVudDogY3VycmVudCBzdGF0ZSAyOkNMT1NFRDxi
cj4yMDIxLTA1LTE4VDIzOjM1OjUwLjYyOTUyMSswMzowMCBvZm9ub2RbOTk5XTogW2luZm9dIFBQ
UDogZXZlbnQ6IDIgKE9wZW4pLCBhY3Rpb246IDEwMjYsIG5ld19zdGF0ZTogNiAoUkVRU0VOVCk8
YnI+MjAyMS0wNS0xOFQyMzozNTo1MC42MzAyMzQrMDM6MDAgb2Zvbm9kWzk5OV06IFtpbmZvXSBQ
UFA6IGxjcDogcHBwY3BfaW5pdGlhbGl6ZV9yZXN0YXJ0X2NvdW50OiBjdXJyZW50IHN0YXRlIDI6
Q0xPU0VEPGJyPjIwMjEtMDUtMThUMjM6MzU6NTAuNjMwODc2KzAzOjAwIG9mb25vZFs5OTldOiBb
aW5mb10gUFBQOiBsY3A6IHBwcGNwX3NlbmRfY29uZmlndXJlX3JlcXVlc3Q6IGN1cnJlbnQgc3Rh
dGUgMjpDTE9TRUQ8YnI+MjAyMS0wNS0xOFQyMzozNTo1MC42MzE2NDErMDM6MDAgb2Zvbm9kWzk5
OV06IFtpbmZvXSBQUFA6IC4uL2dpdC9vZm9uby9nYXRjaGF0L2dhdHBwcC5jOnBwcF9lbnRlcl9w
aGFzZSgpIDE8YnI+MjAyMS0wNS0xOFQyMzozNTo1MC42MzQyNTMrMDM6MDAgb2Zvbm9kWzk5OV06
IFtpbmZvXSBQUFA6IGxjcDogcHBwY3BfcHJvY2Vzc19jb25maWd1cmVfcmVxdWVzdDogY3VycmVu
dCBzdGF0ZSA2OlJFUVNFTlQ8YnI+MjAyMS0wNS0xOFQyMzozNTo1MC42MzUyNzArMDM6MDAgb2Zv
bm9kWzk5OV06IFtpbmZvXSBQUFA6IGxjcDogcHBwY3BfZ2VuZXJhdGVfZXZlbnQ6IGN1cnJlbnQg
c3RhdGUgNjpSRVFTRU5UPGJyPjIwMjEtMDUtMThUMjM6MzU6NTAuNjM1NDIzKzAzOjAwIG9mb25v
ZFs5OTldOiBbaW5mb10gUFBQOiBldmVudDogNyAoUkNSLSksIGFjdGlvbjogNDAwNiwgbmV3X3N0
YXRlOiA2IChSRVFTRU5UKTxicj4yMDIxLTA1LTE4VDIzOjM1OjUwLjYzNTU0NCswMzowMCBvZm9u
b2RbOTk5XTogW2luZm9dIFBQUDogbGNwOiBwcHBjcF9zZW5kX2NvbmZpZ3VyZV9uYWs6IGN1cnJl
bnQgc3RhdGUgNjpSRVFTRU5UPGJyPjIwMjEtMDUtMThUMjM6MzU6NTAuNjM2NTY2KzAzOjAwIG9m
b25vZFs5OTldOiBbaW5mb10gUFBQOiBsY3A6IHBwcGNwX3Byb2Nlc3NfY29uZmlndXJlX2Fjazog
Y3VycmVudCBzdGF0ZSA2OlJFUVNFTlQ8YnI+MjAyMS0wNS0xOFQyMzozNTo1MC42MzY2OTYrMDM6
MDAgb2Zvbm9kWzk5OV06IFtpbmZvXSBQUFA6IGxjcDogcHBwY3BfZ2VuZXJhdGVfZXZlbnQ6IGN1
cnJlbnQgc3RhdGUgNjpSRVFTRU5UPGJyPjIwMjEtMDUtMThUMjM6MzU6NTAuNjM3MDY3KzAzOjAw
IG9mb25vZFs5OTldOiBbaW5mb10gUFBQOiBldmVudDogOCAoUkNBKSwgYWN0aW9uOiAyNywgbmV3
X3N0YXRlOiA3IChBQ0tSQ1ZEKTxicj4yMDIxLTA1LTE4VDIzOjM1OjUwLjYzNzE4NyswMzowMCBv
Zm9ub2RbOTk5XTogW2luZm9dIFBQUDogbGNwOiBwcHBjcF9pbml0aWFsaXplX3Jlc3RhcnRfY291
bnQ6IGN1cnJlbnQgc3RhdGUgNjpSRVFTRU5UPGJyPjIwMjEtMDUtMThUMjM6MzU6NTAuNjM3MTg3
KzAzOjAwIG9mb25vZFs5OTldOiBbaW5mb10gUFBQOiBsY3A6IHBwcGNwX2luaXRpYWxpemVfcmVz
dGFydF9jb3VudDogY3VycmVudCBzdGF0ZSA2OlJFUVNFTlQ8YnI+MjAyMS0wNS0xOFQyMzozNTo1
MC42Mzc1OTcrMDM6MDAgb2Zvbm9kWzk5OV06IFtpbmZvXSBQUFA6IGxjcDogcHBwY3BfcHJvY2Vz
c19jb25maWd1cmVfcmVxdWVzdDogY3VycmVudCBzdGF0ZSA3OkFDS1JDVkQ8YnI+MjAyMS0wNS0x
OFQyMzozNTo1MC42Mzc3MTUrMDM6MDAgb2Zvbm9kWzk5OV06IFtpbmZvXSBQUFA6IGxjcDogcHBw
Y3BfZ2VuZXJhdGVfZXZlbnQ6IGN1cnJlbnQgc3RhdGUgNzpBQ0tSQ1ZEPGJyPjIwMjEtMDUtMThU
MjM6MzU6NTAuNjM3ODI2KzAzOjAwIG9mb25vZFs5OTldOiBbaW5mb10gUFBQOiBldmVudDogNyAo
UkNSLSksIGFjdGlvbjogNDAwNywgbmV3X3N0YXRlOiA3IChBQ0tSQ1ZEKTxicj4yMDIxLTA1LTE4
VDIzOjM1OjUwLjYzNzkyOSswMzowMCBvZm9ub2RbOTk5XTogW2luZm9dIFBQUDogbGNwOiBwcHBj
cF9zZW5kX2NvbmZpZ3VyZV9uYWs6IGN1cnJlbnQgc3RhdGUgNzpBQ0tSQ1ZEPGJyPjIwMjEtMDUt
MThUMjM6MzU6NTAuNjM5OTA3KzAzOjAwIG9mb25vZFs5OTldOiBbaW5mb10gUFBQOiBsY3A6IHBw
cGNwX3Byb2Nlc3NfY29uZmlndXJlX3JlcXVlc3Q6IGN1cnJlbnQgc3RhdGUgNzpBQ0tSQ1ZEPGJy
PjIwMjEtMDUtMThUMjM6MzU6NTAuNjQwMjQ2KzAzOjAwIG9mb25vZFs5OTldOiBbaW5mb10gUFBQ
OiBsY3A6IHBwcGNwX2dlbmVyYXRlX2V2ZW50OiBjdXJyZW50IHN0YXRlIDc6QUNLUkNWRDxicj4y
MDIxLTA1LTE4VDIzOjM1OjUwLjY0MDk5MiswMzowMCBvZm9ub2RbOTk5XTogW2luZm9dIFBQUDog
ZXZlbnQ6IDcgKFJDUi0pLCBhY3Rpb246IDQwMDcsIG5ld19zdGF0ZTogNyAoQUNLUkNWRCk8YnI+
PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOnNtYWxsIj48YnI+PC9kaXY+PGRpdiBzdHlsZT0i
Zm9udC1zaXplOnNtYWxsIj5TbywgdGhlIGZvbGxvd2luZyBsaW5lcyByZXBlYXRzIGluZmluaXRl
bHksIGNvbnRleHQgaXMgbm90IGFjdGl2YXRlZCBhbmQgb2Zvbm8gdXNlcyB+OTAlIG9mIHRoZSBD
UFUgdW50aWwgSSBzdG9wIGl0OjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZTpzbWFsbCI+wqA8
L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6c21hbGwiPjIwMjEtMDUtMThUMjM6MzU6NTAuNjM3
OTI5KzAzOjAwIG9mb25vZFs5OTldOiBbaW5mb10gUFBQOiBsY3A6IHBwcGNwX3NlbmRfY29uZmln
dXJlX25hazogY3VycmVudCBzdGF0ZSA3OkFDS1JDVkQ8YnI+MjAyMS0wNS0xOFQyMzozNTo1MC42
Mzk5MDcrMDM6MDAgb2Zvbm9kWzk5OV06IFtpbmZvXSBQUFA6IGxjcDogcHBwY3BfcHJvY2Vzc19j
b25maWd1cmVfcmVxdWVzdDogY3VycmVudCBzdGF0ZSA3OkFDS1JDVkQ8YnI+MjAyMS0wNS0xOFQy
MzozNTo1MC42NDAyNDYrMDM6MDAgb2Zvbm9kWzk5OV06IFtpbmZvXSBQUFA6IGxjcDogcHBwY3Bf
Z2VuZXJhdGVfZXZlbnQ6IGN1cnJlbnQgc3RhdGUgNzpBQ0tSQ1ZEPGJyPjIwMjEtMDUtMThUMjM6
MzU6NTAuNjQwOTkyKzAzOjAwIG9mb25vZFs5OTldOiBbaW5mb10gUFBQOiBldmVudDogNyAoUkNS
LSksIGFjdGlvbjogNDAwNywgbmV3X3N0YXRlOiA3IChBQ0tSQ1ZEKTwvZGl2PjxkaXYgc3R5bGU9
ImZvbnQtc2l6ZTpzbWFsbCI+PGJyPjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZTpzbWFsbCI+
Q291bGQgc29tZW9uZSBzaGVkIGEgbGlnaHQgb24gd2hhdCBpcyBnb2luZyBvbiB0aGVyZSBhbmQg
aG93IHRvIHNvbHZlIHRoYXQ/PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOnNtYWxsIj48YnI+
PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOnNtYWxsIj5UaGFua3MgaW4gYWR2YW5jZS48L2Rp
dj48ZGl2IHN0eWxlPSJmb250LXNpemU6c21hbGwiPkhhdmUgYSBuaWNlIGRheS48L2Rpdj48ZGl2
IHN0eWxlPSJmb250LXNpemU6c21hbGwiPjxicj48L2Rpdj48ZGl2PjxkaXYgZGlyPSJsdHIiIGRh
dGEtc21hcnRtYWlsPSJnbWFpbF9zaWduYXR1cmUiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJs
dHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGly
PSJsdHIiPjxkaXY+PGZvbnQgZmFjZT0iYXJpYWwgbmFycm93LCBzYW5zLXNlcmlmIj5Zb3VycyBz
aW5jZXJlbHksPC9mb250PjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90
O2FyaWFsIG5hcnJvdyZxdW90OyxzYW5zLXNlcmlmIj5TZXJnZWnCoDwvc3Bhbj48Zm9udCBmYWNl
PSJhcmlhbCBuYXJyb3csIHNhbnMtc2VyaWYiPkdvbHVidHNvdi48L2ZvbnQ+PC9kaXY+PC9kaXY+
PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+Cjwv
ZGl2PjwvZGl2Pgo=

--===============0118657148409806703==--

