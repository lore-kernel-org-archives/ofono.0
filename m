Content-Type: multipart/mixed; boundary="===============4388903509824926041=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] Telit HE910 general fixes for gprs, sms and voicecall
Date: Mon, 09 Mar 2015 20:50:35 -0500
Message-ID: <54FE4DEB.1050803@gmail.com>
In-Reply-To: <CAH4ZQwvt95iLKpd2-LLqW7-APGyyhqs-g7iOdn8pFxxaDybCQw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4388903509824926041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

On 03/06/2015 10:07 AM, Enrico Sau wrote:
> diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
> index f93dd23..7aa90dc 100644
> --- a/drivers/atmodem/sms.c
> +++ b/drivers/atmodem/sms.c
> @@ -396,7 +396,7 @@ static void at_cds_notify(GAtResult *result,
> gpointer user_data)
>          decode_hex_own_buf(hexpdu, -1, &pdu_len, 0, pdu);
>          ofono_sms_status_notify(sms, pdu, pdu_len, tpdu_len);
>
> -       if (data->cnma_enabled)
> +       if (data->cnma_enabled && data->vendor !=3D OFONO_VENDOR_TELIT)
>                  at_ack_delivery(sms);

I suspect this is not needed on newer firmware.

>
>          return;
> @@ -429,7 +429,8 @@ static void at_cmt_notify(GAtResult *result,
> gpointer user_data)
>          decode_hex_own_buf(hexpdu, -1, &pdu_len, 0, pdu);
>          ofono_sms_deliver_notify(sms, pdu, pdu_len, tpdu_len);
>
> -       if (data->vendor !=3D OFONO_VENDOR_SIMCOM)
> +       if (data->vendor !=3D OFONO_VENDOR_SIMCOM &&
> +               data->vendor !=3D OFONO_VENDOR_TELIT)
>                  at_ack_delivery(sms);

Same as above

>   }
>
> diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
> index 2e45317..7c6cd43 100644
> --- a/drivers/atmodem/ussd.c
> +++ b/drivers/atmodem/ussd.c
> @@ -63,6 +63,18 @@ static void read_charset_cb(gboolean ok, GAtResult
> *result,
>          at_util_parse_cscs_query(result, &data->charset);
>   }
>
> +static void charset_cb(gboolean ok, GAtResult *result,
> +                               gpointer user_data)
> +{
> +       struct ussd_data *data =3D user_data;
> +
> +       if (!ok)
> +               return;
> +
> +       g_at_chat_send(data->chat, "AT+CSCS?", cscs_prefix,
> +                       read_charset_cb, data, NULL);
> +}
> +
>   static const unsigned char *ucs2_gsm_to_packed(const char *content,
>                                                  long *msg_len,
>                                                  unsigned char *msg)
> @@ -308,8 +320,12 @@ static int at_ussd_probe(struct ofono_ussd *ussd,
> unsigned int vendor,
>
>          ofono_ussd_set_data(ussd, data);
>
> -       g_at_chat_send(data->chat, "AT+CSCS?", cscs_prefix,
> -                       read_charset_cb, data, NULL);
> +       if(vendor =3D=3D OFONO_VENDOR_TELIT)
> +               g_at_chat_send(data->chat, "AT+CSCS=3DGSM", cscs_prefix,
> +                                       charset_cb, data, NULL);
> +       else
> +               g_at_chat_send(data->chat, "AT+CSCS?", cscs_prefix,
> +                               read_charset_cb, data, NULL);

The CSCS setting should be in plugins/he910.c.  That way you don't need =

to mess with vendor specific code here.

>
>          g_at_chat_send(data->chat, "AT+CUSD=3D1", NULL,
>                          at_ussd_register, ussd, NULL);
> diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
> index 7d823a2..7bfa65f 100644
> --- a/drivers/atmodem/voicecall.c
> +++ b/drivers/atmodem/voicecall.c
> @@ -1116,8 +1116,12 @@ static int at_voicecall_probe(struct
> ofono_voicecall *vc, unsigned int vendor
>          g_at_chat_send(vd->chat, "AT+CRC=3D1", NULL, NULL, NULL, NULL);
>          g_at_chat_send(vd->chat, "AT+CLIP=3D1", NULL, NULL, NULL, NULL);
> -       g_at_chat_send(vd->chat, "AT+CDIP=3D1", NULL, NULL, NULL, NULL);
> -       g_at_chat_send(vd->chat, "AT+CNAP=3D1", NULL, NULL, NULL, NULL);
> +
> +       if (vd->vendor !=3D OFONO_VENDOR_TELIT)
> +       {
> +               g_at_chat_send(vd->chat, "AT+CDIP=3D1", NULL, NULL, NULL,
> NULL);
> +               g_at_chat_send(vd->chat, "AT+CNAP=3D1", NULL, NULL, NULL,
> NULL);
> +       }

If these are not supported, then these commands will return an error. =

Should be safe to leave this in.

Regards,
-Denis

--===============4388903509824926041==--

