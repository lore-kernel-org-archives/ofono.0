Content-Type: multipart/mixed; boundary="===============8353450524903454539=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 1/1] atmodem/lte: Gemalto vendor specific extension
Date: Mon, 15 Oct 2018 13:29:38 -0500
Message-ID: <af3fe243-1c6a-20fd-1bab-57145e871142@gmail.com>
In-Reply-To: <20181013080920.3487-2-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8353450524903454539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 10/13/2018 03:09 AM, Giacinto Cifelli wrote:
> Added a vendor-specific extension for handling PDP context creation
> and authentication, using the actual formats for the vendor.
> =


No, please don't do this.  atutil is only for generic / utility code =

that is vendor neutral.  E.g. stuff described in 27.007.  We made one =

exception here for parsing CREG/CGREG and that is because some vendors =

just can't implement AT commands properly.

> The formating code is in atutils, because it is shared also with
> gprs-context.
> ---
>   drivers/atmodem/atutil.c | 103 +++++++++++++++++++++++++
>   drivers/atmodem/atutil.h |  27 +++++++
>   drivers/atmodem/lte.c    | 161 ++++++++++++++++++++++++++++++++++++---
>   3 files changed, 281 insertions(+), 10 deletions(-)
> =

> diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
> index 6f4e8a20..1201dbf3 100644
> --- a/drivers/atmodem/atutil.c
> +++ b/drivers/atmodem/atutil.c
> @@ -3,6 +3,7 @@
>    *  oFono - Open Source Telephony
>    *
>    *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2018 Gemalto M2M
>    *
>    *  This program is free software; you can redistribute it and/or modify
>    *  it under the terms of the GNU General Public License version 2 as
> @@ -26,6 +27,7 @@
>   #include <glib.h>
>   #include <gatchat.h>
>   #include <string.h>
> +#include <stdio.h>
>   #include <stdlib.h>
>   #include <errno.h>
>   =

> @@ -33,6 +35,8 @@
>   #include <ofono/log.h>
>   #include <ofono/types.h>
>   =

> +#include "ofono.h"
> +
>   #include "atutil.h"
>   #include "vendor.h"
>   =

> @@ -654,3 +658,102 @@ int at_util_get_ipv4_address_and_netmask(const char=
 *addrnetmask,
>   =

>   	return ret;
>   }
> +
> +static int gemalto_get_auth_type(enum ofono_gprs_auth_method auth_method)
> +{
> +	switch (auth_method) {
> +	case OFONO_GPRS_AUTH_METHOD_PAP:
> +		return 1;
> +	case OFONO_GPRS_AUTH_METHOD_CHAP:
> +		return 2;
> +	case OFONO_GPRS_AUTH_METHOD_NONE:
> +		return 0;
> +	}
> +
> +	return 0;

This looks to be exact same enumeration that 27.007 uses...?

> +}
> +
> +gboolean gemalto_get_auth_command(struct ofono_modem *modem, int cid,
> +				enum ofono_gprs_auth_method auth_method,
> +				const char *username, const char *password,
> +				char *buf, guint buflen)
> +{
> +	int gemalto_auth =3D ofono_modem_get_integer(modem, "GemaltoAuthType");

Why don't you just simply pass the gemalto auth into this function =

directly instead of having to pass in the modem object?

> +	int len;
> +	/*
> +	 * 0x01: use sgauth (0=3Duse cgauth)
> +	 * 0x02: pwd, user order (0=3Duser, pwd order)
> +	 * 0x04: always use all: method, user, password
> +	 */

But certain combinations are not valid?  E.g. can we have a +CGAUTH with =

a wrong username/password order?

Have you considered simply writing a gemalto specific gprs.c driver that =

will use SGAUTH and using the default atmodem one on the sane devices?

> +
> +	int auth_type =3D gemalto_get_auth_type(auth_method);
> +
> +	if (auth_type !=3D 0 && (!*username || !*password))
> +		return FALSE;
> +
> +	if (gemalto_auth & 0x01)
> +		len =3D snprintf(buf, buflen, "AT^SGAUTH=3D%d", cid);
> +	else
> +		len =3D snprintf(buf, buflen, "AT+CGAUTH=3D%d", cid);
> +
> +	buflen -=3D len;
> +
> +	switch(auth_type) {
> +	case 0:
> +
> +		if (gemalto_auth & 0x04)
> +			snprintf(buf+len, buflen, ",0,\"\",\"\"");
> +		else
> +			snprintf(buf+len, buflen, ",0");
> +
> +		break;
> +	case 1:
> +	case 2:
> +
> +		if (gemalto_auth & 0x02)
> +			snprintf(buf+len, buflen, ",%d,\"%s\",\"%s\"",
> +					auth_type, password, username);
> +		else
> +			snprintf(buf+len, buflen, ",%d,\"%s\",\"%s\"",
> +					auth_type, username, password);
> +
> +		break;
> +	default:
> +		return FALSE;
> +	}
> +
> +	return TRUE;
> +}
> +
> +void gemalto_get_cgdcont_command(struct ofono_modem *modem,

Err, why do you need the modem object?

> +			guint cid, enum ofono_gprs_proto proto, const char *apn,
> +							char *buf, guint buflen)

Why is CGDCONT specific to gemalto?  This looks pretty standard

> +{
> +	int len =3D snprintf(buf, buflen, "AT+CGDCONT=3D%u", cid);
> +	buflen -=3D len;
> +
> +	/*
> +	 * For future extension: verify if the module supports automatic
> +	 * context provisioning and if so, also if there is a manual override
> +	 * This is an ofono_modem_get_integer property
> +	 */
> +
> +	/*
> +	 * if apn is null, it will remove the context.
> +	 * but if apn is empty, it will create a context with empty apn
> +	 */
> +	if (!apn)
> +		return;
> +
> +	switch (proto) {
> +	case OFONO_GPRS_PROTO_IPV6:
> +		snprintf(buf+len, buflen, ",\"IPV6\",\"%s\"", apn);
> +		break;
> +	case OFONO_GPRS_PROTO_IPV4V6:
> +		snprintf(buf+len, buflen, ",\"IPV4V6\",\"%s\"", apn);
> +		break;
> +	case OFONO_GPRS_PROTO_IP:
> +		snprintf(buf+len, buflen, ",\"IP\",\"%s\"", apn);
> +		break;
> +	}
> +}
> diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
> index 7113a4cd..b74db9fe 100644
> --- a/drivers/atmodem/atutil.h
> +++ b/drivers/atmodem/atutil.h
> @@ -3,6 +3,7 @@
>    *  oFono - Open Source Telephony
>    *
>    *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2018 Gemalto M2M
>    *
>    *  This program is free software; you can redistribute it and/or modify
>    *  it under the terms of the GNU General Public License version 2 as
> @@ -19,6 +20,8 @@
>    *
>    */
>   =

> +struct ofono_modem;
> +

This should not be necessary if you follow the above advice...

>   enum at_util_sms_store {
>   	AT_UTIL_SMS_STORE_SM =3D	0,
>   	AT_UTIL_SMS_STORE_ME =3D	1,
> @@ -86,6 +89,15 @@ void at_util_sim_state_query_free(struct at_util_sim_s=
tate_query *req);
>   int at_util_get_ipv4_address_and_netmask(const char *addrnetmask,
>   						char *address, char *netmask);
>   =

> +gboolean gemalto_get_auth_command(struct ofono_modem *modem, int cid,
> +				enum ofono_gprs_auth_method auth_method,
> +				const char *username, const char *password,
> +				char *buf, guint buflen);
> +
> +void gemalto_get_cgdcont_command(struct ofono_modem *modem,
> +			guint cid, enum ofono_gprs_proto proto, const char *apn,
> +						char *buf, guint buflen);
> +
>   struct cb_data {
>   	void *cb;
>   	void *data;
> @@ -115,6 +127,21 @@ static inline int at_util_convert_signal_strength(in=
t strength)
>   	return result;
>   }
>   =

> +static inline int at_util_convert_signal_strength_cesq(int strength_GSM,
> +					int strength_UTRAN, int strength_EUTRAN)
> +{
> +	int result =3D -1;
> +
> +	if (strength_GSM !=3D 99)
> +		result =3D (strength_GSM * 100) / 63;
> +	else if (strength_UTRAN !=3D 255)
> +		result =3D (strength_UTRAN * 100) / 96;
> +	else if (strength_EUTRAN !=3D 255)
> +		result =3D (strength_EUTRAN * 100) / 97;
> +
> +	return result;
> +}
> +

How is this related to the current patch?

>   #define CALLBACK_WITH_FAILURE(cb, args...)		\
>   	do {						\
>   		struct ofono_error cb_e;		\
> diff --git a/drivers/atmodem/lte.c b/drivers/atmodem/lte.c
> index efa4e5fe..41de4197 100644
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
> @@ -43,12 +44,65 @@
>   =

>   struct lte_driver_data {
>   	GAtChat *chat;
> +	unsigned int vendor;
>   };
>   =

> -static void at_lte_set_default_attach_info_cb(gboolean ok, GAtResult *re=
sult,
> +struct lte_cbd {
> +	gint ref_count; /* Ref count */
> +	ofono_lte_cb_t cb;
> +	void *data;
> +	GAtChat *chat;

Why don't you just include a pointer to lte_driver_data and not store =

all this redundant stuff like vendor, chat, etc.

> +	const struct ofono_lte_default_attach_info *info;

And as I pointed out last time, you can't do this.  The core is not =

obligated to keep the object pointed to around after the driver method =

has been called.  So this might be pointing out into the ether, invalid =

memory, etc.

> +	unsigned int vendor;
> +	struct ofono_modem *modem;
> +};
> +
> +static struct lte_cbd *lte_cb_data_new0(void *cb, void *data,
> +		GAtChat *chat, const struct ofono_lte_default_attach_info *info,
> +		unsigned int vendor, struct ofono_modem *modem)
> +{
> +	struct lte_cbd *cbd =3D g_new0(struct lte_cbd, 1);
> +
> +	cbd->ref_count =3D 1;
> +	cbd->cb =3D cb;
> +	cbd->data =3D data;
> +	cbd->chat =3D chat;
> +	cbd->info =3D info;
> +	cbd->vendor =3D vendor;
> +	cbd->modem =3D modem;
> +
> +	return cbd;
> +}
> +
> +static inline struct lte_cbd *lte_cb_data_ref(struct lte_cbd *cbd)
> +{
> +	if (cbd =3D=3D NULL)
> +		return NULL;
> +
> +	g_atomic_int_inc(&cbd->ref_count);
> +
> +	return cbd;
> +}
> +
> +static void lte_cb_data_unref(gpointer user_data)
> +{
> +	gboolean is_zero;
> +	struct lte_cbd *cbd =3D user_data;
> +
> +	if (cbd =3D=3D NULL)
> +		return;
> +
> +	is_zero =3D g_atomic_int_dec_and_test(&cbd->ref_count);
> +
> +	if (is_zero =3D=3D TRUE)
> +		g_free(cbd);
> +}
> +
> +
> +static void at_lte_set_auth_cb(gboolean ok, GAtResult *result,
>   							gpointer user_data)
>   {
> -	struct cb_data *cbd =3D user_data;
> +	struct lte_cbd *cbd =3D user_data;
>   	ofono_lte_cb_t cb =3D cbd->cb;
>   	struct ofono_error error;
>   =

> @@ -58,27 +112,113 @@ static void at_lte_set_default_attach_info_cb(gbool=
ean ok, GAtResult *result,
>   	cb(&error, cbd->data);
>   }
>   =

> +static void at_lte_set_default_attach_info_cb(gboolean ok, GAtResult *re=
sult,
> +							gpointer user_data)
> +{
> +	struct lte_cbd *cbd =3D user_data;
> +	ofono_lte_cb_t cb =3D cbd->cb;
> +	void *data =3D cbd->data;
> +	struct ofono_error error;
> +	char buf[32 + OFONO_GPRS_MAX_USERNAME_LENGTH +
> +					OFONO_GPRS_MAX_PASSWORD_LENGTH  + 1];
> +	size_t buflen =3D sizeof(buf);
> +	size_t len;
> +	enum ofono_gprs_auth_method auth_method;
> +
> +	if (!ok) {
> +		lte_cb_data_unref(cbd);
> +		decode_at_error(&error, g_at_result_final_response(result));
> +		cb(&error, data);
> +		return;
> +	}
> +
> +
> +	auth_method =3D cbd->info->auth_method;
> +
> +	/* change the authentication method if the  parameters are invalid */
> +	if (!*cbd->info->username || !*cbd->info->password)
> +		auth_method =3D OFONO_GPRS_AUTH_METHOD_NONE;
> +
> +	if (ldd->vendor =3D=3D OFONO_VENDOR_GEMALTO) {
> +
> +		if (!gemalto_get_auth_command(modem, 1, auth_method,
> +						info->username, info->password,
> +						buf, sizeof(buf)))
> +			goto error;
> +
> +	} else { /* default vendor*/
> +		len =3D snprintf(buf, buflen, "AT+CGAUTH=3D0,");
> +		buflen -=3D len;
> +
> +		switch (auth_method) {
> +		case OFONO_GPRS_AUTH_METHOD_PAP:
> +			snprintf(buf + len, buflen, "1,\"%s\",\"%s\"",
> +					cbd->info->username, cbd->info->password);
> +			break;
> +		case OFONO_GPRS_AUTH_METHOD_CHAP:
> +			snprintf(buf + len, buflen, "2,\"%s\",\"%s\"",
> +					cbd->info->username, cbd->info->password);
> +			break;
> +		case OFONO_GPRS_AUTH_METHOD_NONE:
> +			snprintf(buf + len, buflen, "0");
> +			break;
> +		}
> +	}
> +
> +	cbd =3D lte_cb_data_ref(cbd);
> +	if (g_at_chat_send(cbd->chat, buf, NULL,
> +			at_lte_set_auth_cb, cbd, lte_cb_data_unref) > 0)
> +		return;
> +
> +error:
> +	lte_cb_data_unref(cbd);
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
> +	const char *proto;
> +	size_t len;
> +	struct ofono_modem *modem =3D ofono_lte_get_modem(lte);
> +	struct lte_cbd *cbd =3D lte_cb_data_new0(cb, data, ldd->chat, info,
> +							ldd->vendor, modem);
>   =


Again, have you considered just writing a Gemalto specific LTE driver? =

The whole thing is only 140 lines of code right now.

>   	DBG("LTE config with APN: %s", info->apn);
>   =

> -	if (strlen(info->apn) > 0)
> -		snprintf(buf, sizeof(buf), "AT+CGDCONT=3D0,\"IP\",\"%s\"",
> -				info->apn);
> -	else
> -		snprintf(buf, sizeof(buf), "AT+CGDCONT=3D0,\"IP\"");
> +	if (ldd->vendor =3D=3D OFONO_VENDOR_GEMALTO) {
> +		gemalto_get_cgdcont_command(modem, 1, info->proto, info->apn,
> +					buf, sizeof(buf));
> +	} else { /* default vendor*/
> +
> +		switch (info->proto) {
> +		case OFONO_GPRS_PROTO_IPV6:
> +			proto =3D "IPV6";
> +			break;
> +		case OFONO_GPRS_PROTO_IPV4V6:
> +			proto =3D "IPV4V6";
> +			break;
> +		case OFONO_GPRS_PROTO_IP:
> +			proto =3D "IP";
> +			break;
> +		}
> +
> +		len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D0,\"%s\"", proto);
> +
> +		if (*info->apn)
> +			snprintf(buf+len, sizeof(buf)-len, ",\"%s\"",
> +								info->apn);
> +	}
>   =

> -	/* We can't do much in case of failure so don't check response. */
>   	if (g_at_chat_send(ldd->chat, buf, NULL,
> -			at_lte_set_default_attach_info_cb, cbd, g_free) > 0)
> +			at_lte_set_default_attach_info_cb,
> +			cbd, lte_cb_data_unref) > 0)
>   		return;
>   =

> +	lte_cb_data_unref(cbd);
>   	CALLBACK_WITH_FAILURE(cb, data);
>   }
>   =

> @@ -103,6 +243,7 @@ static int at_lte_probe(struct ofono_lte *lte, unsign=
ed int vendor, void *data)
>   		return -ENOMEM;
>   =

>   	ldd->chat =3D g_at_chat_clone(chat);
> +	ldd->vendor =3D vendor;
>   =

>   	ofono_lte_set_data(lte, ldd);
>   =

> =


Regards,
-Denis

--===============8353450524903454539==--

