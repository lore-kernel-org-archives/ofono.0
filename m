Content-Type: multipart/mixed; boundary="===============8784494584205258630=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 7/7] cdmaphonesim: Add CDMA SMS Support
Date: Tue, 04 Jan 2011 15:44:01 -0600
Message-ID: <4D2394A1.7010205@gmail.com>
In-Reply-To: <1293051795-17758-2-git-send-email-lei.2.yu@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8784494584205258630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lei,

On 12/22/2010 03:03 PM, Lei Yu wrote:
> ---
>  Makefile.am            |   10 ++
>  plugins/cdmaphonesim.c |  328 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  plugins/phonesim.conf  |    4 +
>  3 files changed, 342 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/cdmaphonesim.c
> =

> diff --git a/Makefile.am b/Makefile.am
> index 771f57d..f2a686c 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -247,6 +247,16 @@ builtin_modules +=3D cdma_atmodem
>  builtin_sources +=3D drivers/cdmamodem/cdmamodem.h \
>  			drivers/cdmamodem/cdmamodem.c \
>  			drivers/cdmamodem/sms.c
> +
> +if PHONESIM
> +
> +if DATAFILES
> +conf_DATA +=3D plugins/phonesim.conf
> +endif
> +endif
> +

Yikes, you better check this logic.  I suspect simply adding:

+builtin_modules +=3D cdmaphonesim
+builtin_sources +=3D plugins/cdmaphonesim.c

to the existing if PHONESIM block should be enough.

>  endif
>  =

>  builtin_modules +=3D g1
> diff --git a/plugins/cdmaphonesim.c b/plugins/cdmaphonesim.c
> new file mode 100644
> index 0000000..c9a88b4
> --- /dev/null
> +++ b/plugins/cdmaphonesim.c
> @@ -0,0 +1,328 @@
> +/*
> + * This file is part of oFono - Open Source Telephony
> + *
> + * Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 =
USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <errno.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/socket.h>
> +#include <netinet/in.h>
> +#include <arpa/inet.h>
> +
> +#include <glib.h>
> +#include <gatmux.h>
> +#include <gatchat.h>
> +
> +#define OFONO_API_SUBJECT_TO_CHANGE
> +#include <ofono/plugin.h>
> +#include <ofono/log.h>
> +#include <ofono/modem.h>
> +#include <ofono/cdma-sms.h>
> +#include <drivers/atmodem/atutil.h>
> +
> +struct cdmaphonesim_data {
> +	GAtChat *chat;
> +};
> +
> +static int cdmaphonesim_probe(struct ofono_modem *modem)
> +{
> +	struct cdmaphonesim_data *data;
> +
> +	DBG("%p", modem);
> +
> +	data =3D g_try_new0(struct cdmaphonesim_data, 1);
> +	if (data =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	ofono_modem_set_data(modem, data);
> +
> +	return 0;
> +}
> +
> +static void cdmaphonesim_remove(struct ofono_modem *modem)
> +{
> +	struct cdmaphonesim_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	g_free(data);
> +	ofono_modem_set_data(modem, NULL);
> +}
> +
> +static void cdmaphonesim_debug(const char *str, void *user_data)
> +{
> +	ofono_info("%s", str);
> +}
> +
> +static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +
> +	DBG("");
> +
> +	ofono_modem_set_powered(modem, ok);
> +}
> +
> +static void cdmaphonesim_disconnected(gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct cdmaphonesim_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("");
> +
> +	ofono_modem_set_powered(modem, FALSE);
> +
> +	g_at_chat_unref(data->chat);
> +	data->chat =3D NULL;
> +}
> +
> +static int cdmaphonesim_enable(struct ofono_modem *modem)
> +{
> +	struct cdmaphonesim_data *data =3D ofono_modem_get_data(modem);
> +	GIOChannel *io;
> +	GAtSyntax *syntax;
> +	struct sockaddr_in addr;
> +	const char *address;
> +	int sk, err, port;
> +
> +	DBG("%p", modem);
> +
> +	address =3D ofono_modem_get_string(modem, "Address");
> +	if (address =3D=3D NULL)
> +		return -EINVAL;
> +
> +	port =3D ofono_modem_get_integer(modem, "Port");
> +	if (port < 0)
> +		return -EINVAL;
> +
> +	sk =3D socket(PF_INET, SOCK_STREAM, 0);
> +	if (sk < 0)
> +		return -EINVAL;
> +
> +	memset(&addr, 0, sizeof(addr));
> +	addr.sin_family =3D AF_INET;
> +	addr.sin_addr.s_addr =3D inet_addr(address);
> +	addr.sin_port =3D htons(port);
> +
> +	err =3D connect(sk, (struct sockaddr *) &addr, sizeof(addr));
> +	if (err < 0) {
> +		close(sk);
> +		return err;
> +	}
> +
> +	io =3D g_io_channel_unix_new(sk);
> +	if (io =3D=3D NULL) {
> +		close(sk);
> +		return -ENOMEM;
> +	}
> +
> +	syntax =3D g_at_syntax_new_gsmv1();
> +
> +	data->chat =3D g_at_chat_new(io, syntax);
> +
> +	g_at_syntax_unref(syntax);
> +	g_io_channel_unref(io);
> +
> +	if (data->chat =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	if (getenv("OFONO_AT_DEBUG"))
> +		g_at_chat_set_debug(data->chat, cdmaphonesim_debug, NULL);
> +
> +	g_at_chat_set_disconnect_function(data->chat,
> +					cdmaphonesim_disconnected, modem);
> +
> +	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL,
> +					cfun_set_on_cb, modem, NULL);
> +
> +	return -EINPROGRESS;
> +}
> +
> +static int cdmaphonesim_disable(struct ofono_modem *modem)
> +{
> +	struct cdmaphonesim_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	g_at_chat_unref(data->chat);
> +	data->chat =3D NULL;
> +
> +	return 0;
> +}
> +
> +static void cdmaphonesim_pre_sim(struct ofono_modem *modem)
> +{
> +	DBG("%p", modem);
> +}
> +
> +static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	ofono_modem_online_cb_t callback =3D cbd->cb;
> +	struct ofono_error error;
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +
> +	callback(&error, cbd->data);
> +}
> +
> +static void cdmaphonesim_set_online(struct ofono_modem *modem,
> +					ofono_bool_t online,
> +					ofono_modem_online_cb_t cb,
> +					void *user_data)
> +{
> +	struct cdmaphonesim_data *data =3D ofono_modem_get_data(modem);
> +	struct cb_data *cbd =3D cb_data_new(cb, user_data);
> +	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
> +
> +	DBG("modem %p %s", modem, online ? "online" : "offline");
> +
> +	if (cbd =3D=3D NULL)
> +		goto error;
> +
> +	if (g_at_chat_send(data->chat, command, NULL,
> +				set_online_cb, cbd, g_free))
> +		return;
> +
> +error:
> +	g_free(cbd);
> +
> +	CALLBACK_WITH_FAILURE(cb, cbd->data);
> +}
> +
> +static void cdmaphonesim_post_online(struct ofono_modem *modem)
> +{
> +	struct cdmaphonesim_data *data =3D ofono_modem_get_data(modem);
> +
> +	ofono_cdma_sms_create(modem, 0, "cdmamodem", data->chat);
> +}
> +
> +static struct ofono_modem_driver cdmaphonesim_driver =3D {
> +	.name		=3D "cdmaphonesim",
> +	.probe		=3D cdmaphonesim_probe,
> +	.remove		=3D cdmaphonesim_remove,
> +	.enable		=3D cdmaphonesim_enable,
> +	.disable	=3D cdmaphonesim_disable,
> +	.pre_sim	=3D cdmaphonesim_pre_sim,
> +	.set_online	=3D cdmaphonesim_set_online,
> +	.post_online	=3D cdmaphonesim_post_online,
> +};
> +
> +static struct ofono_modem *create_modem(GKeyFile *keyfile, const char *g=
roup)
> +{
> +	struct ofono_modem *modem;
> +	char *value;
> +
> +	DBG("group %s", group);
> +
> +	modem =3D ofono_modem_create(group, "cdmaphonesim");
> +	if (modem =3D=3D NULL)
> +		return NULL;
> +
> +	value =3D g_key_file_get_string(keyfile, group, "Address", NULL);
> +	if (value =3D=3D NULL)
> +		goto error;
> +
> +	ofono_modem_set_string(modem, "Address", value);
> +	g_free(value);
> +
> +	value =3D g_key_file_get_string(keyfile, group, "Port", NULL);
> +	if (value =3D=3D NULL)
> +		goto error;
> +
> +	ofono_modem_set_integer(modem, "Port", atoi(value));
> +	g_free(value);
> +
> +	DBG("%p", modem);
> +
> +	return modem;
> +
> +error:
> +	ofono_error("Missing address or port setting for %s", group);
> +
> +	ofono_modem_remove(modem);
> +
> +	return NULL;
> +}
> +
> +static GSList *modem_list;
> +
> +static void parse_config(const char *filename)
> +{
> +	GKeyFile *keyfile;
> +	GError *err =3D NULL;
> +	char **modems;
> +	int i;
> +
> +	DBG("filename %s", filename);
> +
> +	keyfile =3D g_key_file_new();
> +
> +	g_key_file_set_list_separator(keyfile, ',');
> +
> +	if (!g_key_file_load_from_file(keyfile, filename, 0, &err)) {
> +		ofono_warn("Reading of %s failed: %s", filename, err->message);
> +		g_error_free(err);
> +		goto done;
> +	}
> +
> +	modems =3D g_key_file_get_groups(keyfile, NULL);
> +
> +	for (i =3D 0; modems[i]; i++) {
> +		struct ofono_modem *modem;
> +
> +		modem =3D create_modem(keyfile, modems[i]);
> +		if (modem =3D=3D NULL)
> +			continue;
> +
> +		modem_list =3D g_slist_prepend(modem_list, modem);
> +
> +		ofono_modem_register(modem);
> +	}
> +
> +	g_strfreev(modems);
> +
> +done:
> +	g_key_file_free(keyfile);
> +}
> +
> +static int cdmaphonesim_init(void)
> +{
> +	int err;
> +
> +	err =3D ofono_modem_driver_register(&cdmaphonesim_driver);
> +	if (err < 0)
> +		return err;
> +
> +	parse_config(CONFIGDIR "/phonesim.conf");
> +	return 0;
> +}
> +
> +static void cdmaphonesim_exit(void)
> +{
> +	ofono_modem_driver_unregister(&cdmaphonesim_driver);
> +}
> +
> +OFONO_PLUGIN_DEFINE(cdmaphonesim, "CDMA PhoneSIM driver", VERSION,
> +	OFONO_PLUGIN_PRIORITY_DEFAULT, cdmaphonesim_init, cdmaphonesim_exit)
> diff --git a/plugins/phonesim.conf b/plugins/phonesim.conf
> index 74bb645..8cd9678 100644
> --- a/plugins/phonesim.conf
> +++ b/plugins/phonesim.conf
> @@ -12,3 +12,7 @@
>  #[phonesim]
>  #Address=3D127.0.0.1
>  #Port=3D12345
> +
> +#[cdmaphonesim]
> +#Address=3D127.0.0.1
> +#Port=3D12345

If we have both phonesim and cdmaphonesim plugins active, we need to
make sure they don't interfere with each other.  Perhaps adding a
Type=3Dcdma and having cdmaphonesim look for that Type tag and ignore the
rest would be a good idea?

Regards,
-Denis

--===============8784494584205258630==--

