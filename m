Content-Type: multipart/mixed; boundary="===============0445725926185522222=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [PATCH] gprs: update attached on netreg updates when running LTE
Date: Tue, 01 Oct 2019 22:14:30 +0200
Message-ID: <CAHB-Pjk52AqG5gMihjvVtKKa-QBSuaw4Sqiiac5Gy8wk-eHdRw@mail.gmail.com>
In-Reply-To: <20191001201051.21376-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0445725926185522222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hope this one applies ;-)

Here is a log showing when this issue happened, where a context was
registered before we got signaled
LTE tech...

Oct  1 09:43:47 info : Aux: > AT+COPS=3D3,0\r
Oct  1 09:43:47 info : Aux: < \r\nOK\r\n
Oct  1 09:43:47 info : Aux: > AT+COPS?\r

We are running UTRAN + HSPA

Oct  1 09:43:48 info : Aux: < \r\n+COPS: 0,0,"XXX",6\r\n
Oct  1 09:43:48 info : Aux: < \r\nOK\r\n
Oct  1 09:43:48 debug :
../git/drivers/atmodem/network-registration.c:cops_cb() cops_cb: XXX, 240
07 6
Oct  1 09:43:48 debug : ../git/src/network.c:current_operator_callback()
0x10d1218, 0x10d6fb8
Oct  1 09:43:50 info : Aux: < \r\n+CIEV: 2,4\r\n

We are transitioning to E-UTRAN because context 4 gets activated

Oct  1 09:43:51 info : Aux: < \r\n+CGEV: ME PDN ACT 4\r\n
Oct  1 09:43:51 info : Aux: > AT+CGDCONT?\r
Oct  1 09:43:51 info : Aux: < \r\n+CGDCONT: 1,"IP","XXX","",0,0,0,0,0,0\r\n
Oct  1 09:43:51 info : Aux: < +CGDCONT:
4,"IP","XXX.mnc003.mcc248.gprs","100.98.237.128",0,0,0,0,0,0\r\n
Oct  1 09:43:51 info : Aux: < \r\nOK\r\n

gprs status goes to unknown(normal on ublox when on E-UTRAN) which will
trigger a "detach"

Oct  1 09:43:51 info : Aux: < \r\n+CGREG: 4\r\n
Oct  1 09:43:51 info : Aux: < \r\n+UREG: 0\r\n
Oct  1 09:43:51 debug : ../git/drivers/atmodem/gprs.c:at_cgdcont_read_cb()
ok 1
Oct  1 09:43:51 debug : ../git/src/gprs.c:ofono_gprs_cid_activated() cid 4
Oct  1 09:43:51 debug :
../git/drivers/ubloxmodem/gprs-context.c:ublox_gprs_read_settings() cid 4
Oct  1 09:43:51 debug : ../git/src/modem.c:get_modem_property() modem
0x10ccaa0 property NetworkInterface
Oct  1 09:43:51 debug : ../git/src/gprs.c:pri_read_settings_callback()
0x10d6868
Oct  1 09:43:51 debug : ../git/src/gprs.c:ofono_gprs_status_notify()
/ublox_0 status unknown (4)
Oct  1 09:43:51 debug : ../git/src/gprs.c:ofono_gprs_detached_notify()
/ublox_0
Oct  1 09:43:51 info : Aux: > AT+CREG?\r
Oct  1 09:43:51 info : Aux: < \r\n+CIEV: 9,1\r\n\r\n+UREG: 7\r\n\r\n+CIEV:
9,2\r\n\r\n+CTZE: +08,1,"19/10/01,11:43:53"\r\n
Oct  1 09:43:51 debug :
../git/drivers/ubloxmodem/network-registration.c:ctze_notify() tz +08 dst 1
time 19/10/01,11:43:53
Oct  1 09:43:51 debug : ../git/src/network.c:ofono_netreg_time_notify() net
time 2019-10-01 11:43:53 utcoff 7200 dst 1

We are on E-UTRAN

Oct  1 09:43:51 info : Aux: < \r\n+CREG: 2,5,"2B02","01B57901",7\r\n
Oct  1 09:43:51 info : Aux: < \r\nOK\r\n
Oct  1 09:43:51 debug : ../git/src/network.c:ofono_netreg_status_notify()
/ublox_0 status 5 tech 7 lac 11010 ci 28670209
Oct  1 09:43:51 debug : ../git/src/gprs.c:netreg_status_changed() 5
(roaming)

gprs.c gets signaled about the change to E-UTRAN.
But since we now are on LTE, the code currently expect expect to change to
attached state first
when a new context is registered...But that happened above, so we will wait
for ever...

Oct  1 09:43:51 debug : ../git/src/gprs.c:gprs_netreg_update() attach: 1,
driver_attached: 0
Oct  1 09:43:51 info : Aux: > AT+COPS=3D3,2\r
Oct  1 09:43:51 info : Aux: < \r\nOK\r\n
Oct  1 09:43:51 info : Aux: > AT+COPS?\r

Den tis 1 okt. 2019 kl 22:11 skrev <richard.rojfors@gmail.com>:

> From: Richard R=C3=B6jfors <richard@puffinpack.se>
>
> There was a race condition where a context might be
> registered before the netreg status updates to LTE.
>
> The code took for granted the context is activated after
> the technology update. With this change, any order is
> is accepted.
> ---
>  src/gprs.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/src/gprs.c b/src/gprs.c
> index a8702958..a1e52572 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -1721,12 +1721,18 @@ static void gprs_netreg_update(struct ofono_gprs
> *gprs)
>
>         DBG("attach: %u, driver_attached: %u", attach,
> gprs->driver_attached);
>
> -       if (on_lte(gprs))
> +       if (on_lte(gprs)) {
>                 /*
>                  * For LTE we set attached status only on successful
>                  * context activation.
> +                *
> +                * The context could potentially be registered before the
> netreg
> +                * update is received.
>                  */
> -                return;
> +               gprs_attached_update(gprs);
> +
> +               return;
> +       }
>
>         if (gprs->driver_attached =3D=3D attach)
>                 return;
> --
> 2.20.1
>
>

--===============0445725926185522222==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SG9wZSB0aGlzIG9uZSBhcHBsaWVzIDstKTxicj48YnI+SGVyZSBpcyBh
IGxvZyBzaG93aW5nIHdoZW4gdGhpcyBpc3N1ZSBoYXBwZW5lZCwgd2hlcmUgYSBjb250ZXh0IHdh
cyByZWdpc3RlcmVkIGJlZm9yZSB3ZSBnb3Qgc2lnbmFsZWQ8ZGl2PkxURSB0ZWNoLi4uPGJyPjxi
cj5PY3QgwqAxIDA5OjQzOjQ3IGluZm8gOiBBdXg6ICZndDsgQVQrQ09QUz0zLDBccjxicj5PY3Qg
wqAxIDA5OjQzOjQ3IGluZm8gOiBBdXg6ICZsdDsgXHJcbk9LXHJcbjxicj5PY3QgwqAxIDA5OjQz
OjQ3IGluZm8gOiBBdXg6ICZndDsgQVQrQ09QUz9ccjxicj48YnI+V2UgYXJlIHJ1bm5pbmcgVVRS
QU4gKyBIU1BBPGJyPjxicj5PY3QgwqAxIDA5OjQzOjQ4IGluZm8gOiBBdXg6ICZsdDsgXHJcbitD
T1BTOiAwLDAsJnF1b3Q7WFhYJnF1b3Q7LDZcclxuPGJyPk9jdCDCoDEgMDk6NDM6NDggaW5mbyA6
IEF1eDogJmx0OyBcclxuT0tcclxuPGJyPk9jdCDCoDEgMDk6NDM6NDggZGVidWcgOiAuLi9naXQv
ZHJpdmVycy9hdG1vZGVtL25ldHdvcmstcmVnaXN0cmF0aW9uLmM6Y29wc19jYigpIGNvcHNfY2I6
IFhYWCwgMjQwIDA3IDY8YnI+T2N0IMKgMSAwOTo0Mzo0OCBkZWJ1ZyA6IC4uL2dpdC9zcmMvbmV0
d29yay5jOmN1cnJlbnRfb3BlcmF0b3JfY2FsbGJhY2soKSAweDEwZDEyMTgsIDB4MTBkNmZiODxi
cj5PY3QgwqAxIDA5OjQzOjUwIGluZm8gOiBBdXg6ICZsdDsgXHJcbitDSUVWOiAyLDRcclxuPGJy
Pjxicj5XZSBhcmUgdHJhbnNpdGlvbmluZyB0byBFLVVUUkFOIGJlY2F1c2UgY29udGV4dCA0IGdl
dHMgYWN0aXZhdGVkPGJyPjxicj5PY3QgwqAxIDA5OjQzOjUxIGluZm8gOiBBdXg6ICZsdDsgXHJc
bitDR0VWOiBNRSBQRE4gQUNUIDRcclxuPGJyPk9jdCDCoDEgMDk6NDM6NTEgaW5mbyA6IEF1eDog
Jmd0OyBBVCtDR0RDT05UP1xyPGJyPk9jdCDCoDEgMDk6NDM6NTEgaW5mbyA6IEF1eDogJmx0OyBc
clxuK0NHRENPTlQ6IDEsJnF1b3Q7SVAmcXVvdDssJnF1b3Q7WFhYJnF1b3Q7LCZxdW90OyZxdW90
OywwLDAsMCwwLDAsMFxyXG48YnI+T2N0IMKgMSAwOTo0Mzo1MSBpbmZvIDogQXV4OiAmbHQ7ICtD
R0RDT05UOiA0LCZxdW90O0lQJnF1b3Q7LCZxdW90O1hYWC5tbmMwMDMubWNjMjQ4LmdwcnMmcXVv
dDssJnF1b3Q7MTAwLjk4LjIzNy4xMjgmcXVvdDssMCwwLDAsMCwwLDBcclxuPGJyPk9jdCDCoDEg
MDk6NDM6NTEgaW5mbyA6IEF1eDogJmx0OyBcclxuT0tcclxuPGJyPjxicj5ncHJzIHN0YXR1cyBn
b2VzIHRvIHVua25vd24obm9ybWFsIG9uIHVibG94IHdoZW4gb24gRS1VVFJBTikgd2hpY2ggd2ls
bCB0cmlnZ2VyIGEgJnF1b3Q7ZGV0YWNoJnF1b3Q7PGJyPjxicj5PY3QgwqAxIDA5OjQzOjUxIGlu
Zm8gOiBBdXg6ICZsdDsgXHJcbitDR1JFRzogNFxyXG48YnI+T2N0IMKgMSAwOTo0Mzo1MSBpbmZv
IDogQXV4OiAmbHQ7IFxyXG4rVVJFRzogMFxyXG48YnI+T2N0IMKgMSAwOTo0Mzo1MSBkZWJ1ZyA6
IC4uL2dpdC9kcml2ZXJzL2F0bW9kZW0vZ3Bycy5jOmF0X2NnZGNvbnRfcmVhZF9jYigpIG9rIDE8
YnI+T2N0IMKgMSAwOTo0Mzo1MSBkZWJ1ZyA6IC4uL2dpdC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNf
Y2lkX2FjdGl2YXRlZCgpIGNpZCA0PGJyPk9jdCDCoDEgMDk6NDM6NTEgZGVidWcgOiAuLi9naXQv
ZHJpdmVycy91YmxveG1vZGVtL2dwcnMtY29udGV4dC5jOnVibG94X2dwcnNfcmVhZF9zZXR0aW5n
cygpIGNpZCA0PGJyPk9jdCDCoDEgMDk6NDM6NTEgZGVidWcgOiAuLi9naXQvc3JjL21vZGVtLmM6
Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHgxMGNjYWEwIHByb3BlcnR5IE5ldHdvcmtJbnRl
cmZhY2U8YnI+T2N0IMKgMSAwOTo0Mzo1MSBkZWJ1ZyA6IC4uL2dpdC9zcmMvZ3Bycy5jOnByaV9y
ZWFkX3NldHRpbmdzX2NhbGxiYWNrKCkgMHgxMGQ2ODY4PGJyPk9jdCDCoDEgMDk6NDM6NTEgZGVi
dWcgOiAuLi9naXQvc3JjL2dwcnMuYzpvZm9ub19ncHJzX3N0YXR1c19ub3RpZnkoKSAvdWJsb3hf
MCBzdGF0dXMgdW5rbm93biAoNCk8YnI+T2N0IMKgMSAwOTo0Mzo1MSBkZWJ1ZyA6IC4uL2dpdC9z
cmMvZ3Bycy5jOm9mb25vX2dwcnNfZGV0YWNoZWRfbm90aWZ5KCkgL3VibG94XzA8YnI+T2N0IMKg
MSAwOTo0Mzo1MSBpbmZvIDogQXV4OiAmZ3Q7IEFUK0NSRUc/XHI8YnI+T2N0IMKgMSAwOTo0Mzo1
MSBpbmZvIDogQXV4OiAmbHQ7IFxyXG4rQ0lFVjogOSwxXHJcblxyXG4rVVJFRzogN1xyXG5cclxu
K0NJRVY6IDksMlxyXG5cclxuK0NUWkU6ICswOCwxLCZxdW90OzE5LzEwLzAxLDExOjQzOjUzJnF1
b3Q7XHJcbjxicj5PY3QgwqAxIDA5OjQzOjUxIGRlYnVnIDogLi4vZ2l0L2RyaXZlcnMvdWJsb3ht
b2RlbS9uZXR3b3JrLXJlZ2lzdHJhdGlvbi5jOmN0emVfbm90aWZ5KCkgdHogKzA4IGRzdCAxIHRp
bWUgMTkvMTAvMDEsMTE6NDM6NTM8YnI+T2N0IMKgMSAwOTo0Mzo1MSBkZWJ1ZyA6IC4uL2dpdC9z
cmMvbmV0d29yay5jOm9mb25vX25ldHJlZ190aW1lX25vdGlmeSgpIG5ldCB0aW1lIDIwMTktMTAt
MDEgMTE6NDM6NTMgdXRjb2ZmIDcyMDAgZHN0IDE8YnI+PGJyPldlIGFyZSBvbiBFLVVUUkFOPGJy
Pjxicj5PY3QgwqAxIDA5OjQzOjUxIGluZm8gOiBBdXg6ICZsdDsgXHJcbitDUkVHOiAyLDUsJnF1
b3Q7MkIwMiZxdW90OywmcXVvdDswMUI1NzkwMSZxdW90Oyw3XHJcbjxicj5PY3QgwqAxIDA5OjQz
OjUxIGluZm8gOiBBdXg6ICZsdDsgXHJcbk9LXHJcbjxicj5PY3QgwqAxIDA5OjQzOjUxIGRlYnVn
IDogLi4vZ2l0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX3N0YXR1c19ub3RpZnkoKSAvdWJs
b3hfMCBzdGF0dXMgNSB0ZWNoIDcgbGFjIDExMDEwIGNpIDI4NjcwMjA5PGJyPk9jdCDCoDEgMDk6
NDM6NTEgZGVidWcgOiAuLi9naXQvc3JjL2dwcnMuYzpuZXRyZWdfc3RhdHVzX2NoYW5nZWQoKSA1
IChyb2FtaW5nKTxicj48YnI+Z3Bycy5jIGdldHMgc2lnbmFsZWQgYWJvdXQgdGhlIGNoYW5nZSB0
byBFLVVUUkFOLjwvZGl2PjxkaXY+QnV0IHNpbmNlIHdlIG5vdyBhcmUgb24gTFRFLCB0aGUgY29k
ZSBjdXJyZW50bHkgZXhwZWN0IGV4cGVjdCB0byBjaGFuZ2UgdG8gYXR0YWNoZWQgc3RhdGUgZmly
c3Q8L2Rpdj48ZGl2PndoZW4gYSBuZXcgY29udGV4dCBpcyByZWdpc3RlcmVkLi4uQnV0IHRoYXQg
aGFwcGVuZWQgYWJvdmUsIHNvIHdlIHdpbGwgd2FpdCBmb3IgZXZlci4uLjxicj48YnI+T2N0IMKg
MSAwOTo0Mzo1MSBkZWJ1ZyA6IC4uL2dpdC9zcmMvZ3Bycy5jOmdwcnNfbmV0cmVnX3VwZGF0ZSgp
IGF0dGFjaDogMSwgZHJpdmVyX2F0dGFjaGVkOiAwPGJyPk9jdCDCoDEgMDk6NDM6NTEgaW5mbyA6
IEF1eDogJmd0OyBBVCtDT1BTPTMsMlxyPGJyPk9jdCDCoDEgMDk6NDM6NTEgaW5mbyA6IEF1eDog
Jmx0OyBcclxuT0tcclxuPGJyPk9jdCDCoDEgMDk6NDM6NTEgaW5mbyA6IEF1eDogJmd0OyBBVCtD
T1BTP1xyPGJyPjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBk
aXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPkRlbiB0aXMgMSBva3QuIDIwMTkga2wgMjI6MTEg
c2tyZXYgJmx0OzxhIGhyZWY9Im1haWx0bzpyaWNoYXJkLnJvamZvcnNAZ21haWwuY29tIj5yaWNo
YXJkLnJvamZvcnNAZ21haWwuY29tPC9hPiZndDs6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNz
PSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVm
dDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5Gcm9tOiBSaWNo
YXJkIFLDtmpmb3JzICZsdDs8YSBocmVmPSJtYWlsdG86cmljaGFyZEBwdWZmaW5wYWNrLnNlIiB0
YXJnZXQ9Il9ibGFuayI+cmljaGFyZEBwdWZmaW5wYWNrLnNlPC9hPiZndDs8YnI+Cjxicj4KVGhl
cmUgd2FzIGEgcmFjZSBjb25kaXRpb24gd2hlcmUgYSBjb250ZXh0IG1pZ2h0IGJlPGJyPgpyZWdp
c3RlcmVkIGJlZm9yZSB0aGUgbmV0cmVnIHN0YXR1cyB1cGRhdGVzIHRvIExURS48YnI+Cjxicj4K
VGhlIGNvZGUgdG9vayBmb3IgZ3JhbnRlZCB0aGUgY29udGV4dCBpcyBhY3RpdmF0ZWQgYWZ0ZXI8
YnI+CnRoZSB0ZWNobm9sb2d5IHVwZGF0ZS4gV2l0aCB0aGlzIGNoYW5nZSwgYW55IG9yZGVyIGlz
PGJyPgppcyBhY2NlcHRlZC48YnI+Ci0tLTxicj4KwqBzcmMvZ3Bycy5jIHwgMTAgKysrKysrKyst
LTxicj4KwqAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKTxi
cj4KPGJyPgpkaWZmIC0tZ2l0IGEvc3JjL2dwcnMuYyBiL3NyYy9ncHJzLmM8YnI+CmluZGV4IGE4
NzAyOTU4Li5hMWU1MjU3MiAxMDA2NDQ8YnI+Ci0tLSBhL3NyYy9ncHJzLmM8YnI+CisrKyBiL3Ny
Yy9ncHJzLmM8YnI+CkBAIC0xNzIxLDEyICsxNzIxLDE4IEBAIHN0YXRpYyB2b2lkIGdwcnNfbmV0
cmVnX3VwZGF0ZShzdHJ1Y3Qgb2Zvbm9fZ3BycyAqZ3Bycyk8YnI+Cjxicj4KwqAgwqAgwqAgwqAg
REJHKCZxdW90O2F0dGFjaDogJXUsIGRyaXZlcl9hdHRhY2hlZDogJXUmcXVvdDssIGF0dGFjaCwg
Z3Bycy0mZ3Q7ZHJpdmVyX2F0dGFjaGVkKTs8YnI+Cjxicj4KLcKgIMKgIMKgIMKgaWYgKG9uX2x0
ZShncHJzKSk8YnI+CivCoCDCoCDCoCDCoGlmIChvbl9sdGUoZ3BycykpIHs8YnI+CsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIC8qPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCogRm9yIExU
RSB3ZSBzZXQgYXR0YWNoZWQgc3RhdHVzIG9ubHkgb24gc3VjY2Vzc2Z1bDxicj4KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAqIGNvbnRleHQgYWN0aXZhdGlvbi48YnI+CivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCAqPGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiBUaGUgY29udGV4dCBj
b3VsZCBwb3RlbnRpYWxseSBiZSByZWdpc3RlcmVkIGJlZm9yZSB0aGUgbmV0cmVnPGJyPgorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgKiB1cGRhdGUgaXMgcmVjZWl2ZWQuPGJyPgrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCovPGJyPgotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuOzxi
cj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ3Byc19hdHRhY2hlZF91cGRhdGUoZ3Bycyk7PGJy
PgorPGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm47PGJyPgorwqAgwqAgwqAgwqB9
PGJyPgo8YnI+CsKgIMKgIMKgIMKgIGlmIChncHJzLSZndDtkcml2ZXJfYXR0YWNoZWQgPT0gYXR0
YWNoKTxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuOzxicj4KLS0gPGJyPgoyLjIw
LjE8YnI+Cjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pgo=

--===============0445725926185522222==--

