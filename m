Content-Type: multipart/mixed; boundary="===============0611394972922510584=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Issue where a non-active context remains active
Date: Sun, 15 Sep 2019 19:58:19 +0200
Message-ID: <CAHB-Pjn5jTt8TK=3gLmLNSEW2tzC+--jpgquvqFasxk0i+Xm1A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0611394972922510584==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I would like to discuss this issue before I try to fix it. I might not have
the full picture since I don't know how all modems work.


The context 4 gets activated:
Sep 15 16:06:00 daemon.debug ofonod[542]:
../git/src/gprs.c:ofono_gprs_cid_activated() cid 4
Sep 15 16:06:00 daemon.debug ofonod[542]:
../git/drivers/ubloxmodem/gprs-context.c:ublox_gprs_read_settings() cid 4
Sep 15 16:06:00 daemon.debug ofonod[542]:
../git/src/modem.c:get_modem_property() modem 0x1c7f9a0 property
NetworkInterface
Sep 15 16:06:00 daemon.debug ofonod[542]:
../git/src/gprs.c:pri_read_settings_callback() 0x1c82280
Sep 15 16:06:00 daemon.debug ofonod[542]:
../git/src/gprs.c:gprs_set_attached_property() 0x1c7d500 0 -> 1

---- 8< ---

Things get shaky

Sep 15 16:18:39 daemon.info ofonod[542]: Aux: < \r\n+CREG: 0\r\n
Sep 15 16:18:39 daemon.debug ofonod[542]:
../git/src/network.c:ofono_netreg_status_notify() /ublox_0 status 0 tech -1
lac -1 ci -1
Sep 15 16:18:39 daemon.debug ofonod[542]:
../git/src/network.c:current_operator_callback() 0x1c80408, 0x1c81e08
Sep 15 16:18:39 daemon.debug ofonod[542]:
../git/src/gprs.c:netreg_status_changed() 0 (unregistered)
Sep 15 16:18:39 daemon.debug ofonod[542]:
../git/src/gprs.c:gprs_netreg_update() attach: 0, driver_attached: 1
Sep 15 16:18:39 daemon.debug ofonod[542]:
../git/src/gprs.c:netreg_status_changed() 0 (unregistered)
Sep 15 16:18:39 daemon.debug ofonod[542]:
../git/src/gprs.c:gprs_netreg_update() attach: 0, driver_attached: 0
Sep 15 16:18:39 daemon.info ofonod[542]: Aux: > AT\r
Sep 15 16:18:39 daemon.info ofonod[542]: Aux: < \r\n+CIEV: 7,0\r\n
Sep 15 16:18:39 daemon.info ofonod[542]: Aux: < \r\nOK\r\n
Sep 15 16:18:39 daemon.info ofonod[542]: Aux: Finally woke up the modem

We detach the drivers...

Sep 15 16:18:39 daemon.info ofonod[542]: Aux: > AT+CGATT=3D0\r
Sep 15 16:18:39 daemon.info ofonod[542]: Aux: < \r\n+CGREG: 4\r\n
Sep 15 16:18:39 daemon.debug ofonod[542]:
../git/src/gprs.c:ofono_gprs_status_notify() /ublox_0 status unknown (4)

Gprs status becomes unknown. We are not considered attached anymore, we
call "release_active_contexts".
That call clears the context but DO NOT signal any change on D-Bus so it
will be considered alive...

Sep 15 16:18:39 daemon.debug ofonod[542]:
../git/src/gprs.c:gprs_set_attached_property() 0x1c7d500 1 -> 0

... But the connection manager gets the detached property changed so it
understands the context is not useful

----- 8< -----

Things stabilises...

Sep 15 16:19:11 daemon.info ofonod[542]: Aux: < \r\n+CGREG:
5,"4EE9","0000E06A",2,"01"\r\n
Sep 15 16:19:11 daemon.debug ofonod[542]:
../git/src/gprs.c:ofono_gprs_status_notify() /ublox_0 status roaming (5)
Sep 15 16:19:11 daemon.debug ofonod[542]:
../git/src/gprs.c:gprs_set_attached_property() 0x1c7d500 0 -> 1

We are now considered attached.
Remember that the context that was released internally above, but Active
was not signaled false on D-Bus,
The connection manager believes we are attached AND the context its up.
So its happy.  And actually the context is still up in the modem since we
did not try to bring it down...
But this is all unknown to ofono now since ofono forgot its cid above when
it was released...

----- 8< ----

Now the context goes down...

Sep 15 16:19:12 daemon.info ofonod[542]: Aux: < \r\n+CGEV: ME PDN DEACT
4\r\n
Sep 15 16:19:12 daemon.debug ofonod[542]:
../git/drivers/ubloxmodem/gprs-context.c:cgev_notify() cid 4, active cid: 4
Sep 15 16:19:12 daemon.debug ofonod[542]:
../git/src/gprs.c:ofono_gprs_context_deactivated() 0x1c5e8a0 0x1c7d500 4

It will not be found since the CID was lost when it was released. So
nothing is signalled on D-Bus. The connection manager
still believes the context is up ... but its not.. we are screwed.



So to summarise we do release context when we decide to de-attach.
We are then losing all information about the contexts, such as cid and if
its active.
Its not signalled on D-Bus so the old state remains.

Later on we attach again, the context is alive in the modem, but ofono
doesn't know. The connection manager
believes the context is active all the time.  Then the modem deactivates
the context, ofono has no idea which
context this is, and the connection manager will not get the information.

So how should we fix this without breaking anything..? :)

I was thinking:
1. when we do release_context we should update the Active property on D-Bus.
2. When we are attached again, we could call a list_contexts in case they
"survived" from the modem point of view. And we will reinitialise them on
the ofono side.

Any better suggestion?

Thanks in advance,
Richard

--===============0611394972922510584==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGksPGRpdj48YnI+PC9kaXY+PGRpdj5JIHdvdWxkIGxpa2UgdG8gZGlz
Y3VzcyB0aGlzIGlzc3VlIGJlZm9yZSBJIHRyeSB0byBmaXggaXQuIEkgbWlnaHQgbm90IGhhdmUg
dGhlIGZ1bGwgcGljdHVyZSBzaW5jZSBJIGRvbiYjMzk7dCBrbm93IGhvdyBhbGwgbW9kZW1zIHdv
cmsuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGUgY29udGV4dCA0
IGdldHMgYWN0aXZhdGVkOjwvZGl2PjxkaXY+U2VwIDE1IDE2OjA2OjAwIGRhZW1vbi5kZWJ1ZyBv
Zm9ub2RbNTQyXTogLi4vZ2l0L3NyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jaWRfYWN0aXZhdGVkKCkg
Y2lkIDQ8YnI+U2VwIDE1IDE2OjA2OjAwIGRhZW1vbi5kZWJ1ZyBvZm9ub2RbNTQyXTogLi4vZ2l0
L2RyaXZlcnMvdWJsb3htb2RlbS9ncHJzLWNvbnRleHQuYzp1YmxveF9ncHJzX3JlYWRfc2V0dGlu
Z3MoKSBjaWQgNDxicj5TZXAgMTUgMTY6MDY6MDAgZGFlbW9uLmRlYnVnIG9mb25vZFs1NDJdOiAu
Li9naXQvc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHgxYzdmOWEwIHBy
b3BlcnR5IE5ldHdvcmtJbnRlcmZhY2U8YnI+U2VwIDE1IDE2OjA2OjAwIGRhZW1vbi5kZWJ1ZyBv
Zm9ub2RbNTQyXTogLi4vZ2l0L3NyYy9ncHJzLmM6cHJpX3JlYWRfc2V0dGluZ3NfY2FsbGJhY2so
KSAweDFjODIyODA8YnI+U2VwIDE1IDE2OjA2OjAwIGRhZW1vbi5kZWJ1ZyBvZm9ub2RbNTQyXTog
Li4vZ2l0L3NyYy9ncHJzLmM6Z3Byc19zZXRfYXR0YWNoZWRfcHJvcGVydHkoKSAweDFjN2Q1MDAg
MCAtJmd0OyAxPGJyPjxicj48L2Rpdj48ZGl2Pi0tLS0gOCZsdDsgLS0tPC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj5UaGluZ3MgZ2V0IHNoYWt5PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5TZXAg
MTUgMTY6MTg6MzkgPGEgaHJlZj0iaHR0cDovL2RhZW1vbi5pbmZvIj5kYWVtb24uaW5mbzwvYT4g
b2Zvbm9kWzU0Ml06IEF1eDogJmx0OyBcclxuK0NSRUc6IDBcclxuPGJyPlNlcCAxNSAxNjoxODoz
OSBkYWVtb24uZGVidWcgb2Zvbm9kWzU0Ml06IC4uL2dpdC9zcmMvbmV0d29yay5jOm9mb25vX25l
dHJlZ19zdGF0dXNfbm90aWZ5KCkgL3VibG94XzAgc3RhdHVzIDAgdGVjaCAtMSBsYWMgLTEgY2kg
LTE8YnI+U2VwIDE1IDE2OjE4OjM5IGRhZW1vbi5kZWJ1ZyBvZm9ub2RbNTQyXTogLi4vZ2l0L3Ny
Yy9uZXR3b3JrLmM6Y3VycmVudF9vcGVyYXRvcl9jYWxsYmFjaygpIDB4MWM4MDQwOCwgMHgxYzgx
ZTA4PGJyPlNlcCAxNSAxNjoxODozOSBkYWVtb24uZGVidWcgb2Zvbm9kWzU0Ml06IC4uL2dpdC9z
cmMvZ3Bycy5jOm5ldHJlZ19zdGF0dXNfY2hhbmdlZCgpIDAgKHVucmVnaXN0ZXJlZCk8YnI+U2Vw
IDE1IDE2OjE4OjM5IGRhZW1vbi5kZWJ1ZyBvZm9ub2RbNTQyXTogLi4vZ2l0L3NyYy9ncHJzLmM6
Z3Byc19uZXRyZWdfdXBkYXRlKCkgYXR0YWNoOiAwLCBkcml2ZXJfYXR0YWNoZWQ6IDE8YnI+U2Vw
IDE1IDE2OjE4OjM5IGRhZW1vbi5kZWJ1ZyBvZm9ub2RbNTQyXTogLi4vZ2l0L3NyYy9ncHJzLmM6
bmV0cmVnX3N0YXR1c19jaGFuZ2VkKCkgMCAodW5yZWdpc3RlcmVkKTxicj5TZXAgMTUgMTY6MTg6
MzkgZGFlbW9uLmRlYnVnIG9mb25vZFs1NDJdOiAuLi9naXQvc3JjL2dwcnMuYzpncHJzX25ldHJl
Z191cGRhdGUoKSBhdHRhY2g6IDAsIGRyaXZlcl9hdHRhY2hlZDogMDxicj5TZXAgMTUgMTY6MTg6
MzkgPGEgaHJlZj0iaHR0cDovL2RhZW1vbi5pbmZvIj5kYWVtb24uaW5mbzwvYT4gb2Zvbm9kWzU0
Ml06IEF1eDogJmd0OyBBVFxyPGJyPlNlcCAxNSAxNjoxODozOSA8YSBocmVmPSJodHRwOi8vZGFl
bW9uLmluZm8iPmRhZW1vbi5pbmZvPC9hPiBvZm9ub2RbNTQyXTogQXV4OiAmbHQ7IFxyXG4rQ0lF
VjogNywwXHJcbjxicj5TZXAgMTUgMTY6MTg6MzkgPGEgaHJlZj0iaHR0cDovL2RhZW1vbi5pbmZv
Ij5kYWVtb24uaW5mbzwvYT4gb2Zvbm9kWzU0Ml06IEF1eDogJmx0OyBcclxuT0tcclxuPGJyPlNl
cCAxNSAxNjoxODozOSA8YSBocmVmPSJodHRwOi8vZGFlbW9uLmluZm8iPmRhZW1vbi5pbmZvPC9h
PiBvZm9ub2RbNTQyXTogQXV4OiBGaW5hbGx5IHdva2UgdXAgdGhlIG1vZGVtPC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj5XZSBkZXRhY2ggdGhlIGRyaXZlcnMuLi48L2Rpdj48ZGl2Pjxicj5TZXAg
MTUgMTY6MTg6MzkgPGEgaHJlZj0iaHR0cDovL2RhZW1vbi5pbmZvIj5kYWVtb24uaW5mbzwvYT4g
b2Zvbm9kWzU0Ml06IEF1eDogJmd0OyBBVCtDR0FUVD0wXHI8YnI+U2VwIDE1IDE2OjE4OjM5IDxh
IGhyZWY9Imh0dHA6Ly9kYWVtb24uaW5mbyI+ZGFlbW9uLmluZm88L2E+IG9mb25vZFs1NDJdOiBB
dXg6ICZsdDsgXHJcbitDR1JFRzogNFxyXG48YnI+U2VwIDE1IDE2OjE4OjM5IGRhZW1vbi5kZWJ1
ZyBvZm9ub2RbNTQyXTogLi4vZ2l0L3NyYy9ncHJzLmM6b2Zvbm9fZ3Byc19zdGF0dXNfbm90aWZ5
KCkgL3VibG94XzAgc3RhdHVzIHVua25vd24gKDQpPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5H
cHJzIHN0YXR1cyBiZWNvbWVzIHVua25vd24uIFdlIGFyZSBub3QgY29uc2lkZXJlZCBhdHRhY2hl
ZCBhbnltb3JlLCB3ZSBjYWxsICZxdW90O3JlbGVhc2VfYWN0aXZlX2NvbnRleHRzJnF1b3Q7Ljwv
ZGl2PjxkaXY+VGhhdCBjYWxsIGNsZWFycyB0aGUgY29udGV4dCBidXQgRE8gTk9UIHNpZ25hbCBh
bnkgY2hhbmdlIG9uIEQtQnVzIHNvIGl0IHdpbGwgYmUgY29uc2lkZXJlZCBhbGl2ZS4uLjwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+U2VwIDE1IDE2OjE4OjM5IGRhZW1vbi5kZWJ1ZyBvZm9ub2Rb
NTQyXTogLi4vZ2l0L3NyYy9ncHJzLmM6Z3Byc19zZXRfYXR0YWNoZWRfcHJvcGVydHkoKSAweDFj
N2Q1MDAgMSAtJmd0OyAwPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj4uLi4gQnV0IHRoZSBjb25u
ZWN0aW9uIG1hbmFnZXIgZ2V0cyB0aGUgZGV0YWNoZWQgcHJvcGVydHkgY2hhbmdlZCBzbyBpdCB1
bmRlcnN0YW5kcyB0aGUgY29udGV4dCBpcyBub3QgdXNlZnVsPC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj4tLS0tLSA4Jmx0OyAtLS0tLTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhpbmdzIHN0
YWJpbGlzZXMuLi48L2Rpdj48ZGl2Pjxicj5TZXAgMTUgMTY6MTk6MTEgPGEgaHJlZj0iaHR0cDov
L2RhZW1vbi5pbmZvIj5kYWVtb24uaW5mbzwvYT4gb2Zvbm9kWzU0Ml06IEF1eDogJmx0OyBcclxu
K0NHUkVHOiA1LCZxdW90OzRFRTkmcXVvdDssJnF1b3Q7MDAwMEUwNkEmcXVvdDssMiwmcXVvdDsw
MSZxdW90O1xyXG48YnI+U2VwIDE1IDE2OjE5OjExIGRhZW1vbi5kZWJ1ZyBvZm9ub2RbNTQyXTog
Li4vZ2l0L3NyYy9ncHJzLmM6b2Zvbm9fZ3Byc19zdGF0dXNfbm90aWZ5KCkgL3VibG94XzAgc3Rh
dHVzIHJvYW1pbmcgKDUpPGJyPlNlcCAxNSAxNjoxOToxMSBkYWVtb24uZGVidWcgb2Zvbm9kWzU0
Ml06IC4uL2dpdC9zcmMvZ3Bycy5jOmdwcnNfc2V0X2F0dGFjaGVkX3Byb3BlcnR5KCkgMHgxYzdk
NTAwIDAgLSZndDsgMTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+V2UgYXJlIG5vdyBjb25zaWRl
cmVkIGF0dGFjaGVkLjwvZGl2PjxkaXY+UmVtZW1iZXIgdGhhdCB0aGUgY29udGV4dCB0aGF0IHdh
cyByZWxlYXNlZCBpbnRlcm5hbGx5IGFib3ZlLCBidXQgQWN0aXZlIHdhcyBub3Qgc2lnbmFsZWQg
ZmFsc2Ugb24gRC1CdXMsPC9kaXY+PGRpdj5UaGUgY29ubmVjdGlvbiBtYW5hZ2VyIGJlbGlldmVz
IHdlIGFyZSBhdHRhY2hlZCBBTkQgdGhlIGNvbnRleHQgaXRzIHVwLjwvZGl2PjxkaXY+U28gaXRz
IGhhcHB5LsKgIEFuZCBhY3R1YWxseSB0aGUgY29udGV4dCBpcyBzdGlsbCB1cCBpbiB0aGUgbW9k
ZW0gc2luY2Ugd2UgZGlkIG5vdCB0cnkgdG8gYnJpbmcgaXQgZG93bi4uLjwvZGl2PjxkaXY+QnV0
IHRoaXMgaXMgYWxsIHVua25vd24gdG8gb2Zvbm8gbm93IHNpbmNlIG9mb25vIGZvcmdvdCBpdHMg
Y2lkIGFib3ZlIHdoZW4gaXQgd2FzIHJlbGVhc2VkLi4uPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj4tLS0tLSA4Jmx0OyAtLS0tPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5Ob3cgdGhlIGNvbnRl
eHQgZ29lcyBkb3duLi4uPC9kaXY+PGRpdj48YnI+U2VwIDE1IDE2OjE5OjEyIDxhIGhyZWY9Imh0
dHA6Ly9kYWVtb24uaW5mbyI+ZGFlbW9uLmluZm88L2E+IG9mb25vZFs1NDJdOiBBdXg6ICZsdDsg
XHJcbitDR0VWOiBNRSBQRE4gREVBQ1QgNFxyXG48YnI+U2VwIDE1IDE2OjE5OjEyIGRhZW1vbi5k
ZWJ1ZyBvZm9ub2RbNTQyXTogLi4vZ2l0L2RyaXZlcnMvdWJsb3htb2RlbS9ncHJzLWNvbnRleHQu
YzpjZ2V2X25vdGlmeSgpIGNpZCA0LCBhY3RpdmUgY2lkOiA0PGJyPlNlcCAxNSAxNjoxOToxMiBk
YWVtb24uZGVidWcgb2Zvbm9kWzU0Ml06IC4uL2dpdC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29u
dGV4dF9kZWFjdGl2YXRlZCgpIDB4MWM1ZThhMCAweDFjN2Q1MDAgNDwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+SXQgd2lsbCBub3QgYmUgZm91bmQgc2luY2UgdGhlIENJRCB3YXMgbG9zdCB3aGVu
IGl0IHdhcyByZWxlYXNlZC4gU28gbm90aGluZyBpcyBzaWduYWxsZWQgb24gRC1CdXMuIFRoZSBj
b25uZWN0aW9uIG1hbmFnZXI8L2Rpdj48ZGl2PnN0aWxsIGJlbGlldmVzIHRoZSBjb250ZXh0IGlz
IHVwIC4uLiBidXQgaXRzIG5vdC4uIHdlIGFyZSBzY3Jld2VkLjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+U28gdG8gc3VtbWFyaXNlIHdlIGRv
IHJlbGVhc2UgY29udGV4dCB3aGVuIHdlIGRlY2lkZSB0byBkZS1hdHRhY2guPC9kaXY+PGRpdj5X
ZSBhcmUgdGhlbiBsb3NpbmcgYWxsIGluZm9ybWF0aW9uIGFib3V0IHRoZSBjb250ZXh0cywgc3Vj
aCBhcyBjaWQgYW5kIGlmIGl0cyBhY3RpdmUuPC9kaXY+PGRpdj5JdHMgbm90IHNpZ25hbGxlZCBv
biBELUJ1cyBzbyB0aGUgb2xkIHN0YXRlIHJlbWFpbnMuwqA8L2Rpdj48ZGl2Pjxicj48L2Rpdj48
ZGl2PkxhdGVyIG9uIHdlIGF0dGFjaCBhZ2FpbiwgdGhlIGNvbnRleHQgaXMgYWxpdmUgaW4gdGhl
IG1vZGVtLCBidXQgb2Zvbm8gZG9lc24mIzM5O3Qga25vdy4gVGhlIGNvbm5lY3Rpb24gbWFuYWdl
cjwvZGl2PjxkaXY+YmVsaWV2ZXMgdGhlIGNvbnRleHQgaXMgYWN0aXZlIGFsbCB0aGUgdGltZS7C
oCBUaGVuIHRoZSBtb2RlbSBkZWFjdGl2YXRlcyB0aGUgY29udGV4dCwgb2Zvbm8gaGFzIG5vIGlk
ZWEgd2hpY2g8L2Rpdj48ZGl2PmNvbnRleHQgdGhpcyBpcywgYW5kIHRoZSBjb25uZWN0aW9uIG1h
bmFnZXIgd2lsbCBub3QgZ2V0IHRoZSBpbmZvcm1hdGlvbi48L2Rpdj48ZGl2Pjxicj48L2Rpdj48
ZGl2PlNvIGhvdyBzaG91bGQgd2UgZml4IHRoaXMgd2l0aG91dCBicmVha2luZyBhbnl0aGluZy4u
PyA6KTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSB3YXMgdGhpbmtpbmc6PC9kaXY+PGRpdj4x
LiB3aGVuIHdlIGRvIHJlbGVhc2VfY29udGV4dCB3ZSBzaG91bGQgdXBkYXRlIHRoZSBBY3RpdmUg
cHJvcGVydHkgb24gRC1CdXMuPC9kaXY+PGRpdj4yLiBXaGVuIHdlIGFyZSBhdHRhY2hlZCBhZ2Fp
biwgd2UgY291bGQgY2FsbCBhIGxpc3RfY29udGV4dHMgaW4gY2FzZSB0aGV5ICZxdW90O3N1cnZp
dmVkJnF1b3Q7IGZyb20gdGhlIG1vZGVtIHBvaW50IG9mIHZpZXcuIEFuZCB3ZSB3aWxsIHJlaW5p
dGlhbGlzZSB0aGVtIG9uIHRoZSBvZm9ubyBzaWRlLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
QW55IGJldHRlciBzdWdnZXN0aW9uPzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzIGlu
IGFkdmFuY2UsPC9kaXY+PGRpdj5SaWNoYXJkPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+
PC9kaXY+PC9kaXY+Cg==

--===============0611394972922510584==--

