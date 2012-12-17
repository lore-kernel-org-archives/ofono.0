Content-Type: multipart/mixed; boundary="===============0073724665198207922=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] telit: signal sim inserted when sim ready.
Date: Mon, 17 Dec 2012 09:50:00 -0600
Message-ID: <50CF3F28.4080301@gmail.com>
In-Reply-To: <1355494782-31572-2-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0073724665198207922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

On 12/14/2012 08:19 AM, christopher.vogl(a)hale.at wrote:
> From: Christopher Vogl<christopher.vogl@hale.at>
>
> We need to wait for #QSS: 3 until SIM inserted may be signaled or
> subsequent commands like +CMER will report SIM BUSY which in turn
> leads to a removal of the network registration atom. This has been
> observed with Telit HE910.
>
> In case of #QSS: 1 we need to check if the SIM is locked.
> If the SIM is unlocked we just wait for #QSS: 3,
> if the SIM is not unlocked we signal SIM inserted to be able to
> enter a PIN code.
> ---
>   plugins/telit.c |   43 +++++++++++++++++++++++++++++++++++++++++--
>   1 files changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/plugins/telit.c b/plugins/telit.c
> index fe2ccd6..cd67ef4 100644
> --- a/plugins/telit.c
> +++ b/plugins/telit.c
> @@ -61,6 +61,7 @@
>   #include "bluetooth.h"
>
>   static const char *none_prefix[] =3D { NULL };
> +static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
>   static const char *rsen_prefix[]=3D { "#RSEN:", NULL };
>
>   struct telit_data {
> @@ -211,6 +212,33 @@ static GAtChat *open_device(struct ofono_modem *mode=
m,
>   	return chat;
>   }
>
> +static void at_cpin_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct telit_data *data =3D ofono_modem_get_data(modem);
> +	GAtResultIter iter;
> +	const char *pin_required;
> +
> +	if (!ok)
> +		return;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CPIN:"))
> +		return;
> +
> +	g_at_result_iter_next_unquoted_string(&iter,&pin_required);
> +
> +	// No PIN required, we can wait for #QSS: 3.

Nitpicking, but we don't use // style comments.

> +	if (strcmp(pin_required, "READY")=3D=3D0)
> +		return;
> +
> +	if (data->have_sim =3D=3D FALSE) {
> +		ofono_sim_inserted_notify(data->sim, TRUE);
> +		data->have_sim =3D TRUE;
> +	}
> +}
> +
>   static void switch_sim_state_status(struct ofono_modem *modem, int stat=
us)
>   {
>   	struct telit_data *data =3D ofono_modem_get_data(modem);
> @@ -226,13 +254,24 @@ static void switch_sim_state_status(struct ofono_mo=
dem *modem, int status)
>   		}
>   		break;
>   	case 1:	/* SIM inserted */
> +		/*
> +		 * We want to call ofono_sim_inserted_notify() only if #QSS: 3
> +		 * (SIM READY), as otherwise subsequent commands like +CMER may
> +		 * report SIM BUSY.
> +		 * In case a PIN is required, we have to signal
> +		 * sim inserted on #QSS: 1 and wait in the SIM atom for #QSS: 3
> +		 * after entering the PIN.
> +		 */
> +		g_at_chat_send(data->chat, "AT+CPIN?", cpin_prefix,
> +				at_cpin_cb, modem, NULL);
> +		break;
>   	case 2:	/* SIM inserted and PIN unlocked */
> +		break;
> +	case 3:	/* SIM inserted and READY (SMS&  Phonebook access possible) */
>   		if (data->have_sim =3D=3D FALSE) {
>   			ofono_sim_inserted_notify(data->sim, TRUE);
>   			data->have_sim =3D TRUE;
>   		}
> -		break;
> -	case 3:	/* SIM inserted, SMS and phonebook ready */
>   		if (data->sms_phonebook_added =3D=3D FALSE) {
>   			ofono_phonebook_create(modem, 0, "atmodem", data->chat);
>   			ofono_sms_create(modem, 0, "atmodem", data->chat);

Since we are waiting for QSS:3, should phonebook and sms atom creation =

be moved out of here and simply put into post_sim()?

Regards,
-Denis

--===============0073724665198207922==--

