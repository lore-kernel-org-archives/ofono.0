Content-Type: multipart/mixed; boundary="===============6181547340763630122=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC] ifxmodem: integrating new kernel-space MUX driver
Date: Tue, 01 Feb 2011 12:00:01 +0100
Message-ID: <1296558001.1520.262.camel@aeonflux>
In-Reply-To: <1296532143-22407-1-git-send-email-robertino.benis@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6181547340763630122==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Robertino,

> Request for comments on attempt to integrate new kernel-space
> MUX driver with oFono, for Infineon modem

I am doing just a basic review here to get things going into the right
direction.

> ---
>  drivers/ifxmodem/gprs-context.c |   82 +++++++++++++++++++++++++++++++++=
++-
>  plugins/ifx.c                   |   88 +++++++++++++++++++++++++++++++++=
------
>  2 files changed, 155 insertions(+), 15 deletions(-)
> =

> diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-cont=
ext.c
> index 2c68b44..d5ad46e 100644
> --- a/drivers/ifxmodem/gprs-context.c
> +++ b/drivers/ifxmodem/gprs-context.c
> @@ -27,8 +27,14 @@
>  #include <string.h>
>  #include <stdlib.h>
>  #include <stdio.h>
> +#include <string.h>
>  #include <errno.h>
>  #include <sys/stat.h>
> +#include <sys/ioctl.h>
> +#include <net/if.h>
> +#include <linux/types.h>
> +#include <arpa/inet.h>
> +#include <linux/if_ether.h>
>  =

>  #include <glib.h>
>  =

> @@ -63,7 +69,9 @@ struct gprs_context_data {
>  	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
>  	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
>  	GAtRawIP *rawip;
> +	gboolean use_ofono_mux;

This is the thing I'd rather not do. We can just have a second GPRS
context driver. Not sure about the naming, but one could be "ifxmodem"
and the other "ifxmodem-internal" or similar. Maybe someone comes up
with some better names.

>  	enum state state;
> +	char if_name[IF_NAMESIZE];

This should not be needed. You can just reference the stack variable.

>  	char address[32];
>  	char dns1[32];
>  	char dns2[32];
> @@ -74,12 +82,56 @@ struct gprs_context_data {
>  	void *cb_data;                                  /* Callback data */
>  };
>  =

> +struct gsm_netconfig {
> +	unsigned int adaption;
> +	unsigned short protocol;
> +	unsigned short unused2;
> +	__u8 unused[28]; /* future use */
> +};
> +
> +#define GSMIOC_ENABLE_NET       _IOW('G', 2, struct gsm_netconfig)
> +#define GSMIOC_DISABLE_NET      _IO('G', 3)
> +

This should be in drivers/ifxmodem/gsmmux.h and be a literal copy from
what the kernel has. Check STE and how it does it for CAIF.

>  static void rawip_debug(const char *str, void *data)
>  {
>  	ofono_info("%s: %s", (const char *) data, str);
>  }
>  =

> -static const char *setup_rawip(struct ofono_gprs_context *gc)
> +static const char *setup_rawip_kmux(struct ofono_gprs_context *gc)
> +{
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +	struct gsm_netconfig netconfig;
> +	int fd;
> +	int n;
> +	char *interface =3D NULL;
> +
> +	DBG("");
> +
> +	fd =3D g_io_channel_unix_get_fd(g_at_chat_get_channel(gcd->chat));
> +	ofono_info("Got file descriptor: %d", fd);
> +
> +	g_at_chat_suspend(gcd->chat);
> +
> +	netconfig.adaption =3D 3;
> +	netconfig.protocol =3D htons(ETH_P_IP);
> +	n =3D ioctl(fd, GSMIOC_ENABLE_NET, &netconfig);
> +	if (n < 0) {
> +		ofono_error("Cannot enable network on the mux: %d", n);
> +		return NULL;
> +	}
> +	ofono_info("Net index: %d", n);
> +
> +	interface =3D if_indextoname(n, gcd->if_name);
> +	if (interface =3D=3D NULL) {
> +		ofono_error("Interface index %d error %d error msg %s", n, errno, stre=
rror(errno));
> +		return NULL;
> +	}
> +	ofono_info("Interface name: %s", interface);
> +
> +	return interface;
> +}
> +
> +static const char *setup_rawip_internal(struct ofono_gprs_context *gc)
>  {
>  	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
>  	GAtIO *io;
> @@ -153,7 +205,14 @@ static void session_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
>  	dns[1] =3D gcd->dns2;
>  	dns[2] =3D 0;
>  =

> -	interface =3D setup_rawip(gc);
> +	if (gcd->use_ofono_mux =3D=3D FALSE) {
> +		ofono_info("Calling setup_rawip_kmux()");
> +		interface =3D setup_rawip_kmux(gc);
> +	}
> +	else {
> +		ofono_info("Calling setup_rawip_internal()");
> +		interface =3D setup_rawip_internal(gc);
> +	}
>  	if (interface =3D=3D NULL)
>  		interface =3D "invalid";
>  =

> @@ -436,7 +495,9 @@ static int ifx_gprs_context_probe(struct ofono_gprs_c=
ontext *gc,
>  					unsigned int vendor, void *data)
>  {
>  	GAtChat *chat =3D data;
> +	const char *ldisc;
>  	struct gprs_context_data *gcd;
> +	struct ofono_modem *modem;
>  	struct stat st;
>  =

>  	DBG("");
> @@ -455,6 +516,19 @@ static int ifx_gprs_context_probe(struct ofono_gprs_=
context *gc,
>  =

>  	gcd->chat =3D g_at_chat_clone(chat);
>  =

> +	modem =3D ofono_gprs_context_get_modem(gc);
> +	ldisc =3D ofono_modem_get_string(modem, "LineDiscipline");
> +
> +	ofono_info("Got LineDiscipline variable from udev: %s", ldisc);
> +	if (ldisc !=3D NULL) {
> +		ofono_info("setting up to use kernel mux for data");
> +		gcd->use_ofono_mux =3D FALSE;
> +	}
> +	else {
> +		ofono_info("setting up to use user space mux for data");
> +		gcd->use_ofono_mux =3D TRUE;
> +	}
> +
>  	ofono_gprs_context_set_data(gc, gcd);
>  =

>  	chat =3D g_at_chat_get_slave(gcd->chat);
> @@ -475,6 +549,10 @@ static void ifx_gprs_context_remove(struct ofono_gpr=
s_context *gc)
>  		g_at_chat_resume(gcd->chat);
>  	}
>  =

> +	if (gcd->state !=3D STATE_IDLE && gcd->use_ofono_mux =3D=3D FALSE) {
> +		g_at_chat_resume(gcd->chat);
> +	}
> +

What is this trying to fix? Either it is a general bug or not. Seems
more like a general bug that we tie rawip existence with the state.

Check if remove() will be actually ever called without calling
deactivate() first. It might be well that this is an oversight on my
part.

>  	ofono_gprs_context_set_data(gc, NULL);
>  =

>  	g_at_chat_unref(gcd->chat);
> diff --git a/plugins/ifx.c b/plugins/ifx.c
> index 411c012..9e7c910 100644
> --- a/plugins/ifx.c
> +++ b/plugins/ifx.c
> @@ -26,8 +26,10 @@
>  #include <stdio.h>
>  #include <errno.h>
>  #include <stdlib.h>
> +#include <string.h>
>  #include <sys/stat.h>
>  #include <sys/ioctl.h>
> +#include <linux/types.h>
>  =

>  #include <glib.h>
>  #include <gatchat.h>
> @@ -75,13 +77,31 @@
>  static char *dlc_prefixes[NUM_DLC] =3D { "Voice: ", "Net: ", "GPRS1: ",
>  					"GPRS2: ", "GPRS3: ", "Aux: " };
>  =

> -static const char *dlc_nodes[NUM_DLC] =3D { "/dev/ttyGSM1", "/dev/ttyGSM=
2",
> -					"/dev/ttyGSM3", "/dev/ttyGSM4",
> -					"/dev/ttyGSM5", "/dev/ttyGSM6" };
> +static const char *dlc_nodes[NUM_DLC] =3D { "/dev/gsmtty1", "/dev/gsmtty=
2",
> +					"/dev/gsmtty3", "/dev/gsmtty4",
> +					"/dev/gsmtty5", "/dev/gsmtty6" };
>  =

>  static const char *none_prefix[] =3D { NULL };
>  static const char *xdrv_prefix[] =3D { "+XDRV:", NULL };
>  =

> +struct gsm_config {
> +	unsigned int adaption;
> +	unsigned int encapsulation;
> +	unsigned int initiator;
> +	unsigned int t1;
> +	unsigned int t2;
> +	unsigned int t3;
> +	unsigned int n2;
> +	unsigned int mru;
> +	unsigned int mtu;
> +	unsigned int k;
> +	unsigned int i;
> +	unsigned int unused[8]; /* padding */
> +};
> +
> +#define GSMIOC_GETCONF	_IOR('G', 0, struct gsm_config)
> +#define GSMIOC_SETCONF	_IOW('G', 1, struct gsm_config)
> +

As mentioned above this goes to drivers/ifxmodem/gsmmux.h

>  struct ifx_data {
>  	GIOChannel *device;
>  	GAtMux *mux;
> @@ -471,6 +491,8 @@ static void mux_setup_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
>  {
>  	struct ofono_modem *modem =3D user_data;
>  	struct ifx_data *data =3D ofono_modem_get_data(modem);
> +	int ret;

As a general rule I prefer err as variable name.

> +	struct gsm_config cfg;
>  	int fd;
>  =

>  	DBG("");
> @@ -504,6 +526,34 @@ static void mux_setup_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
>  		goto error;
>  	}
>  =

> +	memset(&cfg, 0, sizeof(struct gsm_config));
> +
> +	if ((ret =3D ioctl(fd, GSMIOC_GETCONF, &cfg)) < 0) {

	err =3D ioct(...
	if (err < 0)

> +		ofono_error("Failed to get configuration on n_gsm multiplexer: %d", re=
t);
> +		goto error;

You forgot to restore the line discipline here.

> +	}
> +
> +	ofono_info("Got default configuration...");
> +	ofono_info("adaption =3D %d", cfg.adaption);
> +	ofono_info("encapsulation =3D %d", cfg.encapsulation);
> +	ofono_info("initiator =3D %d", cfg.initiator);
> +	ofono_info("t1 =3D %d", cfg.t1);
> +	ofono_info("t2 =3D %d", cfg.t2);
> +	ofono_info("t3 =3D %d", cfg.t3);
> +	ofono_info("n2 =3D %d", cfg.n2);
> +	ofono_info("mru =3D %d", cfg.mru);
> +	ofono_info("mtu =3D %d", cfg.mtu);
> +	ofono_info("k =3D %d", cfg.k);
> +
> +	cfg.encapsulation =3D 0; /* encoding - set to basic */
> +	cfg.initiator =3D 1; /* we are starting side */
> +	cfg.mru =3D 1509;
> +	cfg.mtu =3D 1509;
> +	if ((ret =3D ioctl(fd, GSMIOC_SETCONF, &cfg)) < 0) {

Same here.

> +		ofono_error("Failed to configure n_gsm multiplexer: %d", ret);
> +		goto error;

Same here, you need to restore the line discipline.

> +	}
> +
>  	data->dlc_poll_count =3D 0;
>  	data->dlc_poll_source =3D g_timeout_add_seconds(1, dlc_ready_check,
>  								modem);
> @@ -661,10 +711,14 @@ static void ifx_set_online(struct ofono_modem *mode=
m, ofono_bool_t online,
>  =

>  	DBG("%p %s", modem, online ? "online" : "offline");
>  =

> +	if (cbd =3D=3D NULL)
> +		goto error;
> +

We got rid of this.

Your re-base is again against and outdated tree. You really need to be
careful with just copying files over. You need to merge first. Otherwise
you keep snippets like this.

>  	if (g_at_chat_send(data->dlcs[AUX_DLC], command, NULL,
>  					set_online_cb, cbd, g_free) > 0)
>  		return;
>  =

> +error:
>  	g_free(cbd);

Same here. That is from a wrong re-base.
 =

>  	CALLBACK_WITH_FAILURE(cb, cbd->data);
> @@ -726,26 +780,34 @@ static void ifx_post_online(struct ofono_modem *mod=
em)
>  	if (mw)
>  		ofono_message_waiting_register(mw);
>  =

> +	ofono_warn("Creating GPRS");
>  	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_IFX,
>  					"atmodem", data->dlcs[NETREG_DLC]);
>  	if (gprs =3D=3D NULL)
>  		return;
>  =

> -	if (data->mux_ldisc < 0) {
> -		gc =3D ofono_gprs_context_create(modem, 0,
> +	ofono_warn("Creating GPRS context");
> +	gc =3D ofono_gprs_context_create(modem, 0,
>  					"ifxmodem", data->dlcs[GPRS1_DLC]);
> -		if (gc)
> -			ofono_gprs_add_context(gprs, gc);
> +	if (gc) {
> +		ofono_warn("Adding GPRS context");
> +		ofono_gprs_add_context(gprs, gc);
> +	}
>  =

> -		gc =3D ofono_gprs_context_create(modem, 0,
> +	ofono_warn("Creaing 2nd GPRS context");
> +	gc =3D ofono_gprs_context_create(modem, 0,
>  					"ifxmodem", data->dlcs[GPRS2_DLC]);
> -		if (gc)
> -			ofono_gprs_add_context(gprs, gc);
> +	if (gc) {
> +		ofono_warn("Adding 2nd GPRS context");
> +		ofono_gprs_add_context(gprs, gc);
> +	}
>  =

> -		gc =3D ofono_gprs_context_create(modem, 0,
> +	ofono_warn("Creaing 3nd GPRS context");
> +	gc =3D ofono_gprs_context_create(modem, 0,
>  					"ifxmodem", data->dlcs[GPRS3_DLC]);
> -		if (gc)
> -			ofono_gprs_add_context(gprs, gc);
> +	if (gc) {
> +		ofono_warn("Adding 3nd GPRS context");
> +		ofono_gprs_add_context(gprs, gc);
>  	}
>  }
>  =


Regards

Marcel



--===============6181547340763630122==--

