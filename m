Content-Type: multipart/mixed; boundary="===============6740356392204840842=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 4/5] atmodem/lte: proto and authentication handling
Date: Fri, 12 Oct 2018 10:12:18 +0200
Message-ID: <fdd4c609-f8ae-54c8-cdf3-3e06cac75138@southpole.se>
In-Reply-To: <20181012074607.17460-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6740356392204840842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Whoa... slow down a bit!

Firstly, your patches are coming so fast and furious that I don't even =

have time to review them before there's a new one... this is a new =

version, right?=C2=A0 You didn't include a version in the subject so it's n=
ot =

clear whether you've just accidentally resent this.

Secondly, you lose credibility when you send patches that aren't =

properly tested.=C2=A0 If you just want feedback on poorly tested stuff, pa=
ss =

--rfc to git-format-patch so it's clear that the patch is for review and =

not merging.

Make sure you've tested your patches before submission:=C2=A0 compiles =

without warnings, runs, works as expected, no valgrind errors, etc.


On 12/10/18 09:46, Giacinto Cifelli wrote:
> The ofono_lte_default_attach_info now handles also the protocol and the
> authentication method, username and password.
>
> Co-authored-by: Martin Baschin <martin.baschin@googlemail.com>
> ---
>   drivers/atmodem/lte.c | 92 +++++++++++++++++++++++++++++++++++++------
>   1 file changed, 81 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/atmodem/lte.c b/drivers/atmodem/lte.c
> index efa4e5fe..e02864ea 100644
> --- a/drivers/atmodem/lte.c
> +++ b/drivers/atmodem/lte.c
> @@ -3,6 +3,7 @@
>    *  oFono - Open Source Telephony
>    *
>    *  Copyright (C) 2017  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2018 Gemalto M2M
>    *
>    *  This program is free software; you can redistribute it and/or modify
>    *  it under the terms of the GNU General Public License version 2 as
> @@ -45,10 +46,17 @@ struct lte_driver_data {
>   	GAtChat *chat;
>   };
>   =

> -static void at_lte_set_default_attach_info_cb(gboolean ok, GAtResult *re=
sult,
> +struct lte_callbackdata {
> +	ofono_lte_cb_t cb;
> +	void *data;
> +	struct lte_driver_data *ldd;
> +	const struct ofono_lte_default_attach_info *info;
> +};
> +
> +static void at_lte_set_auth_cb(gboolean ok, GAtResult *result,
>   							gpointer user_data)
>   {
> -	struct cb_data *cbd =3D user_data;
> +	struct lte_callbackdata *cbd =3D user_data;

The usual pattern in ofono would be to make struct lte_callbackdata the =

.data member in struct cb_data.

>   	ofono_lte_cb_t cb =3D cbd->cb;
>   	struct ofono_error error;
>   =

> @@ -58,25 +66,89 @@ static void at_lte_set_default_attach_info_cb(gboolea=
n ok, GAtResult *result,
>   	cb(&error, cbd->data);
>   }
>   =

> +static void at_lte_set_auth(gboolean ok, GAtResult *result, gpointer use=
r_data)

I don't care much for the naming here... this is the callback for =

set_default_attach_info so the original name was better.=C2=A0 It's not a =

problem that this callback goes on to set up the authorization info.

> +{
> +	struct lte_callbackdata *cbd =3D user_data;
> +	ofono_lte_cb_t cb =3D cbd->cb;
> +	void *data =3D cbd->data;
> +	struct ofono_error error;
> +	char buf[32 + OFONO_GPRS_MAX_USERNAME_LENGTH +
> +					OFONO_GPRS_MAX_PASSWORD_LENGTH  + 1];
> +	guint buflen =3D sizeof(buf);
> +	guint len;
size_t

> +	enum ofono_gprs_auth_method auth_method;
> +
> +	if (!ok) {
> +		g_free(cbd);
> +		decode_at_error(&error, g_at_result_final_response(result));
> +		cb(&error, data);
> +	}
> +
> +	len =3D snprintf(buf, buflen, "AT+CGAUTH=3D0,");
> +	buflen -=3D len;
> +	auth_method =3D cbd->info->auth_method;
> +
> +	/* change the authentication method if the  parameters are invalid */
> +	if (!*cbd->info->username || !*cbd->info->password)
> +		auth_method =3D OFONO_GPRS_AUTH_METHOD_NONE;
> +
> +	switch (auth_method) {
> +	case OFONO_GPRS_AUTH_METHOD_PAP:
> +		snprintf(buf + len, buflen, "1,\"%s\",\"%s\"",
> +				cbd->info->username, cbd->info->password);
> +		break;
> +	case OFONO_GPRS_AUTH_METHOD_CHAP:
> +		snprintf(buf + len, buflen, "2,\"%s\",\"%s\"",
> +				cbd->info->username, cbd->info->password);
> +		break;
> +	case OFONO_GPRS_AUTH_METHOD_NONE:
> +		snprintf(buf + len, buflen, "0");
> +		break;
> +	}
> +
> +	if (g_at_chat_send(cbd->ldd->chat, buf, NULL,
> +			at_lte_set_auth_cb, cbd, g_free) > 0)
> +		return;
> +
> +	CALLBACK_WITH_FAILURE(cb, data);
> +}
> +
>   static void at_lte_set_default_attach_info(const struct ofono_lte *lte,
>   			const struct ofono_lte_default_attach_info *info,
>   			ofono_lte_cb_t cb, void *data)
>   {
>   	struct lte_driver_data *ldd =3D ofono_lte_get_data(lte);
>   	char buf[32 + OFONO_GPRS_MAX_APN_LENGTH + 1];
> -	struct cb_data *cbd =3D cb_data_new(cb, data);
> +	struct lte_callbackdata *cbd =3D g_new0(struct lte_callbackdata ,1);
> +	const char *proto;
>   =

>   	DBG("LTE config with APN: %s", info->apn);
>   =

> +	cbd->cb =3D cb;
> +	cbd->data =3D data;
> +	cbd->ldd =3D ldd;
> +	cbd->info =3D info;

How about:
cbd->data =3D lte_cbd;
where lte_cbd contains your extra parameters.

> +
> +	switch (info->proto) {
> +	case OFONO_GPRS_PROTO_IPV6:
> +		proto =3D "IPV6";
> +		break;
> +	case OFONO_GPRS_PROTO_IPV4V6:
> +		proto =3D "IPV4V6";
> +		break;
> +	case OFONO_GPRS_PROTO_IP:
> +		proto =3D "IP";
> +		break;
> +	}
> +
>   	if (strlen(info->apn) > 0)
> -		snprintf(buf, sizeof(buf), "AT+CGDCONT=3D0,\"IP\",\"%s\"",
> -				info->apn);
> +		snprintf(buf, sizeof(buf),
> +				"AT+CGDCONT=3D0,\"%s\",\"%s\"", proto, info->apn);
>   	else
> -		snprintf(buf, sizeof(buf), "AT+CGDCONT=3D0,\"IP\"");
> +		snprintf(buf, sizeof(buf), "AT+CGDCONT=3D0,\"%s\"", proto);

How about this?

n =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D0,\"%s\"", proto);
if (info->apn[0])
 =C2=A0=C2=A0=C2=A0 n +=3D snprintf(buf+n, sizeof(buf)-n, ",\"%s\"", info->=
apn);

>   =

> -	/* We can't do much in case of failure so don't check response. */
>   	if (g_at_chat_send(ldd->chat, buf, NULL,
> -			at_lte_set_default_attach_info_cb, cbd, g_free) > 0)
> +						at_lte_set_auth, cbd, NULL) > 0)

If this fails, you leak cbd.

>   		return;
>   =

>   	CALLBACK_WITH_FAILURE(cb, data);
> @@ -84,9 +156,7 @@ static void at_lte_set_default_attach_info(const struc=
t ofono_lte *lte,
>   =

>   static gboolean lte_delayed_register(gpointer user_data)
>   {
> -	struct ofono_lte *lte =3D user_data;
> -
> -	ofono_lte_register(lte);
> +	ofono_lte_register(user_data);

Again, NAK to this bit (I already reviewed this).=C2=A0 This is irrelevant =
to =

the rest of the patch.

/Jonas

>   =

>   	return FALSE;
>   }


--===============6740356392204840842==--

