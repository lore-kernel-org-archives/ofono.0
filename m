Content-Type: multipart/mixed; boundary="===============9043037524364927445=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/1] (RFC) Huawei: Modify ^SYSINFO logic
Date: Sun, 18 Jul 2010 15:59:06 -0700
Message-ID: <1279493946.4572.9.camel@localhost.localdomain>
In-Reply-To: <20100718220903.GA10397@h02.hostsharing.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9043037524364927445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

>  plugins/huawei.c |  114 ++++++++++++++++++++++++++++++++++++++++++++++++=
+----
>  1 files changed, 105 insertions(+), 9 deletions(-)
> =

> diff --git a/plugins/huawei.c b/plugins/huawei.c
> index cfc693d..c14b076 100644
> --- a/plugins/huawei.c
> +++ b/plugins/huawei.c
> @@ -57,12 +57,22 @@
>  =

>  static const char *none_prefix[] =3D { NULL };
>  static const char *sysinfo_prefix[] =3D { "^SYSINFO:", NULL };
> +static const char *cpin_prefix[] =3D { "CPIN:", NULL };
> +
> +enum my_sim_state {
> +	SIM_STATE_INVALID_OR_PIN_BLOCKED =3D 0,
> +	SIM_STATE_NORMAL_SIM_CARD =3D 1,
> +	SIM_STATE_SIM_NOT_VALID_IN_CS_MODE =3D 2,
> +	SIM_STATE_SIM_NOT_VALID_IN_PS_MODE =3D 3,
> +	SIM_STATE_SIM_NOT_VALID_IN_CS_OR_PS_MODE =3D 4,
> +	SIM_STATE_SIM_NOT_PRESENT =3D 255
> +};

Using my_ prefix is not really an option ;)

Anyhow, I think using #define here is as good. So just use define and
leave it as gint sim_state in the source.
 =

>  struct huawei_data {
>  	GAtChat *modem;
>  	GAtChat *pcui;
>  	struct ofono_sim *sim;
> -	gint sim_state;
> +	enum my_sim_state sim_state;
>  	struct ofono_gprs *gprs;
>  	struct ofono_gprs_context *gc;
>  };
> @@ -101,19 +111,105 @@ static void huawei_debug(const char *str, void *us=
er_data)
>  	ofono_info("%s%s", prefix, str);
>  }
>  =

> -static void notify_sim_state(struct ofono_modem *modem, gint sim_state)
> +static void notify_sim_state(struct ofono_modem *modem, enum my_sim_stat=
e sim_state)
>  {
>  	struct huawei_data *data =3D ofono_modem_get_data(modem);
>  =

> -	if (data->sim_state =3D=3D 0 && sim_state =3D=3D 1) {
> -		ofono_sim_inserted_notify(data->sim, TRUE);
> -		data->sim_state =3D sim_state;
> -	} else if (data->sim_state =3D=3D 1 && sim_state =3D=3D 0) {
> -		ofono_sim_inserted_notify(data->sim, FALSE);
> -		data->sim_state =3D sim_state;
> +	switch (sim_state) {
> +	case SIM_STATE_INVALID_OR_PIN_BLOCKED:
> +		if (data->sim_state !=3D sim_state) {
> +			/* TODO copy code from mbm.c function init_simpin_check and ff */
> +			ofono_sim_inserted_notify(data->sim, TRUE);
> +		}
> +
> +		break;

No empty line needed before break here.

> +	case SIM_STATE_NORMAL_SIM_CARD:
> +		if (data->sim_state !=3D sim_state) {
> +			ofono_sim_inserted_notify(data->sim, TRUE);
> +		}

For single line statement we don't do { }

> +
> +		break;
> +
> +	case SIM_STATE_SIM_NOT_VALID_IN_CS_MODE:
> +		if (data->sim_state !=3D sim_state) {
> +			ofono_sim_inserted_notify(data->sim, FALSE);
> +		}
> +
> +		break;
> +
> +	case SIM_STATE_SIM_NOT_VALID_IN_PS_MODE:
> +		if (data->sim_state !=3D sim_state) {
> +			ofono_sim_inserted_notify(data->sim, FALSE);
> +		}
> +
> +		break;
> +
> +	case SIM_STATE_SIM_NOT_VALID_IN_CS_OR_PS_MODE:
> +		if (data->sim_state !=3D sim_state) {
> +			ofono_sim_inserted_notify(data->sim, FALSE);
> +		}
> +
> +		break;
> +
> +	case SIM_STATE_SIM_NOT_PRESENT:
> +		if (data->sim_state !=3D sim_state) {
> +			ofono_sim_inserted_notify(data->sim, FALSE);
> +		}
> +
> +		break;

Just combining these into one might be better:

	case SIM_STATE_SIM_NOT_VALID_IN_CS_OR_PS_MODE:
	case SIM_STATE_SIM_NOT_PRESENT:

and so on.

> +
> +	default:
> +		break;
>  	}
> +	data->sim_state =3D sim_state;

And here I would prefer an extra empty line after the switch block.

>  }
>  =

> +/*
> + *
> + * SYSINFO =3D a,b,c,d,e,f
> + *
> + * a :
> + *   0 - no network access =

> + *   1 - limited access to the network =

> + *   2 - normal access to the network =

> + *   3 - limited access to networks in your area =

> + *   4 - Power saving mode =

> + * b:
> + *   0 - no access to the call date =

> + *   1 - only the circuit switching =

> + *   2 - only the packet switching =

> + *   3 - PS + SC =

> + *   4 - had not registered =

> + * c:
> + *   0 - registered in your home network =

> + *   1 - registered in roaming =

> + * d:
> + *   0 - no network access =

> + *   1 - APMs =

> + *   2 - CDMA =

> + *   3 - GSM / GPRS =

> + *   4 - HDR =

> + *   5 - WCDMA =

> + *   6 - GPS =

> + * e:
> + *   0 - invalid SIM card or PIN code blocked =

> + *   1 - normal SIM card =

> + *   2 - SIM card not valid in CS mode =

> + *   3 - SIM card not valid in PS mode =

> + *   4 - SIM card not valid in PS or CS mode =

> + * f:
> + *   0 - no network access =

> + *   1 - GSM mode =

> + *   2 - GPRS =

> + *   3 - Mode EDGE =

> + *   4 - WCDMA mode =

> + *   5 - HSDPA mode =

> + *   6 - HSUPA mode =

> + *   7 - mode HSPA =

> + *   8 - HSPA + mode
> + *
> + */

Do we wanna keep this inside the source or better create doc/huawei.txt
which explains all the Huawei specific vendor codes we know about. I
think the latter might be more useful.

>  static void sysinfo_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
>  {
>  	struct ofono_modem *modem =3D user_data;
> @@ -277,7 +373,7 @@ static int huawei_enable(struct ofono_modem *modem)
>  		return -EIO;
>  	}
>  =

> -	data->sim_state =3D 0;
> +	data->sim_state =3D SIM_STATE_SIM_NOT_PRESENT;
>  =

>  	g_at_chat_send(data->pcui, "ATE0", none_prefix, NULL, NULL, NULL);
>  =


Regards

Marcel



--===============9043037524364927445==--

