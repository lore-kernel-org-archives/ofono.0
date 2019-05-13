Content-Type: multipart/mixed; boundary="===============6131859849230657656=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC at-export 2/2] ublox: network-registration atom
Date: Mon, 13 May 2019 16:57:28 -0500
Message-ID: <2e34b6e3-8d0b-d8c8-294e-4836aabd6976@gmail.com>
In-Reply-To: <CAHB-Pj=K_LKLqr9PrWmAMZvgotU98QZpggk6SvOtwdXy4pjQvw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6131859849230657656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 05/13/2019 01:20 AM, Richard R=C3=B6jfors wrote:
> Hi,
> =

> I got this case again.
> =

> Killed ofono and checked the statuses manually. The output is below.
> Its clear that creg and cereg both reports roaming, while cgreg reports u=
nknown.

This is a different case?  Your originally case had CREG reporting =

unknown while UREG reporting LTE.

> =

> Denis if netreg would be updated, I still think we have an issue with
> atmodem/gprs.c.
> The problematic part is when at modem received the cgreg and calls
> ofono_gprs_status_notify, the gprs core part will then detach.
> =

> The log when this happened:
> =

> May 13 05:33:37  ofonod[741]: Aux: < \r\n+CREG: 5,"0080","00000006",6\r\n

So we are roaming...

> May 13 05:33:37  ofonod[741]:
> ../ofono-1.29/src/network.c:ofono_netreg_status_notify() /ublox_0
> status 5 tech 6
> May 13 05:33:37  ofonod[741]: ../ofono-1.29/src/gprs.c:netreg_status_chan=
ged() 5
> May 13 05:33:37  ofonod[741]:
> ../ofono-1.29/src/gprs.c:gprs_netreg_update() attach: 1,
> driver_attached: 1
> May 13 05:33:37  ofonod[741]: Aux: > AT\r
> May 13 05:33:37  ofonod[741]: Aux: < \r\nOK\r\n
> May 13 05:33:37  ofonod[741]: Aux: Finally woke up the modem

Weird that you're using this magic.  I thought only the Freerunner modem =

had this issue.  But ok...

> May 13 05:33:37  ofonod[741]: Aux: > AT+COPS=3D3,2\r
> May 13 05:33:37  ofonod[741]: Aux: < \r\n+CIEV: 2,5\r\n
> May 13 05:33:37  ofonod[741]:
> ../ofono-1.29/src/network.c:ofono_netreg_strength_notify() strength
> 100
> May 13 05:33:37  ofonod[741]: Aux: < \r\nOK\r\n
> May 13 05:33:37  ofonod[741]: Aux: > AT+COPS?\r
> May 13 05:33:37  ofonod[741]: Aux: < \r\n+COPS: 0,2,"24007",6\r\n
> May 13 05:33:37  ofonod[741]: Aux: < \r\nOK\r\n
> May 13 05:33:37  ofonod[741]:
> ../ofono-1.29/drivers/atmodem/network-registration.c:cops_numeric_cb()
> Cops numeric got mcc: 240, mnc: 07
> May 13 05:33:37  ofonod[741]: Aux: > AT+CIND?\r
> May 13 05:33:37  ofonod[741]: Aux: < \r\n+CIND: 5,5,0,0,0,0,1,0,2,0,0,1\r=
\n
> May 13 05:33:37  ofonod[741]: Aux: < \r\nOK\r\n
> May 13 05:33:37  ofonod[741]: Aux: > AT+COPS=3D3,0\r
> May 13 05:33:37  ofonod[741]: Aux: < \r\nOK\r\n
> May 13 05:33:37  ofonod[741]: Aux: > AT+COPS?\r
> May 13 05:33:37  ofonod[741]: Aux: < \r\n+COPS: 0,0,"Tele2",6\r\n
> May 13 05:33:37  ofonod[741]: Aux: < \r\nOK\r\n
> May 13 05:33:37  ofonod[741]:
> ../ofono-1.29/drivers/atmodem/network-registration.c:cops_cb()
> cops_cb: Tele2, 240 07 6
> May 13 05:33:37  ofonod[741]:
> ../ofono-1.29/src/network.c:current_operator_callback() 0x1fd2980,
> 0x1fe2c88
> May 13 05:33:37  ofonod[741]: Aux: < \r\n+CGREG: 4\r\n

So for whatever reason the modem (or network?) decides to detach GPRS...

> May 13 05:33:37  ofonod[741]:
> ../ofono-1.29/src/gprs.c:ofono_gprs_status_notify() /ublox_0 status
> unknown (4)
> May 13 05:33:37  ofonod[741]:
> ../ofono-1.29/src/gprs.c:gprs_set_attached_property() 1 -> 0
> =


My memory is fuzzy now, but I'm not sure if we ever put in the logic to =

attempt a re-attach in such a situation (e.g. we didn't request a =

detach).  For all devices we cared about the modem re-attached for us. =

It looks like there's still a TODO for this in src/gprs.c

Regards,
-Denis

--===============6131859849230657656==--

