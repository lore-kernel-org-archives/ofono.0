Content-Type: multipart/mixed; boundary="===============8624263346911444920=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/6] gemalto: support ALS3 in gemalto's plugin
Date: Thu, 15 Mar 2018 12:11:14 -0500
Message-ID: <ede1a470-9930-352a-be94-3501f298974b@gmail.com>
In-Reply-To: <1521118170-23722-3-git-send-email-gabriel.lucas@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8624263346911444920==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gabriel,

On 03/15/2018 07:49 AM, Gabriel Lucas wrote:
> Force serial port opening options
> Wait for modem to be ready to start
> initializing it
> Handle LTE
> ---
>   plugins/gemalto.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++=
+++----
>   1 file changed, 99 insertions(+), 6 deletions(-)
> =

> diff --git a/plugins/gemalto.c b/plugins/gemalto.c
> index 3739d7b..16ca463 100644
> --- a/plugins/gemalto.c
> +++ b/plugins/gemalto.c
> @@ -53,6 +53,10 @@
>   =

>   #define HARDWARE_MONITOR_INTERFACE OFONO_SERVICE ".cinterion.HardwareMo=
nitor"
>   =

> +// Supported gemalto's modem

No // please, use /* */.  This is C code ;)

> +#define GEMALTO_MODEL_PHS8P 	"0053"
> +#define GEMALTO_MODEL_ALS3 		"0061"
> +
>   static const char *none_prefix[] =3D { NULL };
>   static const char *sctm_prefix[] =3D { "^SCTM:", NULL };
>   static const char *sbv_prefix[] =3D { "^SBV:", NULL };
> @@ -70,6 +74,8 @@ struct gemalto_data {
>   	gboolean have_sim;
>   	struct at_util_sim_state_query *sim_state_query;
>   	struct gemalto_hardware_monitor *hm;
> +	guint modem_ready_id;
> +	guint trial_cmd_id;
>   };
>   =

>   static int gemalto_probe(struct ofono_modem *modem)
> @@ -107,10 +113,24 @@ static GAtChat *open_device(const char *device)
>   	GAtSyntax *syntax;
>   	GIOChannel *channel;
>   	GAtChat *chat;
> +	GHashTable *options;
> +
> +	options =3D g_hash_table_new(g_str_hash, g_str_equal);
> +	if (options =3D=3D NULL)
> +		return NULL;
> +
> +	g_hash_table_insert(options, "Baud", "115200");
> +	g_hash_table_insert(options, "StopBits", "1");
> +	g_hash_table_insert(options, "DataBits", "8");
> +	g_hash_table_insert(options, "Parity", "none");
> +	g_hash_table_insert(options, "XonXoff", "off");
> +	g_hash_table_insert(options, "RtsCts", "on");
> +	g_hash_table_insert(options, "Local", "on");
> +	g_hash_table_insert(options, "Read", "on");
>   =

>   	DBG("Opening device %s", device);
>   =

> -	channel =3D g_at_tty_open(device, NULL);
> +	channel =3D g_at_tty_open(device, options);
>   	if (channel =3D=3D NULL)
>   		return NULL;

You leak options here in case channel =3D=3D NULL.  The typical pattern is =

to call g_hash_table_destroy(options) right after g_at_tty_open.  See =

other plugins for details.

>   =

> @@ -118,6 +138,7 @@ static GAtChat *open_device(const char *device)
>   	chat =3D g_at_chat_new(channel, syntax);
>   	g_at_syntax_unref(syntax);
>   	g_io_channel_unref(channel);
> +	g_hash_table_destroy(options);
>   =

>   	if (chat =3D=3D NULL)
>   		return NULL;
> @@ -300,29 +321,33 @@ static int gemalto_hardware_monitor_enable(struct o=
fono_modem *modem)
>   	return 0;
>   }
>   =

> -static int gemalto_enable(struct ofono_modem *modem)
> +static void gemalto_initialize(struct ofono_modem *modem)
>   {
>   	struct gemalto_data *data =3D ofono_modem_get_data(modem);
>   	const char *app, *mdm;
>   =

> -	DBG("%p", modem);
> +	/* Close devices */
> +	g_at_chat_unref(data->mdm);
> +	g_at_chat_unref(data->app);
> +

Why would you close both devices?  It is unnecessary, especially in the =

case that the modem is already up and responding to commands.

> +	DBG("");
>   =

>   	app =3D ofono_modem_get_string(modem, "Application");
>   	mdm =3D ofono_modem_get_string(modem, "Modem");
>   =

>   	if (app =3D=3D NULL || mdm =3D=3D NULL)
> -		return -EINVAL;
> +		return;
>   =

>   	/* Open devices */
>   	data->app =3D open_device(app);
>   	if (data->app =3D=3D NULL)
> -		return -EINVAL;
> +		return;
>   =

>   	data->mdm =3D open_device(mdm);
>   	if (data->mdm =3D=3D NULL) {
>   		g_at_chat_unref(data->app);
>   		data->app =3D NULL;
> -		return -EINVAL;
> +		return;
>   	}
>   =

>   	if (getenv("OFONO_AT_DEBUG")) {
> @@ -340,6 +365,67 @@ static int gemalto_enable(struct ofono_modem *modem)
>   			cfun_enable, modem, NULL);
>   =

>   	gemalto_hardware_monitor_enable(modem);
> +}
> +
> +static void gemalto_modem_ready(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct gemalto_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("");
> +
> +	g_at_chat_unregister(data->app, data->modem_ready_id);
> +	g_at_chat_cancel(data->app, data->trial_cmd_id);
> +
> +	gemalto_initialize(modem);
> +}
> +
> +static void gemalto_at_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct gemalto_data *data =3D ofono_modem_get_data(modem);
> +
> +	g_at_chat_unregister(data->app, data->modem_ready_id);
> +	gemalto_initialize(modem);
> +}
> +
> +static gboolean gemalto_at_timeout(gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct gemalto_data *data =3D ofono_modem_get_data(modem);
> +
> +	data->trial_cmd_id =3D g_at_chat_send(data->app, "AT+CFUN?", none_prefi=
x, gemalto_at_cb, modem, NULL);

What does this do?

> +
> +	return FALSE;
> +}

Where is the timeout started?

> +
> +static int gemalto_enable(struct ofono_modem *modem)
> +{
> +	struct gemalto_data *data =3D ofono_modem_get_data(modem);
> +	const char *app, *mdm;
> +
> +	DBG("%p", modem);
> +
> +	app =3D ofono_modem_get_string(modem, "Application");
> +	mdm =3D ofono_modem_get_string(modem, "Modem");
> +
> +	if (app =3D=3D NULL || mdm =3D=3D NULL)
> +		return -EINVAL;
> +
> +	/* Open devices */
> +	data->app =3D open_device(app);
> +	if (data->app =3D=3D NULL)
> +		return -EINVAL;
> +
> +	data->mdm =3D open_device(mdm);
> +	if (data->mdm =3D=3D NULL) {
> +		g_at_chat_unref(data->app);
> +		data->app =3D NULL;
> +		return -EINVAL;
> +	}
> +
> +	data->modem_ready_id =3D g_at_chat_register(data->app, "^SYSSTART", gem=
alto_modem_ready, FALSE, modem, NULL);
> +	data->trial_cmd_id =3D g_at_chat_send(data->app, "ATE0 AT", none_prefix=
, gemalto_at_cb, modem, NULL);

We use the Linux Kernel coding style with house rules documented in =

doc/coding-style.txt.  No lines over 80 characters please.

Why do you open both ports only to close them in gemalto_initialize? =

One port here would be sufficient.

>   =

>   	return -EINPROGRESS;
>   }
> @@ -449,10 +535,17 @@ static void gemalto_post_sim(struct ofono_modem *mo=
dem)
>   static void gemalto_post_online(struct ofono_modem *modem)
>   {
>   	struct gemalto_data *data =3D ofono_modem_get_data(modem);
> +	const char *model;
>   =

>   	DBG("%p", modem);
>   =

>   	ofono_netreg_create(modem, OFONO_VENDOR_CINTERION, "atmodem", data->ap=
p);
> +
> +	model =3D ofono_modem_get_string(modem, "Model");

You might as well perform this assignment at variable declaration.

> +
> +	if(!strncmp(model, GEMALTO_MODEL_ALS3, 4)) {
> +		ofono_lte_create(modem, "atmodem", data->app);
> +	}

Why strncmp?  No need for {} and there should be a space between if and '('

Also, you most likely need the LTE atom in post_sim.

You also now have to little arguments to ofono_lte_create.  Please git =

pull --rebase first.

>   }
>   =

>   static struct ofono_modem_driver gemalto_driver =3D {
> =


Regards,
-Denis

--===============8624263346911444920==--

