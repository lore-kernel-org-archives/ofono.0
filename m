Content-Type: multipart/mixed; boundary="===============3342084321400649553=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] quectel: EC21 needs aux channel to be the first mux
 channel
Date: Thu, 28 May 2020 16:25:26 +0000
Message-ID: <998d385e-341d-e8ff-178f-eaa8cea086d0@gmail.com>
In-Reply-To: <20200528093239.14347-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3342084321400649553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On 5/28/20 4:32 AM, poeschel(a)lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> =

> The Quectel EC21 does only work correctly, if the mux channel used for
> aux is the first mux channel. It does only put it's URC messages in the
> first mux channel, so this has to be the aux channel in our case.
> To be flexible on the mux order we introduce an array here, that
> contains the initialization data in it's needed order and is then simply
> applied by a for-loop. Initialization of this array is done after we
> queried the modem model.
> ---
>   plugins/quectel.c | 72 ++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 58 insertions(+), 14 deletions(-)
> =


So this looks mostly reasonable, but see below:

> diff --git a/plugins/quectel.c b/plugins/quectel.c
> index 043d39f9..1cad35d6 100644
> --- a/plugins/quectel.c
> +++ b/plugins/quectel.c
> @@ -78,6 +78,21 @@ static const uint8_t gsm0710_terminate[] =3D {
>   	0xf9, /* close flag */
>   };
>   =

> +enum mux_type {
> +	QUECTEL_MUX_TYPE_AUX =3D 0,
> +	QUECTEL_MUX_TYPE_MODEM,
> +	QUECTEL_MUX_TYPE_MAX,
> +};
> +
> +struct mux_initialization_data {
> +	enum mux_type mux_type;
> +	char *chat_debug;
> +	const char *n_gsm_key;
> +	const char *n_gsm_value;
> +};
> +
> +static struct mux_initialization_data mux_order[QUECTEL_MUX_TYPE_MAX];
> +

So the issue with this is that this driver now no-longer supports =

multiple modems of the same type active simultaneously (since all =

instances would be trying to write / read from this location).

A better approach would be to use two such variables, i.e. =

mux_order_ec21 and mux_order_default and then either store a pointer to =

the one to use inside quectel_data, or programmatically by looking up =

based on the quectel_data::model.

Alternatively, storing mux_order in quectel_data itself is also an option.

>   enum quectel_model {
>   	QUECTEL_UNKNOWN,
>   	QUECTEL_UC15,
> @@ -1014,6 +1037,17 @@ static void cgmm_cb(int ok, GAtResult *result, voi=
d *user_data)
>   		return;
>   	}
>   =

> +	mux_order[0] =3D (struct mux_initialization_data)
> +			{ QUECTEL_MUX_TYPE_MODEM,
> +			"Modem: ",
> +			"Modem",
> +			"/dev/gsmtty1"};
> +	mux_order[1] =3D (struct mux_initialization_data)
> +			{ QUECTEL_MUX_TYPE_AUX,
> +			"Aux: ",
> +			"Aux",
> +			"/dev/gsmtty2"};
> +

This would then move into the static initializer above...

>   	if (strcmp(model, "UC15") =3D=3D 0) {
>   		DBG("%p model UC15", modem);
>   		data->vendor =3D OFONO_VENDOR_QUECTEL;
> @@ -1030,6 +1064,16 @@ static void cgmm_cb(int ok, GAtResult *result, voi=
d *user_data)
>   		DBG("%p model EC21", modem);
>   		data->vendor =3D OFONO_VENDOR_QUECTEL;
>   		data->model =3D QUECTEL_EC21;
> +		mux_order[0] =3D (struct mux_initialization_data)
> +				{ QUECTEL_MUX_TYPE_AUX,
> +				"Aux: ",
> +				"Aux",
> +				"/dev/gsmtty1"};
> +		mux_order[1] =3D (struct mux_initialization_data)
> +				{ QUECTEL_MUX_TYPE_MODEM,
> +				"Modem: ",
> +				"Modem",
> +				"/dev/gsmtty2"};
>   	} else {
>   		ofono_warn("%p unknown model: '%s'", modem, model);
>   		data->vendor =3D OFONO_VENDOR_QUECTEL;
> =


Regards,
-Denis
--===============3342084321400649553==--

