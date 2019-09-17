Content-Type: multipart/mixed; boundary="===============6895894106559439723=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [PATCH] gprs: deattach driver when gprs status indicates
 unregistered
Date: Tue, 17 Sep 2019 23:56:54 +0200
Message-ID: <CAHB-Pjk1ixDfKyhYLy+8EyMtQxi1QiazMa4eH3VfgBe-iAzu_A@mail.gmail.com>
In-Reply-To: <20190917214807.19663-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6895894106559439723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

...and a log for this:

Got deregistered

Sep 17 20:02:22 daemon.info: Aux: < \r\n+CREG: 0\r\n
Sep 17 20:02:22 daemon.debug:
../git/src/network.c:ofono_netreg_status_notify() /ublox_0 status 0 tech -1
lac -1 ci -1
Sep 17 20:02:22 daemon.debug:
../git/src/network.c:current_operator_callback() 0x1bb4360, 0x1bb6ae0
Sep 17 20:02:22 daemon.debug: ../git/src/gprs.c:netreg_status_changed() 0
(unregistered)
Sep 17 20:02:22 daemon.debug: ../git/src/gprs.c:gprs_netreg_update()
attach: 0, driver_attached: 1
Sep 17 20:02:22 daemon.debug: ../git/src/gprs.c:netreg_status_changed() 0
(unregistered)
Sep 17 20:02:22 daemon.debug: ../git/src/gprs.c:gprs_netreg_update()
attach: 0, driver_attached: 0
Sep 17 20:02:22 daemon.info: Aux: > AT\r
Sep 17 20:02:22 daemon.info: Aux: < \r\n+CIEV: 7,0\r\n
Sep 17 20:02:22 daemon.info: Aux: < \r\nOK\r\n
Sep 17 20:02:22 daemon.info: Aux: Finally woke up the modem
Sep 17 20:02:22 daemon.info: Aux: > AT+CGATT=3D0\r
Sep 17 20:02:22 daemon.info: Aux: < \r\n+CME ERROR: 148\r\n

Detach failed - driver_attached is set to 1 again

Sep 17 20:02:22 daemon.debug: ../git/src/gprs.c:gprs_attach_callback()
/ublox_0 error =3D 1
Sep 17 20:02:22 daemon.info: Aux: > AT+CGREG?\r
Sep 17 20:02:22 daemon.info: Aux: < \r\n+CGREG: 4\r\n
Sep 17 20:02:22 daemon.info: Aux: < \r\n+UREG: 0\r\n
Sep 17 20:02:22 daemon.info: Aux: < \r\n+CIEV: 9,1\r\n
Sep 17 20:02:22 daemon.info: Aux: < \r\n+CGREG: 2,4\r\n
Sep 17 20:02:22 daemon.info: Aux: < \r\nOK\r\n
Sep 17 20:02:22 daemon.debug: ../git/src/gprs.c:registration_status_cb()
/ublox_0 error 0 status 4

We read back the registration status, but does not set the driver_attached
to 0

Sep 17 20:02:22 daemon.debug: ../git/src/gprs.c:ofono_gprs_status_notify()
/ublox_0 status unknown (4)
Sep 17 20:02:22 daemon.debug:
../git/src/gprs.c:gprs_set_attached_property() 0x1bb1500 1 -> 0
Sep 17 20:02:33 daemon.info: Aux: < \r\n+CREG: 0\r\n
Sep 17 20:02:33 daemon.debug:
../git/src/network.c:ofono_netreg_status_notify() /ublox_0 status 0 tech -1
lac -1 ci -1
Sep 17 20:02:33 daemon.debug:
../git/src/network.c:current_operator_callback() 0x1bb4360, (nil)
Sep 17 20:02:33 daemon.debug: ../git/src/gprs.c:netreg_status_changed() 0
(unregistered)
Sep 17 20:02:33 daemon.debug: ../git/src/gprs.c:gprs_netreg_update()
attach: 0, driver_attached: 1

We still believe the driver is attached, trying to detach again

Sep 17 20:02:33 daemon.info: Aux: > AT\r
Sep 17 20:02:33 daemon.info: Aux: < \r\nOK\r\n
Sep 17 20:02:33 daemon.info: Aux: Finally woke up the modem
Sep 17 20:02:33 daemon.info: Aux: > AT+CGATT=3D0\r
Sep 17 20:05:33 daemon.info: Aux: < \r\n+CME ERROR: 2000\r\n

Detach failed again, setting back driver_attached to 1

Sep 17 20:05:33 daemon.debug: ../git/src/gprs.c:gprs_attach_callback()
/ublox_0 error =3D 1
Sep 17 20:05:33 daemon.info: Aux: > AT\r
Sep 17 20:05:33 daemon.info: Aux: < \r\nOK\r\n
Sep 17 20:05:33 daemon.info: Aux: Finally woke up the modem
Sep 17 20:05:33 daemon.info: Aux: > AT+CGREG?\r
Sep 17 20:05:33 daemon.info: Aux: < \r\n+CGREG: 2,4\r\n
Sep 17 20:05:33 daemon.info: Aux: < \r\nOK\r\n
Sep 17 20:05:33 daemon.debug: ../git/src/gprs.c:registration_status_cb()
/ublox_0 error 0 status 4

We still do not set driver_attached to 0, even CREG says unknown status

Sep 17 20:05:33 daemon.debug: ../git/src/gprs.c:ofono_gprs_status_notify()
/ublox_0 status unknown (4)
Sep 17 20:05:33 daemon.info: Aux: < \r\n+CTZE: +08,1,"19/09/17,22:02:36"\r\n
Sep 17 20:05:33 daemon.info: Aux: < \r\n+CREG: 5,"0000","00000010",2\r\n
Sep 17 20:05:33 daemon.debug:
../git/drivers/ubloxmodem/network-registration.c:ctze_notify() tz +08 dst 1
time 19/09/17,22:02:36
Sep 17 20:05:33 daemon.debug:
../git/src/network.c:ofono_netreg_time_notify() net time 2019-09-17
22:02:36 utcoff 7200 dst 1
Sep 17 20:05:33 daemon.debug:
../git/src/network.c:ofono_netreg_status_notify() /ublox_0 status 5 tech 2
lac 0 ci 16
Sep 17 20:05:33 daemon.debug: ../git/src/gprs.c:netreg_status_changed() 5
(roaming)
Sep 17 20:05:33 daemon.debug: ../git/src/gprs.c:gprs_netreg_update()
attach: 1, driver_attached: 1

We now got registered, but we believe the driver is attached, so no action
is taken and the driver will not be attached...
and the Attached D-Bus property will remain False.

--Richard

Den tis 17 sep. 2019 kl 23:48 skrev <richard.rojfors@gmail.com>:

> From: Richard R=C3=B6jfors <richard@puffinpack.se>
>
> In the same way as we consider the driver attached when the
> gprs status indicates we are registered, we should consider
> it deattached when the status indicates unregistration.
>
> If we don't, then we would not always recover from the case
> when deattaching the driver fails. We would just revert back
> the driver attached status to true, and "ignore" if the status
> indicates the opposite when we check the registration status
> afterwards.
> ---
>  src/gprs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/src/gprs.c b/src/gprs.c
> index de172979..c7b181f5 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -2568,12 +2568,6 @@ void ofono_gprs_status_notify(struct ofono_gprs
> *gprs, int status)
>
>         gprs->status =3D status;
>
> -       if (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
> -                       status !=3D NETWORK_REGISTRATION_STATUS_ROAMING) {
> -               gprs_attached_update(gprs);
> -               return;
> -       }
> -
>         /*
>          * If we're already taking action, e.g. attaching or detaching,
> then
>          * ignore this notification for now, we will take appropriate
> action
> @@ -2582,6 +2576,12 @@ void ofono_gprs_status_notify(struct ofono_gprs
> *gprs, int status)
>         if (gprs->flags & GPRS_FLAG_ATTACHING)
>                 return;
>
> +       if (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
> +                       status !=3D NETWORK_REGISTRATION_STATUS_ROAMING) {
> +               ofono_gprs_detached_notify(gprs);
> +               return;
> +       }
> +
>         /* We registered without being powered */
>         if (gprs->powered =3D=3D FALSE)
>                 goto detach;
> --
> 2.20.1
>
>

--===============6895894106559439723==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+Li4uYW5kIGEgbG9nIGZvciB0aGlzOjxicj48
YnI+R290IGRlcmVnaXN0ZXJlZDxicj48YnI+U2VwIDE3IDIwOjAyOjIyIDxhIGhyZWY9Imh0dHA6
Ly9kYWVtb24uaW5mbyI+ZGFlbW9uLmluZm88L2E+OiBBdXg6ICZsdDsgXHJcbitDUkVHOiAwXHJc
bjxicj5TZXAgMTcgMjA6MDI6MjIgZGFlbW9uLmRlYnVnOiAuLi9naXQvc3JjL25ldHdvcmsuYzpv
Zm9ub19uZXRyZWdfc3RhdHVzX25vdGlmeSgpIC91YmxveF8wIHN0YXR1cyAwIHRlY2ggLTEgbGFj
IC0xIGNpIC0xPGJyPlNlcCAxNyAyMDowMjoyMiBkYWVtb24uZGVidWc6IC4uL2dpdC9zcmMvbmV0
d29yay5jOmN1cnJlbnRfb3BlcmF0b3JfY2FsbGJhY2soKSAweDFiYjQzNjAsIDB4MWJiNmFlMDxi
cj5TZXAgMTcgMjA6MDI6MjIgZGFlbW9uLmRlYnVnOiAuLi9naXQvc3JjL2dwcnMuYzpuZXRyZWdf
c3RhdHVzX2NoYW5nZWQoKSAwICh1bnJlZ2lzdGVyZWQpPGJyPlNlcCAxNyAyMDowMjoyMiBkYWVt
b24uZGVidWc6IC4uL2dpdC9zcmMvZ3Bycy5jOmdwcnNfbmV0cmVnX3VwZGF0ZSgpIGF0dGFjaDog
MCwgZHJpdmVyX2F0dGFjaGVkOiAxPGJyPlNlcCAxNyAyMDowMjoyMiBkYWVtb24uZGVidWc6IC4u
L2dpdC9zcmMvZ3Bycy5jOm5ldHJlZ19zdGF0dXNfY2hhbmdlZCgpIDAgKHVucmVnaXN0ZXJlZCk8
YnI+U2VwIDE3IDIwOjAyOjIyIGRhZW1vbi5kZWJ1ZzogLi4vZ2l0L3NyYy9ncHJzLmM6Z3Byc19u
ZXRyZWdfdXBkYXRlKCkgYXR0YWNoOiAwLCBkcml2ZXJfYXR0YWNoZWQ6IDA8YnI+U2VwIDE3IDIw
OjAyOjIyIDxhIGhyZWY9Imh0dHA6Ly9kYWVtb24uaW5mbyI+ZGFlbW9uLmluZm88L2E+OiBBdXg6
ICZndDsgQVRccjxicj5TZXAgMTcgMjA6MDI6MjIgPGEgaHJlZj0iaHR0cDovL2RhZW1vbi5pbmZv
Ij5kYWVtb24uaW5mbzwvYT46IEF1eDogJmx0OyBcclxuK0NJRVY6IDcsMFxyXG48YnI+U2VwIDE3
IDIwOjAyOjIyIDxhIGhyZWY9Imh0dHA6Ly9kYWVtb24uaW5mbyI+ZGFlbW9uLmluZm88L2E+OiBB
dXg6ICZsdDsgXHJcbk9LXHJcbjxicj5TZXAgMTcgMjA6MDI6MjIgPGEgaHJlZj0iaHR0cDovL2Rh
ZW1vbi5pbmZvIj5kYWVtb24uaW5mbzwvYT46IEF1eDogRmluYWxseSB3b2tlIHVwIHRoZSBtb2Rl
bTxicj5TZXAgMTcgMjA6MDI6MjIgPGEgaHJlZj0iaHR0cDovL2RhZW1vbi5pbmZvIj5kYWVtb24u
aW5mbzwvYT46IEF1eDogJmd0OyBBVCtDR0FUVD0wXHI8ZGl2PlNlcCAxNyAyMDowMjoyMiA8YSBo
cmVmPSJodHRwOi8vZGFlbW9uLmluZm8iPmRhZW1vbi5pbmZvPC9hPjogQXV4OiAmbHQ7IFxyXG4r
Q01FIEVSUk9SOiAxNDhcclxuPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGRpdj5EZXRh
Y2ggZmFpbGVkIC0gZHJpdmVyX2F0dGFjaGVkIGlzIHNldCB0byAxIGFnYWluPC9kaXY+PGRpdj48
L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlNlcCAxNyAyMDowMjoyMiBkYWVtb24uZGVi
dWc6IC4uL2dpdC9zcmMvZ3Bycy5jOmdwcnNfYXR0YWNoX2NhbGxiYWNrKCkgL3VibG94XzAgZXJy
b3IgPSAxPGJyPlNlcCAxNyAyMDowMjoyMiA8YSBocmVmPSJodHRwOi8vZGFlbW9uLmluZm8iPmRh
ZW1vbi5pbmZvPC9hPjogQXV4OiAmZ3Q7IEFUK0NHUkVHP1xyPGJyPlNlcCAxNyAyMDowMjoyMiA8
YSBocmVmPSJodHRwOi8vZGFlbW9uLmluZm8iPmRhZW1vbi5pbmZvPC9hPjogQXV4OiAmbHQ7IFxy
XG4rQ0dSRUc6IDRcclxuPGJyPlNlcCAxNyAyMDowMjoyMiA8YSBocmVmPSJodHRwOi8vZGFlbW9u
LmluZm8iPmRhZW1vbi5pbmZvPC9hPjogQXV4OiAmbHQ7IFxyXG4rVVJFRzogMFxyXG48YnI+U2Vw
IDE3IDIwOjAyOjIyIDxhIGhyZWY9Imh0dHA6Ly9kYWVtb24uaW5mbyI+ZGFlbW9uLmluZm88L2E+
OiBBdXg6ICZsdDsgXHJcbitDSUVWOiA5LDFcclxuPGJyPlNlcCAxNyAyMDowMjoyMiA8YSBocmVm
PSJodHRwOi8vZGFlbW9uLmluZm8iPmRhZW1vbi5pbmZvPC9hPjogQXV4OiAmbHQ7IFxyXG4rQ0dS
RUc6IDIsNFxyXG48YnI+U2VwIDE3IDIwOjAyOjIyIDxhIGhyZWY9Imh0dHA6Ly9kYWVtb24uaW5m
byI+ZGFlbW9uLmluZm88L2E+OiBBdXg6ICZsdDsgXHJcbk9LXHJcbjxicj5TZXAgMTcgMjA6MDI6
MjIgZGFlbW9uLmRlYnVnOiAuLi9naXQvc3JjL2dwcnMuYzpyZWdpc3RyYXRpb25fc3RhdHVzX2Ni
KCkgL3VibG94XzAgZXJyb3IgMCBzdGF0dXMgNDxkaXY+PGJyPjwvZGl2PjxkaXY+V2UgcmVhZCBi
YWNrIHRoZSByZWdpc3RyYXRpb24gc3RhdHVzLCBidXQgZG9lcyBub3Qgc2V0IHRoZSBkcml2ZXJf
YXR0YWNoZWQgdG8gMDwvZGl2PjxkaXY+PGJyPlNlcCAxNyAyMDowMjoyMiBkYWVtb24uZGVidWc6
IC4uL2dpdC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfc3RhdHVzX25vdGlmeSgpIC91YmxveF8wIHN0
YXR1cyB1bmtub3duICg0KTxicj5TZXAgMTcgMjA6MDI6MjIgZGFlbW9uLmRlYnVnOiAuLi9naXQv
c3JjL2dwcnMuYzpncHJzX3NldF9hdHRhY2hlZF9wcm9wZXJ0eSgpIDB4MWJiMTUwMCAxIC0mZ3Q7
IDA8YnI+U2VwIDE3IDIwOjAyOjMzIDxhIGhyZWY9Imh0dHA6Ly9kYWVtb24uaW5mbyI+ZGFlbW9u
LmluZm88L2E+OiBBdXg6ICZsdDsgXHJcbitDUkVHOiAwXHJcbjxicj5TZXAgMTcgMjA6MDI6MzMg
ZGFlbW9uLmRlYnVnOiAuLi9naXQvc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdfc3RhdHVzX25v
dGlmeSgpIC91YmxveF8wIHN0YXR1cyAwIHRlY2ggLTEgbGFjIC0xIGNpIC0xPGJyPlNlcCAxNyAy
MDowMjozMyBkYWVtb24uZGVidWc6IC4uL2dpdC9zcmMvbmV0d29yay5jOmN1cnJlbnRfb3BlcmF0
b3JfY2FsbGJhY2soKSAweDFiYjQzNjAsIChuaWwpPGJyPlNlcCAxNyAyMDowMjozMyBkYWVtb24u
ZGVidWc6IC4uL2dpdC9zcmMvZ3Bycy5jOm5ldHJlZ19zdGF0dXNfY2hhbmdlZCgpIDAgKHVucmVn
aXN0ZXJlZCk8YnI+U2VwIDE3IDIwOjAyOjMzIGRhZW1vbi5kZWJ1ZzogLi4vZ2l0L3NyYy9ncHJz
LmM6Z3Byc19uZXRyZWdfdXBkYXRlKCkgYXR0YWNoOiAwLCBkcml2ZXJfYXR0YWNoZWQ6IDE8YnI+
PGJyPldlIHN0aWxsIGJlbGlldmUgdGhlIGRyaXZlciBpcyBhdHRhY2hlZCwgdHJ5aW5nIHRvIGRl
dGFjaCBhZ2Fpbjxicj48YnI+U2VwIDE3IDIwOjAyOjMzIDxhIGhyZWY9Imh0dHA6Ly9kYWVtb24u
aW5mbyI+ZGFlbW9uLmluZm88L2E+OiBBdXg6ICZndDsgQVRccjxicj5TZXAgMTcgMjA6MDI6MzMg
PGEgaHJlZj0iaHR0cDovL2RhZW1vbi5pbmZvIj5kYWVtb24uaW5mbzwvYT46IEF1eDogJmx0OyBc
clxuT0tcclxuPGJyPlNlcCAxNyAyMDowMjozMyA8YSBocmVmPSJodHRwOi8vZGFlbW9uLmluZm8i
PmRhZW1vbi5pbmZvPC9hPjogQXV4OiBGaW5hbGx5IHdva2UgdXAgdGhlIG1vZGVtPGJyPlNlcCAx
NyAyMDowMjozMyA8YSBocmVmPSJodHRwOi8vZGFlbW9uLmluZm8iPmRhZW1vbi5pbmZvPC9hPjog
QXV4OiAmZ3Q7IEFUK0NHQVRUPTBccjxicj5TZXAgMTcgMjA6MDU6MzMgPGEgaHJlZj0iaHR0cDov
L2RhZW1vbi5pbmZvIj5kYWVtb24uaW5mbzwvYT46IEF1eDogJmx0OyBcclxuK0NNRSBFUlJPUjog
MjAwMFxyXG48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkRldGFjaCBmYWlsZWQgYWdhaW4sIHNl
dHRpbmcgYmFjayBkcml2ZXJfYXR0YWNoZWQgdG8gMTwvZGl2PjxkaXY+PGJyPlNlcCAxNyAyMDow
NTozMyBkYWVtb24uZGVidWc6IC4uL2dpdC9zcmMvZ3Bycy5jOmdwcnNfYXR0YWNoX2NhbGxiYWNr
KCkgL3VibG94XzAgZXJyb3IgPSAxPGJyPlNlcCAxNyAyMDowNTozMyA8YSBocmVmPSJodHRwOi8v
ZGFlbW9uLmluZm8iPmRhZW1vbi5pbmZvPC9hPjogQXV4OiAmZ3Q7IEFUXHI8YnI+U2VwIDE3IDIw
OjA1OjMzIDxhIGhyZWY9Imh0dHA6Ly9kYWVtb24uaW5mbyI+ZGFlbW9uLmluZm88L2E+OiBBdXg6
ICZsdDsgXHJcbk9LXHJcbjxicj5TZXAgMTcgMjA6MDU6MzMgPGEgaHJlZj0iaHR0cDovL2RhZW1v
bi5pbmZvIj5kYWVtb24uaW5mbzwvYT46IEF1eDogRmluYWxseSB3b2tlIHVwIHRoZSBtb2RlbTxi
cj5TZXAgMTcgMjA6MDU6MzMgPGEgaHJlZj0iaHR0cDovL2RhZW1vbi5pbmZvIj5kYWVtb24uaW5m
bzwvYT46IEF1eDogJmd0OyBBVCtDR1JFRz9ccjxicj5TZXAgMTcgMjA6MDU6MzMgPGEgaHJlZj0i
aHR0cDovL2RhZW1vbi5pbmZvIj5kYWVtb24uaW5mbzwvYT46IEF1eDogJmx0OyBcclxuK0NHUkVH
OiAyLDRcclxuPC9kaXY+PGRpdj5TZXAgMTcgMjA6MDU6MzMgPGEgaHJlZj0iaHR0cDovL2RhZW1v
bi5pbmZvIj5kYWVtb24uaW5mbzwvYT46IEF1eDogJmx0OyBcclxuT0tcclxuPGJyPlNlcCAxNyAy
MDowNTozMyBkYWVtb24uZGVidWc6IC4uL2dpdC9zcmMvZ3Bycy5jOnJlZ2lzdHJhdGlvbl9zdGF0
dXNfY2IoKSAvdWJsb3hfMCBlcnJvciAwIHN0YXR1cyA0PGJyPjxicj48ZGl2PldlIHN0aWxsIGRv
IG5vdCBzZXQgZHJpdmVyX2F0dGFjaGVkIHRvIDAsIGV2ZW4gQ1JFRyBzYXlzIHVua25vd24gc3Rh
dHVzPC9kaXY+PGRpdj48L2Rpdj7CoDxicj5TZXAgMTcgMjA6MDU6MzMgZGFlbW9uLmRlYnVnOiAu
Li9naXQvc3JjL2dwcnMuYzpvZm9ub19ncHJzX3N0YXR1c19ub3RpZnkoKSAvdWJsb3hfMCBzdGF0
dXMgdW5rbm93biAoNCk8YnI+U2VwIDE3IDIwOjA1OjMzIDxhIGhyZWY9Imh0dHA6Ly9kYWVtb24u
aW5mbyI+ZGFlbW9uLmluZm88L2E+OiBBdXg6ICZsdDsgXHJcbitDVFpFOiArMDgsMSwmcXVvdDsx
OS8wOS8xNywyMjowMjozNiZxdW90O1xyXG48YnI+U2VwIDE3IDIwOjA1OjMzIDxhIGhyZWY9Imh0
dHA6Ly9kYWVtb24uaW5mbyI+ZGFlbW9uLmluZm88L2E+OiBBdXg6ICZsdDsgXHJcbitDUkVHOiA1
LCZxdW90OzAwMDAmcXVvdDssJnF1b3Q7MDAwMDAwMTAmcXVvdDssMlxyXG48YnI+U2VwIDE3IDIw
OjA1OjMzIGRhZW1vbi5kZWJ1ZzogLi4vZ2l0L2RyaXZlcnMvdWJsb3htb2RlbS9uZXR3b3JrLXJl
Z2lzdHJhdGlvbi5jOmN0emVfbm90aWZ5KCkgdHogKzA4IGRzdCAxIHRpbWUgMTkvMDkvMTcsMjI6
MDI6MzY8YnI+U2VwIDE3IDIwOjA1OjMzIGRhZW1vbi5kZWJ1ZzogLi4vZ2l0L3NyYy9uZXR3b3Jr
LmM6b2Zvbm9fbmV0cmVnX3RpbWVfbm90aWZ5KCkgbmV0IHRpbWUgMjAxOS0wOS0xNyAyMjowMjoz
NiB1dGNvZmYgNzIwMCBkc3QgMTxicj5TZXAgMTcgMjA6MDU6MzMgZGFlbW9uLmRlYnVnOiAuLi9n
aXQvc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdfc3RhdHVzX25vdGlmeSgpIC91YmxveF8wIHN0
YXR1cyA1IHRlY2ggMiBsYWMgMCBjaSAxNjxicj5TZXAgMTcgMjA6MDU6MzMgZGFlbW9uLmRlYnVn
OiAuLi9naXQvc3JjL2dwcnMuYzpuZXRyZWdfc3RhdHVzX2NoYW5nZWQoKSA1IChyb2FtaW5nKTxi
cj5TZXAgMTcgMjA6MDU6MzMgZGFlbW9uLmRlYnVnOiAuLi9naXQvc3JjL2dwcnMuYzpncHJzX25l
dHJlZ191cGRhdGUoKSBhdHRhY2g6IDEsIGRyaXZlcl9hdHRhY2hlZDogMTxicj48L2Rpdj48L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PldlIG5vdyBnb3QgcmVnaXN0ZXJlZCwgYnV0IHdlIGJlbGll
dmUgdGhlIGRyaXZlciBpcyBhdHRhY2hlZCwgc28gbm8gYWN0aW9uIGlzIHRha2VuIGFuZCB0aGUg
ZHJpdmVyIHdpbGwgbm90IGJlIGF0dGFjaGVkLi4uPC9kaXY+PGRpdj5hbmQgdGhlIEF0dGFjaGVk
IEQtQnVzIHByb3BlcnR5IHdpbGwgcmVtYWluIEZhbHNlLjwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+LS1SaWNoYXJkPC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2
IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+RGVuIHRpcyAxNyBzZXAuIDIwMTkga2wgMjM6
NDggc2tyZXYgJmx0OzxhIGhyZWY9Im1haWx0bzpyaWNoYXJkLnJvamZvcnNAZ21haWwuY29tIj5y
aWNoYXJkLnJvamZvcnNAZ21haWwuY29tPC9hPiZndDs6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNs
YXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXIt
bGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5Gcm9tOiBS
aWNoYXJkIFLDtmpmb3JzICZsdDs8YSBocmVmPSJtYWlsdG86cmljaGFyZEBwdWZmaW5wYWNrLnNl
IiB0YXJnZXQ9Il9ibGFuayI+cmljaGFyZEBwdWZmaW5wYWNrLnNlPC9hPiZndDs8YnI+Cjxicj4K
SW4gdGhlIHNhbWUgd2F5IGFzIHdlIGNvbnNpZGVyIHRoZSBkcml2ZXIgYXR0YWNoZWQgd2hlbiB0
aGU8YnI+CmdwcnMgc3RhdHVzIGluZGljYXRlcyB3ZSBhcmUgcmVnaXN0ZXJlZCwgd2Ugc2hvdWxk
IGNvbnNpZGVyPGJyPgppdCBkZWF0dGFjaGVkIHdoZW4gdGhlIHN0YXR1cyBpbmRpY2F0ZXMgdW5y
ZWdpc3RyYXRpb24uPGJyPgo8YnI+CklmIHdlIGRvbiYjMzk7dCwgdGhlbiB3ZSB3b3VsZCBub3Qg
YWx3YXlzIHJlY292ZXIgZnJvbSB0aGUgY2FzZTxicj4Kd2hlbiBkZWF0dGFjaGluZyB0aGUgZHJp
dmVyIGZhaWxzLiBXZSB3b3VsZCBqdXN0IHJldmVydCBiYWNrPGJyPgp0aGUgZHJpdmVyIGF0dGFj
aGVkIHN0YXR1cyB0byB0cnVlLCBhbmQgJnF1b3Q7aWdub3JlJnF1b3Q7IGlmIHRoZSBzdGF0dXM8
YnI+CmluZGljYXRlcyB0aGUgb3Bwb3NpdGUgd2hlbiB3ZSBjaGVjayB0aGUgcmVnaXN0cmF0aW9u
IHN0YXR1czxicj4KYWZ0ZXJ3YXJkcy48YnI+Ci0tLTxicj4KwqBzcmMvZ3Bycy5jIHwgMTIgKysr
KysrLS0tLS0tPGJyPgrCoDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRp
b25zKC0pPGJyPgo8YnI+CmRpZmYgLS1naXQgYS9zcmMvZ3Bycy5jIGIvc3JjL2dwcnMuYzxicj4K
aW5kZXggZGUxNzI5NzkuLmM3YjE4MWY1IDEwMDY0NDxicj4KLS0tIGEvc3JjL2dwcnMuYzxicj4K
KysrIGIvc3JjL2dwcnMuYzxicj4KQEAgLTI1NjgsMTIgKzI1NjgsNiBAQCB2b2lkIG9mb25vX2dw
cnNfc3RhdHVzX25vdGlmeShzdHJ1Y3Qgb2Zvbm9fZ3BycyAqZ3BycywgaW50IHN0YXR1cyk8YnI+
Cjxicj4KwqAgwqAgwqAgwqAgZ3Bycy0mZ3Q7c3RhdHVzID0gc3RhdHVzOzxicj4KPGJyPgotwqAg
wqAgwqAgwqBpZiAoc3RhdHVzICE9IE5FVFdPUktfUkVHSVNUUkFUSU9OX1NUQVRVU19SRUdJU1RF
UkVEICZhbXA7JmFtcDs8YnI+Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0
YXR1cyAhPSBORVRXT1JLX1JFR0lTVFJBVElPTl9TVEFUVVNfUk9BTUlORykgezxicj4KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgZ3Byc19hdHRhY2hlZF91cGRhdGUoZ3Bycyk7PGJyPgotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqByZXR1cm47PGJyPgotwqAgwqAgwqAgwqB9PGJyPgotPGJyPgrCoCDC
oCDCoCDCoCAvKjxicj4KwqAgwqAgwqAgwqAgwqAqIElmIHdlJiMzOTtyZSBhbHJlYWR5IHRha2lu
ZyBhY3Rpb24sIGUuZy4gYXR0YWNoaW5nIG9yIGRldGFjaGluZywgdGhlbjxicj4KwqAgwqAgwqAg
wqAgwqAqIGlnbm9yZSB0aGlzIG5vdGlmaWNhdGlvbiBmb3Igbm93LCB3ZSB3aWxsIHRha2UgYXBw
cm9wcmlhdGUgYWN0aW9uPGJyPgpAQCAtMjU4Miw2ICsyNTc2LDEyIEBAIHZvaWQgb2Zvbm9fZ3By
c19zdGF0dXNfbm90aWZ5KHN0cnVjdCBvZm9ub19ncHJzICpncHJzLCBpbnQgc3RhdHVzKTxicj4K
wqAgwqAgwqAgwqAgaWYgKGdwcnMtJmd0O2ZsYWdzICZhbXA7IEdQUlNfRkxBR19BVFRBQ0hJTkcp
PGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm47PGJyPgo8YnI+CivCoCDCoCDCoCDC
oGlmIChzdGF0dXMgIT0gTkVUV09SS19SRUdJU1RSQVRJT05fU1RBVFVTX1JFR0lTVEVSRUQgJmFt
cDsmYW1wOzxicj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RhdHVzICE9
IE5FVFdPUktfUkVHSVNUUkFUSU9OX1NUQVRVU19ST0FNSU5HKSB7PGJyPgorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBvZm9ub19ncHJzX2RldGFjaGVkX25vdGlmeShncHJzKTs8YnI+CivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHJldHVybjs8YnI+CivCoCDCoCDCoCDCoH08YnI+Cis8YnI+CsKgIMKg
IMKgIMKgIC8qIFdlIHJlZ2lzdGVyZWQgd2l0aG91dCBiZWluZyBwb3dlcmVkICovPGJyPgrCoCDC
oCDCoCDCoCBpZiAoZ3Bycy0mZ3Q7cG93ZXJlZCA9PSBGQUxTRSk8YnI+CsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIGdvdG8gZGV0YWNoOzxicj4KLS0gPGJyPgoyLjIwLjE8YnI+Cjxicj4KPC9ibG9j
a3F1b3RlPjwvZGl2PjwvZGl2Pgo=

--===============6895894106559439723==--

