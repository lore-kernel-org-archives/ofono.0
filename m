Content-Type: multipart/mixed; boundary="===============4549324784100756487=="
MIME-Version: 1.0
From: Chen Yuwei <yuwachen@gmail.com>
Subject: PPP disconnet with Huawei modem
Date: Wed, 10 Nov 2010 08:50:12 +0000
Message-ID: <AANLkTi=CCUNMFGCiGYkDPDR_keqRNjHP3qnyMgug6dcb@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4549324784100756487==
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

--===============4549324784100756487==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdj5IaSw8L2Rpdj4KPGRpdj6gPC9kaXY+CjxkaXY+SSB1c2UgTWVlR28gTkIgMTAvMjYgcmVs
ZWFzZSB0b6Bicm93c2Ugc29tZSB3ZWJzaXRlIHZpYSBIdWF3ZWkgbW9kZW0sPC9kaXY+CjxkaXY+
VGhloFBQUCBjb25uZWN0aW9uoGlzIGRpc2Nvbm5lY3RlZKB3aGVuIHJlY2lldmUgYSBQUFAgZXZl
bnQgKFJYSi0pLjwvZGl2Pgo8ZGl2PlRoZW6gdGhlIFBQUKBjYW4gbm90IGJlIGNvbm5lY3RlZCBh
bnltb3JlLiBXaHk/PC9kaXY+CjxkaXY+V2hhdCBjb25kaXRpb26gZG9lcyBvZm9ubyByZWNpZXZl
IHRoaXMgZXZlbnQ/PC9kaXY+CjxkaXY+VGhlIG9mb25voGFsc28gcmVjaWV2ZWQgdWRldiBldmVu
dCAmcXVvdDtyZW1vdmUmcXVvdDsgYW5kIHJlbW92ZWQgdGhlIGh1YXdlaSBtb2RlbS48L2Rpdj4K
PGRpdj5CdXQgSSBkb2VzIG5vdCBwdWxsIG91dCB0aGUgbW9kZW0uPC9kaXY+CjxkaXY+V2hhdCBj
b25kaXRpb26gZG9lcyB1ZGV2IHNlbmQgdGhlICZxdW90O3JlbW92ZSZxdW90OyBldmVudD88L2Rp
dj4KPGRpdj6gPC9kaXY+CjxkaXY+VGhlIGZvbGxvd2luZyBpcyB0aGUgb2Zvbm8gZGVidWcgbWVz
c2FnZXM6PC9kaXY+CjxkaXY+oDwvZGl2Pgo8ZGl2Pm9mb25vZFsxMDMzXTogUENVSTogJmx0OyBc
clxuXkJPT1Q6MjA1NzYxMjYsMCwwLDAsMjBcclxuPGJyPm9mb25vZFsxMDMzXTogUENVSTogJmx0
OyBcclxuXkRTRkxPV1JQVDowMDAwMDA2NCwwMDAwMDAwMCwwMDAwMDAwMCwwMDAwMDAwMDAwMDA1
NkRCLDAwMDAwMDAwMDAwMTI0NUEsMDAwM0U4MDAsMDAwRkEwMDBcclxuPGJyPm9mb25vZFsxMDMz
XTogUENVSTogJmx0OyBcclxuXlJTU0k6MThcclxuPGJyPgpvZm9ub2RbMTAzM106IFBDVUk6ICZs
dDsgXHJcbl5EU0ZMT1dSUFQ6MDAwMDAwNjYsMDAwMDAwMDAsMDAwMDAwMDAsMDAwMDAwMDAwMDAw
NTZEQiwwMDAwMDAwMDAwMDEyNDVBLDAwMDNFODAwLDAwMEZBMDAwXHJcbjxicj5vZm9ub2RbMTAz
M106IFBQUDogbGNwOiBwcHBjcF9nZW5lcmF0ZV9ldmVudDogY3VycmVudCBzdGF0ZSA5Ok9QRU5F
RDxicj48Zm9udCBzdHlsZT0iQkFDS0dST1VORC1DT0xPUjogI2ZmMDAwMCIgY29sb3I9IiNmZmZm
ZmYiPjxmb250IHN0eWxlPSJCQUNLR1JPVU5ELUNPTE9SOiAjZmZmZmZmIiBjb2xvcj0iI2ZmMDAw
MCI+b2Zvbm9kWzEwMzNdOiBQUFA6IGV2ZW50OiAxNCAoUlhKLSksIGFjdGlvbjogODIyNSwgbmV3
X3N0YXRlOiA1IChTVE9QUElORyk8L2ZvbnQ+PGZvbnQgc3R5bGU9IkJBQ0tHUk9VTkQtQ09MT1I6
ICNmZmZmZmYiPjxmb250IHN0eWxlPSJCQUNLR1JPVU5ELUNPTE9SOiAjZmYwMDAwIj48L2ZvbnQ+
PGJyPgo8L2ZvbnQ+PC9mb250Pm9mb25vZFsxMDMzXTogUFBQOiBsY3A6IHBwcGNwX2luaXRpYWxp
emVfcmVzdGFydF9jb3VudDogY3VycmVudCBzdGF0ZSA5Ok9QRU5FRDxicj5vZm9ub2RbMTAzM106
IFBQUDogbGNwOiBwcHBjcF9zZW5kX3Rlcm1pbmF0ZV9yZXF1ZXN0OiBjdXJyZW50IHN0YXRlIDk6
T1BFTkVEPGJyPm9mb25vZFsxMDMzXTogUFBQOiBpcGNwOiBwcHBjcF9nZW5lcmF0ZV9ldmVudDog
Y3VycmVudCBzdGF0ZSA5Ok9QRU5FRDxicj4Kb2Zvbm9kWzEwMzNdOiBQUFA6IGV2ZW50OiAxIChE
b3duKSwgYWN0aW9uOiAyMDEsIG5ld19zdGF0ZTogMSAoU1RBUlRJTkcpPGJyPkVudGVyaW5nIG5l
dyBwaGFzZTogNTxicj48Zm9udCBjb2xvcj0iI2ZmMDAwMCI+b2Zvbm9kWzEwMzNdOiBwbHVnaW5z
L3VkZXYuYzpyZW1vdmVfbW9kZW0oKSAvZGV2aWNlcy92aXJ0dWFsL25ldC9wcHAwPGJyPjwvZm9u
dD5vZm9ub2RbMTAzM106IFBDVUk6ICZsdDsgXHJcbl5SU1NJOjE4XHJcbjxicj4Kb2Zvbm9kWzEw
MzNdOiBQUFA6IGxjcDogcHBwY3BfcHJvY2Vzc190ZXJtaW5hdGVfYWNrOiBjdXJyZW50IHN0YXRl
IDU6U1RPUFBJTkc8YnI+b2Zvbm9kWzEwMzNdOiBQUFA6IGxjcDogcHBwY3BfZ2VuZXJhdGVfZXZl
bnQ6IGN1cnJlbnQgc3RhdGUgNTpTVE9QUElORzxicj5vZm9ub2RbMTAzM106IFBQUDogZXZlbnQ6
IDExIChSVEEpLCBhY3Rpb246IDgwMywgbmV3X3N0YXRlOiAzIChTVE9QUEVEKTxicj4Kb2Zvbm9k
WzEwMzNdOiBQUFA6IGxjcDogcHBwY3BfdGhpc19sYXllcl9maW5pc2hlZDogY3VycmVudCBzdGF0
ZSAzOlNUT1BQRUQ8YnI+RW50ZXJpbmcgbmV3IHBoYXNlOiAwPGJyPm9mb25vZFsxMDMzXTogZHJp
dmVycy9hdG1vZGVtL2dwcnMtY29udGV4dC5jOnBwcF9kaXNjb25uZWN0KCkgPGJyPjxmb250IGNv
bG9yPSIjZmYwMDAwIj48Zm9udCBjb2xvcj0iIzAwMDAwMCI+b2Zvbm9kWzEwMzNdOiBNb2RlbTog
Jmd0OyBBVCtDR0RDT05UPTEsJnF1b3Q7SVAmcXVvdDssJnF1b3Q7aW50ZXJuZXQmcXVvdDtccjwv
Zm9udD48YnI+CjwvZm9udD5vZm9ub2RbMTAzM106IFBDVUk6ICZsdDsgXHJcbl5EU0ZMT1dSUFQ6
MDAwMDAwNjgsMDAwMDAwNEUsMDAwMDAwNjgsMDAwMDAwMDAwMDAwNTc3NywwMDAwMDAwMDAwMDEy
NTJBLDAwMDNFODAwLDAwMEZBMDAwXHJcbjxicj5vZm9ub2RbMTAzM106IFBDVUk6ICZsdDsgXHJc
bl5NT0RFOjUsNVxyXG48YnI+b2Zvbm9kWzEwMzNdOiBQQ1VJOiAmbHQ7IFxyXG5eRFNGTE9XUlBU
OjAwMDAwMDZBLDAwMDAwMDAwLDAwMDAwMDAwLDAwMDAwMDAwMDAwMDU3NzcsMDAwMDAwMDAwMDAx
MjUyQSwwMDAwMDAwMCwwMDAwMDAwMFxyXG48YnI+Cm9mb25vZFsxMDMzXTogUENVSTogJmx0OyBc
clxuXlJTU0k6MThcclxuPGJyPm9mb25vZFsxMDMzXTogUENVSTogJmx0OyBcclxuXk1PREU6NSw0
XHJcbjxicj5vZm9ub2RbMTAzM106IE1vZGVtOiAmbHQ7IFxyXG5OTyBDQVJSSUVSXHJcbjxicj5v
Zm9ub2RbMTAzM106IHNyYy9ncHJzLmM6cHJpX2FjdGl2YXRlX2NhbGxiYWNrKCkgMHg5NGQ3NDIw
IChudWxsKTxicj5vZm9ub2RbMTAzM106IHNyYy9ncHJzLmM6cHJpX2FjdGl2YXRlX2NhbGxiYWNr
KCkgQWN0aXZhdGluZyBjb250ZXh0IGZhaWxlZCB3aXRoIGVycm9yOiBVbmtub3duIGVycm9yIHR5
cGU8YnI+Cm9mb25vZFsxMDMzXTogcGx1Z2lucy9odWF3ZWkuYzpodWF3ZWlfZGlzY29ubmVjdCgp
IDxicj5vZm9ub2RbMTAzM106IHNyYy9ncHJzLmM6Z3Byc19jb250ZXh0X3JlbW92ZSgpIGF0b206
IDB4OTRkMmVlMDxicj5vZm9ub2RbMTAzM106IGRyaXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRleHQu
YzphdF9ncHJzX2NvbnRleHRfcmVtb3ZlKCkgPGJyPm9mb25vZFsxMDMzXTogc3JjL21vZGVtLmM6
Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg5NGQ0MDcwIHByb3BlcnR5IE1vZGVtPGJyPgpv
Zm9ub2RbMTAzM106IHBsdWdpbnMvaHVhd2VpLmM6b3Blbl9kZXZpY2UoKSBNb2RlbSAvZGV2L3R0
eVVTQjA8YnI+b2Zvbm9kWzEwMzNdOiBSZW9wZW5lZCBHUFJTIGNvbnRleHQgY2hhbm5lbDxicj5v
Zm9ub2RbMTAzM106IFBDVUk6ICZsdDsgXHJcbl5SU1NJOjE4XHJcbjxicj5vZm9ub2RbMTAzM106
IFBDVUk6ICZsdDsgXHJcbitDUkVHOiAxLCAyODI5LCAxMTk3RjhGXHJcblxyXG4rQ0dSRUc6IDEs
IDI4MjksIDExOTdGOEZcclxuPGJyPgo8YnI+QlI8L2Rpdj4KPGRpdj6gPC9kaXY+CjxkaXY+RWx0
b248L2Rpdj4K

--===============4549324784100756487==--

