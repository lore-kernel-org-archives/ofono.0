Content-Type: multipart/mixed; boundary="===============6247296980481552282=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 2/3] modem: add EmergencyMode property
Date: Thu, 11 Nov 2010 02:59:01 +0900
Message-ID: <1289411941.9615.277.camel@aeonflux>
In-Reply-To: <4CDAAB58.20000@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6247296980481552282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >> Here you should turn the radio off if it was off before starting the
> >> emergency call.
> >>
> >>    =

> > =

> > The rationale behind leaving the radio on after emergency calls
> > was to have the theoretical possibility the emergency call center
> > to call you back (when SIM card is present...). If this is an unrealist=
ic
> > scenario, I'll disable the radio after emergency calls in case it was o=
ff
> > before the call.
> > =

> =

> That is a fair point, however, just silently leaving us Online might not
> be a good idea.
> =

> I suggest finding out how exactly this is supposed to work.  E.g. can we
> get away with starting an X minute timeout every time we leave emergency
> mode and go offline automatically?  This timeout would obviously have to
> be canceled if the user sets Online manually.

on one hand I see this making perfect sense. For example just leave the
modem in online state for lets say 15 minutes. But then on the other
hand I am worried about regulatory requirements where the modem is
suppose to be offline.

So what I would propose here to actually leave the modem online for a
really short period of time like 30 seconds or so. And then bring it
back down. Then we can tweak that value to our needs. And in addition
the user could switched it back online by himself and we avoid going
into offline mode and back to online mode.

Of course when switching to online mode by user we need to ensure that
all atoms are brought up properly.

Regards

Marcel



--===============6247296980481552282==--

