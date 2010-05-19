Content-Type: multipart/mixed; boundary="===============5500799561584588029=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 2/2] huawei: add gprs context
Date: Wed, 19 May 2010 08:44:38 -0500
Message-ID: <201005190844.38234.denkenz@gmail.com>
In-Reply-To: <20100519140659.3163.1433.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5500799561584588029==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> +	ret =3D at_util_parse_reg_unsolicited(result, "+CGREG:", &status,
> +					    NULL, NULL, NULL,
> +					    OFONO_VENDOR_HUAWEI);

No mixing of tabs & spaces for indentation

> +
> +	if (ret =3D=3D FALSE)
> +		return;
> +
> +	ofono_gprs_status_notify(gprs, status);
> +}
> +
> +static inline void report_signal_strength(struct ofono_netreg *netreg,
> +					  int strength)

And here

> +{
> +	DBG("%d", strength);
> +
> +	if (strength =3D=3D 99)
> +		strength =3D -1;
> +	else
> +		strength =3D (strength * 100) / 31;
> +
> +	ofono_netreg_strength_notify(netreg, strength);
> +}

You might really want to make this into an atutil function instead of copy-
pasting it around.

> +
> +static void huawei_rssi_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_netreg *netreg =3D user_data;
> +	GAtResultIter iter;
> +	int strength;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "^RSSI:"))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &strength))
> +		return;
> +
> +	report_signal_strength(netreg, strength);
> +}
> +
>  static void huawei_post_sim(struct ofono_modem *modem)
>  {
>  	struct huawei_data *data =3D ofono_modem_get_data(modem);
> +	struct ofono_gprs_context *gc;
> +	struct ofono_netreg *netreg;
> +	struct ofono_gprs *gprs;
> =

>  	DBG("%p", modem);
> =

> -	ofono_netreg_create(modem, OFONO_VENDOR_HUAWEI, "atmodem", data->chat);
> +	netreg =3D ofono_netreg_create(modem, OFONO_VENDOR_HUAWEI, "atmodem",
> +				     data->chat);

Again with mixed indentation

>  	ofono_sms_create(modem, OFONO_VENDOR_QUALCOMM_MSM, "atmodem",
>  data->chat); +
> +	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_HUAWEI, "atmodem",
> +				 data->chat);

And here

> +	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->chat);
> +
> +	if (gprs && gc) {
> +		ofono_gprs_add_context(gprs, gc);
> +
> +		/* huawei has a separate channel for CGREG notifications */
> +		g_at_chat_register(data->event, "+CGREG:",
> +				   huawei_cgreg_notify, FALSE, gprs, NULL);

And here

> +
> +		/* huawei uses non-standard "^RSSI:18" strings */
> +		g_at_chat_register(data->event, "^RSSI:",
> +				   huawei_rssi_notify, FALSE, netreg, NULL);

And here

> +	}
>  }
> =

>  static struct ofono_modem_driver huawei_driver =3D {

Regards,
-Denis

--===============5500799561584588029==--

