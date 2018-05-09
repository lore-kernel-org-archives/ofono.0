Content-Type: multipart/mixed; boundary="===============2310470089487999734=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Incoming sms problem on Motorola Droid 4
Date: Wed, 09 May 2018 08:50:34 +0200
Message-ID: <20180509065033.GB10423@amd>
In-Reply-To: <bb8c59dd-db99-f86d-2ca1-ed746809327d@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2310470089487999734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue 2018-05-08 17:08:25, Denis Kenzior wrote:
> Hi Pavel,
> =

> On 05/08/2018 04:51 PM, Pavel Machek wrote:
> >Hi!
> >
> >I have problems with incoming SMS. ofono tries to use +CNMI=3D1,2,2,1,0
> >
> >>AT+CNMI=3D?
> >< +CNMI: (0,1,2),(0,1,2,3),(0,2),(0,1,2),(0,1)
> >< OK
> >ofonod[3070]: drivers/atmodem/sms.c:build_cnmi_string()
> >ofonod[3070]: drivers/atmodem/sms.c:construct_ack_pdu()
> >>AT+CNMI=3D1,2,2,1,0
> >< OK
> >ofonod[3070]: src/network.c:__ofono_netreg_add_status_watch() 0x5bbbf0
> >
> >... unfortunately, with that configuration no messages are comming to
> >ofono and the other phone sees them as "delievery failed".
> =

> So you're saying the modem firmware is lying about supporting all these
> modes :)

I'm saying this modem is broken in more than one way, yes. I tried
CNMI=3D1,1, but that did not work too well:

ofonod[2935]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb:
90, 00, 30
> AT+CNMI=3D1,1
< OK
ofonod[2935]: src/network.c:__ofono_netreg_add_status_watch() 0x53bbf0
...
ofonod[2935]: src/modem.c:get_modem_property() modem 0x53b000 property
SystemPath
ofonod[2935]: plugins/upower.c:battery_props_changed()
< +CMTI: "ME",-1
ofonod[2935]: Unable to parse CMTI notification
< +CIEV: 7,1

I'm getting the +CMTI: "ME",-1 indication in other cases, too :-(.

> >I had some luck with unicsy_demo using AT+CNMI=3D1,2 with text mode (not
> >PDU) messages. That works well enough for me.
> =

> oFono doesn't support text mode...
> =

> >
> >Unfortunately, if I force ofono to pass "AT+CNMI=3D1,2", it does not
> >work well, either.
> =

> You could try using value of '1' for the <mt> parameter and see if the mo=
dem
> will route messages to memory first and send a +CMTI indication..

Invalid SMTI indication, AFAICT :-(. Let me play some more...

> >Any ideas how to debug this / what to try?
> >
> =

> I think you have to play with some combinations, not really sure what to
> tell you. Refer to 3GPP 27.005 for details on the SMS related AT commands.

Thanks for the pointer.

									Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============2310470089487999734==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFscnltamtBQ2drUU1PZndhcFhiK3ZMQXRnQ2RHNW9CZDVwVFBDc0hoSWZjNUx3YzZ1UW0K
Rk5zQW9MbkdTOTdWUGNPNHNGZmcrcW4yRGRmakVnQjYKPU5GcHUKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============2310470089487999734==--

