Content-Type: multipart/mixed; boundary="===============4035954811165022444=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/4] netreg: Add CPHS CSP PLMN mode implementation
Date: Wed, 26 Jan 2011 12:12:44 +0100
Message-ID: <1296040364.1520.116.camel@aeonflux>
In-Reply-To: <AANLkTikGYBZBqo5czuDORzRxOraAJo6c811RrFMs+sAA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4035954811165022444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> >> -static const char *registration_mode_to_string(int mode)
> >> +static const char *registration_mode_to_string(int mode, gboolean for=
ced_auto)
> >>  {
> >> +     if (forced_auto)
> >> +             return "auto-only";
> >> +
> >
> > I see the benefit of keeping this in this function, but I would not have
> > done it like this actually. I would have kept it next to the function
> > needing that string and let it do the auto-only check by itself.
> =

> That is how I originally had it, but this ends up being a bit less
> code. Also, I'd like to localize all of these constant strings into a
> single function and not sprinkle them across the code.

so I am counting two callers to registration_mode_to_string.

> > Another possibility might be to convert this into
> >
> >        get_registration_mode_string(struct ofono_netreg *netreg)
> >
> > Since I am not mistaken, then the netreg->mode is always set before you
> > are calling this, right?
> =

> No, you call it with the new value. The function will then compare the
> old and the new, and based on this decide on sending a
> PropertyChanged.

In the current code base it is always checked and set before:

        if (netreg->mode =3D=3D mode)
                return;

        netreg->mode =3D mode;

	...

	strmode =3D registration_mode_to_string(mode);

Just on a different thought here. The NETWORK_REGISTRATION_MODE_* is
local to src/network.c. We could just add the AUTO_ONLY mode there.

The only downside I is see the already nasty init_registration_status
check, but that might be acceptable compared to crippling the string
conversion function.

However at least the check would be clearly to just checking mode and
not mode + forced_mode.

Regards

Marcel



--===============4035954811165022444==--

