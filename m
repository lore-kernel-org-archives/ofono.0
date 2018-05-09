Content-Type: multipart/mixed; boundary="===============7590651187349036745=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Incoming sms problem on Motorola Droid 4
Date: Wed, 09 May 2018 10:18:20 +0200
Message-ID: <20180509081820.GC10423@amd>
In-Reply-To: <01DCB5CE-E309-4864-A722-5E5D8723162E@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7590651187349036745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> >> I have problems with incoming SMS. ofono tries to use +CNMI=3D1,2,2,1,0
> >>> AT+CNMI=3D?
> >> < +CNMI: (0,1,2),(0,1,2,3),(0,2),(0,1,2),(0,1)
> >> < OK
> >> ofonod[3070]: drivers/atmodem/sms.c:build_cnmi_string()
> >> ofonod[3070]: drivers/atmodem/sms.c:construct_ack_pdu()
> >>> AT+CNMI=3D1,2,2,1,0
> >> < OK
> >> ofonod[3070]: src/network.c:__ofono_netreg_add_status_watch() 0x5bbbf0
> >> ... unfortunately, with that configuration no messages are comming to
> >> ofono and the other phone sees them as "delievery failed".
> > =

> > So you're saying the modem firmware is lying about supporting all these=
 modes :)
> > =

> >> I had some luck with unicsy_demo using AT+CNMI=3D1,2 with text mode (n=
ot
> >> PDU) messages. That works well enough for me.
> > =

> > oFono doesn't support text mode=E2=80=A6
> =

> and it is impossible to support in a sane and complete manner.

Ok, so after some more experiments:

ofonod[3057]: drivers/atmodem/sms.c:construct_ack_pdu()
> AT+CNMI=3D1,2,2,1,0
< OK
ofonod[3057]: src/network.c:__ofono_netreg_add_status_watch() 0x538bf0
ofonod[3057]: src/sms.c:sms_restore_tx_queue()
ofonod[3057]: plugins/push-notification.c:sms_watch() registered
ofonod[3057]: plugins/smart-messaging.c:sms_watch() registered
> AT+CMGL=3D4
< OK
ofonod[3057]: drivers/atmodem/sms.c:at_cmgl_done()
> AT+CGSMS=3D3
< OK
< +CMT: ,38
<PDU
0791247033801600200C91246040431330000081508022704280156FF3DBFD06CDD1EF3A9B0=
CBABFE56B90FB7D07
ofonod[3057]: drivers/atmodem/sms.c:at_cmt_notify() Got new SMS
Deliver PDU via CMT:
0791247033801600200C91246040431330000081508022704280156FF3DBFD06CDD1EF3A9B0=
CBABFE56B90FB7D07,
38
ofonod[3057]: src/sms.c:ofono_sms_deliver_notify() len 46 tpdu len 38
ofonod[3057]: src/sms.c:handle_deliver()
ofonod[3057]: src/sms.c:sms_dispatch()
ofonod[3057]: src/sms.c:sms_dispatch() dst -1 src -1
ofonod[3057]: drivers/atmodem/sms.c:at_ack_delivery()
PDU Len 2, strlen 4
PDU last char 48
0000^ZCNMA=3D1,2
<PR
0000^ZCNMA=3D1,2
< +CMS ERROR: 304
ofonod[3057]: CNMA acknowledgement failed: Further SMS reception is
not guaranteed
< +CIEV: 1,4

Modem does not like our CNMA acknowledgement. AFAICT, we are sending

AT+CNMA=3D1,2
0000^Z

If I attempt to do AT+CNMA=3D1, AT+CNMA=3D0 or just plain At=3DCNMA, it does
not like that, either, but with +CMS ERROR: 500.

Is "0000" correct thing to send for message acknowledge?

Best regards,
								Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============7590651187349036745==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFscnlyc3dBQ2drUU1PZndhcFhiK3ZJZHhBQ2VLZmQ0ci9QUlFWcHBuaWVBUCtmWjBYWHgK
TmxRQW9MTTFDUFpaMjBUL2NWRGNZcUZFYndOSE1pY1UKPVR5NHQKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============7590651187349036745==--

