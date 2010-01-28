Content-Type: multipart/mixed; boundary="===============7395192243400815706=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: FW: [RFC 3/3] STE-plugin: Adding STE plugin
Date: Thu, 28 Jan 2010 10:25:34 -0600
Message-ID: <201001281025.35704.denkenz@gmail.com>
In-Reply-To: <61D8D34BB13CFE408D154529C120E0790326B437@eseldmw101.eemea.ericsson.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7395192243400815706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> > All of this logic needs to go away.  The core already handles all of
> > this, including selection of ATH/CHLD, waiting/held.  Please review
> > src/voicecall.c.
> > If the core logic is not sufficient or does not properly handle a
> > certain case, then lets see if we can fix the core first.  Drivers
> > should not concern themselves with this stuff.
> =

> OK, we can remove the state logic, but STE modem cannot terminate
> calls in state DIALING and ALERTING with CHLD=3D1X. We need to use
> ATH (or AT+CHUP) instead.

oFono already takes care of this for single calls (see src/voicecall.c =

voicecall_hangup.)  So this is only an issue in the case of three way calls=
, =

is this what you're referring to here?

> =

> For now I think we will remove the state logic from ste_release_specific =
as
> you suggest. Terminating calls in state DIALING and ALERTING must then be
> handled by the Core part. The simplest would probably be to use hangup in
> this case, but I suspect hangup work differently for different modems.
> So if you cannot use hangup as the general approach, maybe it could be
> implemented by adding callback functions release_dialing and
>  release_alerting in struct ofono_voicecall_driver. The STE driver could
>  send ATH from release_dialing and release_alerting, other drivers could
>  leave them empty and this could default to use release_specific instead?

What I have been considering to take care of this case is to add end_all an=
d =

end_all_active callbacks.  According to 27.007/22.030 ATH should end all ca=
lls =

(active + held) except waiting calls, while +CHUP should only end the =

currently active call.  At least on one TI modem I tried this works as =

expected.  Do your modems implement the same behavior?

If so then we can always use end_all_active for dialing/incoming/alerting =

cases.

> =

> > With this in mind, you might not need to track any state in this
> > driver at all.  See drivers/calypsomodem/voicecall.c for details.
> > TI's CPI notifications are almost exactly the same as the STE ECAV.
> =

> The STE ECAV update is giving delta updates on the state information,
> right now I don't see how we can get the ofono_voicall_notify right
> without keeping some state information in ecav_notify.
> =


Yes you're right, I was assuming ECAV gives you more information on whether =

the call was released locally or remotely.

Regards,
-Denis

--===============7395192243400815706==--

