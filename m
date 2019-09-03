Content-Type: multipart/mixed; boundary="===============7953385066795987721=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH] ublox: gprs: React on context deactivation
Date: Tue, 03 Sep 2019 21:49:27 +0200
Message-ID: <CAALamod_189UAzzrasmZfOvrShOkC5-ug2y39xE7sKErZqG=-w@mail.gmail.com>
In-Reply-To: <CAHB-Pjnvdu+90EHZ3rEotangEsAATeACUFWUenWgywOm6aB6Hw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7953385066795987721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2019, 16:11 Richard R=C3=B6jfors <richard.rojfors@gmail.co=
m>
wrote:

> Hi,
>
> An example log when this happened. In this case ofono thought context 4
> was still activated
> even though it was deactivated
>

Yes, I've seen this, too, and have a similar patch that I never got around
to sending. Please apply.

/Jonas


> 12:47:52 info: Aux: < \r\n+CIEV: 9,2\r\n
> 12:50:37 info: Aux: < \r\n+CIEV: 2,2\r\n
> 12:50:42 info: Aux: < \r\n+CIEV: 2,1\r\n
> 12:51:06 info: Aux: < \r\n+CIEV: 2,0\r\n
> 12:51:08 info: Aux: < \r\n+CGREG: 5,"004B","0000E404",6,"01"\r\n
> 12:51:08 debug: ../git/src/gprs.c:ofono_gprs_status_notify() /ublox_0
> status roaming (5)
> 12:51:08 info: Aux: < \r\n+UREG: 6\r\n
> 12:51:08 info: Aux: < \r\n+CIEV: 9,2\r\n
> 12:51:08 info: Aux: < \r\n+CIEV: 9,1\r\n
> 12:51:09 info: Aux: < \r\n+CGEV: NW MODIFY 4,0,0\r\n
> 12:51:16 info: Aux: < \r\n+CREG: 0\r\n
> 12:51:16 debug: ../git/src/network.c:ofono_netreg_status_notify() /ublox_0
> status 0 tech -1 lac -1 ci -1
> 12:51:16 debug: ../git/src/network.c:current_operator_callback() 0x6f2440,
> 0x6f2fe8
> 12:51:16 debug: ../git/src/gprs.c:netreg_status_changed() 0 (unregistered)
> 12:51:16 debug: ../git/src/gprs.c:gprs_netreg_update() attach: 0,
> driver_attached: 1
> 12:51:16 debug: ../git/src/gprs.c:netreg_status_changed() 0 (unregistered)
> 12:51:16 debug: ../git/src/gprs.c:gprs_netreg_update() attach: 0,
> driver_attached: 0
> 12:51:16 info: Aux: > AT\r
> 12:51:16 info: Aux: < \r\n+CIEV: 7,0\r\n
> 12:51:16 info: Aux: < \r\nOK\r\n
> 12:51:16 info: Aux: Finally woke up the modem
> 12:51:16 info: Aux: > AT+CGATT=3D0\r
> 12:51:16 info: Aux: < \r\n+CGREG: 4\r\n
> 12:51:16 debug: ../git/src/gprs.c:ofono_gprs_status_notify() /ublox_0
> status unknown (4)
> 12:51:16 info: Aux: < \r\n+UREG: 0\r\n
> 12:51:16 info: Aux: < \r\n+CIEV: 9,1\r\n
> 12:51:16 info: Aux: < \r\nOK\r\n
> 12:51:16 debug: ../git/src/gprs.c:gprs_attach_callback() /ublox_0 error =
=3D 0
> 12:51:16 info: Aux: > AT+CGREG?\r
> 12:51:16 info: Aux: < \r\n+CGREG: 2,4\r\n
> 12:51:16 info: Aux: < \r\nOK\r\n
> 12:51:16 debug: ../git/src/gprs.c:registration_status_cb() /ublox_0 error
> 0 status 4
> 12:51:16 debug: ../git/src/gprs.c:ofono_gprs_status_notify() /ublox_0
> status unknown (4)
> 12:51:27 info: Aux: < \r\n+CREG: 0\r\n
> 12:51:27 debug: ../git/src/network.c:ofono_netreg_status_notify() /ublox_0
> status 0 tech -1 lac -1 ci -1
> 12:51:27 debug: ../git/src/network.c:current_operator_callback() 0x6f2440,
> (nil)
> 12:51:27 debug: ../git/src/gprs.c:netreg_status_changed() 0 (unregistered)
> 12:51:27 debug: ../git/src/gprs.c:gprs_netreg_update() attach: 0,
> driver_attached: 0
> 12:51:27 info: Aux: < \r\n+CIEV: 2,2\r\n
> 12:51:30 info: Aux: < \r\n+CTZE: +08,1,"19/09/03,14:51:29"\r\n
> 12:51:30 debug:
> ../git/drivers/ubloxmodem/network-registration.c:ctze_notify() tz +08 dst=
 1
> time 19/09/03,14:51:29
> 12:51:30 debug: ../git/src/network.c:ofono_netreg_time_notify() net time
> 2019-09-03 14:51:29 utcoff 7200 dst 1
> 12:51:30 info: Aux: < \r\n+CREG: 5,"0080","00000006",2\r\n
> 12:51:30 debug: ../git/src/network.c:ofono_netreg_status_notify() /ublox_0
> status 5 tech 2 lac 128 ci 6
> 12:51:30 debug: ../git/src/gprs.c:netreg_status_changed() 5 (roaming)
> 12:51:30 debug: ../git/src/gprs.c:gprs_netreg_update() attach: 1,
> driver_attached: 0
> 12:51:30 info: Aux: > AT\r
> 12:51:30 info: Aux: < \r\n+CIEV: 7,1\r\n
> 12:51:30 info: Aux: < \r\nOK\r\n
> 12:51:30 info: Aux: Finally woke up the modem
> 12:51:30 info: Aux: > AT+COPS=3D3,2\r
> 12:51:30 info: Aux: < \r\nOK\r\n
> 12:51:30 info: Aux: > AT+COPS?\r
> 12:51:30 info: Aux: < \r\n+COPS: 0,2,"24002",2\r\n
> 12:51:30 info: Aux: < \r\nOK\r\n
> 12:51:30 debug:
> ../git/drivers/atmodem/network-registration.c:cops_numeric_cb() Cops
> numeric got mcc: 240, mnc: 02
> 12:51:30 info: Aux: > AT+CSQ\r
> 12:51:30 info: Aux: < \r\n+CSQ: 11,1\r\n
> 12:51:30 info: Aux: < \r\nOK\r\n
> 12:51:30 debug: ../git/drivers/atmodem/network-registration.c:csq_cb()
> csq_cb: 11
> 12:51:30 debug: ../git/src/network.c:ofono_netreg_strength_notify()
> strength 35
> 12:51:30 info: Aux: > AT+CGATT=3D1\r
> 12:51:37 info: Aux: < \r\n+CME ERROR: 148\r\n
> 12:51:37 debug: ../git/src/gprs.c:gprs_attach_callback() /ublox_0 error =
=3D 1
> 12:51:37 info: Aux: > AT+COPS=3D3,0\r
> 12:51:37 info: Aux: < \r\n+CIEV: 2,3\r\n
> 12:51:37 info: Aux: < \r\n+CREG: 0\r\n
> 12:51:37 debug: ../git/src/network.c:ofono_netreg_status_notify() /ublox_0
> status 0 tech -1 lac -1 ci -1
> 12:51:37 debug: ../git/src/network.c:current_operator_callback() 0x6f2440,
> (nil)
> 12:51:37 debug: ../git/src/gprs.c:netreg_status_changed() 0 (unregistered)
> 12:51:37 debug: ../git/src/gprs.c:gprs_netreg_update() attach: 0,
> driver_attached: 0
> 12:51:37 info: Aux: < \r\n+CIEV: 7,0\r\n\r\n+CREG: 3\r\n
> 12:51:37 debug: ../git/src/network.c:ofono_netreg_status_notify() /ublox_0
> status 3 tech -1 lac -1 ci -1
> 12:51:37 debug: ../git/src/network.c:current_operator_callback() 0x6f2440,
> (nil)
> 12:51:37 debug: ../git/src/gprs.c:netreg_status_changed() 3 (denied)
> 12:51:37 debug: ../git/src/gprs.c:gprs_netreg_update() attach: 0,
> driver_attached: 0
> 12:51:37 info: Aux: < \r\nOK\r\n
> 12:51:37 info: Aux: > AT+COPS?\r
> 12:51:37 info: Aux: < \r\n+COPS: 0\r\n
> 12:51:37 info: Aux: < \r\nOK\r\n
> 12:51:37 debug: ../git/src/network.c:current_operator_callback() 0x6f2440,
> (nil)
> 12:51:37 info: Aux: > AT+CGREG?\r
> 12:51:37 info: Aux: < \r\n+CGREG: 2,3\r\n
> 12:51:37 info: Aux: < \r\nOK\r\n
> 12:51:37 debug: ../git/src/gprs.c:registration_status_cb() /ublox_0 error
> 0 status 3
> 12:51:37 debug: ../git/src/gprs.c:ofono_gprs_status_notify() /ublox_0
> status denied (3)
> 12:51:47 info: Aux: < \r\n+CIEV: 2,1\r\n
> 12:51:48 info: Aux: < \r\n+CIEV: 2,2\r\n
> 12:51:49 info: Aux: < \r\n+CIEV: 2,1\r\n
> 12:51:50 info: Aux: < \r\n+CREG: 0\r\n
> 12:51:50 debug: ../git/src/network.c:ofono_netreg_status_notify() /ublox_0
> status 0 tech -1 lac -1 ci -1
> 12:51:50 debug: ../git/src/network.c:current_operator_callback() 0x6f2440,
> (nil)
> 12:51:50 debug: ../git/src/gprs.c:netreg_status_changed() 0 (unregistered)
> 12:51:50 debug: ../git/src/gprs.c:gprs_netreg_update() attach: 0,
> driver_attached: 0
> 12:51:50 info: Aux: < \r\n+CGREG: 5,"4E85","000003EA",2,"01"\r\n
> 12:51:50 debug: ../git/src/gprs.c:ofono_gprs_status_notify() /ublox_0
> status roaming (5)
> 12:51:50 info: Aux: < \r\n+UREG: 3\r\n
> 12:51:50 info: Aux: < \r\n+CIEV: 9,2\r\n
> 12:51:50 info: Aux: < \r\n+CTZE: +08,1,"19/09/03,14:51:50"\r\n
> 12:51:50 debug:
> ../git/drivers/ubloxmodem/network-registration.c:ctze_notify() tz +08 dst=
 1
> time 19/09/03,14:51:50
> 12:51:50 debug: ../git/src/network.c:ofono_netreg_time_notify() net time
> 2019-09-03 14:51:50 utcoff 7200 dst 1
> 12:51:50 info: Aux: < \r\n+CREG: 5,"0E63","8CD17D00",2\r\n
> 12:51:50 debug: ../git/src/network.c:ofono_netreg_status_notify() /ublox_0
> status 5 tech 2 lac 3683 ci 2147483647
> 12:51:50 debug: ../git/src/gprs.c:netreg_status_changed() 5 (roaming)
> 12:51:50 debug: ../git/src/gprs.c:gprs_netreg_update() attach: 1,
> driver_attached: 1
> 12:51:50 info: Aux: > AT\r
> 12:51:50 info: Aux: < \r\n+CIEV: 7,1\r\n
> 12:51:50 info: Aux: < \r\nOK\r\n
> 12:51:50 info: Aux: Finally woke up the modem
> 12:51:50 info: Aux: > AT+COPS=3D3,2\r
> 12:51:50 info: Aux: < \r\nOK\r\n
> 12:51:50 info: Aux: > AT+COPS?\r
> 12:51:50 info: Aux: < \r\n+COPS: 0,2,"24002",2\r\n
> 12:51:50 info: Aux: < \r\nOK\r\n
> 12:51:50 debug:
> ../git/drivers/atmodem/network-registration.c:cops_numeric_cb() Cops
> numeric got mcc: 240, mnc: 02
> 12:51:50 info: Aux: > AT+CSQ\r
> 12:51:50 info: Aux: < \r\n+CSQ: 8,1\r\n
> 12:51:50 info: Aux: < \r\nOK\r\n
> 12:51:50 debug: ../git/drivers/atmodem/network-registration.c:csq_cb()
> csq_cb: 8
> 12:51:50 debug: ../git/src/network.c:ofono_netreg_strength_notify()
> strength 25
> 12:51:50 info: Aux: > AT+COPS=3D3,0\r
> 12:51:50 info: Aux: < \r\nOK\r\n
> 12:51:50 info: Aux: > AT+COPS?\r
> 12:51:50 info: Aux: < \r\n+COPS: 0,0,"3 SE",2\r\n
> 12:51:50 info: Aux: < \r\nOK\r\n
> 12:51:50 debug: ../git/drivers/atmodem/network-registration.c:cops_cb()
> cops_cb: 3 SE, 240 02 2
> 12:51:50 debug: ../git/src/network.c:current_operator_callback() 0x6f2440,
> (nil)
> 12:51:50 debug: ../git/src/gprs.c:netreg_status_changed() 5 (roaming)
> 12:51:50 debug: ../git/src/gprs.c:gprs_netreg_update() attach: 1,
> driver_attached: 1
> 12:51:52 info: Aux: < \r\n+CGEV: ME PDN DEACT 4\r\n
> 12:51:53 info: Aux: < \r\n+CIEV: 2,2\r\n
> 12:52:03 info: Aux: < \r\n+CIEV: 2,1\r\n
> 12:52:08 info: Aux: < \r\n+CIEV: 2,2\r\n
> 12:52:14 info: Aux: < \r\n+CIEV: 2,1\r\n
>
> Den tis 3 sep. 2019 kl 16:06 skrev <richard.rojfors@gmail.com>:
>
>> From: Richard R=C3=B6jfors <richard@puffinpack.se>
>>
>> In case a context get deactivated when a AT+CGACT=3D0 is
>> not issued, indicate that to gprs core.
>> This can happen if the device has an auto activated
>> LTE context and modem switches over to for instance UTRAN.
>> ---
>>  drivers/ubloxmodem/gprs-context.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ubloxmodem/gprs-context.c
>> b/drivers/ubloxmodem/gprs-context.c
>> index ff78a42a..188c2c62 100644
>> --- a/drivers/ubloxmodem/gprs-context.c
>> +++ b/drivers/ubloxmodem/gprs-context.c
>> @@ -40,6 +40,8 @@
>>
>>  #include "ubloxmodem.h"
>>
>> +#define UBLOX_FLAG_DEACTIVATING 0x01
>> +
>>  static const char *none_prefix[] =3D { NULL };
>>  static const char *cgcontrdp_prefix[] =3D { "+CGCONTRDP:", NULL };
>>  static const char *uipaddr_prefix[] =3D { "+UIPADDR:", NULL };
>> @@ -57,6 +59,7 @@ struct gprs_context_data {
>>         ofono_gprs_context_cb_t cb;
>>         void *cb_data;
>>         enum netmode networking_mode;
>> +       int flags;
>>  };
>>
>>  static void uipaddr_cb(gboolean ok, GAtResult *result, gpointer
>> user_data)
>> @@ -426,6 +429,8 @@ static void cgact_disable_cb(gboolean ok, GAtResult
>> *result, gpointer user_data)
>>
>>         DBG("ok %d", ok);
>>
>> +       gcd->flags &=3D ~UBLOX_FLAG_DEACTIVATING;
>> +
>>         if (!ok) {
>>                 CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
>>                 return;
>> @@ -448,6 +453,8 @@ static void ublox_gprs_deactivate_primary(struct
>> ofono_gprs_context *gc,
>>         gcd->cb =3D cb;
>>         gcd->cb_data =3D data;
>>
>> +       gcd->flags |=3D UBLOX_FLAG_DEACTIVATING;
>> +
>>         snprintf(buf, sizeof(buf), "AT+CGACT=3D0,%u", gcd->active_contex=
t);
>>         g_at_chat_send(gcd->chat, buf, none_prefix,
>>                         cgact_disable_cb, gc, NULL);
>> @@ -473,10 +480,16 @@ static void cgev_notify(GAtResult *result, gpointer
>> user_data)
>>                 sscanf(event, "%*s %*s %*s %u", &cid);
>>         else if (g_str_has_prefix(event, "NW DEACT"))
>>                 sscanf(event, "%*s %*s %u", &cid);
>> +       else if (!(gcd->flags & UBLOX_FLAG_DEACTIVATING) &&
>> +                g_str_has_prefix(event, "ME PDN DEACT"))
>> +               /* The modem might consider the ME deactivating without
>> +                * an explicit CGACT=3D0 beeing sent
>> +                */
>> +               sscanf(event, "%*s %*s %*s %u", &cid);
>>         else
>>                 return;
>>
>> -       DBG("cid %d", cid);
>> +       DBG("cid %d, active cid: %d", cid, gcd->active_context);
>>
>>         if ((unsigned int) cid !=3D gcd->active_context)
>>                 return;
>> --
>> 2.20.1
>>
>>

--===============7953385066795987721==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9ImF1dG8iPjxkaXY+PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRp
diBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFR1ZSwgU2VwIDMsIDIwMTksIDE2OjEx
IFJpY2hhcmQgUsO2amZvcnMgJmx0OzxhIGhyZWY9Im1haWx0bzpyaWNoYXJkLnJvamZvcnNAZ21h
aWwuY29tIj5yaWNoYXJkLnJvamZvcnNAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2
PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4
O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJs
dHIiPkhpLDxkaXY+PGJyPjwvZGl2PjxkaXY+QW4gZXhhbXBsZSBsb2cgd2hlbiB0aGlzIGhhcHBl
bmVkLiBJbiB0aGlzIGNhc2Ugb2Zvbm8gdGhvdWdodCBjb250ZXh0IDQgd2FzIHN0aWxsIGFjdGl2
YXRlZDwvZGl2PjxkaXY+ZXZlbiB0aG91Z2ggaXQgd2FzIGRlYWN0aXZhdGVkPGJyPjwvZGl2Pjwv
ZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+PGJyPjwvZGl2Pjxk
aXYgZGlyPSJhdXRvIj5ZZXMsIEkmIzM5O3ZlIHNlZW4gdGhpcywgdG9vLCBhbmQgaGF2ZSBhIHNp
bWlsYXIgcGF0Y2ggdGhhdCBJIG5ldmVyIGdvdCBhcm91bmQgdG8gc2VuZGluZy4gUGxlYXNlIGFw
cGx5LsKgPC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxicj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+L0pv
bmFzwqA8L2Rpdj48ZGl2IGRpcj0iYXV0byI+PGJyPjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48ZGl2
IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHls
ZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1s
ZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRpdj48YnI+MTI6NDc6NTIgaW5mbzogQXV4OiAmbHQ7
IFxyXG4rQ0lFVjogOSwyXHJcbjxicj4xMjo1MDozNyBpbmZvOiBBdXg6ICZsdDsgXHJcbitDSUVW
OiAyLDJcclxuPGJyPjEyOjUwOjQyIGluZm86IEF1eDogJmx0OyBcclxuK0NJRVY6IDIsMVxyXG48
YnI+MTI6NTE6MDYgaW5mbzogQXV4OiAmbHQ7IFxyXG4rQ0lFVjogMiwwXHJcbjxicj4xMjo1MTow
OCBpbmZvOiBBdXg6ICZsdDsgXHJcbitDR1JFRzogNSwmcXVvdDswMDRCJnF1b3Q7LCZxdW90OzAw
MDBFNDA0JnF1b3Q7LDYsJnF1b3Q7MDEmcXVvdDtcclxuPGJyPjEyOjUxOjA4IGRlYnVnOiAuLi9n
aXQvc3JjL2dwcnMuYzpvZm9ub19ncHJzX3N0YXR1c19ub3RpZnkoKSAvdWJsb3hfMCBzdGF0dXMg
cm9hbWluZyAoNSk8YnI+MTI6NTE6MDggaW5mbzogQXV4OiAmbHQ7IFxyXG4rVVJFRzogNlxyXG48
YnI+MTI6NTE6MDggaW5mbzogQXV4OiAmbHQ7IFxyXG4rQ0lFVjogOSwyXHJcbjxicj4xMjo1MTow
OCBpbmZvOiBBdXg6ICZsdDsgXHJcbitDSUVWOiA5LDFcclxuPGJyPjEyOjUxOjA5IGluZm86IEF1
eDogJmx0OyBcclxuK0NHRVY6IE5XIE1PRElGWSA0LDAsMFxyXG48YnI+MTI6NTE6MTYgaW5mbzog
QXV4OiAmbHQ7IFxyXG4rQ1JFRzogMFxyXG48YnI+MTI6NTE6MTYgZGVidWc6IC4uL2dpdC9zcmMv
bmV0d29yay5jOm9mb25vX25ldHJlZ19zdGF0dXNfbm90aWZ5KCkgL3VibG94XzAgc3RhdHVzIDAg
dGVjaCAtMSBsYWMgLTEgY2kgLTE8YnI+MTI6NTE6MTYgZGVidWc6IC4uL2dpdC9zcmMvbmV0d29y
ay5jOmN1cnJlbnRfb3BlcmF0b3JfY2FsbGJhY2soKSAweDZmMjQ0MCwgMHg2ZjJmZTg8YnI+MTI6
NTE6MTYgZGVidWc6IC4uL2dpdC9zcmMvZ3Bycy5jOm5ldHJlZ19zdGF0dXNfY2hhbmdlZCgpIDAg
KHVucmVnaXN0ZXJlZCk8YnI+MTI6NTE6MTYgZGVidWc6IC4uL2dpdC9zcmMvZ3Bycy5jOmdwcnNf
bmV0cmVnX3VwZGF0ZSgpIGF0dGFjaDogMCwgZHJpdmVyX2F0dGFjaGVkOiAxPGJyPjEyOjUxOjE2
IGRlYnVnOiAuLi9naXQvc3JjL2dwcnMuYzpuZXRyZWdfc3RhdHVzX2NoYW5nZWQoKSAwICh1bnJl
Z2lzdGVyZWQpPGJyPjEyOjUxOjE2IGRlYnVnOiAuLi9naXQvc3JjL2dwcnMuYzpncHJzX25ldHJl
Z191cGRhdGUoKSBhdHRhY2g6IDAsIGRyaXZlcl9hdHRhY2hlZDogMDxicj4xMjo1MToxNiBpbmZv
OiBBdXg6ICZndDsgQVRccjxicj4xMjo1MToxNiBpbmZvOiBBdXg6ICZsdDsgXHJcbitDSUVWOiA3
LDBcclxuPGJyPjEyOjUxOjE2IGluZm86IEF1eDogJmx0OyBcclxuT0tcclxuPGJyPjEyOjUxOjE2
IGluZm86IEF1eDogRmluYWxseSB3b2tlIHVwIHRoZSBtb2RlbTxicj4xMjo1MToxNiBpbmZvOiBB
dXg6ICZndDsgQVQrQ0dBVFQ9MFxyPGJyPjEyOjUxOjE2IGluZm86IEF1eDogJmx0OyBcclxuK0NH
UkVHOiA0XHJcbjxicj4xMjo1MToxNiBkZWJ1ZzogLi4vZ2l0L3NyYy9ncHJzLmM6b2Zvbm9fZ3By
c19zdGF0dXNfbm90aWZ5KCkgL3VibG94XzAgc3RhdHVzIHVua25vd24gKDQpPGJyPjEyOjUxOjE2
IGluZm86IEF1eDogJmx0OyBcclxuK1VSRUc6IDBcclxuPGJyPjEyOjUxOjE2IGluZm86IEF1eDog
Jmx0OyBcclxuK0NJRVY6IDksMVxyXG48YnI+MTI6NTE6MTYgaW5mbzogQXV4OiAmbHQ7IFxyXG5P
S1xyXG48YnI+MTI6NTE6MTYgZGVidWc6IC4uL2dpdC9zcmMvZ3Bycy5jOmdwcnNfYXR0YWNoX2Nh
bGxiYWNrKCkgL3VibG94XzAgZXJyb3IgPSAwPGJyPjEyOjUxOjE2IGluZm86IEF1eDogJmd0OyBB
VCtDR1JFRz9ccjxicj4xMjo1MToxNiBpbmZvOiBBdXg6ICZsdDsgXHJcbitDR1JFRzogMiw0XHJc
bjxicj4xMjo1MToxNiBpbmZvOiBBdXg6ICZsdDsgXHJcbk9LXHJcbjxicj4xMjo1MToxNiBkZWJ1
ZzogLi4vZ2l0L3NyYy9ncHJzLmM6cmVnaXN0cmF0aW9uX3N0YXR1c19jYigpIC91YmxveF8wIGVy
cm9yIDAgc3RhdHVzIDQ8YnI+MTI6NTE6MTYgZGVidWc6IC4uL2dpdC9zcmMvZ3Bycy5jOm9mb25v
X2dwcnNfc3RhdHVzX25vdGlmeSgpIC91YmxveF8wIHN0YXR1cyB1bmtub3duICg0KTxicj4xMjo1
MToyNyBpbmZvOiBBdXg6ICZsdDsgXHJcbitDUkVHOiAwXHJcbjxicj4xMjo1MToyNyBkZWJ1Zzog
Li4vZ2l0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX3N0YXR1c19ub3RpZnkoKSAvdWJsb3hf
MCBzdGF0dXMgMCB0ZWNoIC0xIGxhYyAtMSBjaSAtMTxicj4xMjo1MToyNyBkZWJ1ZzogLi4vZ2l0
L3NyYy9uZXR3b3JrLmM6Y3VycmVudF9vcGVyYXRvcl9jYWxsYmFjaygpIDB4NmYyNDQwLCAobmls
KTxicj4xMjo1MToyNyBkZWJ1ZzogLi4vZ2l0L3NyYy9ncHJzLmM6bmV0cmVnX3N0YXR1c19jaGFu
Z2VkKCkgMCAodW5yZWdpc3RlcmVkKTxicj4xMjo1MToyNyBkZWJ1ZzogLi4vZ2l0L3NyYy9ncHJz
LmM6Z3Byc19uZXRyZWdfdXBkYXRlKCkgYXR0YWNoOiAwLCBkcml2ZXJfYXR0YWNoZWQ6IDA8YnI+
MTI6NTE6MjcgaW5mbzogQXV4OiAmbHQ7IFxyXG4rQ0lFVjogMiwyXHJcbjxicj4xMjo1MTozMCBp
bmZvOiBBdXg6ICZsdDsgXHJcbitDVFpFOiArMDgsMSwmcXVvdDsxOS8wOS8wMywxNDo1MToyOSZx
dW90O1xyXG48YnI+MTI6NTE6MzAgZGVidWc6IC4uL2dpdC9kcml2ZXJzL3VibG94bW9kZW0vbmV0
d29yay1yZWdpc3RyYXRpb24uYzpjdHplX25vdGlmeSgpIHR6ICswOCBkc3QgMSB0aW1lIDE5LzA5
LzAzLDE0OjUxOjI5PGJyPjEyOjUxOjMwIGRlYnVnOiAuLi9naXQvc3JjL25ldHdvcmsuYzpvZm9u
b19uZXRyZWdfdGltZV9ub3RpZnkoKSBuZXQgdGltZSAyMDE5LTA5LTAzIDE0OjUxOjI5IHV0Y29m
ZiA3MjAwIGRzdCAxPGJyPjEyOjUxOjMwIGluZm86IEF1eDogJmx0OyBcclxuK0NSRUc6IDUsJnF1
b3Q7MDA4MCZxdW90OywmcXVvdDswMDAwMDAwNiZxdW90OywyXHJcbjxicj4xMjo1MTozMCBkZWJ1
ZzogLi4vZ2l0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX3N0YXR1c19ub3RpZnkoKSAvdWJs
b3hfMCBzdGF0dXMgNSB0ZWNoIDIgbGFjIDEyOCBjaSA2PGJyPjEyOjUxOjMwIGRlYnVnOiAuLi9n
aXQvc3JjL2dwcnMuYzpuZXRyZWdfc3RhdHVzX2NoYW5nZWQoKSA1IChyb2FtaW5nKTxicj4xMjo1
MTozMCBkZWJ1ZzogLi4vZ2l0L3NyYy9ncHJzLmM6Z3Byc19uZXRyZWdfdXBkYXRlKCkgYXR0YWNo
OiAxLCBkcml2ZXJfYXR0YWNoZWQ6IDA8YnI+MTI6NTE6MzAgaW5mbzogQXV4OiAmZ3Q7IEFUXHI8
YnI+MTI6NTE6MzAgaW5mbzogQXV4OiAmbHQ7IFxyXG4rQ0lFVjogNywxXHJcbjxicj4xMjo1MToz
MCBpbmZvOiBBdXg6ICZsdDsgXHJcbk9LXHJcbjxicj4xMjo1MTozMCBpbmZvOiBBdXg6IEZpbmFs
bHkgd29rZSB1cCB0aGUgbW9kZW08YnI+MTI6NTE6MzAgaW5mbzogQXV4OiAmZ3Q7IEFUK0NPUFM9
MywyXHI8YnI+MTI6NTE6MzAgaW5mbzogQXV4OiAmbHQ7IFxyXG5PS1xyXG48YnI+MTI6NTE6MzAg
aW5mbzogQXV4OiAmZ3Q7IEFUK0NPUFM/XHI8YnI+MTI6NTE6MzAgaW5mbzogQXV4OiAmbHQ7IFxy
XG4rQ09QUzogMCwyLCZxdW90OzI0MDAyJnF1b3Q7LDJcclxuPGJyPjEyOjUxOjMwIGluZm86IEF1
eDogJmx0OyBcclxuT0tcclxuPGJyPjEyOjUxOjMwIGRlYnVnOiAuLi9naXQvZHJpdmVycy9hdG1v
ZGVtL25ldHdvcmstcmVnaXN0cmF0aW9uLmM6Y29wc19udW1lcmljX2NiKCkgQ29wcyBudW1lcmlj
IGdvdCBtY2M6IDI0MCwgbW5jOiAwMjxicj4xMjo1MTozMCBpbmZvOiBBdXg6ICZndDsgQVQrQ1NR
XHI8YnI+MTI6NTE6MzAgaW5mbzogQXV4OiAmbHQ7IFxyXG4rQ1NROiAxMSwxXHJcbjxicj4xMjo1
MTozMCBpbmZvOiBBdXg6ICZsdDsgXHJcbk9LXHJcbjxicj4xMjo1MTozMCBkZWJ1ZzogLi4vZ2l0
L2RyaXZlcnMvYXRtb2RlbS9uZXR3b3JrLXJlZ2lzdHJhdGlvbi5jOmNzcV9jYigpIGNzcV9jYjog
MTE8YnI+MTI6NTE6MzAgZGVidWc6IC4uL2dpdC9zcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19z
dHJlbmd0aF9ub3RpZnkoKSBzdHJlbmd0aCAzNTxicj4xMjo1MTozMCBpbmZvOiBBdXg6ICZndDsg
QVQrQ0dBVFQ9MVxyPGJyPjEyOjUxOjM3IGluZm86IEF1eDogJmx0OyBcclxuK0NNRSBFUlJPUjog
MTQ4XHJcbjxicj4xMjo1MTozNyBkZWJ1ZzogLi4vZ2l0L3NyYy9ncHJzLmM6Z3Byc19hdHRhY2hf
Y2FsbGJhY2soKSAvdWJsb3hfMCBlcnJvciA9IDE8YnI+MTI6NTE6MzcgaW5mbzogQXV4OiAmZ3Q7
IEFUK0NPUFM9MywwXHI8YnI+MTI6NTE6MzcgaW5mbzogQXV4OiAmbHQ7IFxyXG4rQ0lFVjogMiwz
XHJcbjxicj4xMjo1MTozNyBpbmZvOiBBdXg6ICZsdDsgXHJcbitDUkVHOiAwXHJcbjxicj4xMjo1
MTozNyBkZWJ1ZzogLi4vZ2l0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX3N0YXR1c19ub3Rp
ZnkoKSAvdWJsb3hfMCBzdGF0dXMgMCB0ZWNoIC0xIGxhYyAtMSBjaSAtMTxicj4xMjo1MTozNyBk
ZWJ1ZzogLi4vZ2l0L3NyYy9uZXR3b3JrLmM6Y3VycmVudF9vcGVyYXRvcl9jYWxsYmFjaygpIDB4
NmYyNDQwLCAobmlsKTxicj4xMjo1MTozNyBkZWJ1ZzogLi4vZ2l0L3NyYy9ncHJzLmM6bmV0cmVn
X3N0YXR1c19jaGFuZ2VkKCkgMCAodW5yZWdpc3RlcmVkKTxicj4xMjo1MTozNyBkZWJ1ZzogLi4v
Z2l0L3NyYy9ncHJzLmM6Z3Byc19uZXRyZWdfdXBkYXRlKCkgYXR0YWNoOiAwLCBkcml2ZXJfYXR0
YWNoZWQ6IDA8YnI+MTI6NTE6MzcgaW5mbzogQXV4OiAmbHQ7IFxyXG4rQ0lFVjogNywwXHJcblxy
XG4rQ1JFRzogM1xyXG48YnI+MTI6NTE6MzcgZGVidWc6IC4uL2dpdC9zcmMvbmV0d29yay5jOm9m
b25vX25ldHJlZ19zdGF0dXNfbm90aWZ5KCkgL3VibG94XzAgc3RhdHVzIDMgdGVjaCAtMSBsYWMg
LTEgY2kgLTE8YnI+MTI6NTE6MzcgZGVidWc6IC4uL2dpdC9zcmMvbmV0d29yay5jOmN1cnJlbnRf
b3BlcmF0b3JfY2FsbGJhY2soKSAweDZmMjQ0MCwgKG5pbCk8YnI+MTI6NTE6MzcgZGVidWc6IC4u
L2dpdC9zcmMvZ3Bycy5jOm5ldHJlZ19zdGF0dXNfY2hhbmdlZCgpIDMgKGRlbmllZCk8YnI+MTI6
NTE6MzcgZGVidWc6IC4uL2dpdC9zcmMvZ3Bycy5jOmdwcnNfbmV0cmVnX3VwZGF0ZSgpIGF0dGFj
aDogMCwgZHJpdmVyX2F0dGFjaGVkOiAwPGJyPjEyOjUxOjM3IGluZm86IEF1eDogJmx0OyBcclxu
T0tcclxuPGJyPjEyOjUxOjM3IGluZm86IEF1eDogJmd0OyBBVCtDT1BTP1xyPGJyPjEyOjUxOjM3
IGluZm86IEF1eDogJmx0OyBcclxuK0NPUFM6IDBcclxuPGJyPjEyOjUxOjM3IGluZm86IEF1eDog
Jmx0OyBcclxuT0tcclxuPGJyPjEyOjUxOjM3IGRlYnVnOiAuLi9naXQvc3JjL25ldHdvcmsuYzpj
dXJyZW50X29wZXJhdG9yX2NhbGxiYWNrKCkgMHg2ZjI0NDAsIChuaWwpPGJyPjEyOjUxOjM3IGlu
Zm86IEF1eDogJmd0OyBBVCtDR1JFRz9ccjxicj4xMjo1MTozNyBpbmZvOiBBdXg6ICZsdDsgXHJc
bitDR1JFRzogMiwzXHJcbjxicj4xMjo1MTozNyBpbmZvOiBBdXg6ICZsdDsgXHJcbk9LXHJcbjxi
cj4xMjo1MTozNyBkZWJ1ZzogLi4vZ2l0L3NyYy9ncHJzLmM6cmVnaXN0cmF0aW9uX3N0YXR1c19j
YigpIC91YmxveF8wIGVycm9yIDAgc3RhdHVzIDM8YnI+MTI6NTE6MzcgZGVidWc6IC4uL2dpdC9z
cmMvZ3Bycy5jOm9mb25vX2dwcnNfc3RhdHVzX25vdGlmeSgpIC91YmxveF8wIHN0YXR1cyBkZW5p
ZWQgKDMpPGJyPjEyOjUxOjQ3IGluZm86IEF1eDogJmx0OyBcclxuK0NJRVY6IDIsMVxyXG48YnI+
MTI6NTE6NDggaW5mbzogQXV4OiAmbHQ7IFxyXG4rQ0lFVjogMiwyXHJcbjxicj4xMjo1MTo0OSBp
bmZvOiBBdXg6ICZsdDsgXHJcbitDSUVWOiAyLDFcclxuPGJyPjEyOjUxOjUwIGluZm86IEF1eDog
Jmx0OyBcclxuK0NSRUc6IDBcclxuPGJyPjEyOjUxOjUwIGRlYnVnOiAuLi9naXQvc3JjL25ldHdv
cmsuYzpvZm9ub19uZXRyZWdfc3RhdHVzX25vdGlmeSgpIC91YmxveF8wIHN0YXR1cyAwIHRlY2gg
LTEgbGFjIC0xIGNpIC0xPGJyPjEyOjUxOjUwIGRlYnVnOiAuLi9naXQvc3JjL25ldHdvcmsuYzpj
dXJyZW50X29wZXJhdG9yX2NhbGxiYWNrKCkgMHg2ZjI0NDAsIChuaWwpPGJyPjEyOjUxOjUwIGRl
YnVnOiAuLi9naXQvc3JjL2dwcnMuYzpuZXRyZWdfc3RhdHVzX2NoYW5nZWQoKSAwICh1bnJlZ2lz
dGVyZWQpPGJyPjEyOjUxOjUwIGRlYnVnOiAuLi9naXQvc3JjL2dwcnMuYzpncHJzX25ldHJlZ191
cGRhdGUoKSBhdHRhY2g6IDAsIGRyaXZlcl9hdHRhY2hlZDogMDxicj4xMjo1MTo1MCBpbmZvOiBB
dXg6ICZsdDsgXHJcbitDR1JFRzogNSwmcXVvdDs0RTg1JnF1b3Q7LCZxdW90OzAwMDAwM0VBJnF1
b3Q7LDIsJnF1b3Q7MDEmcXVvdDtcclxuPGJyPjEyOjUxOjUwIGRlYnVnOiAuLi9naXQvc3JjL2dw
cnMuYzpvZm9ub19ncHJzX3N0YXR1c19ub3RpZnkoKSAvdWJsb3hfMCBzdGF0dXMgcm9hbWluZyAo
NSk8YnI+MTI6NTE6NTAgaW5mbzogQXV4OiAmbHQ7IFxyXG4rVVJFRzogM1xyXG48YnI+MTI6NTE6
NTAgaW5mbzogQXV4OiAmbHQ7IFxyXG4rQ0lFVjogOSwyXHJcbjxicj4xMjo1MTo1MCBpbmZvOiBB
dXg6ICZsdDsgXHJcbitDVFpFOiArMDgsMSwmcXVvdDsxOS8wOS8wMywxNDo1MTo1MCZxdW90O1xy
XG48YnI+MTI6NTE6NTAgZGVidWc6IC4uL2dpdC9kcml2ZXJzL3VibG94bW9kZW0vbmV0d29yay1y
ZWdpc3RyYXRpb24uYzpjdHplX25vdGlmeSgpIHR6ICswOCBkc3QgMSB0aW1lIDE5LzA5LzAzLDE0
OjUxOjUwPGJyPjEyOjUxOjUwIGRlYnVnOiAuLi9naXQvc3JjL25ldHdvcmsuYzpvZm9ub19uZXRy
ZWdfdGltZV9ub3RpZnkoKSBuZXQgdGltZSAyMDE5LTA5LTAzIDE0OjUxOjUwIHV0Y29mZiA3MjAw
IGRzdCAxPGJyPjEyOjUxOjUwIGluZm86IEF1eDogJmx0OyBcclxuK0NSRUc6IDUsJnF1b3Q7MEU2
MyZxdW90OywmcXVvdDs4Q0QxN0QwMCZxdW90OywyXHJcbjxicj4xMjo1MTo1MCBkZWJ1ZzogLi4v
Z2l0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX3N0YXR1c19ub3RpZnkoKSAvdWJsb3hfMCBz
dGF0dXMgNSB0ZWNoIDIgbGFjIDM2ODMgY2kgMjE0NzQ4MzY0Nzxicj4xMjo1MTo1MCBkZWJ1Zzog
Li4vZ2l0L3NyYy9ncHJzLmM6bmV0cmVnX3N0YXR1c19jaGFuZ2VkKCkgNSAocm9hbWluZyk8YnI+
MTI6NTE6NTAgZGVidWc6IC4uL2dpdC9zcmMvZ3Bycy5jOmdwcnNfbmV0cmVnX3VwZGF0ZSgpIGF0
dGFjaDogMSwgZHJpdmVyX2F0dGFjaGVkOiAxPGJyPjEyOjUxOjUwIGluZm86IEF1eDogJmd0OyBB
VFxyPGJyPjEyOjUxOjUwIGluZm86IEF1eDogJmx0OyBcclxuK0NJRVY6IDcsMVxyXG48YnI+MTI6
NTE6NTAgaW5mbzogQXV4OiAmbHQ7IFxyXG5PS1xyXG48YnI+MTI6NTE6NTAgaW5mbzogQXV4OiBG
aW5hbGx5IHdva2UgdXAgdGhlIG1vZGVtPGJyPjEyOjUxOjUwIGluZm86IEF1eDogJmd0OyBBVCtD
T1BTPTMsMlxyPGJyPjEyOjUxOjUwIGluZm86IEF1eDogJmx0OyBcclxuT0tcclxuPGJyPjEyOjUx
OjUwIGluZm86IEF1eDogJmd0OyBBVCtDT1BTP1xyPGJyPjEyOjUxOjUwIGluZm86IEF1eDogJmx0
OyBcclxuK0NPUFM6IDAsMiwmcXVvdDsyNDAwMiZxdW90OywyXHJcbjxicj4xMjo1MTo1MCBpbmZv
OiBBdXg6ICZsdDsgXHJcbk9LXHJcbjxicj4xMjo1MTo1MCBkZWJ1ZzogLi4vZ2l0L2RyaXZlcnMv
YXRtb2RlbS9uZXR3b3JrLXJlZ2lzdHJhdGlvbi5jOmNvcHNfbnVtZXJpY19jYigpIENvcHMgbnVt
ZXJpYyBnb3QgbWNjOiAyNDAsIG1uYzogMDI8YnI+MTI6NTE6NTAgaW5mbzogQXV4OiAmZ3Q7IEFU
K0NTUVxyPGJyPjEyOjUxOjUwIGluZm86IEF1eDogJmx0OyBcclxuK0NTUTogOCwxXHJcbjxicj4x
Mjo1MTo1MCBpbmZvOiBBdXg6ICZsdDsgXHJcbk9LXHJcbjxicj4xMjo1MTo1MCBkZWJ1ZzogLi4v
Z2l0L2RyaXZlcnMvYXRtb2RlbS9uZXR3b3JrLXJlZ2lzdHJhdGlvbi5jOmNzcV9jYigpIGNzcV9j
YjogODxicj4xMjo1MTo1MCBkZWJ1ZzogLi4vZ2l0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVn
X3N0cmVuZ3RoX25vdGlmeSgpIHN0cmVuZ3RoIDI1PGJyPjEyOjUxOjUwIGluZm86IEF1eDogJmd0
OyBBVCtDT1BTPTMsMFxyPGJyPjEyOjUxOjUwIGluZm86IEF1eDogJmx0OyBcclxuT0tcclxuPGJy
PjEyOjUxOjUwIGluZm86IEF1eDogJmd0OyBBVCtDT1BTP1xyPGJyPjEyOjUxOjUwIGluZm86IEF1
eDogJmx0OyBcclxuK0NPUFM6IDAsMCwmcXVvdDszIFNFJnF1b3Q7LDJcclxuPGJyPjEyOjUxOjUw
IGluZm86IEF1eDogJmx0OyBcclxuT0tcclxuPGJyPjEyOjUxOjUwIGRlYnVnOiAuLi9naXQvZHJp
dmVycy9hdG1vZGVtL25ldHdvcmstcmVnaXN0cmF0aW9uLmM6Y29wc19jYigpIGNvcHNfY2I6IDMg
U0UsIDI0MCAwMiAyPGJyPjEyOjUxOjUwIGRlYnVnOiAuLi9naXQvc3JjL25ldHdvcmsuYzpjdXJy
ZW50X29wZXJhdG9yX2NhbGxiYWNrKCkgMHg2ZjI0NDAsIChuaWwpPGJyPjEyOjUxOjUwIGRlYnVn
OiAuLi9naXQvc3JjL2dwcnMuYzpuZXRyZWdfc3RhdHVzX2NoYW5nZWQoKSA1IChyb2FtaW5nKTxi
cj4xMjo1MTo1MCBkZWJ1ZzogLi4vZ2l0L3NyYy9ncHJzLmM6Z3Byc19uZXRyZWdfdXBkYXRlKCkg
YXR0YWNoOiAxLCBkcml2ZXJfYXR0YWNoZWQ6IDE8YnI+MTI6NTE6NTIgaW5mbzogQXV4OiAmbHQ7
IFxyXG4rQ0dFVjogTUUgUEROIERFQUNUIDRcclxuPGJyPjEyOjUxOjUzIGluZm86IEF1eDogJmx0
OyBcclxuK0NJRVY6IDIsMlxyXG48YnI+MTI6NTI6MDMgaW5mbzogQXV4OiAmbHQ7IFxyXG4rQ0lF
VjogMiwxXHJcbjxicj4xMjo1MjowOCBpbmZvOiBBdXg6ICZsdDsgXHJcbitDSUVWOiAyLDJcclxu
PGJyPjEyOjUyOjE0IGluZm86IEF1eDogJmx0OyBcclxuK0NJRVY6IDIsMVxyXG48YnI+PC9kaXY+
PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0i
Z21haWxfYXR0ciI+RGVuIHRpcyAzIHNlcC4gMjAxOSBrbCAxNjowNiBza3JldiAmbHQ7PGEgaHJl
Zj0ibWFpbHRvOnJpY2hhcmQucm9qZm9yc0BnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIiByZWw9
Im5vcmVmZXJyZXIiPnJpY2hhcmQucm9qZm9yc0BnbWFpbC5jb208L2E+Jmd0Ozo8YnI+PC9kaXY+
PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4
IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVm
dDoxZXgiPkZyb206IFJpY2hhcmQgUsO2amZvcnMgJmx0OzxhIGhyZWY9Im1haWx0bzpyaWNoYXJk
QHB1ZmZpbnBhY2suc2UiIHRhcmdldD0iX2JsYW5rIiByZWw9Im5vcmVmZXJyZXIiPnJpY2hhcmRA
cHVmZmlucGFjay5zZTwvYT4mZ3Q7PGJyPgo8YnI+CkluIGNhc2UgYSBjb250ZXh0IGdldCBkZWFj
dGl2YXRlZCB3aGVuIGEgQVQrQ0dBQ1Q9MCBpczxicj4Kbm90IGlzc3VlZCwgaW5kaWNhdGUgdGhh
dCB0byBncHJzIGNvcmUuPGJyPgpUaGlzIGNhbiBoYXBwZW4gaWYgdGhlIGRldmljZSBoYXMgYW4g
YXV0byBhY3RpdmF0ZWQ8YnI+CkxURSBjb250ZXh0IGFuZCBtb2RlbSBzd2l0Y2hlcyBvdmVyIHRv
IGZvciBpbnN0YW5jZSBVVFJBTi48YnI+Ci0tLTxicj4KwqBkcml2ZXJzL3VibG94bW9kZW0vZ3By
cy1jb250ZXh0LmMgfCAxNSArKysrKysrKysrKysrKy08YnI+CsKgMSBmaWxlIGNoYW5nZWQsIDE0
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSk8YnI+Cjxicj4KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdWJsb3htb2RlbS9ncHJzLWNvbnRleHQuYyBiL2RyaXZlcnMvdWJsb3htb2RlbS9ncHJzLWNv
bnRleHQuYzxicj4KaW5kZXggZmY3OGE0MmEuLjE4OGMyYzYyIDEwMDY0NDxicj4KLS0tIGEvZHJp
dmVycy91YmxveG1vZGVtL2dwcnMtY29udGV4dC5jPGJyPgorKysgYi9kcml2ZXJzL3VibG94bW9k
ZW0vZ3Bycy1jb250ZXh0LmM8YnI+CkBAIC00MCw2ICs0MCw4IEBAPGJyPgo8YnI+CsKgI2luY2x1
ZGUgJnF1b3Q7dWJsb3htb2RlbS5oJnF1b3Q7PGJyPgo8YnI+CisjZGVmaW5lIFVCTE9YX0ZMQUdf
REVBQ1RJVkFUSU5HIDB4MDE8YnI+Cis8YnI+CsKgc3RhdGljIGNvbnN0IGNoYXIgKm5vbmVfcHJl
Zml4W10gPSB7IE5VTEwgfTs8YnI+CsKgc3RhdGljIGNvbnN0IGNoYXIgKmNnY29udHJkcF9wcmVm
aXhbXSA9IHsgJnF1b3Q7K0NHQ09OVFJEUDomcXVvdDssIE5VTEwgfTs8YnI+CsKgc3RhdGljIGNv
bnN0IGNoYXIgKnVpcGFkZHJfcHJlZml4W10gPSB7ICZxdW90OytVSVBBRERSOiZxdW90OywgTlVM
TCB9Ozxicj4KQEAgLTU3LDYgKzU5LDcgQEAgc3RydWN0IGdwcnNfY29udGV4dF9kYXRhIHs8YnI+
CsKgIMKgIMKgIMKgIG9mb25vX2dwcnNfY29udGV4dF9jYl90IGNiOzxicj4KwqAgwqAgwqAgwqAg
dm9pZCAqY2JfZGF0YTs8YnI+CsKgIMKgIMKgIMKgIGVudW0gbmV0bW9kZSBuZXR3b3JraW5nX21v
ZGU7PGJyPgorwqAgwqAgwqAgwqBpbnQgZmxhZ3M7PGJyPgrCoH07PGJyPgo8YnI+CsKgc3RhdGlj
IHZvaWQgdWlwYWRkcl9jYihnYm9vbGVhbiBvaywgR0F0UmVzdWx0ICpyZXN1bHQsIGdwb2ludGVy
IHVzZXJfZGF0YSk8YnI+CkBAIC00MjYsNiArNDI5LDggQEAgc3RhdGljIHZvaWQgY2dhY3RfZGlz
YWJsZV9jYihnYm9vbGVhbiBvaywgR0F0UmVzdWx0ICpyZXN1bHQsIGdwb2ludGVyIHVzZXJfZGF0
YSk8YnI+Cjxicj4KwqAgwqAgwqAgwqAgREJHKCZxdW90O29rICVkJnF1b3Q7LCBvayk7PGJyPgo8
YnI+CivCoCDCoCDCoCDCoGdjZC0mZ3Q7ZmxhZ3MgJmFtcDs9IH5VQkxPWF9GTEFHX0RFQUNUSVZB
VElORzs8YnI+Cis8YnI+CsKgIMKgIMKgIMKgIGlmICghb2spIHs8YnI+CsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIENBTExCQUNLX1dJVEhfRkFJTFVSRShnY2QtJmd0O2NiLCBnY2QtJmd0O2NiX2Rh
dGEpOzxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuOzxicj4KQEAgLTQ0OCw2ICs0
NTMsOCBAQCBzdGF0aWMgdm9pZCB1YmxveF9ncHJzX2RlYWN0aXZhdGVfcHJpbWFyeShzdHJ1Y3Qg
b2Zvbm9fZ3Byc19jb250ZXh0ICpnYyw8YnI+CsKgIMKgIMKgIMKgIGdjZC0mZ3Q7Y2IgPSBjYjs8
YnI+CsKgIMKgIMKgIMKgIGdjZC0mZ3Q7Y2JfZGF0YSA9IGRhdGE7PGJyPgo8YnI+CivCoCDCoCDC
oCDCoGdjZC0mZ3Q7ZmxhZ3MgfD0gVUJMT1hfRkxBR19ERUFDVElWQVRJTkc7PGJyPgorPGJyPgrC
oCDCoCDCoCDCoCBzbnByaW50ZihidWYsIHNpemVvZihidWYpLCAmcXVvdDtBVCtDR0FDVD0wLCV1
JnF1b3Q7LCBnY2QtJmd0O2FjdGl2ZV9jb250ZXh0KTs8YnI+CsKgIMKgIMKgIMKgIGdfYXRfY2hh
dF9zZW5kKGdjZC0mZ3Q7Y2hhdCwgYnVmLCBub25lX3ByZWZpeCw8YnI+CsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNnYWN0X2Rpc2FibGVfY2IsIGdjLCBOVUxMKTs8YnI+CkBA
IC00NzMsMTAgKzQ4MCwxNiBAQCBzdGF0aWMgdm9pZCBjZ2V2X25vdGlmeShHQXRSZXN1bHQgKnJl
c3VsdCwgZ3BvaW50ZXIgdXNlcl9kYXRhKTxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3Nj
YW5mKGV2ZW50LCAmcXVvdDslKnMgJSpzICUqcyAldSZxdW90OywgJmFtcDtjaWQpOzxicj4KwqAg
wqAgwqAgwqAgZWxzZSBpZiAoZ19zdHJfaGFzX3ByZWZpeChldmVudCwgJnF1b3Q7TlcgREVBQ1Qm
cXVvdDspKTxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3NjYW5mKGV2ZW50LCAmcXVvdDsl
KnMgJSpzICV1JnF1b3Q7LCAmYW1wO2NpZCk7PGJyPgorwqAgwqAgwqAgwqBlbHNlIGlmICghKGdj
ZC0mZ3Q7ZmxhZ3MgJmFtcDsgVUJMT1hfRkxBR19ERUFDVElWQVRJTkcpICZhbXA7JmFtcDs8YnI+
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnX3N0cl9oYXNfcHJlZml4KGV2ZW50LCAmcXVvdDtN
RSBQRE4gREVBQ1QmcXVvdDspKTxicj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogVGhlIG1v
ZGVtIG1pZ2h0IGNvbnNpZGVyIHRoZSBNRSBkZWFjdGl2YXRpbmcgd2l0aG91dDxicj4KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgICogYW4gZXhwbGljaXQgQ0dBQ1Q9MCBiZWVpbmcgc2VudDxicj4K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICovPGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBz
c2NhbmYoZXZlbnQsICZxdW90OyUqcyAlKnMgJSpzICV1JnF1b3Q7LCAmYW1wO2NpZCk7PGJyPgrC
oCDCoCDCoCDCoCBlbHNlPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm47PGJyPgo8
YnI+Ci3CoCDCoCDCoCDCoERCRygmcXVvdDtjaWQgJWQmcXVvdDssIGNpZCk7PGJyPgorwqAgwqAg
wqAgwqBEQkcoJnF1b3Q7Y2lkICVkLCBhY3RpdmUgY2lkOiAlZCZxdW90OywgY2lkLCBnY2QtJmd0
O2FjdGl2ZV9jb250ZXh0KTs8YnI+Cjxicj4KwqAgwqAgwqAgwqAgaWYgKCh1bnNpZ25lZCBpbnQp
IGNpZCAhPSBnY2QtJmd0O2FjdGl2ZV9jb250ZXh0KTxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgcmV0dXJuOzxicj4KLS0gPGJyPgoyLjIwLjE8YnI+Cjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2
Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+PC9kaXY+Cg==

--===============7953385066795987721==--

