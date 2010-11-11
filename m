Content-Type: multipart/mixed; boundary="===============8209248637741697466=="
MIME-Version: 1.0
From: =?unknown-8bit?b?0KTRjNC+0LTQvtGA?= <nobodydead@gmail.com>
Subject: Re: PPP disconnected via Huawei modem
Date: Thu, 11 Nov 2010 08:32:41 +0000
Message-ID: <AANLkTikEFbfPtVpwPxxZiW5OMnyWEWRK+DsfNsc1c+Lk@mail.gmail.com>
In-Reply-To: <AANLkTimyMY0Y3hf7wA=rJghB5MtVLgeji7wQ+VUr9anf@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8209248637741697466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/11/11 Chen Yuwei <yuwachen@gmail.com>

> Hi,
>
> I use MeeGo NB 10/26 release to browse some website via Huawei modem,
> The PPP connection is disconnected when recieve a PPP event (RXJ-).
> Then the PPP can not be connected anymore. Why?
> What condition does ofono recieve this event?
> The ofono also recieved udev event "remove" and removed the huawei modem.
> But I does not pull out the modem.
> What condition does udev send the "remove" event?
>
> The following is the ofono debug messages:
>
> ofonod[1033]: PCUI: < \r\n^BOOT:20576126,0,0,0,20\r\n
> ofonod[1033]: PCUI: <
> \r\n^DSFLOWRPT:00000064,00000000,00000000,00000000000056DB,00000000000124=
5A,0003E800,000FA000\r\n
> ofonod[1033]: PCUI: < \r\n^RSSI:18\r\n
> ofonod[1033]: PCUI: <
> \r\n^DSFLOWRPT:00000066,00000000,00000000,00000000000056DB,00000000000124=
5A,0003E800,000FA000\r\n
> ofonod[1033]: PPP: lcp: pppcp_generate_event: current state 9:OPENED
> ofonod[1033]: PPP: event: 14 (RXJ-), action: 8225, new_state: 5 (STOPPING)
> ofonod[1033]: PPP: lcp: pppcp_initialize_restart_count: current state
> 9:OPENED
> ofonod[1033]: PPP: lcp: pppcp_send_terminate_request: current state
> 9:OPENED
> ofonod[1033]: PPP: ipcp: pppcp_generate_event: current state 9:OPENED
> ofonod[1033]: PPP: event: 1 (Down), action: 201, new_state: 1 (STARTING)
> Entering new phase: 5
> ofonod[1033]: plugins/udev.c:remove_modem() /devices/virtual/net/ppp0
> ofonod[1033]: PCUI: < \r\n^RSSI:18\r\n
> ofonod[1033]: PPP: lcp: pppcp_process_terminate_ack: current state
> 5:STOPPING
> ofonod[1033]: PPP: lcp: pppcp_generate_event: current state 5:STOPPING
> ofonod[1033]: PPP: event: 11 (RTA), action: 803, new_state: 3 (STOPPED)
> ofonod[1033]: PPP: lcp: pppcp_this_layer_finished: current state 3:STOPPED
> Entering new phase: 0
> ofonod[1033]: drivers/atmodem/gprs-context.c:ppp_disconnect()
> ofonod[1033]: Modem: > AT+CGDCONT=3D1,"IP","internet"\r
> ofonod[1033]: PCUI: <
> \r\n^DSFLOWRPT:00000068,0000004E,00000068,0000000000005777,00000000000125=
2A,0003E800,000FA000\r\n
> ofonod[1033]: PCUI: < \r\n^MODE:5,5\r\n
> ofonod[1033]: PCUI: <
> \r\n^DSFLOWRPT:0000006A,00000000,00000000,0000000000005777,00000000000125=
2A,00000000,00000000\r\n
> ofonod[1033]: PCUI: < \r\n^RSSI:18\r\n
> ofonod[1033]: PCUI: < \r\n^MODE:5,4\r\n
> ofonod[1033]: Modem: < \r\nNO CARRIER\r\n
> ofonod[1033]: src/gprs.c:pri_activate_callback() 0x94d7420 (null)
> ofonod[1033]: src/gprs.c:pri_activate_callback() Activating context failed
> with error: Unknown error type
> ofonod[1033]: plugins/huawei.c:huawei_disconnect()
> ofonod[1033]: src/gprs.c:gprs_context_remove() atom: 0x94d2ee0
> ofonod[1033]: drivers/atmodem/gprs-context.c:at_gprs_context_remove()
> ofonod[1033]: src/modem.c:get_modem_property() modem 0x94d4070 property
> Modem
> ofonod[1033]: plugins/huawei.c:open_device() Modem /dev/ttyUSB0
> ofonod[1033]: Reopened GPRS context channel
> ofonod[1033]: PCUI: < \r\n^RSSI:18\r\n
> ofonod[1033]: PCUI: < \r\n+CREG: 1, 2829, 1197F8F\r\n\r\n+CGREG: 1, 2829,
> 1197F8F\r\n
>
> BR
>
> Elton
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>
>

http://www.mail-archive.com/ofono(a)ofono.org/msg05056.html

Look at this thread.
Same problem

--===============8209248637741697466==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+MjAxMC8xMS8xMSBDaGVuIFl1d2VpIDxz
cGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOnl1d2FjaGVuQGdtYWlsLmNvbSI+eXV3
YWNoZW5AZ21haWwuY29tPC9hPiZndDs8L3NwYW4+PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFp
bF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNv
bGlkO3BhZGRpbmctbGVmdDoxZXg7Ij4KPHA+SGksPGJyPqA8YnI+SSB1c2UgTWVlR28gTkIgMTAv
MjYgcmVsZWFzZSB0byBicm93c2Ugc29tZSB3ZWJzaXRlIHZpYSBIdWF3ZWkgbW9kZW0sPGJyPlRo
ZSBQUFAgY29ubmVjdGlvbiBpcyBkaXNjb25uZWN0ZWQgd2hlbiByZWNpZXZlIGEgUFBQIGV2ZW50
IChSWEotKS48YnI+VGhlbiB0aGUgUFBQIGNhbiBub3QgYmUgY29ubmVjdGVkIGFueW1vcmUuIFdo
eT88YnI+V2hhdCBjb25kaXRpb24gZG9lcyBvZm9ubyByZWNpZXZlIHRoaXMgZXZlbnQ/PGJyPgoK
VGhlIG9mb25vIGFsc28gcmVjaWV2ZWQgdWRldiBldmVudCAmcXVvdDtyZW1vdmUmcXVvdDsgYW5k
IHJlbW92ZWQgdGhlIGh1YXdlaSBtb2RlbS48YnI+QnV0IEkgZG9lcyBub3QgcHVsbCBvdXQgdGhl
IG1vZGVtLjxicj5XaGF0IGNvbmRpdGlvbiBkb2VzIHVkZXYgc2VuZCB0aGUgJnF1b3Q7cmVtb3Zl
JnF1b3Q7IGV2ZW50Pzxicj6gPGJyPlRoZSBmb2xsb3dpbmcgaXMgdGhlIG9mb25vIGRlYnVnIG1l
c3NhZ2VzOjxicj4KCqA8YnI+b2Zvbm9kWzEwMzNdOiBQQ1VJOiAmbHQ7IFxyXG5eQk9PVDoyMDU3
NjEyNiwwLDAsMCwyMFxyXG48YnI+b2Zvbm9kWzEwMzNdOiBQQ1VJOiAmbHQ7IFxyXG5eRFNGTE9X
UlBUOjAwMDAwMDY0LDAwMDAwMDAwLDAwMDAwMDAwLDAwMDAwMDAwMDAwMDU2REIsMDAwMDAwMDAw
MDAxMjQ1QSwwMDAzRTgwMCwwMDBGQTAwMFxyXG48YnI+b2Zvbm9kWzEwMzNdOiBQQ1VJOiAmbHQ7
IFxyXG5eUlNTSToxOFxyXG48YnI+CgpvZm9ub2RbMTAzM106IFBDVUk6ICZsdDsgXHJcbl5EU0ZM
T1dSUFQ6MDAwMDAwNjYsMDAwMDAwMDAsMDAwMDAwMDAsMDAwMDAwMDAwMDAwNTZEQiwwMDAwMDAw
MDAwMDEyNDVBLDAwMDNFODAwLDAwMEZBMDAwXHJcbjxicj5vZm9ub2RbMTAzM106IFBQUDogbGNw
OiBwcHBjcF9nZW5lcmF0ZV9ldmVudDogY3VycmVudCBzdGF0ZSA5Ok9QRU5FRDxicj5vZm9ub2Rb
MTAzM106IFBQUDogZXZlbnQ6IDE0IChSWEotKSwgYWN0aW9uOiA4MjI1LCBuZXdfc3RhdGU6IDUg
KFNUT1BQSU5HKTxicj4KCm9mb25vZFsxMDMzXTogUFBQOiBsY3A6IHBwcGNwX2luaXRpYWxpemVf
cmVzdGFydF9jb3VudDogY3VycmVudCBzdGF0ZSA5Ok9QRU5FRDxicj5vZm9ub2RbMTAzM106IFBQ
UDogbGNwOiBwcHBjcF9zZW5kX3Rlcm1pbmF0ZV9yZXF1ZXN0OiBjdXJyZW50IHN0YXRlIDk6T1BF
TkVEPGJyPm9mb25vZFsxMDMzXTogUFBQOiBpcGNwOiBwcHBjcF9nZW5lcmF0ZV9ldmVudDogY3Vy
cmVudCBzdGF0ZSA5Ok9QRU5FRDxicj4KCm9mb25vZFsxMDMzXTogUFBQOiBldmVudDogMSAoRG93
biksIGFjdGlvbjogMjAxLCBuZXdfc3RhdGU6IDEgKFNUQVJUSU5HKTxicj5FbnRlcmluZyBuZXcg
cGhhc2U6IDU8YnI+b2Zvbm9kWzEwMzNdOiBwbHVnaW5zL3VkZXYuYzpyZW1vdmVfbW9kZW0oKSAv
ZGV2aWNlcy92aXJ0dWFsL25ldC9wcHAwPGJyPm9mb25vZFsxMDMzXTogUENVSTogJmx0OyBcclxu
XlJTU0k6MThcclxuPGJyPm9mb25vZFsxMDMzXTogUFBQOiBsY3A6IHBwcGNwX3Byb2Nlc3NfdGVy
bWluYXRlX2FjazogY3VycmVudCBzdGF0ZSA1OlNUT1BQSU5HPGJyPgoKb2Zvbm9kWzEwMzNdOiBQ
UFA6IGxjcDogcHBwY3BfZ2VuZXJhdGVfZXZlbnQ6IGN1cnJlbnQgc3RhdGUgNTpTVE9QUElORzxi
cj5vZm9ub2RbMTAzM106IFBQUDogZXZlbnQ6IDExIChSVEEpLCBhY3Rpb246IDgwMywgbmV3X3N0
YXRlOiAzIChTVE9QUEVEKTxicj5vZm9ub2RbMTAzM106IFBQUDogbGNwOiBwcHBjcF90aGlzX2xh
eWVyX2ZpbmlzaGVkOiBjdXJyZW50IHN0YXRlIDM6U1RPUFBFRDxicj4KCkVudGVyaW5nIG5ldyBw
aGFzZTogMDxicj5vZm9ub2RbMTAzM106IGRyaXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRleHQuYzpw
cHBfZGlzY29ubmVjdCgpIDxicj5vZm9ub2RbMTAzM106IE1vZGVtOiAmZ3Q7IEFUK0NHRENPTlQ9
MSwmcXVvdDtJUCZxdW90OywmcXVvdDtpbnRlcm5ldCZxdW90O1xyPGJyPm9mb25vZFsxMDMzXTog
UENVSTogJmx0OyBcclxuXkRTRkxPV1JQVDowMDAwMDA2OCwwMDAwMDA0RSwwMDAwMDA2OCwwMDAw
MDAwMDAwMDA1Nzc3LDAwMDAwMDAwMDAwMTI1MkEsMDAwM0U4MDAsMDAwRkEwMDBcclxuPGJyPgoK
b2Zvbm9kWzEwMzNdOiBQQ1VJOiAmbHQ7IFxyXG5eTU9ERTo1LDVcclxuPGJyPm9mb25vZFsxMDMz
XTogUENVSTogJmx0OyBcclxuXkRTRkxPV1JQVDowMDAwMDA2QSwwMDAwMDAwMCwwMDAwMDAwMCww
MDAwMDAwMDAwMDA1Nzc3LDAwMDAwMDAwMDAwMTI1MkEsMDAwMDAwMDAsMDAwMDAwMDBcclxuPGJy
Pm9mb25vZFsxMDMzXTogUENVSTogJmx0OyBcclxuXlJTU0k6MThcclxuPGJyPm9mb25vZFsxMDMz
XTogUENVSTogJmx0OyBcclxuXk1PREU6NSw0XHJcbjxicj4KCm9mb25vZFsxMDMzXTogTW9kZW06
ICZsdDsgXHJcbk5PIENBUlJJRVJcclxuPGJyPm9mb25vZFsxMDMzXTogc3JjL2dwcnMuYzpwcmlf
YWN0aXZhdGVfY2FsbGJhY2soKSAweDk0ZDc0MjAgKG51bGwpPGJyPm9mb25vZFsxMDMzXTogc3Jj
L2dwcnMuYzpwcmlfYWN0aXZhdGVfY2FsbGJhY2soKSBBY3RpdmF0aW5nIGNvbnRleHQgZmFpbGVk
IHdpdGggZXJyb3I6IFVua25vd24gZXJyb3IgdHlwZTxicj4KCm9mb25vZFsxMDMzXTogcGx1Z2lu
cy9odWF3ZWkuYzpodWF3ZWlfZGlzY29ubmVjdCgpIDxicj5vZm9ub2RbMTAzM106IHNyYy9ncHJz
LmM6Z3Byc19jb250ZXh0X3JlbW92ZSgpIGF0b206IDB4OTRkMmVlMDxicj5vZm9ub2RbMTAzM106
IGRyaXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRleHQuYzphdF9ncHJzX2NvbnRleHRfcmVtb3ZlKCkg
PGJyPm9mb25vZFsxMDMzXTogc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0g
MHg5NGQ0MDcwIHByb3BlcnR5IE1vZGVtPGJyPgoKb2Zvbm9kWzEwMzNdOiBwbHVnaW5zL2h1YXdl
aS5jOm9wZW5fZGV2aWNlKCkgTW9kZW0gL2Rldi90dHlVU0IwPGJyPm9mb25vZFsxMDMzXTogUmVv
cGVuZWQgR1BSUyBjb250ZXh0IGNoYW5uZWw8YnI+b2Zvbm9kWzEwMzNdOiBQQ1VJOiAmbHQ7IFxy
XG5eUlNTSToxOFxyXG48YnI+b2Zvbm9kWzEwMzNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JFRzogMSwg
MjgyOSwgMTE5N0Y4RlxyXG5cclxuK0NHUkVHOiAxLCAyODI5LCAxMTk3RjhGXHJcbjwvcD4KCgo8
cD5CUjxicj6gPGJyPkVsdG9uPC9wPgo8YnI+X19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX188YnI+Cm9mb25vIG1haWxpbmcgbGlzdDxicj4KPGEgaHJlZj0ibWFp
bHRvOm9mb25vQG9mb25vLm9yZyI+b2Zvbm9Ab2Zvbm8ub3JnPC9hPjxicj4KPGEgaHJlZj0iaHR0
cDovL2xpc3RzLm9mb25vLm9yZy9saXN0aW5mby9vZm9ubyIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6
Ly9saXN0cy5vZm9uby5vcmcvbGlzdGluZm8vb2Zvbm88L2E+PGJyPgo8YnI+PC9ibG9ja3F1b3Rl
PjwvZGl2Pjxicj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxtZXRhIGh0dHAtZXF1aXY9ImNvbnRlbnQt
dHlwZSIgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij48YSBocmVmPSJodHRwOi8v
d3d3Lm1haWwtYXJjaGl2ZS5jb20vb2Zvbm9Ab2Zvbm8ub3JnL21zZzA1MDU2Lmh0bWwiPmh0dHA6
Ly93d3cubWFpbC1hcmNoaXZlLmNvbS9vZm9ub0BvZm9uby5vcmcvbXNnMDUwNTYuaHRtbDwvYT48
L2Rpdj4KPGRpdj48YnI+PC9kaXY+PGRpdj5Mb29rIGF0IHRoaXMgdGhyZWFkLjwvZGl2PjxkaXY+
U2FtZSBwcm9ibGVtPC9kaXY+Cg==

--===============8209248637741697466==--

