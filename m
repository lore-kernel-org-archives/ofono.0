Content-Type: multipart/mixed; boundary="===============6206510651041759081=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 5/6] atmodem/lte: proto and authentication handling
Date: Fri, 12 Oct 2018 04:54:12 +0200
Message-ID: <CAKSBH7GXDSfN70fd+7WVbxir6PxerDf56kcM_RqcZ5iaCgnXDw@mail.gmail.com>
In-Reply-To: <da05e9af-1ac8-a0ec-c6fd-8d3d96b10bbd@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6206510651041759081==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 11, 2018 at 9:51 PM Jonas Bonn <jonas@southpole.se> wrote:
>
> Hi,
>
> I think this patch deserves a couple of lines of justification in the pat=
ch description.  From the subject, it isn't obvious what this is about, and=
 a quick glance at the diff only raises further questions.  Try to explain =
in the patch description what this is about, what problem your modification=
 is solving.
>

Ok, I will duplicate the explanation in patch 2/6.

>
> On 10/10/18 08:54, Giacinto Cifelli wrote:
>
> ---
>  drivers/atmodem/lte.c | 79 +++++++++++++++++++++++++++----------------
>  1 file changed, 50 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/atmodem/lte.c b/drivers/atmodem/lte.c
> index efa4e5fe..1d097c68 100644
> --- a/drivers/atmodem/lte.c
> +++ b/drivers/atmodem/lte.c
> @@ -3,6 +3,7 @@
>   *  oFono - Open Source Telephony
>   *
>   *  Copyright (C) 2017  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2018 Gemalto M2M
>
>
> Why is copyright attributed to Gemalto when you and the other purported a=
uthors (referencing your AUTHORS patch... see below) all use gmail addresse=
s?

We decided not to use our Gemalto emails for this. Also because it is
difficult to send formatted patches from there.

>
>
> On 10/10/18 08:54, Giacinto Cifelli wrote:
>
> ---
>  AUTHORS | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/AUTHORS b/AUTHORS
> index 2d360e6e..8f0f5893 100644
> --- a/AUTHORS
> +++ b/AUTHORS
> @@ -138,3 +138,6 @@ Florent Beillonnet <florent.beillonnet@gmail.com>
>  Martin Hundeb=C3=B8ll <martin@geanix.com>
>  Julien Tournier <tournier.julien@gmail.com>
>  Nandini Rebello <nandini.rebello@intel.com>
> +Giacinto Cifelli <gciofono@gmail.com>
> +Martin Baschin <martin.baschin@googlemail.com>
> +Sebastian Arnd <sebastianarnd@gmail.com>
>
>
> Three authors but only Giacinto's name appears in the patches?

Yes, I have reworked the code of both Martin and Sebastian, but
doesn't seem fair not to mention them.

>
>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2 as
> @@ -45,48 +46,67 @@ struct lte_driver_data {
>   GAtChat *chat;
>  };
>
> -static void at_lte_set_default_attach_info_cb(gboolean ok, GAtResult *re=
sult,
> - gpointer user_data)
> +static void at_set_reg_info(const struct ofono_lte *lte,
> + const struct ofono_lte_default_attach_info *info)
>  {
> - struct cb_data *cbd =3D user_data;
> - ofono_lte_cb_t cb =3D cbd->cb;
> - struct ofono_error error;
> + struct lte_driver_data *ldd =3D ofono_lte_get_data(lte);
> + char buf_cgdcont[32 + OFONO_GPRS_MAX_APN_LENGTH  +1];
> + char buf_cgauth[32 + OFONO_GPRS_MAX_USERNAME_LENGTH +
> + OFONO_GPRS_MAX_PASSWORD_LENGTH +1];
> + guint buflen =3D sizeof(buf_cgauth);
> + enum ofono_gprs_auth_method auth_method;
>
> - DBG("ok %d", ok);
> + if (strlen(info->apn) > 0)
> + snprintf(buf_cgdcont, sizeof(buf_cgdcont),
> + "AT+CGDCONT=3D0,\"IP\",\"%s\"", info->apn);
> + else
> + snprintf(buf_cgdcont, sizeof(buf_cgdcont),
> + "AT+CGDCONT=3D0,\"IP\"");
>
> - decode_at_error(&error, g_at_result_final_response(result));
> - cb(&error, cbd->data);
> + if (g_at_chat_send(ldd->chat, buf_cgdcont, NULL, NULL, NULL, NULL) =3D=
=3D 0)
> + return;
> +
> + snprintf(buf_cgauth, buflen, "AT+CGAUTH=3D0,");
> + buflen -=3D strlen(buf_cgauth);
>
>
> Using snprintf() without checking the return value is mostly pointless...=
 if you know with certainty that your buffer will hold your string just use=
 sprintf.  The above could be better written as:
>
> n =3D sprintf(...);
> buflen -=3D n;
>

ok

>
> +
> + auth_method =3D info->auth_method;
> +
> + /*
> + * change the authentication method if the  parameters are invalid
> + * for behavior compatibility
> + */
> + if(!*info->username || !*info->password)
> + auth_method =3D OFONO_GPRS_AUTH_METHOD_NONE;
> +
> + switch(auth_method) {
> + case OFONO_GPRS_AUTH_METHOD_PAP:
> + snprintf(buf_cgauth+strlen(buf_cgauth),
>
>
> You know strlen(buf_cgauth) already... it's 'n' above, the return value f=
rom snprintf.  No need to traverse the string again to figure this out.

ok

>
> + buflen, "1,\"%s\",\"%s\"",
> + info->username, info->password);
> + break;
> + case OFONO_GPRS_AUTH_METHOD_CHAP:
> + snprintf(buf_cgauth+strlen(buf_cgauth),
> + buflen, "2,\"%s\",\"%s\"",
> + info->username, info->password);
> + break;
> + case OFONO_GPRS_AUTH_METHOD_NONE:
> + snprintf(buf_cgauth+strlen(buf_cgauth), buflen, "0");
> + break;
> + }
> +
> + g_at_chat_send(ldd->chat, buf_cgauth, NULL, NULL, NULL, NULL);
>
>
> Can't fail?

I will check this

>
>  }
>
>  static void at_lte_set_default_attach_info(const struct ofono_lte *lte,
>   const struct ofono_lte_default_attach_info *info,
>   ofono_lte_cb_t cb, void *data)
>  {
> - struct lte_driver_data *ldd =3D ofono_lte_get_data(lte);
> - char buf[32 + OFONO_GPRS_MAX_APN_LENGTH + 1];
> - struct cb_data *cbd =3D cb_data_new(cb, data);
> -
> - DBG("LTE config with APN: %s", info->apn);
> -
> - if (strlen(info->apn) > 0)
> - snprintf(buf, sizeof(buf), "AT+CGDCONT=3D0,\"IP\",\"%s\"",
> - info->apn);
> - else
> - snprintf(buf, sizeof(buf), "AT+CGDCONT=3D0,\"IP\"");
> -
> - /* We can't do much in case of failure so don't check response. */
> - if (g_at_chat_send(ldd->chat, buf, NULL,
> - at_lte_set_default_attach_info_cb, cbd, g_free) > 0)
> - return;
> -
> - CALLBACK_WITH_FAILURE(cb, data);
> + CALLBACK_WITH_SUCCESS(cb, data);
>  }
>
>
>
> Aside from abandoning all error handling, what does set_reg_info provide =
that could not have been handled by set_default_attach_info?

this is the result of a long discussion with Denis.
Since the properties are set one by one, setting ip, apn, auth_method,
username, password would cause the call of AT+CGDCONT and AT+CGAUTH
several times, with incomplete
and possibly modified parameters (for the authentication, you need to
have all 3 valid to have it executed properly).

An atom can still chose to apply the parameters on the go in
set_default_attach_info, but set_reg_info is executed just before
going online, with all parameters already set.
It has also the advantage of working more like gprs-context, when the
parameters are set before activating the context and not all the time.

>
>
>  static gboolean lte_delayed_register(gpointer user_data)
>  {
> - struct ofono_lte *lte =3D user_data;
> -
> - ofono_lte_register(lte);
> + ofono_lte_register(user_data);
>
>
> I prefer the original version... nonetheless, this change doesn't belong =
in this patch.

ok

>
>
>   return FALSE;
>  }
> @@ -129,6 +149,7 @@ static struct ofono_lte_driver driver =3D {
>   .probe =3D at_lte_probe,
>   .remove =3D at_lte_remove,
>   .set_default_attach_info =3D at_lte_set_default_attach_info,
> + .set_reg_info =3D at_set_reg_info,
>  };
>
>  void at_lte_init(void)
>
>
> /Jonas

Giacinto

--===============6206510651041759081==--

