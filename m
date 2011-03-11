Content-Type: multipart/mixed; boundary="===============5552475820820160966=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH 1/3] ifx: integration of kernel mux (n_gsm) and its line
 discipline
Date: Fri, 11 Mar 2011 14:04:43 -0800
Message-ID: <1299881083.2055.8.camel@aeonflux>
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D4018813A9C5FE3@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5552475820820160966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

> > > diff --git a/plugins/ifx.c b/plugins/ifx.c
> > > index 527a8c4..9c2a5c1 100644
> > > --- a/plugins/ifx.c
> > > +++ b/plugins/ifx.c
> > > @@ -26,8 +26,12 @@
> > >  #include <stdio.h>
> > >  #include <errno.h>
> > >  #include <stdlib.h>
> > > +#include <string.h>
> > >  #include <sys/stat.h>
> > >  #include <sys/ioctl.h>
> > > +#include <linux/types.h>
> > > +#include <linux/gsmmux.h>
> > > +#include <unistd.h>
> > =

> > please move unistd.h up since as a rule of thumb, the system headers
> > should be included before the unix ones.
> > =

> > Also gsmmux.h is not acceptable. We have to carry a local copy for a
> > while since otherwise compilation would fail on older kernels.
> =

> Ok. It's what Robertino did in his first patch for the kernel mux integra=
tion.
> I've changed that thinking it was better to used the gsmmux.h of the kern=
el tree. I'll redo that.
> =

> > =

> > Why do you need linux/types.h?
> > =

> =

> Do not really remember :(
> I think this is for the gsmmux.h file but if it's the case it to this fil=
e to include this one. I'll review that.

in theory if gsmmux.h requires linux/types.h, then it should include it.

> > >  #include <glib.h>
> > >  #include <gatchat.h>
> > > @@ -75,9 +79,9 @@
> > >  static char *dlc_prefixes[NUM_DLC] =3D { "Voice: ", "Net: ", "GPRS1:
> > ",
> > >  					"GPRS2: ", "GPRS3: ", "Aux: " };
> > >
> > > -static const char *dlc_nodes[NUM_DLC] =3D { "/dev/ttyGSM1",
> > "/dev/ttyGSM2",
> > > -					"/dev/ttyGSM3", "/dev/ttyGSM4",
> > > -					"/dev/ttyGSM5", "/dev/ttyGSM6" };
> > > +static const char *dlc_nodes[NUM_DLC] =3D { "/dev/gsmtty1",
> > "/dev/gsmtty2",
> > > +					"/dev/gsmtty3", "/dev/gsmtty4",
> > > +					"/dev/gsmtty5", "/dev/gsmtty6" };
> > =

> > I am not a big fan of these hardcoded names. I was not a big fan for
> > the original MUX code and that has not changed.
> > =

> > So what happens if you have to multiplexer running at the same time?
> > =

> =

> No idea. I'll try to analyze this point.

This needs a bit more thinking here. Also in reality the names are not
guaranteed. It might have happened that udev renamed them.

The current code has exactly the same problem. I know that is an issue,
it just happens to be that the current code is not used anyway.

> > >  static const char *none_prefix[] =3D { NULL };
> > >  static const char *xdrv_prefix[] =3D { "+XDRV:", NULL };
> > > @@ -392,6 +396,7 @@ static gboolean dlc_ready_check(gpointer
> > user_data)
> > >  	struct ifx_data *data =3D ofono_modem_get_data(modem);
> > >  	struct stat st;
> > >  	int i;
> > > +	GHashTable *options;
> > >
> > >  	DBG("");
> > >
> > > @@ -405,8 +410,14 @@ static gboolean dlc_ready_check(gpointer
> > user_data)
> > >  		return TRUE;
> > >  	}
> > >
> > > +	options =3D g_hash_table_new(g_str_hash, g_str_equal);
> > > +	if (options =3D=3D NULL)
> > > +		goto error;
> > > +
> > > +	g_hash_table_insert(options, "Local", "on");
> > > +
> > =

> > Why is this needed?
> =

> This is needed for PDP context deactivation.
> If you don't set the local to on a tty close occurs when you do the PDP c=
ontext deactivation.

That sounds like a kernel bug to me as well. Why is the kernel closing
the TTY if you switch back to AT command mode. We are still holding an
open file descriptor to it.

> > > +	ofono_info("Got default configuration...");
> > > +	ofono_info("adaption =3D %d", cfg.adaption);
> > > +	ofono_info("encapsulation =3D %d", cfg.encapsulation);
> > > +	ofono_info("initiator =3D %d", cfg.initiator);
> > > +	ofono_info("t1 =3D %d", cfg.t1);
> > > +	ofono_info("t2 =3D %d", cfg.t2);
> > > +	ofono_info("t3 =3D %d", cfg.t3);
> > > +	ofono_info("n2 =3D %d", cfg.n2);
> > > +	ofono_info("mru =3D %d", cfg.mru);
> > > +	ofono_info("mtu =3D %d", cfg.mtu);
> > > +	ofono_info("k =3D %d", cfg.k);
> > =

> > This pretty heavy debug information and not ofono_info material.
> > =

> =

> Agree. I kept them from the original patch of Robertino but I'll change t=
hat.
> =

> > > +	cfg.encapsulation =3D 0; /* encoding - set to basic */
> > > +	cfg.initiator =3D 1; /* we are starting side */
> > > +	cfg.mru =3D 1500;
> > > +	cfg.mtu =3D 1500;
> > > +
> > > +	err =3D ioctl(fd, GSMIOC_SETCONF, &cfg);
> > > +	if (err < 0) {
> > > +		ofono_error("Failed to configure n_gsm multiplexer: %d",
> > err);
> > > +		goto error;
> > > +	}
> > > +
> > >  	data->dlc_poll_count =3D 0;
> > >  	data->dlc_poll_source =3D g_timeout_add_seconds(1, dlc_ready_check,
> > >  								modem);
> > > @@ -511,6 +557,9 @@ static void mux_setup_cb(gboolean ok, GAtResult
> > *result, gpointer user_data)
> > >  	return;
> > >
> > >  error:
> > > +	if (ioctl(fd, TIOCSETD, &data->saved_ldisc) < 0)
> > > +		ofono_warn("Failed to restore line discipline");
> > > +
> > =

> > This is not right. Even if you fail GSMIOC_GETCONF you try to restore
> > the line discipline. That makes no sense.
> > =

> =

> Agree that is not right but not for the GSMIOC_GETCONF failing.
> It's not right because I try to restore the line discipline even if the i=
octl who gives it failed. I'll review that.
> =

> > >  	data->saved_ldisc =3D -1;
> > >
> > >  	g_io_channel_unref(data->device);
> > > @@ -593,9 +642,9 @@ static int ifx_enable(struct ofono_modem *modem)
> > >  					NULL, NULL, NULL);
> > >
> > >  	/* Enable multiplexer */
> > > -	data->frame_size =3D 1509;
> > > +	data->frame_size =3D 1500;
> > >
> > > -	g_at_chat_send(chat, "AT+CMUX=3D0,0,,1509,10,3,30,,", NULL,
> > > +	g_at_chat_send(chat, "AT+CMUX=3D0,0,,1500,10,3,30,,", NULL,
> > >  					mux_setup_cb, modem, NULL);
> > =

> > So why did the frame_size changed here? Does the modem firmware changed
> > or is this actual a bug in oFono already today?
> > =

> =

> It's a bug in oFono.

Then lets get that fixed separately with a proper commit message
explaining why using frame size of 1500 is correct.

We need a proper track record of changes and don't intermix them.

> > >  	data->mux_init_timeout =3D g_timeout_add_seconds(5, mux_timeout_cb,
> > > @@ -732,22 +781,20 @@ static void ifx_post_online(struct ofono_modem
> > *modem)
> > >  	if (gprs =3D=3D NULL)
> > >  		return;
> > >
> > > -	if (data->mux_ldisc < 0) {
> > > -		gc =3D ofono_gprs_context_create(modem, 0,
> > > +	gc =3D ofono_gprs_context_create(modem, 0,
> > >  					"ifxmodem", data->dlcs[GPRS1_DLC]);
> > > -		if (gc)
> > > -			ofono_gprs_add_context(gprs, gc);
> > > +	if (gc)
> > > +		ofono_gprs_add_context(gprs, gc);
> > >
> > > -		gc =3D ofono_gprs_context_create(modem, 0,
> > > +	gc =3D ofono_gprs_context_create(modem, 0,
> > >  					"ifxmodem", data->dlcs[GPRS2_DLC]);
> > > -		if (gc)
> > > +	if (gc)
> > >  			ofono_gprs_add_context(gprs, gc);
> > >
> > > -		gc =3D ofono_gprs_context_create(modem, 0,
> > > +	gc =3D ofono_gprs_context_create(modem, 0,
> > >  					"ifxmodem", data->dlcs[GPRS3_DLC]);
> > > -		if (gc)
> > > -			ofono_gprs_add_context(gprs, gc);
> > > -	}
> > > +	if (gc)
> > > +		ofono_gprs_add_context(gprs, gc);
> > >  }
> > =

> > We can not just do this unconditionally. Then using the internal MUX
> > will not work anymore.
> =

> Don't understand your point. This part of code is done in both cases: usi=
ng internal MUX or not.
> The check (data->mux_ldisc < 0) is TRUE when you are using the internal M=
UX.

I see that you do an extra set of checks in the gprs-context.c. I need
to think about that a little bit.

Regards

Marcel



--===============5552475820820160966==--

