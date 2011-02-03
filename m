Content-Type: multipart/mixed; boundary="===============0081057986022768684=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 1/2] netreg: Add CPHS CSP implementation
Date: Thu, 03 Feb 2011 23:22:47 +0200
Message-ID: <AANLkTikYqwWwF7Wi1SCi78dim0QveT3=_s_9o9aT7rbB@mail.gmail.com>
In-Reply-To: <4D4B18C0.9000809@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0081057986022768684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2011/2/3 Denis Kenzior <denkenz@gmail.com>:
>> + =C2=A0 =C2=A0 if (netreg->mode =3D=3D NETWORK_REGISTRATION_MODE_AUTO_O=
NLY)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
>> +
>
> So we might just return access_denied here as well.

There is a reason for allowing this, namely that sometimes you want to
re-run the logic for automatically operator selection. Granted, this
is not your most common use case, but since it also does no harm to
allowing it, I didn't.

>> =C2=A0 =C2=A0 =C2=A0 set_registration_mode(netreg, NETWORK_REGISTRATION_=
MODE_AUTO);
>>
>> =C2=A0 =C2=A0 =C2=A0 return NULL;
>
> <snip>
>
>> @@ -1769,7 +1835,7 @@ static void netreg_load_settings(struct ofono_netr=
eg *netreg)
>> =C2=A0 =C2=A0 =C2=A0 mode =3D g_key_file_get_integer(netreg->settings, S=
ETTINGS_GROUP,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Mode", NULL=
);
>>
>> - =C2=A0 =C2=A0 if (mode >=3D 0 && mode <=3D 1)
>> + =C2=A0 =C2=A0 if (mode !=3D NETWORK_REGISTRATION_MODE_AUTO_ONLY)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 netreg->mode =3D mode;
>>
>
> This check is unnecessary, you already loaded the settings before you
> managed to load the sim file. =C2=A0You're also removing a sanity check f=
or
> no real reason.

That's just a bug. The intention was to write:

if (mode =3D=3D NEtWORK_REGISTRATION_MODE_AUTO ||
                mode =3D=3D NETWORK_REGISTRATION_MODE_MANUAL)
        netreg->mode =3D mode;

The patch has a seemingly shorter way of describing the same, but as
you point out, misses the sanity check. Must have been lack of coffee
or something. ;)

> This brings up another point, since the CPHS CSP file is actually
> user-writeable (for some unknown reason) the user can remove the SIM,
> put it in another phone and modify the forced-auto settings. =C2=A0If you
> store the forced-auto mode in the settings file, then there's no way to
> ever go back to non-forced auto, even though he should be able to.

I think the above way will in fact default to auto even if the
settings store has auto-only. And yes, EFcsp can definitely change
even at run-time, as manual mode really should be allowed when
roaming, at least in countries that the operator for instance has
multiple suitable roaming partners with varying coverage.

> I suggest that when forced-auto is detected, that we only write
> NETWORK_REGISTRATION_MODE_AUTO to the settings store.

That sounds reasonable, too.

Cheers,
Aki

--===============0081057986022768684==--

