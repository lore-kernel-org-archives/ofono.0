Content-Type: multipart/mixed; boundary="===============7379600057376942397=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Problems with voice call.
Date: Wed, 15 Jul 2009 11:51:20 -0500
Message-ID: <200907151151.21627.denkenz@gmail.com>
In-Reply-To: <4A5D6FAB.8090500@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7379600057376942397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marko,

> 788                 while (g_at_result_iter_next_number(&iter, &mode))
> 789                         if (mode =3D=3D 1)
> 790                                 supported =3D TRUE;

This is me being dyslexic.  It should be looking for mode =3D=3D 0 instead.

> With E51 the SMS error is returned from function at_cpms_query_cb()
> on line 764.
>
> 764                 return at_sms_not_supported(modem);
>

This is strange, what does the E51 return for "AT+CPMS=3D?"

I've pushed fixes to the initialization and this is working at least for th=
e =

Neo and on our simulator.  Can you report if your devices get further?

Regards,
-Denis

--===============7379600057376942397==--

