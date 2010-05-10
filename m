Content-Type: multipart/mixed; boundary="===============4981188655284520101=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/6] Add mbmmodem STK driver.
Date: Mon, 10 May 2010 15:00:15 -0500
Message-ID: <201005101500.15529.denkenz@gmail.com>
In-Reply-To: <1273192047-11247-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4981188655284520101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Tested with a F3607gw data card.
> ---
>  Makefile.am                 |    3 +-
>  drivers/mbmmodem/mbmmodem.c |    2 +
>  drivers/mbmmodem/mbmmodem.h |    3 +
>  drivers/mbmmodem/stk.c      |  254
>  +++++++++++++++++++++++++++++++++++++++++++ plugins/mbm.c               =
| =

>   45 +++++++-
>  5 files changed, 302 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/mbmmodem/stk.c
> =

> diff --git a/plugins/mbm.c b/plugins/mbm.c
> index 53bd7ae..199aa17 100644
> --- a/plugins/mbm.c
> +++ b/plugins/mbm.c
> @@ -37,6 +37,7 @@
>  #include <ofono/devinfo.h>
>  #include <ofono/netreg.h>
>  #include <ofono/sim.h>
> +#include <ofono/stk.h>
>  #include <ofono/sms.h>
>  #include <ofono/cbs.h>
>  #include <ofono/ssn.h>
> @@ -54,11 +55,13 @@
>  #include <drivers/atmodem/vendor.h>
> =

>  static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
> +static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
>  static const char *none_prefix[] =3D { NULL };
> =

>  struct mbm_data {
>  	GAtChat *modem_port;
>  	GAtChat *data_port;
> +	gboolean have_sim;
>  };
> =

>  static int mbm_probe(struct ofono_modem *modem)
> @@ -96,18 +99,51 @@ static void mbm_debug(const char *str, void *user_dat=
a)
>  	ofono_info("%s %s", prefix, str);
>  }
> =

> -static void cfun_enable(gboolean ok, GAtResult *result, gpointer
>  user_data) +static void status_check(gboolean ok, GAtResult *result,
>  gpointer user_data) {
>  	struct ofono_modem *modem =3D user_data;
> +	struct mbm_data *data =3D ofono_modem_get_data(modem);
> +	GAtResultIter iter;
> +	gint sw[2];
> =

>  	DBG("");
> =

>  	if (!ok)
> -		ofono_modem_set_powered(modem, FALSE);
> +		goto poweron;
> +
> +	/* Modem fakes a 94 04 response from card (File Id not found /
> +	 * Pattern not found) when there's no card in the slot.
> +	 */
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CRSM:"))
> +		goto poweron;
> +
> +	g_at_result_iter_next_number(&iter, &sw[0]);
> +	g_at_result_iter_next_number(&iter, &sw[1]);
> =

> +	data->have_sim =3D sw[0] !=3D 0x94 || sw[1] !=3D 0x04;
> +
> +poweron:
>  	ofono_modem_set_powered(modem, TRUE);
>  }
> =


This has to do with SIM inserted / removed detection.  Can you send this as=
 a =

separate patch from the STK driver?

> +static void cfun_enable(gboolean ok, GAtResult *result, gpointer
>  user_data) +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct mbm_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("");
> +
> +	if (!ok) {
> +		ofono_modem_set_powered(modem, FALSE);
> +		return;
> +	}
> +
> +	g_at_chat_send(data->modem_port, "AT+CRSM=3D242", crsm_prefix,
> +			status_check, modem);
> +}
> +
>  static void cfun_query(gboolean ok, GAtResult *result, gpointer user_dat=
a)
>  {
>  	struct ofono_modem *modem =3D user_data;
> @@ -133,7 +169,7 @@ static void cfun_query(gboolean ok, GAtResult *result,
>  gpointer user_data) return;
>  	}
> =

> -	ofono_modem_set_powered(modem, TRUE);
> +	cfun_enable(TRUE, NULL, modem);
>  }
> =

>  static void emrdy_notifier(GAtResult *result, gpointer user_data)
> @@ -290,8 +326,9 @@ static void mbm_pre_sim(struct ofono_modem *modem)
>  	ofono_devinfo_create(modem, 0, "atmodem", data->modem_port);
>  	sim =3D ofono_sim_create(modem, 0, "atmodem", data->modem_port);
>  	ofono_voicecall_create(modem, 0, "atmodem", data->modem_port);
> +	ofono_stk_create(modem, 0, "mbmmodem", data->modem_port);

This part is actually related to STK support in this driver.  Please break =
it =

out into a separate patch as well.

> =

> -	if (sim)
> +	if (data->have_sim && sim)
>  		ofono_sim_inserted_notify(sim, TRUE);
>  }
> =


Regards,
-Denis

--===============4981188655284520101==--

