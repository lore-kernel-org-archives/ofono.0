Content-Type: multipart/mixed; boundary="===============2999015137683998214=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH_v2] huaweicdma: Create first draft for plugin huaweicdma
Date: Tue, 12 Jul 2011 12:23:09 +0200
Message-ID: <1310466191.21109.86.camel@aeonflux>
In-Reply-To: <1310464990-20448-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2999015137683998214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

> +/*
> + * This file is part of oFono - Open Source Telephony
> + *
> + * Copyright (C) 2010 Nokia Corporation. All rights reserved.
> + * Copyright (C) 2008-2011  Intel Corporation. All rights reserved.

it is nice of you that you wanna keep some Nokia copyright in here, but
there is no Nokia copyright in this skeleton. All skeletons are from
Intel actually.

> +#include <drivers/atmodem/atutil.h>
> +#include <ofono/cdma-voicecall.h>

Do not bother with CDMA voicecalls here.

> +#include <ofono/devinfo.h>
> +#include <ofono/cdma-connman.h>
> +
> +#include "common.h"
> +
> +struct huaweicdma_data {
> +	GAtChat *chat;
> +};
> +
> +static void huaweicdma_debug(const char *str, void *data)
> +{
> +	const char *prefix =3D data;
> +
> +	ofono_info("%s%s", prefix, str);
> +}
> +
> +static int huaweicdma_probe(struct ofono_modem *modem)
> +{
> +	struct huaweicdma_data *data;
> +
> +	DBG("%p", modem);
> +
> +	data =3D g_try_new0(struct huaweicdma_data, 1);
> +	if (data =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	ofono_modem_set_data(modem, data);
> +
> +	return 0;
> +}
> +
> +static void huaweicdma_remove(struct ofono_modem *modem)
> +{
> +	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	ofono_modem_set_data(modem, NULL);
> +
> +	g_at_chat_unref(data->chat);
> +
> +	g_free(data);
> +}
> +
> +static int huaweicdma_enable(struct ofono_modem *modem)
> +{
> +	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
> +	GAtSyntax *syntax;
> +	GIOChannel *channel;
> +	const char *device;
> +
> +	device =3D ofono_modem_get_string(modem, "Device");
> +	if (device =3D=3D NULL)
> +		return -EINVAL;
> +
> +	channel =3D g_at_tty_open(device, NULL);
> +	if (channel =3D=3D NULL)
> +		return -EIO;
> +
> +	/*
> +	 * TODO: Will need a CDMA AT syntax parser later.
> +	 * Using GSM V1 for now.
> +	 */
> +	syntax =3D g_at_syntax_new_gsmv1();

This is not a fix me later. You need to figure out if the Huawei modem
can handle V1 syntax or not. Most likely not. Since the GSM version also
uses the permissive parser.

> +	data->chat =3D g_at_chat_new(channel, syntax);
> +	g_at_syntax_unref(syntax);
> +	g_io_channel_unref(channel);
> +
> +	if (data->chat =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	if (getenv("OFONO_AT_DEBUG"))
> +		g_at_chat_set_debug(data->chat, huaweicdma_debug,
> +					"CDMA Device: ");
> +
> +	return 0;
> +}
> +
> +static int huaweicdma_disable(struct ofono_modem *modem)
> +{
> +	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	g_at_chat_unref(data->chat);
> +	data->chat =3D NULL;
> +
> +	return 0;
> +}
> +
> +static void huaweicdma_pre_sim(struct ofono_modem *modem)
> +{
> +	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
> +
> +	ofono_cdma_voicecall_create(modem, 0, "cdmamodem", data->chat);

Do not bother with voicecall support here.

> +	ofono_devinfo_create(modem, 0, "cdmamodem", data->chat);
> +}
> +
> +static void huaweicdma_post_sim(struct ofono_modem *modem)
> +{
> +}
> +
> +static void huaweicdma_post_online(struct ofono_modem *modem)
> +{
> +	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);

Extra empty line here. And I like to have even the debug prints
consistent over post_sim and pre_sim as well.

> +	ofono_cdma_connman_create(modem, 0, "cdmamodem", data->chat);
> +}
> +
> +static struct ofono_modem_driver huaweicdma_driver =3D {
> +	.name			=3D "huaweicdma",
> +	.probe			=3D huaweicdma_probe,
> +	.remove			=3D huaweicdma_remove,
> +	.enable			=3D huaweicdma_enable,
> +	.disable		=3D huaweicdma_disable,
> +	.pre_sim		=3D huaweicdma_pre_sim,
> +	.post_sim		=3D huaweicdma_post_sim,
> +	.post_online		=3D huaweicdma_post_online,
> +};

Remove one tab here. No need to extend it this much.

> +static int huaweicdma_init(void)
> +{
> +	return ofono_modem_driver_register(&huaweicdma_driver);
> +}
> +
> +static void huaweicdma_exit(void)
> +{
> +	ofono_modem_driver_unregister(&huaweicdma_driver);
> +}
> +
> +OFONO_PLUGIN_DEFINE(huaweicdma, "Huawei CDMA AT Modem", VERSION,
> +			OFONO_PLUGIN_PRIORITY_DEFAULT,
> +			huaweicdma_init, huaweicdma_exit)

The rest looks fine.

Regards

Marcel



--===============2999015137683998214==--

