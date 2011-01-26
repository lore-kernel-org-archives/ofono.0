Content-Type: multipart/mixed; boundary="===============5274867048251962723=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 2/4] netreg: Add CPHS CSP PLMN mode implementation
Date: Wed, 26 Jan 2011 13:45:16 +0200
Message-ID: <AANLkTinrU2Mxym1=HrEqGmrSP6Lqn98Cs8aQ=taeRfQi@mail.gmail.com>
In-Reply-To: <1296040364.1520.116.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5274867048251962723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2011/1/26 Marcel Holtmann <marcel@holtmann.org>:
>> That is how I originally had it, but this ends up being a bit less
>> code. Also, I'd like to localize all of these constant strings into a
>> single function and not sprinkle them across the code.
>
> so I am counting two callers to registration_mode_to_string.

Yup, that's two times "auto-only". ;)

> In the current code base it is always checked and set before:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (netreg->mode =3D=3D mode)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0netreg->mode =3D mode;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0...
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0strmode =3D registration_mode_to_string(mode);

Ah, right. I was thinking one call up the stack.

> Just on a different thought here. The NETWORK_REGISTRATION_MODE_* is
> local to src/network.c. We could just add the AUTO_ONLY mode there.
>
> The only downside I is see the already nasty init_registration_status
> check, but that might be acceptable compared to crippling the string
> conversion function.
>
> However at least the check would be clearly to just checking mode and
> not mode + forced_mode.

I thought about this, but then we'd need more logic to when the user
calls NetworkRegistration.Register() for automatic mode. That
obviously can't change the mode. But perhaps this is now more
manageable, since we got rid of Deregister(), which means there is
just this one case to worry about.

Cheers,
Aki

--===============5274867048251962723==--

