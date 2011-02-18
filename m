Content-Type: multipart/mixed; boundary="===============5821136208888376325=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 11/18] isimodem: gprs-context updates wgmodem2.5
Date: Fri, 18 Feb 2011 16:17:49 +0200
Message-ID: <AANLkTimNRhRPr87kvEf6Kvq-vA-NvYpWzavm8EQFqFQr@mail.gmail.com>
In-Reply-To: <79c722cc404870768dc3e5352fa9bc6d73074cde.1297772944.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5821136208888376325==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2011/2/15 Andreas Westin <andreas.westin@stericsson.com>:
> From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>
>
> ---
> =C2=A0drivers/isimodem/gprs-context.c | =C2=A0 95 +++++++++++++++++++++++=
++-------------
> =C2=A01 files changed, 62 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/isimodem/gprs-context.c b/drivers/isimodem/gprs-cont=
ext.c
> index 6d579d8..f458fcc 100644
> --- a/drivers/isimodem/gprs-context.c
> +++ b/drivers/isimodem/gprs-context.c
> @@ -347,32 +347,52 @@ static void send_context_authenticate(GIsiClient *c=
lient, void *opaque)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct context_data *cd =3D opaque;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t username_len =3D strlen(cd->username);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t password_len =3D strlen(cd->password);
> + =C2=A0 =C2=A0 =C2=A0 size_t sb_user_info_len =3D (3 + username_len + 3)=
 & ~3;
> + =C2=A0 =C2=A0 =C2=A0 size_t fill_sb_user_info_count =3D
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 sb_user_info_len - (3 + username_len);
> + =C2=A0 =C2=A0 =C2=A0 uint8_t *fill_sb_user_info_data =3D
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 g_try_malloc0(fill_sb_user_info_count);
> + =C2=A0 =C2=A0 =C2=A0 size_t sb_password_info_len =3D (3 + password_len =
+ 3) & ~3;
> + =C2=A0 =C2=A0 =C2=A0 size_t fill_sb_password_info_count =3D
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 sb_user_info_len - (3 + password_len);

This should be sb_password_info_len, no?

> + =C2=A0 =C2=A0 =C2=A0 uint8_t *fill_sb_password_info_data =3D
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 g_try_malloc0(fill_sb_password_info_count);

There's no reason to allocate the padding from heap. (Especially if
they're never freed.)

I applied this patch, but fixed the above issues afterwards. Please
check that it's still doing the right thing.

Cheers,
Aki

--===============5821136208888376325==--

