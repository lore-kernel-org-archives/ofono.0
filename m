Content-Type: multipart/mixed; boundary="===============7207702997818350452=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH_v4] speedupcdma: add speedup cdma skeleton plugin
Date: Thu, 21 Jul 2011 12:00:20 +0200
Message-ID: <1311242421.21109.265.camel@aeonflux>
In-Reply-To: <1311215468-2462-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7207702997818350452==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

I applied the patch and fixed up the last issues by myself. Please
review them closely.

> Free speedupcdma_data while removing modem.

Version and changelog comments have to come after the ---. Otherwise
they end up in the commit log. And without a previous commit they make
no sense then.

If in doubt, please check your patch with git am and see how it applies.

> ---
>  Makefile.am           |    3 +
>  plugins/speedupcdma.c |  210 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 213 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/speedupcdma.c
> =

> diff --git a/Makefile.am b/Makefile.am
> index a4e6c95..4b72091 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -336,6 +336,9 @@ builtin_sources +=3D plugins/telit.c
>  builtin_modules +=3D speedup
>  builtin_sources +=3D plugins/speedup.c
>  =

> +builtin_modules +=3D speedupcdma
> +builtin_sources +=3D plugins/speedupcdma.c
> +
>  if BLUETOOTH
>  builtin_modules +=3D bluetooth
>  builtin_sources +=3D plugins/bluetooth.c plugins/bluetooth.h
> diff --git a/plugins/speedupcdma.c b/plugins/speedupcdma.c
> new file mode 100644
> index 0000000..65da2f6
> --- /dev/null
> +++ b/plugins/speedupcdma.c
> @@ -0,0 +1,210 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <stdio.h>
> +#include <errno.h>
> +#include <stdlib.h>
> +
> +#include <glib.h>
> +#include <gatchat.h>
> +#include <gattty.h>
> +
> +#define OFONO_API_SUBJECT_TO_CHANGE
> +#include <ofono/plugin.h>
> +#include <ofono/modem.h>
> +#include <ofono/devinfo.h>
> +#include <ofono/cdma-connman.h>
> +#include <ofono/log.h>
> +
> +#include <drivers/atmodem/atutil.h>
> +
> +static const char *none_prefix[] =3D { NULL };
> +
> +struct speedupcdma_data {
> +	GAtChat *chat;
> +};
> +
> +static void speedupcdma_debug(const char *str, void *data)
> +{
> +	const char *prefix =3D data;
> +
> +	ofono_info("%s%s", prefix, str);
> +}
> +
> +static int speedupcdma_probe(struct ofono_modem *modem)
> +{
> +	struct speedupcdma_data *data;
> +
> +	DBG("%p", modem);
> +
> +	data =3D g_try_new0(struct speedupcdma_data, 1);
> +	if (data =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	ofono_modem_set_data(modem, data);
> +
> +	return 0;
> +}
> +
> +static void speedupcdma_remove(struct ofono_modem *modem)
> +{
> +	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	g_free(data);
> +	ofono_modem_set_data(modem, NULL);
> +}

The general rule here is to first call ofono_modem_set_data() in a
remove callback to set it back to NULL and then free the data. This is
how all of the other plugins do it as well.

It does not make a difference here since we are single threaded with a
mainloop, but it is style that we should keep.

If really in doubt, the IFX plugin is the best example since we spent a
lot of time to make it clean and be able to have it as a reference.

> +static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_da=
ta)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +
> +	DBG("");
> +
> +	if (!ok) {
> +		struct speedupcdma_data *data =3D ofono_modem_get_data(modem);

While this is fine, the general style is to keep it at the top.

> +
> +		g_at_chat_unref(data->chat);
> +		data->chat =3D=3D NULL;

And seriously? This even gives a compile error:

  CC     plugins/speedupcdma.o
plugins/speedupcdma.c: In function =E2=80=98cfun_enable=E2=80=99:
plugins/speedupcdma.c:91:3: error: statement with no effect [-Werror=3Dunus=
ed-value]
cc1: all warnings being treated as errors

I know that typos like this happen. Even I overlooked it in the v3
review, but the compiler warning should have been a big indication that
something is wrong here. That is why I insist that developers use
bootstrap-configure to enable maintainer-mode and we can catch these
ones.

In your previous code with the g_at_chat_unref() inside the remove
callback, this would have caused a crash when enabling of a modem failed
and you stop ofonod after.

> +		ofono_modem_set_powered(modem, FALSE);
> +		return;
> +	}
> +
> +	ofono_modem_set_powered(modem, TRUE);
> +}
> +
> +static int speedupcdma_enable(struct ofono_modem *modem)
> +{
> +	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
> +	GAtSyntax *syntax;
> +	GIOChannel *channel;
> +	const char *modem_path;
> +
> +	modem_path =3D ofono_modem_get_string(modem, "Modem");
> +	if (modem_path =3D=3D NULL)
> +		return -EINVAL;
> +
> +	DBG("path is: %s", modem_path);
> +
> +	channel =3D g_at_tty_open(modem_path, NULL);
> +	if (channel =3D=3D NULL)
> +		return -EIO;
> +
> +	syntax =3D g_at_syntax_new_gsm_permissive();
> +	data->chat =3D g_at_chat_new(channel, syntax);
> +	g_at_syntax_unref(syntax);
> +
> +	g_io_channel_unref(channel);
> +
> +	if (data->chat =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	if (getenv("OFONO_AT_DEBUG"))
> +		g_at_chat_set_debug(data->chat, speedupcdma_debug, "Modem: ");
> +
> +	g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", none_prefix,
> +						NULL, NULL, NULL);
> +
> +	g_at_chat_send(data->chat, "AT+CFUN=3D1", none_prefix,
> +					cfun_enable, modem, NULL);
> +
> +	return -EINPROGRESS;
> +}
> +
> +static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_d=
ata)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("");
> +
> +	g_at_chat_unref(data->chat);
> +	data->chat =3D NULL;
> +
> +	if (ok)
> +		ofono_modem_set_powered(modem, FALSE);
> +}
> +
> +static int speedupcdma_disable(struct ofono_modem *modem)
> +{
> +	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	g_at_chat_send(data->chat, "AT+CFUN=3D0", none_prefix,
> +					cfun_disable, modem, NULL);
> +
> +	return -EINPROGRESS;
> +}
> +
> +static void speedupcdma_pre_sim(struct ofono_modem *modem)
> +{
> +	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	ofono_devinfo_create(modem, 0, "cdmamodem", data->chat);
> +}
> +
> +static void speedupcdma_post_sim(struct ofono_modem *modem)
> +{
> +	DBG("%p", modem);
> +}
> +
> +static void speedupcdma_post_online(struct ofono_modem *modem)
> +{
> +	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	ofono_cdma_connman_create(modem, 0, "cdmamodem", data->chat);
> +}
> +
> +static struct ofono_modem_driver speedupcdma_driver =3D {
> +	.name		=3D "speedupcdma",
> +	.probe		=3D speedupcdma_probe,
> +	.remove		=3D speedupcdma_remove,
> +	.enable		=3D speedupcdma_enable,
> +	.disable	=3D speedupcdma_disable,
> +	.pre_sim	=3D speedupcdma_pre_sim,
> +	.post_sim	=3D speedupcdma_post_sim,
> +	.post_online	=3D speedupcdma_post_online,
> +};
> +
> +static int speedupcdma_init(void)
> +{
> +	return ofono_modem_driver_register(&speedupcdma_driver);
> +}
> +
> +static void speedupcdma_exit(void)
> +{
> +	ofono_modem_driver_unregister(&speedupcdma_driver);
> +}
> +
> +OFONO_PLUGIN_DEFINE(speedupcdma, "Speedup CDMA modem driver", VERSION,
> +				OFONO_PLUGIN_PRIORITY_DEFAULT,
> +				speedupcdma_init, speedupcdma_exit)

I fixed up the name to Speed Up since that is how this company name
seems to be written. At least according to my Google search ;)

Regards

Marcel



--===============7207702997818350452==--

