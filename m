Content-Type: multipart/mixed; boundary="===============4305952058124424888=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCHv2] gatmux: take reference to mux object while processing
 incoming data
Date: Tue, 08 Oct 2019 20:46:13 +0200
Message-ID: <61193cf8-6f81-b3f4-f289-18523278b170@geanix.com>
In-Reply-To: <22c80e86-4a7f-05da-0ca6-051284681de5@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4305952058124424888==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 08/10/2019 06.08, Denis Kenzior wrote:
>> @@ -646,13 +653,6 @@ void g_at_mux_unref(GAtMux *mux)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> -static void read_watcher_destroy_notify(gpointer user_data)
>> -{
>> -=C2=A0=C2=A0=C2=A0 GAtMux *mux =3D user_data;
>> -
>> -=C2=A0=C2=A0=C2=A0 mux->read_watch =3D 0;
>> -}
>> -
>> =C2=A0 gboolean g_at_mux_start(GAtMux *mux)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mux->channel =3D=3D NULL)
>> @@ -666,8 +666,7 @@ gboolean g_at_mux_start(GAtMux *mux)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mux->read_watch =3D g_io_add_watch_full(m=
ux->channel, =

>> G_PRIORITY_DEFAULT,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 recei=
ved_data, mux,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 read_=
watcher_destroy_notify);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 recei=
ved_data, mux, NULL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mux->shutdown =3D FALSE;
>>
> =

> Can you tell me why this part is needed?=C2=A0 Does glib not call =

> read_watcher_destroy_notify right away when the source is removed?

I sent is as a separate patch to show the details.

// Martin
--===============4305952058124424888==--

