Content-Type: multipart/mixed; boundary="===============1007718592669044690=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC_v1 2/2] sierra: Add SIM state polling
Date: Tue, 29 Nov 2011 11:36:51 -0600
Message-ID: <4ED51833.7050208@gmail.com>
In-Reply-To: <1322758133-19701-3-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1007718592669044690==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 12/01/2011 10:48 AM, Guillaume Zajac wrote:
> It has been reported than for some Sierra modem, the SIM
> initialization process leads to +CME ERROR: 10 sim not
> present. The issue might come from SIM is not ready.

Do you have an AT log of these reports?

> ---
>  plugins/sierra.c |   26 +++++++++++++++++++++++++-
>  1 files changed, 25 insertions(+), 1 deletions(-)
> =

> diff --git a/plugins/sierra.c b/plugins/sierra.c
> index b33382d..45e75c1 100644
> --- a/plugins/sierra.c
> +++ b/plugins/sierra.c
> @@ -47,6 +47,8 @@ static const char *none_prefix[] =3D { NULL };
>  =

>  struct sierra_data {
>  	GAtChat *chat;
> +	gboolean have_sim;
> +	struct at_util_sim_state_query *sim_state_query;
>  };
>  =

>  static void sierra_debug(const char *str, void *user_data)
> @@ -82,6 +84,9 @@ static void sierra_remove(struct ofono_modem *modem)
>  	/* Cleanup after hot-unplug */
>  	g_at_chat_unref(data->chat);
>  =

> +	/* Cleanup potential SIM state polling */
> +	at_util_sim_state_query_free(data->sim_state_query);
> +
>  	g_free(data);
>  }
>  =

> @@ -118,6 +123,21 @@ static GAtChat *open_device(struct ofono_modem *mode=
m,
>  	return chat;
>  }
>  =

> +static void sim_state_cb(gboolean present, gpointer user_data)
> +{
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
> +	g_at_chat_send(data->chat, "AT&C0", NULL, NULL, NULL, NULL);

Fair enough, however:

- You are not using data->have_sim anywhere, presumably you want to use
it in sierra_pre_sim to notify the sim inserted status...
- The sierra driver does not instantiate any gprs_context drivers, so it
isn't even capable of GPRS in its current state.  Sending the &C0
command is only needed if you are planning to use PPP and probably
belongs in a separate patch.

> +}
> +
>  static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_da=
ta)
>  {
>  	struct ofono_modem *modem =3D user_data;
> @@ -128,9 +148,13 @@ static void cfun_enable(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
>  	if (!ok) {
>  		g_at_chat_unref(data->chat);
>  		data->chat =3D NULL;
> +
> +		ofono_modem_set_powered(modem, FALSE);
> +		return;
>  	}
>  =

> -	ofono_modem_set_powered(modem, ok);
> +	data->sim_state_query =3D at_util_sim_state_query_new(data->chat,
> +						2, 20, sim_state_cb, modem);
>  }
>  =

>  static int sierra_enable(struct ofono_modem *modem)

Regards,
-Denis

--===============1007718592669044690==--

