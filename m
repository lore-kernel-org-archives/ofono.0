Content-Type: multipart/mixed; boundary="===============9026340764565642897=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [sim-ready-nofify-v5 PATCH 2/3] atmodem/sim: use
 ofono_sim_ready_notify
Date: Tue, 15 Feb 2011 17:30:34 +0200
Message-ID: <AANLkTimxMAnyo-vG+HYZ+90Ndxe6xE_gnYY+5G43HGrg@mail.gmail.com>
In-Reply-To: <4D5310B1.8010007@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9026340764565642897==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2011/2/10 Denis Kenzior <denkenz@gmail.com>:
> So all this logic seems to work by luck.

AFAIK that is the way you wanted it. Continue initialization after
1) pin query returns None, and
2) notify is called after that.

If notify is called when pin is not None, recheck pin.

> =C2=A0oFono roughly does this:
> pin_query:
> send AT+CPIN?
> if READY then set waiting_for_pin to none, and wait in
> ofono_sim_ready_notify
> if PIN then set waiting_for_pin to the pin, and wait in
> ofono_sim_ready_notify
>
> ofono_sim_ready_notify:
> if waiting_for_pin is none proceed with initialization
> otherwise go back to pin_query

Sounds about correct.

> Here's a log of this running on IFX:
> ofonod[521]: Aux: > AT+CPIN?\r
> ofonod[521]: Aux: < \r\n+CPIN: SIM PIN\r\n
> ofonod[521]: Aux: < \r\nOK\r\n
> ofonod[521]: drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: SIM PIN
> ....
> ofonod[521]: Aux: > AT+CPIN=3D"0000"\r
> ofonod[521]: Aux: < \r\nOK\r\n
> ofonod[521]: Aux: > AT+CPIN?\r
> ofonod[521]: Aux: < \r\n+CME ERROR: 14\r\n
> ofonod[521]: Querying PIN authentication state failed
> ....
> ofonod[521]: Aux: < \r\n+XSIM: 7\r\n
> ofonod[521]: drivers/atmodem/sim.c:at_xsim_notify()
> ofonod[521]: drivers/atmodem/sim.c:ready_unregister_and_notify()
> ofonod[521]: src/sim.c:ofono_sim_ready_notify()
> ofonod[521]: plugins/ifx.c:xsim_notify() state 7
> ofonod[521]: Aux: > AT+CPIN?\r
> ofonod[521]: Aux: < \r\n+CPIN: READY\r\n
> ofonod[521]: Aux: < \r\nOK\r\n
> ofonod[521]: drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: READY
> ofonod[521]: drivers/atmodem/sim.c:at_pin_retries_query()
> ofonod[521]: drivers/atmodem/sim.c:ready_timeout()
> ofonod[521]: src/sim.c:ofono_sim_ready_notify()
>
> As you can see, we are in fact calling ofono_sim_ready_notify twice in
> short succession. =C2=A0The only reason we're not stuck for 5 seconds the
> second time around is that the xsim notification function sets ready to
> TRUE.

That is the way it was designed.

Second time around driver knows SIM is ready, so it schedules a call
to ofono_sim_ready_notify() in at_wait_for_ready().

We could avoid extra AT+CPIN? if needed, e.g., at_pin_query() could
return error immediately if ready_source is set.

>This is all pretty convoluted. =C2=A0I don't really like this at all.

It is. How would you like to clarify the code? Better naming for
functions, comments?

> Another case to consider is a cold boot quirked modem, PIN disabled. =C2=
=A0We
> are highly likely to receive XSIM way before we even query the PIN. =C2=
=A0So
> ready is false, ready_id is > 0 and we end up waiting for 5 seconds here
> for no good reason.

The +XSIM etc. is subscribed when SIM atom is probed, so oFono ends up
waiting only if SIM probe is done after ready indication. For MBM,
there is no good way to find out the SIM readyness (apart from reading
something from the SIM). For IFX, I think we could check the state
with an AT+XSIMSTATE? request.

> Did you intend if (ok && sd_ready_id =3D=3D 0) here?
>
> Otherwise I don't see how non-quirked modems ever signal sim_ready or
> why you would want to start a timer if you know a notification is coming
> anyway.

The at_wait_for_ready() will schedule immediately a callback (timer
with timeout of 0) if modem has not registered a ready indication
(ready_id is 0).

-- =

Pekka.Pessi mail at nokia.com

--===============9026340764565642897==--

