Content-Type: multipart/mixed; boundary="===============2408759003722923046=="
MIME-Version: 1.0
From: Chen Yuwei <yuwachen@gmail.com>
Subject: PPP disconnected via Huawei modem
Date: Thu, 11 Nov 2010 15:14:46 +0800
Message-ID: <AANLkTimyMY0Y3hf7wA=rJghB5MtVLgeji7wQ+VUr9anf@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2408759003722923046==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I use MeeGo NB 10/26 release to browse some website via Huawei modem,
The PPP connection is disconnected when recieve a PPP event (RXJ-).
Then the PPP can not be connected anymore. Why?
What condition does ofono recieve this event?
The ofono also recieved udev event "remove" and removed the huawei modem.
But I does not pull out the modem.
What condition does udev send the "remove" event?

The following is the ofono debug messages:

ofonod[1033]: PCUI: < \r\n^BOOT:20576126,0,0,0,20\r\n
ofonod[1033]: PCUI: <
\r\n^DSFLOWRPT:00000064,00000000,00000000,00000000000056DB,000000000001245A=
,0003E800,000FA000\r\n
ofonod[1033]: PCUI: < \r\n^RSSI:18\r\n
ofonod[1033]: PCUI: <
\r\n^DSFLOWRPT:00000066,00000000,00000000,00000000000056DB,000000000001245A=
,0003E800,000FA000\r\n
ofonod[1033]: PPP: lcp: pppcp_generate_event: current state 9:OPENED
ofonod[1033]: PPP: event: 14 (RXJ-), action: 8225, new_state: 5 (STOPPING)
ofonod[1033]: PPP: lcp: pppcp_initialize_restart_count: current state
9:OPENED
ofonod[1033]: PPP: lcp: pppcp_send_terminate_request: current state 9:OPENED
ofonod[1033]: PPP: ipcp: pppcp_generate_event: current state 9:OPENED
ofonod[1033]: PPP: event: 1 (Down), action: 201, new_state: 1 (STARTING)
Entering new phase: 5
ofonod[1033]: plugins/udev.c:remove_modem() /devices/virtual/net/ppp0
ofonod[1033]: PCUI: < \r\n^RSSI:18\r\n
ofonod[1033]: PPP: lcp: pppcp_process_terminate_ack: current state
5:STOPPING
ofonod[1033]: PPP: lcp: pppcp_generate_event: current state 5:STOPPING
ofonod[1033]: PPP: event: 11 (RTA), action: 803, new_state: 3 (STOPPED)
ofonod[1033]: PPP: lcp: pppcp_this_layer_finished: current state 3:STOPPED
Entering new phase: 0
ofonod[1033]: drivers/atmodem/gprs-context.c:ppp_disconnect()
ofonod[1033]: Modem: > AT+CGDCONT=3D1,"IP","internet"\r
ofonod[1033]: PCUI: <
\r\n^DSFLOWRPT:00000068,0000004E,00000068,0000000000005777,000000000001252A=
,0003E800,000FA000\r\n
ofonod[1033]: PCUI: < \r\n^MODE:5,5\r\n
ofonod[1033]: PCUI: <
\r\n^DSFLOWRPT:0000006A,00000000,00000000,0000000000005777,000000000001252A=
,00000000,00000000\r\n
ofonod[1033]: PCUI: < \r\n^RSSI:18\r\n
ofonod[1033]: PCUI: < \r\n^MODE:5,4\r\n
ofonod[1033]: Modem: < \r\nNO CARRIER\r\n
ofonod[1033]: src/gprs.c:pri_activate_callback() 0x94d7420 (null)
ofonod[1033]: src/gprs.c:pri_activate_callback() Activating context failed
with error: Unknown error type
ofonod[1033]: plugins/huawei.c:huawei_disconnect()
ofonod[1033]: src/gprs.c:gprs_context_remove() atom: 0x94d2ee0
ofonod[1033]: drivers/atmodem/gprs-context.c:at_gprs_context_remove()
ofonod[1033]: src/modem.c:get_modem_property() modem 0x94d4070 property
Modem
ofonod[1033]: plugins/huawei.c:open_device() Modem /dev/ttyUSB0
ofonod[1033]: Reopened GPRS context channel
ofonod[1033]: PCUI: < \r\n^RSSI:18\r\n
ofonod[1033]: PCUI: < \r\n+CREG: 1, 2829, 1197F8F\r\n\r\n+CGREG: 1, 2829,
1197F8F\r\n

BR

Elton

--===============2408759003722923046==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+SGksPGJyPqA8YnI+SSB1c2UgTWVlR28gTkIgMTAvMjYgcmVsZWFzZSB0byBicm93c2Ugc29t
ZSB3ZWJzaXRlIHZpYSBIdWF3ZWkgbW9kZW0sPGJyPlRoZSBQUFAgY29ubmVjdGlvbiBpcyBkaXNj
b25uZWN0ZWQgd2hlbiByZWNpZXZlIGEgUFBQIGV2ZW50IChSWEotKS48YnI+VGhlbiB0aGUgUFBQ
IGNhbiBub3QgYmUgY29ubmVjdGVkIGFueW1vcmUuIFdoeT88YnI+V2hhdCBjb25kaXRpb24gZG9l
cyBvZm9ubyByZWNpZXZlIHRoaXMgZXZlbnQ/PGJyPgpUaGUgb2Zvbm8gYWxzbyByZWNpZXZlZCB1
ZGV2IGV2ZW50ICZxdW90O3JlbW92ZSZxdW90OyBhbmQgcmVtb3ZlZCB0aGUgaHVhd2VpIG1vZGVt
Ljxicj5CdXQgSSBkb2VzIG5vdCBwdWxsIG91dCB0aGUgbW9kZW0uPGJyPldoYXQgY29uZGl0aW9u
IGRvZXMgdWRldiBzZW5kIHRoZSAmcXVvdDtyZW1vdmUmcXVvdDsgZXZlbnQ/PGJyPqA8YnI+VGhl
IGZvbGxvd2luZyBpcyB0aGUgb2Zvbm8gZGVidWcgbWVzc2FnZXM6PGJyPgqgPGJyPm9mb25vZFsx
MDMzXTogUENVSTogJmx0OyBcclxuXkJPT1Q6MjA1NzYxMjYsMCwwLDAsMjBcclxuPGJyPm9mb25v
ZFsxMDMzXTogUENVSTogJmx0OyBcclxuXkRTRkxPV1JQVDowMDAwMDA2NCwwMDAwMDAwMCwwMDAw
MDAwMCwwMDAwMDAwMDAwMDA1NkRCLDAwMDAwMDAwMDAwMTI0NUEsMDAwM0U4MDAsMDAwRkEwMDBc
clxuPGJyPm9mb25vZFsxMDMzXTogUENVSTogJmx0OyBcclxuXlJTU0k6MThcclxuPGJyPgpvZm9u
b2RbMTAzM106IFBDVUk6ICZsdDsgXHJcbl5EU0ZMT1dSUFQ6MDAwMDAwNjYsMDAwMDAwMDAsMDAw
MDAwMDAsMDAwMDAwMDAwMDAwNTZEQiwwMDAwMDAwMDAwMDEyNDVBLDAwMDNFODAwLDAwMEZBMDAw
XHJcbjxicj5vZm9ub2RbMTAzM106IFBQUDogbGNwOiBwcHBjcF9nZW5lcmF0ZV9ldmVudDogY3Vy
cmVudCBzdGF0ZSA5Ok9QRU5FRDxicj5vZm9ub2RbMTAzM106IFBQUDogZXZlbnQ6IDE0IChSWEot
KSwgYWN0aW9uOiA4MjI1LCBuZXdfc3RhdGU6IDUgKFNUT1BQSU5HKTxicj4Kb2Zvbm9kWzEwMzNd
OiBQUFA6IGxjcDogcHBwY3BfaW5pdGlhbGl6ZV9yZXN0YXJ0X2NvdW50OiBjdXJyZW50IHN0YXRl
IDk6T1BFTkVEPGJyPm9mb25vZFsxMDMzXTogUFBQOiBsY3A6IHBwcGNwX3NlbmRfdGVybWluYXRl
X3JlcXVlc3Q6IGN1cnJlbnQgc3RhdGUgOTpPUEVORUQ8YnI+b2Zvbm9kWzEwMzNdOiBQUFA6IGlw
Y3A6IHBwcGNwX2dlbmVyYXRlX2V2ZW50OiBjdXJyZW50IHN0YXRlIDk6T1BFTkVEPGJyPgpvZm9u
b2RbMTAzM106IFBQUDogZXZlbnQ6IDEgKERvd24pLCBhY3Rpb246IDIwMSwgbmV3X3N0YXRlOiAx
IChTVEFSVElORyk8YnI+RW50ZXJpbmcgbmV3IHBoYXNlOiA1PGJyPm9mb25vZFsxMDMzXTogcGx1
Z2lucy91ZGV2LmM6cmVtb3ZlX21vZGVtKCkgL2RldmljZXMvdmlydHVhbC9uZXQvcHBwMDxicj5v
Zm9ub2RbMTAzM106IFBDVUk6ICZsdDsgXHJcbl5SU1NJOjE4XHJcbjxicj5vZm9ub2RbMTAzM106
IFBQUDogbGNwOiBwcHBjcF9wcm9jZXNzX3Rlcm1pbmF0ZV9hY2s6IGN1cnJlbnQgc3RhdGUgNTpT
VE9QUElORzxicj4Kb2Zvbm9kWzEwMzNdOiBQUFA6IGxjcDogcHBwY3BfZ2VuZXJhdGVfZXZlbnQ6
IGN1cnJlbnQgc3RhdGUgNTpTVE9QUElORzxicj5vZm9ub2RbMTAzM106IFBQUDogZXZlbnQ6IDEx
IChSVEEpLCBhY3Rpb246IDgwMywgbmV3X3N0YXRlOiAzIChTVE9QUEVEKTxicj5vZm9ub2RbMTAz
M106IFBQUDogbGNwOiBwcHBjcF90aGlzX2xheWVyX2ZpbmlzaGVkOiBjdXJyZW50IHN0YXRlIDM6
U1RPUFBFRDxicj4KRW50ZXJpbmcgbmV3IHBoYXNlOiAwPGJyPm9mb25vZFsxMDMzXTogZHJpdmVy
cy9hdG1vZGVtL2dwcnMtY29udGV4dC5jOnBwcF9kaXNjb25uZWN0KCkgPGJyPm9mb25vZFsxMDMz
XTogTW9kZW06ICZndDsgQVQrQ0dEQ09OVD0xLCZxdW90O0lQJnF1b3Q7LCZxdW90O2ludGVybmV0
JnF1b3Q7XHI8YnI+b2Zvbm9kWzEwMzNdOiBQQ1VJOiAmbHQ7IFxyXG5eRFNGTE9XUlBUOjAwMDAw
MDY4LDAwMDAwMDRFLDAwMDAwMDY4LDAwMDAwMDAwMDAwMDU3NzcsMDAwMDAwMDAwMDAxMjUyQSww
MDAzRTgwMCwwMDBGQTAwMFxyXG48YnI+Cm9mb25vZFsxMDMzXTogUENVSTogJmx0OyBcclxuXk1P
REU6NSw1XHJcbjxicj5vZm9ub2RbMTAzM106IFBDVUk6ICZsdDsgXHJcbl5EU0ZMT1dSUFQ6MDAw
MDAwNkEsMDAwMDAwMDAsMDAwMDAwMDAsMDAwMDAwMDAwMDAwNTc3NywwMDAwMDAwMDAwMDEyNTJB
LDAwMDAwMDAwLDAwMDAwMDAwXHJcbjxicj5vZm9ub2RbMTAzM106IFBDVUk6ICZsdDsgXHJcbl5S
U1NJOjE4XHJcbjxicj5vZm9ub2RbMTAzM106IFBDVUk6ICZsdDsgXHJcbl5NT0RFOjUsNFxyXG48
YnI+Cm9mb25vZFsxMDMzXTogTW9kZW06ICZsdDsgXHJcbk5PIENBUlJJRVJcclxuPGJyPm9mb25v
ZFsxMDMzXTogc3JjL2dwcnMuYzpwcmlfYWN0aXZhdGVfY2FsbGJhY2soKSAweDk0ZDc0MjAgKG51
bGwpPGJyPm9mb25vZFsxMDMzXTogc3JjL2dwcnMuYzpwcmlfYWN0aXZhdGVfY2FsbGJhY2soKSBB
Y3RpdmF0aW5nIGNvbnRleHQgZmFpbGVkIHdpdGggZXJyb3I6IFVua25vd24gZXJyb3IgdHlwZTxi
cj4Kb2Zvbm9kWzEwMzNdOiBwbHVnaW5zL2h1YXdlaS5jOmh1YXdlaV9kaXNjb25uZWN0KCkgPGJy
Pm9mb25vZFsxMDMzXTogc3JjL2dwcnMuYzpncHJzX2NvbnRleHRfcmVtb3ZlKCkgYXRvbTogMHg5
NGQyZWUwPGJyPm9mb25vZFsxMDMzXTogZHJpdmVycy9hdG1vZGVtL2dwcnMtY29udGV4dC5jOmF0
X2dwcnNfY29udGV4dF9yZW1vdmUoKSA8YnI+b2Zvbm9kWzEwMzNdOiBzcmMvbW9kZW0uYzpnZXRf
bW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDk0ZDQwNzAgcHJvcGVydHkgTW9kZW08YnI+Cm9mb25v
ZFsxMDMzXTogcGx1Z2lucy9odWF3ZWkuYzpvcGVuX2RldmljZSgpIE1vZGVtIC9kZXYvdHR5VVNC
MDxicj5vZm9ub2RbMTAzM106IFJlb3BlbmVkIEdQUlMgY29udGV4dCBjaGFubmVsPGJyPm9mb25v
ZFsxMDMzXTogUENVSTogJmx0OyBcclxuXlJTU0k6MThcclxuPGJyPm9mb25vZFsxMDMzXTogUENV
STogJmx0OyBcclxuK0NSRUc6IDEsIDI4MjksIDExOTdGOEZcclxuXHJcbitDR1JFRzogMSwgMjgy
OSwgMTE5N0Y4RlxyXG48L3A+Cgo8cD5CUjxicj6gPGJyPkVsdG9uPC9wPgo=

--===============2408759003722923046==--

