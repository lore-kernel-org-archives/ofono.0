Content-Type: multipart/mixed; boundary="===============4218528147888761636=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [RFC_v0] sierra: Add SIM state polling
Date: Thu, 01 Dec 2011 16:02:10 +0000
Message-ID: <ED4DEEB78293B34A9D0EAC02A474A46E07E4DD@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <1322753831-11643-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4218528147888761636==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

>  static void sierra_debug(const char *str, void *user_data) @@ -79,6 +81,=
12
> @@ static void sierra_remove(struct ofono_modem *modem)
> =

>  	ofono_modem_set_data(modem, NULL);
> =

> +	/* Cleanup potential SIM state polling */
> +	at_util_sim_state_query_free(data->sim_state_query);
> +
> +	/* Cleanup after hot-unplug */
> +	g_at_chat_unref(data->chat);

Seems that you found an issue not related to your change. Maybe a dedicated=
 submit would be nice.

> +
>  	g_free(data);
>  }
> =

> @@ -115,6 +123,21 @@ static GAtChat *open_device(struct ofono_modem
> *modem,
>  	return chat;
>  }
> =

> +static void sim_state_cb(gboolean present, gpointer user_data) {
> +	struct ofono_modem *modem =3D user_data;
> +	struct sierra_data *data =3D ofono_modem_get_data(modem);
> +
> +	at_util_sim_state_query_free(data->sim_state_query);
> +	data->sim_state_query =3D NULL;
> +
> +	data->have_sim =3D present;
> +
> +	ofono_modem_set_powered(modem, TRUE);
> +
> +	g_at_chat_send(data->chat, "AT&C0", NULL, NULL, NULL, NULL); }
> +
>  static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_da=
ta)  {
>  	struct ofono_modem *modem =3D user_data; @@ -127,7 +150,8 @@
> static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_dat=
a)
>  		data->chat =3D NULL;
>  	}
> =

> -	ofono_modem_set_powered(modem, ok);
> +	data->sim_state_query =3D at_util_sim_state_query_new(data->chat,
> +						2, 20, sim_state_cb, modem);

So in case of cfun_enable failure, you will query for SIM state?

>  }
> =

>  static int sierra_enable(struct ofono_modem *modem)
> --

Regards,

Bertrand
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============4218528147888761636==--

