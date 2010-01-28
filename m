Content-Type: multipart/mixed; boundary="===============1255430129415912771=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: FW: [RFC 3/3] STE-plugin: Adding STE plugin
Date: Thu, 28 Jan 2010 14:49:37 -0600
Message-ID: <201001281449.37476.denkenz@gmail.com>
In-Reply-To: <61D8D34BB13CFE408D154529C120E0790326B620@eseldmw101.eemea.ericsson.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1255430129415912771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> > oFono already takes care of this for single calls (see src/voicecall.c
> > voicecall_hangup.)  So this is only an issue in the case of three way
> > calls, is this what you're referring to here?
> =

> Kind of. This is very good, it takes care of the situation with emergency
>  call which cannot be terminated with CHLD commands.
> =

> But I think there are more issues. If I am not mistaken STE-modems have
> the following behavior:
> CHLD=3D1X can only terminate call in state ACTIVE or HELD. (I think
> this is as STE interprets the standards).

The standards specify that CHLD=3D1X can only terminate an ACTIVE call.  Mo=
st =

modems implement it this way.  There are vendor extensions that provide thi=
s =

functionality (e.g. CHLD=3D7X on TI.)  By default oFono assumes that =

release_specific will simply fail if a user attempts to use it on an e.g. H=
ELD =

call with no modem support.

> =

> a) If you are in a active call and receives a new incoming call (ALERTING)
> and want to reject the new ALERTING call, then STE modem cannot
> terminate this call with CHLD=3D1X. It has to be terminated with CHLD=3D0
> (cause=3DBUSY) or ATH (possible CHUP).

Ok, lets get the terminology clear here.  In this case the incoming call is =

not ALERTING, it is WAITING.  WAITING calls are always rejected by using =

CHLD=3D0.  ALERTING calls are always outgoing calls that transitioned from =

DIALING to alerting the user.

> =

> b) Or you may have the following situation. One call on HOLD,
> another ACTIVE call, and then you receive a new incoming call ALERTING.
> If you try to terminate the new incoming (ALERTING) call with CHLD=3D0,
> I think you as a side effect will terminate the call on hold as well.
> If I am not mistaken ATH (possible CHUP) would be the correct in this
> situation for STE modems

The standards are quite clear here, the WAITING call always takes precedenc=
e =

and thus only the WAITING call is affected. Can you check that STE modems d=
o =

indeed get this wrong?  If the modem is standards compliant, oFono does the =

right thing here.

> =

> c) If you have an call on hold and initiate a new call, but want to
> terminate the newly initiated call (DIALING), then this call cannot be
> terminated with CHLD=3D1X, but you would have to use ATH (or possible CHU=
P).

Yes, so this is the case that we do need to take care of in the core.  Most =

modems let us get away with sending release_specific up to this point.

> > What I have been considering to take care of this case is to add
> > end_all and end_all_active callbacks.  According to 27.007/22.030 ATH
> > should end all calls (active + held) except waiting calls, while
> > +CHUP should only end the currently active call.  At least on one TI
> > modem I tried this works as expected.  Do your modems implement the
> > same behavior?
> =

> No, I don't think so. I think ATH will only terminate one call.
> In order to terminate all calls you would probably need to do something
> like: AT+CHLD=3D0;H But I'm not sure this works in all possible scenarios
> either...

Can you check the behavior of ATH vs CHUP on STE modems?  We need to send t=
he =

right one here or both HELD and ACTIVE/DIALING/ALERTING will be terminated.=
  =

If using CHUP and ATH doesn't work out we'll have to come up with another =

solution.

Regards,
-Denis

--===============1255430129415912771==--

