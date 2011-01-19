Content-Type: multipart/mixed; boundary="===============8992417858585440772=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 2/6] Define packet switched bearers
Date: Thu, 20 Jan 2011 00:23:04 +0200
Message-ID: <AANLkTi=oTBytjGcpGdTDJnsZOGzf1uEXcYEQ11CVm-O3@mail.gmail.com>
In-Reply-To: <1295428765-8683-2-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8992417858585440772==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

2011/1/19 R=C3=A9mi Denis-Courmont <remi.denis-courmont@nokia.com>:
> ---
> =C2=A0src/common.c | =C2=A0 23 +++++++++++++++++++++++
> =C2=A0src/common.h | =C2=A0 13 +++++++++++++
> =C2=A02 files changed, 36 insertions(+), 0 deletions(-)
>
> diff --git a/src/common.c b/src/common.c
> index d4e567b..2dd0da0 100644
> --- a/src/common.c
> +++ b/src/common.c

snip.

> +/* 27.007 Section 7.29 */
> +enum packet_bearer {
> + =C2=A0 =C2=A0 =C2=A0 PACKET_BEARER_NONE =3D 0,
> + =C2=A0 =C2=A0 =C2=A0 PACKET_BEARER_GPRS =3D 1,
> + =C2=A0 =C2=A0 =C2=A0 PACKET_BEARER_EGPRS =3D 2,
> + =C2=A0 =C2=A0 =C2=A0 PACKET_BEARER_UMTS =3D 3,
> + =C2=A0 =C2=A0 =C2=A0 PACKET_BEARER_HSUPA =3D 4,
> + =C2=A0 =C2=A0 =C2=A0 PACKET_BEARER_HSDPA =3D 5,
> + =C2=A0 =C2=A0 =C2=A0 PACKET_BEARER_HSUPA_HSDPA =3D 6,
> + =C2=A0 =C2=A0 =C2=A0 PACKET_BEARER_EPS =3D 7,
> +};

These need to be right-aligned with tabs. See coding-style, M12.

Cheers,
Aki

--===============8992417858585440772==--

