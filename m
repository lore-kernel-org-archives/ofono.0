Content-Type: multipart/mixed; boundary="===============1611499268948294625=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 3/5] doc: Add documentation for 'forced-mode'
Date: Tue, 18 Jan 2011 21:02:22 +0200
Message-ID: <AANLkTi=iRmh+ihG+9OHyx8p95v19tAAwE3sWOsnkTNBZ@mail.gmail.com>
In-Reply-To: <1295360891.3873.179.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1611499268948294625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2011/1/18 Marcel Holtmann <marcel@holtmann.org>:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 "auto" =C2=A0 =C2=A0 =C2=A0 =C2=A0 Network regi=
stration is performed
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0automatically.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 "forced-auto" =C2=A0Network registration is per=
formed
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0automatically while manual
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0selection is disabled.
>
> we need to discuss this a little bit. I am not sure using a mode of
> forced auto is the best choice here.
>
> Maybe an extra property like "ManualAllowed" would be better. Thoughts?

The reason I ended up extending the Mode property was that once
forced_auto is true, no other Mode than auto is anyway possible. So in
a sense it is another type of Mode, which isn't to say a separate
property wouldn't work equally well.

I'm really open to either option. The way the code is written makes it
very easy to just expose this as a separate property.

Cheers,
Aki

--===============1611499268948294625==--

