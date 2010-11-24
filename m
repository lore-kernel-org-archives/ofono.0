Content-Type: multipart/mixed; boundary="===============1590238405651933943=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH] isi: Fix issue in call forwarding erase response
Date: Wed, 24 Nov 2010 15:12:19 +0200
Message-ID: <AANLkTing8i6CrbykTxR9JHKOE3vt=BBiqfbmkU6qJ+YN@mail.gmail.com>
In-Reply-To: <1290593454-22149-2-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1590238405651933943==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

2010/11/24 Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>:
> ---
> =C2=A0drivers/isimodem/call-forwarding.c | =C2=A0 20 ++++++++++++++------
> =C2=A01 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/isimodem/call-forwarding.c b/drivers/isimodem/call-f=
orwarding.c
> index 1448451..c364bdf 100644
> --- a/drivers/isimodem/call-forwarding.c
> +++ b/drivers/isimodem/call-forwarding.c
> @@ -98,12 +98,20 @@ static gboolean decode_gsm_forwarding_info(const void=
 *restrict data,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uint8_t _ton;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0char *_number =3D NULL;
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (!g_isi_sb_iter_get_byte(&iter, &_status, 3)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || !g_isi_sb_iter_get_byte(&iter, &_ton,=
 4)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || !g_isi_sb_iter_get_byte(&iter, &_norp=
ly, 5)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || !g_isi_sb_iter_get_byte(&iter, &_numl=
en, 7)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || !g_isi_sb_iter_get_alpha_tag(&iter, &=
_number,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _numlen * 2,=
 10))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (status && !g_isi_sb_iter_get_byte(&iter, &_status, 3))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return FALSE;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (ton && !g_isi_sb_iter_get_byte(&iter, &_ton, 4))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return FALSE;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (norply && !g_isi_sb_iter_get_byte(&iter, &_norply, 5))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return FALSE;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (number && !g_isi_sb_iter_get_byte(&iter, &_numlen, 7))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return FALSE;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (number && !g_isi_sb_iter_get_alpha_tag(&iter,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &_number, _numlen * 2, 10))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return FALSE;

I think the problem is that we try to decode the alpha tag even when
it is not present, i.e., when _numlen is zero.

In fact, this has already been fixed in my current working tree in a
bit different way. Mostly due to the fact that I added a new
g_isi_sb_iter_get_struct() method, which allows a little easier access
to sub-blocks like the one above.

If you're curious, here's the tree with the fix:
http://meego.gitorious.org/~akiniemi/meego-cellular/ofono-aki/commits/gisi

Thanks for the report in any case! ;)

Cheers,
Aki

--===============1590238405651933943==--

