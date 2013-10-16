Content-Type: multipart/mixed; boundary="===============7475293016474722069=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: Re: [PATCH] Fix gprs provisioning for some SIM (non-USIM) cards
Date: Wed, 16 Oct 2013 19:50:37 +0200
Message-ID: <CACM4vuAAmckEbnFWe_S47fsbmJ0iDsvhkvovkVyZZT066KS41A@mail.gmail.com>
In-Reply-To: <525EB77B.4030505@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7475293016474722069==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,


> We've been here before...
>
> http://comments.gmane.org/gmane.comp.handhelds.ofono/13552
>
> Something like this is definitely needed... SIM's from at least one
> carrier in Sweden fail to provide the MNC length.

The SIM that showed the bug in our case was from a guy in Pakistan. So
it seems that these SIMs are used by more operators than one would
expect.

> The MNC can only be one value and that value can even change depending on=
 whether you're
> operating the same SIM in a 2G device or 3G device. So trying length 3 wh=
en in reality it is 2
> can and most likely will get you into trouble.

I do not think this can happen. For a given MCC, the length of the MNC
is always the same, or at least that is the recommendation of the ITU.

> I might be convinced to default to MNC length 2 in that case
>
> Regards,
> -Denis


 I do not think this is a good idea. Taking a look the ITU database,
countries like USA, Canada, or Colombia have MNC length =3D=3D 3.

As the relationship between MCC and MNC is deterministic, when we know
the MCC we can directly find out the MNC length. I agree in that
trying first length 2, then 3 is not very elegant. But if we do not do
that I see two possible solutions:

1.- Store a table statically or in a file with the correspondence
between MCC and MNC length. I foresee maintenance problems with this
approach.

2.- Add a function in the provision driver so we can ask for the MNC
length for a given MCC, which would be invoked when MNC length is not
found in EFad. The implementation would search in the provisioning DB:
it could return the length of the first MNC found for that MCC (it
must be the same for all networks for that MCC).

Opinions on this?

Thanks,
Alfonso

--===============7475293016474722069==--

