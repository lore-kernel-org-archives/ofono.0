Content-Type: multipart/mixed; boundary="===============4321568803625048537=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH 02/11] Changes done as per the changed driver API
Date: Wed, 01 Sep 2010 15:49:12 +0300
Message-ID: <AANLkTinZwThD6Y0oifubMVz=TF=Q6ZuutMeyFKLBpAKv@mail.gmail.com>
In-Reply-To: <1283338836-13572-2-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4321568803625048537==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

2010/9/1 Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>:
> ---
> =C2=A0drivers/atmodem/ussd.c | =C2=A0 87 +++++++++++++++++++++++++++++---=
---------------
> =C2=A01 files changed, 54 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
> index 1e1fc25..c386fcd 100644
> --- a/drivers/atmodem/ussd.c
> +++ b/drivers/atmodem/ussd.c
> @@ -56,11 +56,12 @@ static void cusd_parse(GAtResult *result, struct ofon=
o_ussd *ussd)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int status;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int dcs;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *content;
> - =C2=A0 =C2=A0 =C2=A0 char *converted =3D NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0gboolean udhi;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0enum sms_charset charset;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0gboolean compressed;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0gboolean iso639;
> + =C2=A0 =C2=A0 =C2=A0 unsigned char *msg =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 int msg_len =3D 0;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0g_at_result_iter_init(&iter, result);
>
> @@ -83,24 +84,15 @@ static void cusd_parse(GAtResult *result, struct ofon=
o_ussd *ussd)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0charset =3D SMS_CH=
ARSET_7BIT;
>
> - =C2=A0 =C2=A0 =C2=A0 if (charset =3D=3D SMS_CHARSET_7BIT)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 converted =3D convert_=
gsm_to_utf8((const guint8 *) content,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 strlen(content), NULL, NULL, 0);
> -
> - =C2=A0 =C2=A0 =C2=A0 else if (charset =3D=3D SMS_CHARSET_8BIT) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: Figure out wh=
at to do with 8 bit data */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_error("8-bit cod=
ed USSD response received");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D 4; /* Not s=
upported */
> - =C2=A0 =C2=A0 =C2=A0 } else {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* No other encoding i=
s mentioned in TS27007 7.15 */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_error("Unsupport=
ed USSD data coding scheme (%02x)", dcs);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D 4; /* Not s=
upported */
> + out:
> + =C2=A0 =C2=A0 =C2=A0 if (content){
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg =3D g_memdup(conte=
nt, strlen(content));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg_len =3D strlen(con=
tent);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> -out:
> - =C2=A0 =C2=A0 =C2=A0 ofono_ussd_notify(ussd, status, converted);
> + =C2=A0 =C2=A0 =C2=A0 ofono_ussd_notify(ussd, status, dcs, msg, msg_len);

I thought the modem already unpacks the ussd message to 8-bit gsm and
the dcs parameter is rather meaningless in that case. Perhaps the
atmodem ussd should re-pack the string in order to achieve the desired
symmetry on the API?

-- =

Pekka.Pessi mail at nokia.com

--===============4321568803625048537==--

