Content-Type: multipart/mixed; boundary="===============6567989348523991571=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/8] telit: notify sim inserted when sim ready
Date: Mon, 20 Aug 2012 09:50:53 -0500
Message-ID: <50324ECD.2060202@gmail.com>
In-Reply-To: <50324B05.1080807@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6567989348523991571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

<snip>

>>
>> You might need to do the same thing as we did for e.g. IFX and STE.
>> notify sim insertion on #QSS: 1, and only return from CPIN once #QSS:
>> 3 has been sent. See drivers/atmodem/sim.c at_epev_notify() or
>> at_xsim_notify() for an example.
>
> This works fine in case the PIN is locked, but has the unpleasant side
> effect that I receive a timeout when calling the D-Bus method to enter
> the PIN because #QSS: 3 takes so long (e.g. 32 seconds from entering the
> PIN until a #QSS: 3).

Feel free to extend the timeout on the enter-pin script.  Also, you can =

in theory wait until #QSS: 2 and not 3 right?  From what I remember QSS: =

3 pertains to Phonebook and SMS being ready.  For those you can add a =

quirk that queries / waits for QSS:3   See how we handled this in =

plugins/calypso.c and %CSTAT.  Alternatively we can try to do this =

inside the individual drivers using a vendor quirk.

> If the PIN is unlocked I will never get to at_pin_send_cb(), where
> +XSIM, *EPEV or #QSS are registered, and ofono will step to post-sim
> phase (where sms and phonebook atoms are created) immediately without
> waiting for #QSS: 3.

See above ;)

Regards,
-Denis

--===============6567989348523991571==--

