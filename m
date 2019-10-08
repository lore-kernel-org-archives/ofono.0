Content-Type: multipart/mixed; boundary="===============5154495437519542735=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gatmux: don't free cmux data until watchers are destroyed
Date: Mon, 07 Oct 2019 23:06:00 -0500
Message-ID: <ed1f5907-1c13-89de-f87f-3a86ebbc38f4@gmail.com>
In-Reply-To: <dac0d35f-9d7e-4277-e694-2a17245755ef@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5154495437519542735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 10/7/19 1:37 PM, Martin Hundeb=C3=B8ll wrote:
>> Why not do something like:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_mux_ref(mux);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 1; i <=3D MAX_CHANNELS && !mux->shutdow=
n; i++) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
t offset =3D i / 8;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
t bit =3D i % 8;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (!(mux->newdata[offset] & (1 << bit)))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 di=
spatch_sources(mux->dlcs[i-1], G_IO_IN);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_mux_unref(mux);
>>
> =

> I'm afraid this isn't enough, as I still get use-after-free when using =

> gatmux in the quectel plugin (see attached log).

That buffer size check is a bit dubious and should never happen in =

practice, it is also something that one cannot recover from if the =

condition does get hit.  I actually would just take it out, but you can =

also just check the condition right before the mux_unref and scribble it =

to a temporary.  i.e.

bool buffer_full =3D false;

g_at_mux_ref();

for (...) {
	...
	dispatch_sources(...);
}

buffer_full =3D !mux->shutdown && mux->buf_used =3D=3D sizeof(mux->buf);

g_at_mux_unref();


...

if (buffer_full)
	return FALSE;

Regards,
-Denis
--===============5154495437519542735==--

