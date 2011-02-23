Content-Type: multipart/mixed; boundary="===============3616472247679171211=="
MIME-Version: 1.0
From: Jussi Kangas <jussi.kangas@tieto.com>
Subject: Re: [PATCH] sim: showing lock state with call meter
Date: Wed, 23 Feb 2011 17:24:34 +0200
Message-ID: <1298474674.26475.79.camel@jussi-desktop>
In-Reply-To: <4D64A5F1.5090004@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3616472247679171211==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2011-02-23 at 08:15 +0200, Denis Kenzior wrote:
> >  =

> > -	if (pin_type !=3D OFONO_SIM_PASSWORD_NONE &&
> > -			sim->state =3D=3D OFONO_SIM_STATE_READY) {
> > +	if ((pin_type !=3D OFONO_SIM_PASSWORD_NONE &&
> > +			sim->state =3D=3D OFONO_SIM_STATE_READY) &&
> > +				(pin_type !=3D OFONO_SIM_PASSWORD_SIM_PIN2)) {
> =

> I don't see how this can work.  You need to check for pin_type !=3D NONE,
> PIN2 and PUK2 AND state =3D=3D READY here.  This also only covers the case
> of the PIN2 or PUK2 being triggered when call-meter is active.  You do
> not take care of the case where PIN2 or PUK2 are already required during
> sim initialization.

Hmm. It seems to work here. If I try reset call meter with wrong
password I get pin_type OFONO_SIM_PASSWORD_SIM_PIN2 and
OFONO_SIM_STATE_READY. APIs stay up and SIM manager shows pin2 locked
and pin2 required. (Which is kinda wrong I admit, u cannot unlock the
pin2, pin2 should always be visible in LockedPins or not at all, I would
prefer the later. However it is showed as it is showed and it was
working that way already before this patch). If I run same case three
times I get same values but API shows that puk2 is required and all
API:s stay up. If I run the case with correct password it does not come
to this code at all all. =


PIN2 cannot be required in startup. It is only required if u do
something with certain features like fdn or call meter. PUK2 can be
blocked in startup all right but it does not matter from startup point
of view. If I start the oFono with PIN2 blocked I get pin_type
OFONO_SIM_PASSWORD_SIM_PIN2 and OFONO_SIM_STATE_INSERTED states and API
shows pin2 locked and puk2 required as required. (does not seem work if
I boot up the modem and not just oFono though. Looks like modem bug
where it does not read voluntarily PIN2 state.)

Br,
-Jussi =





--===============3616472247679171211==--

