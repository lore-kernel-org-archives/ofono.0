Content-Type: multipart/mixed; boundary="===============6902264678971219926=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: Re: Alcatel Onetouch X515 support
Date: Thu, 08 Nov 2012 17:43:05 +0100
Message-ID: <CABvLYuBU9h+RJuutiFf3EYaiydj2Rd2MQWKY0u2ZjhdOCGfaBg@mail.gmail.com>
In-Reply-To: <509BD307.2010108@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6902264678971219926==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,


> The SIM busy stuff is tricky.  oFono reads lots of files from the SIM
> before even checking CPIN.  So you need to check the CPIN SIM busy
> condition before signaling that the SIM is inserted.  As I said, check how
> other Qualcomm based devices are doing this.  E.g. Huawei, ZTE, etc.
>

I've checked this, and i think we're talking about different things. From
what i understand you're talking about the sim being busy at early sim
initialization (after enabling the modem it must wait for the sim to be
ready before notifying the core a sim is inserted).
I'm talking about the sim being busy right after entering the pin. The sim
is initialized, and "AT+CPIN?" returns " +CPIN: SIM PIN". Then i enter the
pin with AT+CPIN=3D"xxxx". Right after this the pin is checked with
"AT+CPIN?" and now it returns "+CME ERROR: 14".

In at_pin_send_cb i see that for ZTE the state is polled with
 at_util_sim_state_query_new, i think this also must be done for Alcatel.
And for huawei this should probably look at ^SIMST.

I've added a log showing the issue (reproduced with a huawei dongle)
ofonod[3481]: src/modem.c:modem_change_state() old state: 0, new state: 1
ofonod[3481]: plugins/huawei.c:huawei_pre_sim() 0x8bf3b00
ofonod[3481]: PCUI: > AT^USSDMODE?\r
ofonod[3481]: src/sim.c:ofono_sim_add_state_watch() 0x8bf8f20
ofonod[3481]: src/sim.c:ofono_sim_add_state_watch() 0x8bf8f20
ofonod[3481]: PCUI: < \r\n^USSDMODE: 1\r\n\r\nOK\r\n
ofonod[3481]: PCUI: > AT^DIALMODE?\r
ofonod[3481]: PCUI: < \r\n^DIALMODE:0,2\r\n\r\nOK\r\n
ofonod[3481]: Modem support (CDC support: NDIS port)
ofonod[3481]: PCUI: > AT+GCAP\r
ofonod[3481]: PCUI: < \r\n+CME ERROR: 100\r\n
ofonod[3481]: PCUI: > AT+CRSM=3D192,12258,0,0,255\r
ofonod[3481]: PCUI: < \r\n+CME ERROR: 11\r\n
ofonod[3481]: PCUI: > AT+CGMI\r
ofonod[3481]: PCUI: < \r\nHuawei Technologies Co., Ltd.\r\n\r\nOK\r\n
ofonod[3481]: PCUI: > AT+CRSM=3D192,28421,0,0,255\r
ofonod[3481]: PCUI: < \r\n+CME ERROR: 11\r\n
ofonod[3481]: PCUI: > AT+CGMM\r
ofonod[3481]: PCUI: < \r\nE369\r\n\r\nOK\r\n
ofonod[3481]: PCUI: > AT+CRSM=3D192,12037,0,0,255\r
ofonod[3481]: PCUI: < \r\n+CME ERROR: 11\r\n
ofonod[3481]: PCUI: > AT+CGMR\r
ofonod[3481]: PCUI: < \r\n41.102.18.00.00\r\n\r\nOK\r\n
ofonod[3481]: PCUI: > AT+CPIN?\r
ofonod[3481]: PCUI: < \r\n+CPIN: SIM PIN\r\n\r\nOK\r\n
ofonod[3481]: drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: SIM PIN
ofonod[3481]: drivers/atmodem/sim.c:at_pin_retries_query()
ofonod[3481]: PCUI: > AT+CGSN\r
ofonod[3481]: PCUI: < \r\n868414001268790\r\n\r\nOK\r\n
ofonod[3481]: PCUI: > AT^CPIN?\r
ofonod[3481]: PCUI: < \r\n^SRVST: 0\r\n
ofonod[3481]: PCUI: < \r\n^CPIN: SIM PIN,3,10,3,10,2\r\n\r\nOK\r\n
ofonod[3481]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter id=3D9,
val=3D10
ofonod[3481]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter id=3D1,
val=3D3
ofonod[3481]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter id=3D11,
val=3D10
ofonod[3481]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter id=3D4,
val=3D2
ofonod[3481]: PCUI: > AT+CPIN=3D"1111"\r
ofonod[3481]: PCUI: < \r\nOK\r\n
ofonod[3481]: PCUI: > AT+CPIN?\r
ofonod[3481]: PCUI: < \r\n+CME ERROR: 14\r\n
ofonod[3481]: Querying PIN authentication state failed
ofonod[3481]: PCUI: < \r\n^SIMST: 1,0\r\n
ofonod[3481]: plugins/huawei.c:simst_notify() 0 -> 1

Regards,
Cedric

--===============6902264678971219926==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2Pkhp
IERlbmlzLDwvZGl2PjxkaXY+oDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIg
c3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdC13aWR0aDoxcHg7Ym9y
ZGVyLWxlZnQtY29sb3I6cmdiKDIwNCwyMDQsMjA0KTtib3JkZXItbGVmdC1zdHlsZTpzb2xpZDtw
YWRkaW5nLWxlZnQ6MWV4Ij4KPGRpdj48ZGl2IGNsYXNzPSJoNSI+PGJsb2NrcXVvdGUgY2xhc3M9
ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0
LXdpZHRoOjFweDtib3JkZXItbGVmdC1jb2xvcjpyZ2IoMjA0LDIwNCwyMDQpO2JvcmRlci1sZWZ0
LXN0eWxlOnNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj4K
VGhlIFNJTSBidXN5IHN0dWZmIGlzIHRyaWNreS4goG9Gb25vIHJlYWRzIGxvdHMgb2YgZmlsZXMg
ZnJvbSB0aGUgU0lNIGJlZm9yZSBldmVuIGNoZWNraW5nIENQSU4uIKBTbyB5b3UgbmVlZCB0byBj
aGVjayB0aGUgQ1BJTiBTSU0gYnVzeSBjb25kaXRpb24gYmVmb3JlIHNpZ25hbGluZyB0aGF0IHRo
ZSBTSU0gaXMgaW5zZXJ0ZWQuIKBBcyBJIHNhaWQsIGNoZWNrIGhvdyBvdGhlciBRdWFsY29tbSBi
YXNlZCBkZXZpY2VzIGFyZSBkb2luZyB0aGlzLiCgRS5nLiBIdWF3ZWksIFpURSwgZXRjLjxicj4K
PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+SSYjMzk7dmUgY2hlY2tlZCB0aGlzLCBh
bmQgaSB0aGluayB3ZSYjMzk7cmUgdGFsa2luZyBhYm91dCBkaWZmZXJlbnQgdGhpbmdzLiBGcm9t
IHdoYXQgaSB1bmRlcnN0YW5kIHlvdSYjMzk7cmUgdGFsa2luZyBhYm91dCB0aGUgc2ltIGJlaW5n
IGJ1c3kgYXQgZWFybHkgc2ltIGluaXRpYWxpemF0aW9uIChhZnRlciBlbmFibGluZyB0aGUgbW9k
ZW0gaXQgbXVzdCB3YWl0IGZvciB0aGUgc2ltIHRvIGJlIHJlYWR5IGJlZm9yZSBub3RpZnlpbmcg
dGhlIGNvcmUgYSBzaW0gaXMgaW5zZXJ0ZWQpLqA8L2Rpdj4KPGRpdj5JJiMzOTttIHRhbGtpbmcg
YWJvdXQgdGhlIHNpbSBiZWluZyBidXN5IHJpZ2h0IGFmdGVyIGVudGVyaW5nIHRoZSBwaW4uIFRo
ZSBzaW0gaXMgaW5pdGlhbGl6ZWQsIGFuZCAmcXVvdDtBVCtDUElOPyZxdW90OyByZXR1cm5zICZx
dW90O6ArQ1BJTjogU0lNIFBJTiZxdW90Oy4gVGhlbiBpIGVudGVyIHRoZSBwaW4gd2l0aCBBVCtD
UElOPSZxdW90O3h4eHgmcXVvdDsuIFJpZ2h0IGFmdGVyIHRoaXMgdGhlIHBpbiBpcyBjaGVja2Vk
IHdpdGggJnF1b3Q7QVQrQ1BJTj8mcXVvdDsgYW5kIG5vdyBpdCByZXR1cm5zICZxdW90OytDTUUg
RVJST1I6IDE0JnF1b3Q7LjwvZGl2Pgo8ZGl2Pjxicj48L2Rpdj48ZGl2PkluIGF0X3Bpbl9zZW5k
X2NiIGkgc2VlIHRoYXQgZm9yIFpURSB0aGUgc3RhdGUgaXMgcG9sbGVkIHdpdGggoGF0X3V0aWxf
c2ltX3N0YXRlX3F1ZXJ5X25ldywgaSB0aGluayB0aGlzIGFsc28gbXVzdCBiZSBkb25lIGZvciBB
bGNhdGVsLiBBbmQgZm9yIGh1YXdlaSB0aGlzIHNob3VsZCBwcm9iYWJseSBsb29rIGF0oF5TSU1T
VC48L2Rpdj48ZGl2Pjxicj4KPC9kaXY+PGRpdj5JJiMzOTt2ZSBhZGRlZCBhIGxvZyBzaG93aW5n
IHRoZSBpc3N1ZSAocmVwcm9kdWNlZCB3aXRoIGEgaHVhd2VpIGRvbmdsZSk8L2Rpdj48ZGl2Pjxk
aXY+b2Zvbm9kWzM0ODFdOiBzcmMvbW9kZW0uYzptb2RlbV9jaGFuZ2Vfc3RhdGUoKSBvbGQgc3Rh
dGU6IDAsIG5ldyBzdGF0ZTogMTwvZGl2PjxkaXY+b2Zvbm9kWzM0ODFdOiBwbHVnaW5zL2h1YXdl
aS5jOmh1YXdlaV9wcmVfc2ltKCkgMHg4YmYzYjAwPC9kaXY+CjxkaXY+b2Zvbm9kWzM0ODFdOiBQ
Q1VJOiAmZ3Q7IEFUXlVTU0RNT0RFP1xyPC9kaXY+PGRpdj5vZm9ub2RbMzQ4MV06IHNyYy9zaW0u
YzpvZm9ub19zaW1fYWRkX3N0YXRlX3dhdGNoKCkgMHg4YmY4ZjIwPC9kaXY+PGRpdj5vZm9ub2Rb
MzQ4MV06IHNyYy9zaW0uYzpvZm9ub19zaW1fYWRkX3N0YXRlX3dhdGNoKCkgMHg4YmY4ZjIwPC9k
aXY+PGRpdj5vZm9ub2RbMzQ4MV06IFBDVUk6ICZsdDsgXHJcbl5VU1NETU9ERTogMVxyXG5cclxu
T0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzM0ODFdOiBQQ1VJOiAmZ3Q7IEFUXkRJQUxNT0RFP1xy
PC9kaXY+PGRpdj5vZm9ub2RbMzQ4MV06IFBDVUk6ICZsdDsgXHJcbl5ESUFMTU9ERTowLDJcclxu
XHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzM0ODFdOiBNb2RlbSBzdXBwb3J0IChDREMgc3Vw
cG9ydDogTkRJUyBwb3J0KTwvZGl2PjxkaXY+b2Zvbm9kWzM0ODFdOiBQQ1VJOiAmZ3Q7IEFUK0dD
QVBccjwvZGl2Pgo8ZGl2Pm9mb25vZFszNDgxXTogUENVSTogJmx0OyBcclxuK0NNRSBFUlJPUjog
MTAwXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzM0ODFdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDEy
MjU4LDAsMCwyNTVccjwvZGl2PjxkaXY+b2Zvbm9kWzM0ODFdOiBQQ1VJOiAmbHQ7IFxyXG4rQ01F
IEVSUk9SOiAxMVxyXG48L2Rpdj48ZGl2Pm9mb25vZFszNDgxXTogUENVSTogJmd0OyBBVCtDR01J
XHI8L2Rpdj4KPGRpdj5vZm9ub2RbMzQ4MV06IFBDVUk6ICZsdDsgXHJcbkh1YXdlaSBUZWNobm9s
b2dpZXMgQ28uLCBMdGQuXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszNDgxXTogUENV
STogJmd0OyBBVCtDUlNNPTE5MiwyODQyMSwwLDAsMjU1XHI8L2Rpdj48ZGl2Pm9mb25vZFszNDgx
XTogUENVSTogJmx0OyBcclxuK0NNRSBFUlJPUjogMTFcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzQ4
MV06IFBDVUk6ICZndDsgQVQrQ0dNTVxyPC9kaXY+CjxkaXY+b2Zvbm9kWzM0ODFdOiBQQ1VJOiAm
bHQ7IFxyXG5FMzY5XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszNDgxXTogUENVSTog
Jmd0OyBBVCtDUlNNPTE5MiwxMjAzNywwLDAsMjU1XHI8L2Rpdj48ZGl2Pm9mb25vZFszNDgxXTog
UENVSTogJmx0OyBcclxuK0NNRSBFUlJPUjogMTFcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzQ4MV06
IFBDVUk6ICZndDsgQVQrQ0dNUlxyPC9kaXY+CjxkaXY+b2Zvbm9kWzM0ODFdOiBQQ1VJOiAmbHQ7
IFxyXG40MS4xMDIuMTguMDAuMDBcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzM0ODFd
OiBQQ1VJOiAmZ3Q7IEFUK0NQSU4/XHI8L2Rpdj48ZGl2Pm9mb25vZFszNDgxXTogUENVSTogJmx0
OyBcclxuK0NQSU46IFNJTSBQSU5cclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzM0ODFd
OiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3Bpbl9jYigpIGNyc21fcGluX2NiOiBTSU0gUElO
PC9kaXY+CjxkaXY+b2Zvbm9kWzM0ODFdOiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfcGluX3Jl
dHJpZXNfcXVlcnkoKaA8L2Rpdj48ZGl2Pm9mb25vZFszNDgxXTogUENVSTogJmd0OyBBVCtDR1NO
XHI8L2Rpdj48ZGl2Pm9mb25vZFszNDgxXTogUENVSTogJmx0OyBcclxuODY4NDE0MDAxMjY4Nzkw
XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszNDgxXTogUENVSTogJmd0OyBBVF5DUElO
P1xyPC9kaXY+CjxkaXY+b2Zvbm9kWzM0ODFdOiBQQ1VJOiAmbHQ7IFxyXG5eU1JWU1Q6IDBcclxu
PC9kaXY+PGRpdj5vZm9ub2RbMzQ4MV06IFBDVUk6ICZsdDsgXHJcbl5DUElOOiBTSU0gUElOLDMs
MTAsMywxMCwyXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFszNDgxXTogZHJpdmVycy9h
dG1vZGVtL3NpbS5jOmh1YXdlaV9jcGluX2NiKCkgcmV0cnkgY291bnRlciBpZD05LCB2YWw9MTA8
L2Rpdj4KPGRpdj5vZm9ub2RbMzQ4MV06IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzpodWF3ZWlfY3Bp
bl9jYigpIHJldHJ5IGNvdW50ZXIgaWQ9MSwgdmFsPTM8L2Rpdj48ZGl2Pm9mb25vZFszNDgxXTog
ZHJpdmVycy9hdG1vZGVtL3NpbS5jOmh1YXdlaV9jcGluX2NiKCkgcmV0cnkgY291bnRlciBpZD0x
MSwgdmFsPTEwPC9kaXY+PGRpdj5vZm9ub2RbMzQ4MV06IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzpo
dWF3ZWlfY3Bpbl9jYigpIHJldHJ5IGNvdW50ZXIgaWQ9NCwgdmFsPTI8L2Rpdj4KPGRpdj5vZm9u
b2RbMzQ4MV06IFBDVUk6ICZndDsgQVQrQ1BJTj0mcXVvdDsxMTExJnF1b3Q7XHI8L2Rpdj48ZGl2
Pm9mb25vZFszNDgxXTogUENVSTogJmx0OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzQ4
MV06IFBDVUk6ICZndDsgQVQrQ1BJTj9ccjwvZGl2PjxkaXY+b2Zvbm9kWzM0ODFdOiBQQ1VJOiAm
bHQ7IFxyXG4rQ01FIEVSUk9SOiAxNFxyXG48L2Rpdj48ZGl2Pm9mb25vZFszNDgxXTogUXVlcnlp
bmcgUElOIGF1dGhlbnRpY2F0aW9uIHN0YXRlIGZhaWxlZDwvZGl2Pgo8ZGl2Pm9mb25vZFszNDgx
XTogUENVSTogJmx0OyBcclxuXlNJTVNUOiAxLDBcclxuPC9kaXY+PGRpdj5vZm9ub2RbMzQ4MV06
IHBsdWdpbnMvaHVhd2VpLmM6c2ltc3Rfbm90aWZ5KCkgMCAtJmd0OyAxPC9kaXY+PC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj5SZWdhcmRzLDwvZGl2PjxkaXY+Q2VkcmljPC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+CjxkaXY+PGJyPjwvZGl2PjwvZGl2
Pjxicj48L2Rpdj4K

--===============6902264678971219926==--

