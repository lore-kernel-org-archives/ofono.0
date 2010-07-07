Content-Type: multipart/mixed; boundary="===============4548462418347862285=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: FYI: Emergency calls with MBM modem
Date: Wed, 07 Jul 2010 10:52:26 -0500
Message-ID: <4C34A2BA.70308@gmail.com>
In-Reply-To: <AANLkTimjzak-lL4wbASpV4bAfuPzk2C4mltcSJ7kXw8G@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4548462418347862285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> However, 27.007 implies (see, for instance, commentary on +CPIN) that
> things the atmodem voicecall driver takes as granted (+CLCC, +CHLD) do
> not necessary work when there is no SIM or SIM is missing PIN code.
> +CIND polling is only thing promised by spec (however, it did not work
> on my MBM).

I'm not following, why would we ever need +CHLD if the SIM is missing?
Would we ever be able to establish multiple emergency calls to actually
call this?

+CHLD not working when PIN is ready and an emergency 3-way call
situation is another matter though...

> =

> Another thing is the radio handling: making an emergency calls
> requires that radio is explicitly turned on (with AT+CFUN=3D1). If there
> is no SIM or SIM is missing PIN and radio is on, modem registers with
> its IMEI code (it gets so called limited service). Keeping radio on in
> limited service state just wastes battery (unless you want to make an
> emergency call).
> =


What do you propose here?

Regards,
-Denis

--===============4548462418347862285==--

