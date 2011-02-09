Content-Type: multipart/mixed; boundary="===============7318543188097136064=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: [PATCH 5/7] cdmamodem: Add Signal Strength Support
Date: Wed, 09 Feb 2011 14:58:30 -0800
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC702F8D73B@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <1297199100-2712-6-git-send-email-dara.spieker-doyle@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7318543188097136064==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dara,

> -----Original Message-----
> From: ofono-bounces(a)ofono.org =

> [mailto:ofono-bounces(a)ofono.org] On Behalf Of Dara Spieker-Doyle
> Sent: 08 February 2011 13:05
> To: ofono(a)ofono.org
> Subject: [PATCH 5/7] cdmamodem: Add Signal Strength Support
> =


> +static gboolean cdma_get_next_number(const char *line, gint =

> *number) {
> +	int pos;
> +	int end;
> +	int len;
> +	int value =3D 0;
> +
> +	len =3D strlen(line);
> +
> +	pos =3D 0;
> +	end =3D pos;
> +
> +	while (line[end] >=3D '0' && line[end] <=3D '9') {
> +		value =3D value * 10 + (int)(line[end] - '0');
> +		end +=3D 1;
> +	}
> +
> +	if (pos =3D=3D end)
> +		return FALSE;
> +
> +	pos =3D skip_to_next_field(line, end, len);
> +
> +	if (number)
> +		*number =3D value;
> +
> +	return TRUE;
> +}
> +

This is a duplicate of g_at_result_iter_next_number().
Why cant use this function instead of cdma_get_next_number() ?

> +static void cdma_csq_cb(gboolean ok, GAtResult *result, gpointer =

> +user_data) {
> +	struct cb_data *cbd =3D user_data;
> +	ofono_cdma_netreg_strength_cb_t cb =3D cbd->cb;
> +	const char *prefix =3D cbd->user;
> +	struct ofono_error error;
> +	const char *attr;
> +	int strength =3D -1;
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +
> +	if (!ok) {
> +		cb(&error, -1, cbd->data);
> +		return;
> +	}
> +
> +	if (at_util_parse_attr(result, prefix, &attr) =3D=3D FALSE) {
> +		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
> +		return;
> +	}
> +
> +	cdma_get_next_number(attr, &strength);
> +
> +	DBG("csq_cb: %d", strength);
> +
> +	cb(&error, at_util_convert_signal_strength(strength), =

> cbd->data); }

Refer csq_cb() implementation in /drivers/atmodem/network-registration.c

BR,
Rajesh

--===============7318543188097136064==--

