Content-Type: multipart/mixed; boundary="===============7399241665081173757=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCH] gatmux: don't free cmux data until watchers are destroyed
Date: Tue, 08 Oct 2019 20:47:38 +0200
Message-ID: <6e5d0f61-6854-8f4d-ebc2-eac5a1548505@geanix.com>
In-Reply-To: <ed1f5907-1c13-89de-f87f-3a86ebbc38f4@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7399241665081173757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 08/10/2019 06.06, Denis Kenzior wrote:
> =

> On 10/7/19 1:37 PM, Martin Hundeb=C3=B8ll wrote:
>>> Why not do something like:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_mux_ref(mux);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 1; i <=3D MAX_CHANNELS && !mux->shut=
down; i++) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 int offset =3D i / 8;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 int bit =3D i % 8;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if (!(mux->newdata[offset] & (1 << bit)))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 dispatch_sources(mux->dlcs[i-1], G_IO_IN);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_mux_unref(mux);
>>>
>>
>> I'm afraid this isn't enough, as I still get use-after-free when using =

>> gatmux in the quectel plugin (see attached log).
> =

> That buffer size check is a bit dubious and should never happen in =

> practice, it is also something that one cannot recover from if the =

> condition does get hit.=C2=A0 I actually would just take it out, but you =
can =

> also just check the condition right before the mux_unref and scribble it =

> to a temporary.=C2=A0 i.e.
> =

> bool buffer_full =3D false;
> =

> g_at_mux_ref();
> =

> for (...) {
>  =C2=A0=C2=A0=C2=A0=C2=A0...
>  =C2=A0=C2=A0=C2=A0=C2=A0dispatch_sources(...);
> }
> =

> buffer_full =3D !mux->shutdown && mux->buf_used =3D=3D sizeof(mux->buf);

Why the "!mux->shutdown" here? I would expect that to be checked before =

processing the data...

// Martin
--===============7399241665081173757==--

