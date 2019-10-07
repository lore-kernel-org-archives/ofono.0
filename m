Content-Type: multipart/mixed; boundary="===============3501479074964603827=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCH] gatmux: don't free cmux data until watchers are destroyed
Date: Mon, 07 Oct 2019 23:33:30 +0200
Message-ID: <1f30ea6c-4f86-ea64-fead-693308600e6c@geanix.com>
In-Reply-To: <b231a0fd-6b2e-c2aa-4537-42eeabd128d0@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3501479074964603827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 30/09/2019 22.59, Denis Kenzior wrote:
> Hi Martin,
> =

>> @@ -227,12 +227,15 @@ static void dispatch_sources(GAtMuxChannel =

>> *channel, GIOCondition condition)
>> =C2=A0 static gboolean received_data(GIOChannel *channel, GIOCondition c=
ond,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpointer data)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 GAtMux *mux =3D data;
>> +=C2=A0=C2=A0=C2=A0 GAtMux *mux =3D g_at_mux_ref(data);
> =

> So you're taking a ref here unconditionally, yet...
> =

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GIOStatus status;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gsize bytes_read;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cond & G_IO_NVAL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_done;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (mux->shutdown)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return FALSE;
> =

> You don't return it here?

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 debug(mux, "received data");
>> @@ -270,15 +273,22 @@ static gboolean received_data(GIOChannel =

>> *channel, GIOCondition cond,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cond & (G_IO_HUP | G_IO_ERR))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return FALSE;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_done;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (status !=3D G_IO_STATUS_NORMAL && sta=
tus !=3D G_IO_STATUS_AGAIN)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return FALSE;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_done;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mux->buf_used =3D=3D sizeof(mux->buf))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return FALSE;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_done;
>> +
>> +=C2=A0=C2=A0=C2=A0 g_at_mux_unref(mux);
> =

> Why not do something like:
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_mux_ref(mux);
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 for (i =3D 1; i <=3D MAX_CHANNELS && !mux->shutdown; i++=
) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int offs=
et =3D i / 8;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int bit =
=3D i % 8;
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(mu=
x->newdata[offset] & (1 << bit)))
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dispatch=
_sources(mux->dlcs[i-1], G_IO_IN);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_mux_unref(mux);

I chose to stick with the unconditional reference. Your suggestion can =

cause the mux object to be freed when unref'ed after the loop, but the =

function accesses it again later in

	if (mux->buf_used =3D=3D sizeof(mux->buf))

The unconditional reference makes the flow nicer, IMO.

// Martin
--===============3501479074964603827==--

