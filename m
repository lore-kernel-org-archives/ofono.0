Content-Type: multipart/mixed; boundary="===============8996936319723629938=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] Support Telit cdc acm device
Date: Mon, 17 Dec 2012 10:34:26 -0600
Message-ID: <50CF4992.4080209@gmail.com>
In-Reply-To: <1355761338-9081-2-git-send-email-mingli@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8996936319723629938==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mingli,

On 12/17/2012 10:22 AM, Mingli Wu wrote:
> This patch is for Telit HE910 modem. Configure modem and aux ports
> of ACM devices. some code of this patch was found on the Internet.
> ---
>   include/modem.h  |    3 +++
>   plugins/telit.c  |   24 +++++++++++++++++++++++-
>   plugins/udevng.c |   30 +++++++++++++++++++++++++++++-
>   src/modem.c      |   11 +++++++++++
>   4 files changed, 66 insertions(+), 2 deletions(-)

You need to break up these patches, see our patch submission guidelines =

in HACKING document, 'Submitting Patches' section.  Also please review =

the coding style guidelines in doc/coding-style.txt.

>
> diff --git a/include/modem.h b/include/modem.h
> index 6e08275..303bc24 100644
> --- a/include/modem.h
> +++ b/include/modem.h
> @@ -112,6 +112,9 @@ int ofono_modem_set_boolean(struct ofono_modem *modem,
>   ofono_bool_t ofono_modem_get_boolean(struct ofono_modem *modem,
>   					const char *key);
>
> +void ofono_modem_set_modem_info(struct ofono_modem *omodem, void *modem_=
info);
> +void *ofono_modem_get_modem_info(struct ofono_modem *omodem);
> +

This is not required, ofono_modem_set_string, set_integer, set_boolean =

are already enough.

>   int ofono_modem_driver_register(const struct ofono_modem_driver *);
>   void ofono_modem_driver_unregister(const struct ofono_modem_driver *);
>
> diff --git a/plugins/telit.c b/plugins/telit.c
> index a0f7deb..aaf2a9d 100644
> --- a/plugins/telit.c
> +++ b/plugins/telit.c
> @@ -180,6 +180,7 @@ static gboolean hw_event_cb(GIOChannel *hw_io, GIOCon=
dition condition,
>   	return FALSE;
>   }
>
> +extern gboolean udevng_match_modem_id(struct ofono_modem *modem, char *v=
endorid, char *productid);
>   static GAtChat *open_device(struct ofono_modem *modem,
>   				const char *key, char *debug)
>   {
> @@ -187,6 +188,7 @@ static GAtChat *open_device(struct ofono_modem *modem,
>   	GAtSyntax *syntax;
>   	GIOChannel *channel;
>   	GAtChat *chat;
> +	GHashTable *options =3D NULL;
>
>   	device =3D ofono_modem_get_string(modem, key);
>   	if (device =3D=3D NULL)
> @@ -194,7 +196,27 @@ static GAtChat *open_device(struct ofono_modem *mode=
m,
>
>   	DBG("%s %s", key, device);
>
> -	channel =3D g_at_tty_open(device, NULL);
> +	/* This is for Telit HE910. */
> +	if(udevng_match_modem_id(modem, "1bc7", "0021")){
> +		options =3D g_hash_table_new(g_str_hash, g_str_equal);
> +
> +		if (options =3D=3D NULL)
> +			return NULL;
> +
> +		g_hash_table_insert(options, "Baud", "115200");
> +		g_hash_table_insert(options, "Parity", "none");
> +		g_hash_table_insert(options, "StopBits", "1");
> +		g_hash_table_insert(options, "DataBits", "8");
> +		g_hash_table_insert(options, "XonXoff", "off");
> +		g_hash_table_insert(options, "Local", "on");
> +		g_hash_table_insert(options, "RtsCts", "on");
> +	}
> +
> +	channel =3D g_at_tty_open(device, options);
> +	if(options){
> +		g_hash_table_destroy(options);
> +	}
> +

This was already taken care of by the patch from Christopher that was =

applied today.

>   	if (channel =3D=3D NULL)
>   		return NULL;
>
> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index afb02ca..b7cdef6 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -57,6 +57,20 @@ struct device_info {
>   	char *sysattr;
>   };
>
> +
> +gboolean udevng_match_modem_id(struct ofono_modem *modem, char *vendorid=
, char *productid)
> +{
> +	struct modem_info *modem_info =3D ofono_modem_get_modem_info(modem);
> +
> +	if(!modem_info){
> +		return FALSE;
> +	}
> +	if (g_strcmp0(modem_info->vendor, vendorid) || g_strcmp0(modem_info->mo=
del, productid)){
> +		return FALSE;
> +	}
> +	return TRUE;
> +}
> +
>   static gboolean setup_isi(struct modem_info *modem)
>   {
>   	const char *node =3D NULL;
> @@ -620,6 +634,17 @@ static gboolean setup_telit(struct modem_info *modem)
>   			else if (g_strcmp0(info->number, "03") =3D=3D 0)
>   				aux =3D info->devnode;
>   		}
> +		/* This for Telit HE910 */
> +		else if (!g_strcmp0(modem->vendor, "1bc7")&&  !g_strcmp0(modem->model,=
 "0021")){
> +			if (g_strcmp0(info->interface, "2/2/1") =3D=3D 0) {
> +				if (g_strcmp0(info->number, "00") =3D=3D 0)
> +					mdm =3D info->devnode;
> +				else if (g_strcmp0(info->number, "02") =3D=3D 0)
> +					diag =3D info->devnode;
> +				else if (g_strcmp0(info->number, "06") =3D=3D 0)
> +					aux =3D info->devnode;
> +			}
> +		}
>   	}
>
>   	if (aux =3D=3D NULL || mdm =3D=3D NULL)
> @@ -629,7 +654,8 @@ static gboolean setup_telit(struct modem_info *modem)
>
>   	ofono_modem_set_string(modem->modem, "Modem", mdm);
>   	ofono_modem_set_string(modem->modem, "Aux", aux);
> -	ofono_modem_set_string(modem->modem, "GPS", gps);
> +	//ofono_modem_set_string(modem->modem, "GPS", gps);
> +	ofono_modem_set_string(modem->modem, "Diag", diag);

Please do not leave dead code in your patch submissions.

>
>   	return TRUE;
>   }
> @@ -988,6 +1014,7 @@ static struct {
>   	{ "simcom",	"option",	"05c6", "9000"	},
>   	{ "telit",	"usbserial",	"1bc7"		},
>   	{ "telit",	"option",	"1bc7"		},
> +	{ "telit",      "cdc_acm",      "1bc7", "0021"  },
>   	{ "nokia",	"option",	"0421", "060e"	},
>   	{ "nokia",	"option",	"0421", "0623"	},
>   	{ "samsung",	"option",	"04e8", "6889"	},
> @@ -1113,6 +1140,7 @@ static gboolean create_modem(gpointer key, gpointer=
 value, gpointer user_data)
>   	if (modem->modem =3D=3D NULL)
>   		return TRUE;
>
> +	ofono_modem_set_modem_info(modem->modem, modem);
>   	for (i =3D 0; driver_list[i].name; i++) {
>   		if (g_str_equal(driver_list[i].name, modem->driver) =3D=3D FALSE)
>   			continue;
> diff --git a/src/modem.c b/src/modem.c
> index 3c7c80a..207dce8 100644
> --- a/src/modem.c
> +++ b/src/modem.c
> @@ -87,6 +87,7 @@ struct ofono_modem {
>   	void			*driver_data;
>   	char			*driver_type;
>   	char			*name;
> +	void                    *modem_info;
>   };
>
>   struct ofono_devinfo {
> @@ -119,6 +120,16 @@ struct modem_property {
>   	void *value;
>   };
>
> +void ofono_modem_set_modem_info(struct ofono_modem *omodem, void *modem_=
info)
> +{
> +	omodem->modem_info =3D modem_info;
> +}
> +
> +void *ofono_modem_get_modem_info(struct ofono_modem *omodem)
> +{
> +	return omodem->modem_info;
> +}
> +
>   static const char *modem_type_to_string(enum ofono_modem_type type)
>   {
>   	switch (type) {

Regards,
-Denis

--===============8996936319723629938==--

