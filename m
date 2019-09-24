Content-Type: multipart/mixed; boundary="===============1394216215781160769=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] ublox: rework device initialization sequence
Date: Tue, 24 Sep 2019 10:28:01 -0500
Message-ID: <67dd2d66-e5c4-4cd5-b473-d3221877cb31@gmail.com>
In-Reply-To: <5b442107-0001-4d97-2c60-2e368fa0e5d6@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1394216215781160769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

>> Can data->init_cmd be 0 here?
> =

> Yes... init_cmd gets cleared in init_cmd_cb when the command succeeds. =

> We reuse the callback to get an extra 1 second delay (which we require) =

> before continuing with the initialization.=C2=A0 There's a comment about =
this =

> in init_cmd_cb above.
> =


Ah right.  I read that comment but didn't put the two together.  Still, =

seems like you could use l_timeout_set_callback to make life easier for =

yourself.

>>> +=C2=A0=C2=A0=C2=A0 g_at_chat_unref(data->aux);
>>> +=C2=A0=C2=A0=C2=A0 data->aux =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0 g_at_chat_unref(data->modem);
>>> +=C2=A0=C2=A0=C2=A0 data->modem =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0 ofono_modem_set_powered(modem, FALSE);
>>> +=C2=A0=C2=A0=C2=A0 return;
>>
>> This return isn't needed, and you may want to just put these =

>> statements into a common utility since you copy-paste this in two places.
> =

> Yes, but it's not needed anywhere else... are you requiring a static =

> inline function for this or can I just resubmit this without the return =

> statement?

I count like 3 places in ublox.c that do this 5 line incantation and =

you're adding 2 more.

Anyhow, I can take your patch and fix this separately or you can do this =

right ;)

Regards,
-Denis

--===============1394216215781160769==--

