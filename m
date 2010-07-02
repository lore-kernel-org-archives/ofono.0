Content-Type: multipart/mixed; boundary="===============1969292925150363906=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/6] test-stkutil: Fix always true condition.
Date: Fri, 02 Jul 2010 14:52:46 -0500
Message-ID: <4C2E438E.1090502@gmail.com>
In-Reply-To: <1277911458-4984-4-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1969292925150363906==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> -		g_assert(cs->daddr.number_type =3D=3D cs->daddr.number_type);
> -		g_assert(cs->daddr.numbering_plan =3D=3D cs->daddr.numbering_plan);
> +		g_assert(cs->daddr.number_type =3D=3D ts->daddr.number_type);
> +		g_assert(cs->daddr.numbering_plan =3D=3D ts->daddr.numbering_plan);

Very nice catch.  Applied thanks.

Regards,
-Denis

--===============1969292925150363906==--

