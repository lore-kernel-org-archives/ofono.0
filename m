Content-Type: multipart/mixed; boundary="===============6583982266925656512=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gatmux: don't free cmux data until watchers are destroyed
Date: Tue, 08 Oct 2019 14:44:45 -0500
Message-ID: <5cb463be-7e72-7908-645d-f4eabff59aa1@gmail.com>
In-Reply-To: <6e5d0f61-6854-8f4d-ebc2-eac5a1548505@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6583982266925656512==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

>>> I'm afraid this isn't enough, as I still get use-after-free when =

>>> using gatmux in the quectel plugin (see attached log).
>>
>> That buffer size check is a bit dubious and should never happen in =

>> practice, it is also something that one cannot recover from if the =

>> condition does get hit.=C2=A0 I actually would just take it out, but you =

>> can also just check the condition right before the mux_unref and =

>> scribble it to a temporary.=C2=A0 i.e.
>>
>> bool buffer_full =3D false;
>>
>> g_at_mux_ref();
>>
>> for (...) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0...
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dispatch_sources(...);
>> }
>>
>> buffer_full =3D !mux->shutdown && mux->buf_used =3D=3D sizeof(mux->buf);
> =

> Why the "!mux->shutdown" here? I would expect that to be checked before =

> processing the data...

Ah you're right, strictly speaking checking mux->shutdown would be =

redundant.  The idea was to avoid returning FALSE if we're shut down, =

but I guess it shouldn't matter.

Regards,
-Denis
--===============6583982266925656512==--

