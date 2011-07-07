Content-Type: multipart/mixed; boundary="===============8899036769431392255=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] phonesim: add support of +CBC
Date: Thu, 07 Jul 2011 01:14:27 -0500
Message-ID: <4E154EC3.4060300@gmail.com>
In-Reply-To: <1310048886-6029-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8899036769431392255==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 07/07/2011 09:28 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> PTS test TP/PSI/BV-03-I [Transfer Battery Level Indication] needs to
> change battery level and check that the battery level indication is
> received at the HF.
> So add support for +CBC in phonesim plugin, and force update of the
> battery indicator on HFP AG Emulator registration.
> ---
>  plugins/phonesim.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 59 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/phonesim.c b/plugins/phonesim.c
> index f49c13a..eb04dd1 100644
> --- a/plugins/phonesim.c
> +++ b/plugins/phonesim.c
> @@ -64,6 +64,8 @@
>  #include <drivers/atmodem/sim-poll.h>
>  #include <drivers/atmodem/atutil.h>
>  =

> +#include "../src/ofono.h"
> +

using #include "ofono.h" should be sufficient.

>  static const char *none_prefix[] =3D { NULL };
>  static const char *ptty_prefix[] =3D { "+PTTY:", NULL };
>  static int next_iface =3D 0;
> @@ -73,6 +75,7 @@ struct phonesim_data {
>  	GAtChat *chat;
>  	gboolean calypso;
>  	gboolean use_mux;
> +	unsigned int hfp_watch;
>  };
>  =

>  struct gprs_context_data {
> @@ -419,6 +422,40 @@ static void crst_notify(GAtResult *result, gpointer =
user_data)
>  	g_idle_add(phonesim_reset, user_data);
>  }
>  =

> +static void emulator_battery_cb(struct ofono_atom *atom, void *data)
> +{
> +	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
> +	int val =3D 0;
> +
> +	if (GPOINTER_TO_INT(data) > 0)
> +		val =3D (GPOINTER_TO_INT(data) - 1) / 20 + 1;
> +
> +	ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_BATTERY, val);
> +}
> +
> +static void cbc_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	GAtResultIter iter;
> +	int status;
> +	int level;
> +
> +	g_at_result_iter_init(&iter, result);
> +	if (!g_at_result_iter_next(&iter, "+CBC:"))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &status))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &level))
> +		return;
> +
> +	__ofono_modem_foreach_registered_atom(modem,
> +						OFONO_ATOM_TYPE_EMULATOR_HFP,
> +						emulator_battery_cb,
> +						GUINT_TO_POINTER(level));
> +}
> +
>  static void phonesim_disconnected(gpointer user_data)
>  {
>  	struct ofono_modem *modem =3D user_data;
> @@ -481,6 +518,19 @@ static void mux_setup(GAtMux *mux, gpointer user_dat=
a)
>  					cfun_set_on_cb, modem, NULL);
>  }
>  =

> +static void emulator_hfp_watch(struct ofono_atom *atom,
> +				enum ofono_atom_watch_condition cond,
> +				void *user_data)
> +{
> +	struct phonesim_data *data =3D user_data;
> +
> +	if (cond !=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED)
> +		return;
> +
> +	/* Force battery charge update on emulator registration */
> +	g_at_chat_send(data->chat, "AT+CBC", none_prefix, NULL, NULL, NULL);
> +}
> +

While your implementation is fine for phonesim, I'd rather err on the
safe side and make this a little bit better.  I'm mostly concerned about
this code being copied for 'production' use in the future.

Instead, can we query CBC status when phonesim finishes powering up,
store the value and notify the stored value when the new atom is registered?

>  static int phonesim_enable(struct ofono_modem *modem)
>  {
>  	struct phonesim_data *data =3D ofono_modem_get_data(modem);
> @@ -574,6 +624,13 @@ static int phonesim_enable(struct ofono_modem *modem)
>  	g_at_chat_register(data->chat, "+CRST:",
>  				crst_notify, FALSE, modem, NULL);
>  =

> +	g_at_chat_register(data->chat, "+CBC:",
> +				cbc_notify, FALSE, modem, NULL);
> +
> +	data->hfp_watch =3D __ofono_modem_add_atom_watch(modem,
> +					OFONO_ATOM_TYPE_EMULATOR_HFP,
> +					emulator_hfp_watch, data, NULL);
> +
>  	return 0;
>  }
>  =

> @@ -612,6 +669,8 @@ static int phonesim_disable(struct ofono_modem *modem)
>  =

>  	DBG("%p", modem);
>  =

> +	__ofono_modem_remove_atom_watch(modem, data->hfp_watch);
> +
>  	g_at_chat_unref(data->chat);
>  	data->chat =3D NULL;
>  =


Regards,
-Denis

--===============8899036769431392255==--

