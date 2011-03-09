Content-Type: multipart/mixed; boundary="===============0262978053188177622=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/3] ifx: integration of kernel mux (n_gsm) and its line
 discipline
Date: Wed, 09 Mar 2011 13:46:26 -0800
Message-ID: <1299707186.2497.11.camel@aeonflux>
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D4018813A9C5DB9@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0262978053188177622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> diff --git a/plugins/ifx.c b/plugins/ifx.c
> index 527a8c4..9c2a5c1 100644
> --- a/plugins/ifx.c
> +++ b/plugins/ifx.c
> @@ -26,8 +26,12 @@
>  #include <stdio.h>
>  #include <errno.h>
>  #include <stdlib.h>
> +#include <string.h>
>  #include <sys/stat.h>
>  #include <sys/ioctl.h>
> +#include <linux/types.h>
> +#include <linux/gsmmux.h>
> +#include <unistd.h>

please move unistd.h up since as a rule of thumb, the system headers
should be included before the unix ones.

Also gsmmux.h is not acceptable. We have to carry a local copy for a
while since otherwise compilation would fail on older kernels.

Why do you need linux/types.h?
 =

>  #include <glib.h>
>  #include <gatchat.h>
> @@ -75,9 +79,9 @@
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

I am not a big fan of these hardcoded names. I was not a big fan for the
original MUX code and that has not changed.

So what happens if you have to multiplexer running at the same time?
 =

>  static const char *none_prefix[] =3D { NULL };
>  static const char *xdrv_prefix[] =3D { "+XDRV:", NULL };
> @@ -392,6 +396,7 @@ static gboolean dlc_ready_check(gpointer user_data)
>  	struct ifx_data *data =3D ofono_modem_get_data(modem);
>  	struct stat st;
>  	int i;
> +	GHashTable *options;
>  =

>  	DBG("");
>  =

> @@ -405,8 +410,14 @@ static gboolean dlc_ready_check(gpointer user_data)
>  		return TRUE;
>  	}
>  =

> +	options =3D g_hash_table_new(g_str_hash, g_str_equal);
> +	if (options =3D=3D NULL)
> +		goto error;
> +
> +	g_hash_table_insert(options, "Local", "on");
> +

Why is this needed?

>  	for (i =3D 0; i < NUM_DLC; i++) {
> -		GIOChannel *channel =3D g_at_tty_open(dlc_nodes[i], NULL);
> +		GIOChannel *channel =3D g_at_tty_open(dlc_nodes[i], options);
>  =

>  		data->dlcs[i] =3D create_chat(channel, modem, dlc_prefixes[i]);
>  		if (data->dlcs[i] =3D=3D NULL) {
> @@ -415,6 +426,8 @@ static gboolean dlc_ready_check(gpointer user_data)
>  		}
>  	}
>  =

> +	g_hash_table_destroy(options);
> +
>  	data->dlc_poll_source =3D 0;
>  =

>  	/* iterate through mainloop */
> @@ -455,7 +468,7 @@ static void setup_internal_mux(struct ofono_modem *mo=
dem)
>  			ofono_error("Failed to create channel");
>  			goto error;
>  		}
> -        }
> +	}
>  =

>  	/* wait for DLC creation to settle */
>  	data->dlc_init_source =3D g_timeout_add(10, dlc_setup, modem);
> @@ -471,7 +484,9 @@ static void mux_setup_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
>  {
>  	struct ofono_modem *modem =3D user_data;
>  	struct ifx_data *data =3D ofono_modem_get_data(modem);
> -	int fd;
> +	int err;
> +	struct gsm_config cfg;
> +	int fd =3D -1;
>  =

>  	DBG("");
>  =

> @@ -504,6 +519,37 @@ static void mux_setup_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
>  		goto error;
>  	}
>  =

> +	memset(&cfg, 0, sizeof(struct gsm_config));
> +
> +	err =3D ioctl(fd, GSMIOC_GETCONF, &cfg);
> +	if (err < 0) {
> +		ofono_error("Failed to get multiplexer configuration: %d", err);
> +		goto error;
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

This pretty heavy debug information and not ofono_info material.

> +	cfg.encapsulation =3D 0; /* encoding - set to basic */
> +	cfg.initiator =3D 1; /* we are starting side */
> +	cfg.mru =3D 1500;
> +	cfg.mtu =3D 1500;
> +
> +	err =3D ioctl(fd, GSMIOC_SETCONF, &cfg);
> +	if (err < 0) {
> +		ofono_error("Failed to configure n_gsm multiplexer: %d", err);
> +		goto error;
> +	}
> +
>  	data->dlc_poll_count =3D 0;
>  	data->dlc_poll_source =3D g_timeout_add_seconds(1, dlc_ready_check,
>  								modem);
> @@ -511,6 +557,9 @@ static void mux_setup_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
>  	return;
>  =

>  error:
> +	if (ioctl(fd, TIOCSETD, &data->saved_ldisc) < 0)
> +		ofono_warn("Failed to restore line discipline");
> +

This is not right. Even if you fail GSMIOC_GETCONF you try to restore
the line discipline. That makes no sense.

>  	data->saved_ldisc =3D -1;
>  =

>  	g_io_channel_unref(data->device);
> @@ -593,9 +642,9 @@ static int ifx_enable(struct ofono_modem *modem)
>  					NULL, NULL, NULL);
>  =

>  	/* Enable multiplexer */
> -	data->frame_size =3D 1509;
> +	data->frame_size =3D 1500;
>  =

> -	g_at_chat_send(chat, "AT+CMUX=3D0,0,,1509,10,3,30,,", NULL,
> +	g_at_chat_send(chat, "AT+CMUX=3D0,0,,1500,10,3,30,,", NULL,
>  					mux_setup_cb, modem, NULL);

So why did the frame_size changed here? Does the modem firmware changed
or is this actual a bug in oFono already today?
 =

>  	data->mux_init_timeout =3D g_timeout_add_seconds(5, mux_timeout_cb,
> @@ -732,22 +781,20 @@ static void ifx_post_online(struct ofono_modem *mod=
em)
>  	if (gprs =3D=3D NULL)
>  		return;
>  =

> -	if (data->mux_ldisc < 0) {
> -		gc =3D ofono_gprs_context_create(modem, 0,
> +	gc =3D ofono_gprs_context_create(modem, 0,
>  					"ifxmodem", data->dlcs[GPRS1_DLC]);
> -		if (gc)
> -			ofono_gprs_add_context(gprs, gc);
> +	if (gc)
> +		ofono_gprs_add_context(gprs, gc);
>  =

> -		gc =3D ofono_gprs_context_create(modem, 0,
> +	gc =3D ofono_gprs_context_create(modem, 0,
>  					"ifxmodem", data->dlcs[GPRS2_DLC]);
> -		if (gc)
> +	if (gc)
>  			ofono_gprs_add_context(gprs, gc);
>  =

> -		gc =3D ofono_gprs_context_create(modem, 0,
> +	gc =3D ofono_gprs_context_create(modem, 0,
>  					"ifxmodem", data->dlcs[GPRS3_DLC]);
> -		if (gc)
> -			ofono_gprs_add_context(gprs, gc);
> -	}
> +	if (gc)
> +		ofono_gprs_add_context(gprs, gc);
>  }

We can not just do this unconditionally. Then using the internal MUX
will not work anymore.

Regards

Marcel



--===============0262978053188177622==--

