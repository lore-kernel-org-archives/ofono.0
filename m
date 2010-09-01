Content-Type: multipart/mixed; boundary="===============6032704550719946112=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 02/11] Changes done as per the changed driver API
Date: Wed, 01 Sep 2010 17:12:02 +0200
Message-ID: <AANLkTi=xZgRGy3PYVS5OJyXkXA5bLzQ26ZibG+ki54s8@mail.gmail.com>
In-Reply-To: <1283338836-13572-2-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6032704550719946112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 1 September 2010 13:00, Jeevaka Badrappan
<jeevaka.badrappan@elektrobit.com> wrote:
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
>
> - =C2=A0 =C2=A0 =C2=A0 g_free(converted);
> + =C2=A0 =C2=A0 =C2=A0 g_free(msg);
> =C2=A0}

I agree with Pekka that maybe this should repack the 7-bit messages
into packed 7-bit, as this is what STK will be expecting in response
(I think).  Also, why are we g_memdup'ing the content instead of using
directly?

>
> =C2=A0static void cusd_request_cb(gboolean ok, GAtResult *result, gpointe=
r user_data)
> @@ -117,47 +109,76 @@ static void cusd_request_cb(gboolean ok, GAtResult =
*result, gpointer user_data)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cusd_parse(result, ussd);
> =C2=A0}
>
> -static void at_ussd_request(struct ofono_ussd *ussd, const char *str,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_ussd_cb_t cb, void *user_data)
> +static void at_ussd_request(struct ofono_ussd *ussd, int dcs,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0const unsigned char *str, int str_len,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0ofono_ussd_cb_t cb, void *user_data)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ussd_data *data =3D ofono_ussd_get_data=
(ussd);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct cb_data *cbd =3D cb_data_new(cb, user_d=
ata);
> + =C2=A0 =C2=A0 =C2=A0 int dcs_value =3D 0x0f; =C2=A0// GSM 7 bit default=
 alphabet
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char *converted =3D NULL;
> - =C2=A0 =C2=A0 =C2=A0 int dcs;
> - =C2=A0 =C2=A0 =C2=A0 int max_len;
> + =C2=A0 =C2=A0 =C2=A0 unsigned char *coded_str =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 long coded_str_len;
> + =C2=A0 =C2=A0 =C2=A0 long num_packed;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0long written;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0char buf[256];
> + =C2=A0 =C2=A0 =C2=A0 char *encoded_data =3D NULL;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!cbd)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cbd->user =3D ussd;
>
> - =C2=A0 =C2=A0 =C2=A0 converted =3D convert_utf8_to_gsm(str, strlen(str)=
, NULL, &written, 0);
> + =C2=A0 =C2=A0 =C2=A0 if (dcs =3D=3D -1){
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 converted =3D convert_=
utf8_to_gsm((const char *) str, str_len, NULL, &written, 0);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!converted)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto error;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* As per 3GPP TS 23.0=
38, When this character set is used,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the characters=
 of the message are packed in octets as shown in section 6.1.2.1.1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* and the messag=
e can consist of up to 160 characters.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 coded_str =3D pack_7bi=
t(converted, written, 0, TRUE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &num_packed, 0);

You could use pack_7bit_own_buf here too.

Please check the style doc about spaces after/before {}.

Best regards

--===============6032704550719946112==--

