Content-Type: multipart/mixed; boundary="===============7617576412659329517=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH v4 4/4] atmodem/lte: proto and authentication handling
Date: Sat, 13 Oct 2018 08:23:51 +0200
Message-ID: <87a9d0c5-0ddf-f165-eff5-69c0ee8f3a3a@southpole.se>
In-Reply-To: <20181013054855.20150-5-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7617576412659329517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,


On 13/10/18 07:48, Giacinto Cifelli wrote:
> The ofono_lte_default_attach_info now handles also the protocol and the
> authentication method, username and password.
>
> Co-authored-by: Martin Baschin <martin.baschin@googlemail.com>
> ---
>   drivers/atmodem/lte.c | 133 ++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 123 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/atmodem/lte.c b/drivers/atmodem/lte.c
> index efa4e5fe..72e0a6ef 100644
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
> @@ -45,10 +46,57 @@ struct lte_driver_data {
>   	GAtChat *chat;
>   };
>   =

> -static void at_lte_set_default_attach_info_cb(gboolean ok, GAtResult *re=
sult,
> +struct lte_cbd {
> +	gint ref_count; /* Ref count */
> +	ofono_lte_cb_t cb;
> +	void *data;
> +	GAtChat *chat;
> +	const struct ofono_lte_default_attach_info *info;
> +};
> +
> +static struct lte_cbd *lte_cb_data_new0(void *cb, void *data,
> +		GAtChat *chat, const struct ofono_lte_default_attach_info *info)
> +{
> +	struct lte_cbd *cbd =3D g_new0(struct lte_cbd, 1);
> +
> +	cbd->ref_count =3D 1;
> +	cbd->cb =3D cb;
> +	cbd->data =3D data;
> +	cbd->chat =3D chat;
> +	cbd->info =3D info;
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

The above isn't wrong, but I question the need for the atomic =

constructs.=C2=A0 ofono isn't a thread-safe library.

I see that there other uses of atomic accessors in the codebase, but I =

believe these are remnants of a past approach with other ambitions... =

Denis will set me right if I'm wrong about this because this mostly =

predates my involvement with ofono. :)

/Jonas


--===============7617576412659329517==--

