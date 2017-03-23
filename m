Content-Type: multipart/mixed; boundary="===============1050316435998209349=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 4/5] gobi: Do not use low-power modes for some modems
Date: Thu, 23 Mar 2017 10:45:46 -0500
Message-ID: <429668ec-2e0e-e450-55f3-a383090f2ebc@gmail.com>
In-Reply-To: <1490206493-17454-5-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1050316435998209349==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On 03/22/2017 01:14 PM, Lukasz Nowak wrote:
> From: Lukasz Nowak <lnowak@tycoint.com>
>
> Telit QMI modems have a problem with the low-power operating modes.
> After entering and leaving such a state, UIM service does not return.
> The sim card is still marked as powered-down. The QMI interface does
> not have a way to power it back on.
>
> To avoid this, keep modems with the "AlwaysOnline" flag online
> in the disable-modem and offline-modem procedures.
> ---
>  plugins/gobi.c | 41 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/plugins/gobi.c b/plugins/gobi.c
> index 6a78941..d944b39 100644
> --- a/plugins/gobi.c
> +++ b/plugins/gobi.c
> @@ -168,7 +168,14 @@ static void get_oper_mode_cb(struct qmi_result *resu=
lt, void *user_data)
>
>  	data->oper_mode =3D mode;
>
> -	switch (data->oper_mode) {
> +	/*
> +	 * Telit QMI modem must remain online. If powered down, it also
> +	 * powers down the sim card, and QMI interface has no way to bring
> +	 * it back alive.
> +	 */
> +	if (ofono_modem_get_boolean(modem, "AlwaysOnline"))
> +		ofono_modem_set_powered(modem, TRUE);
> +	else switch (data->oper_mode) {

else switch is not really our style.  It might be better to simply =

return if AlwaysOnline is true. e.g.

if (ofono_modem_get_boolean(modem, "AlwaysOnline")) {
	ofono_modem_set_powered(...);
	return;
}

switch(...)

>  	case QMI_DMS_OPER_MODE_ONLINE:
>  		param =3D qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
>  					QMI_DMS_OPER_MODE_PERSIST_LOW_POWER);
> @@ -353,14 +360,21 @@ static int gobi_disable(struct ofono_modem *modem)
>  	qmi_service_cancel_all(data->dms);
>  	qmi_service_unregister_all(data->dms);
>
> -	param =3D qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
> -					QMI_DMS_OPER_MODE_PERSIST_LOW_POWER);
> -	if (!param)
> -		return -ENOMEM;
> +	/*
> +	 * Telit QMI modem must remain online. If powered down, it also
> +	 * powers down the sim card, and QMI interface has no way to bring
> +	 * it back alive.
> +	 */
> +	if (!ofono_modem_get_boolean(modem, "AlwaysOnline")) {
> +		param =3D qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
> +						QMI_DMS_OPER_MODE_PERSIST_LOW_POWER);

Please don't go over 80 characters / line

It might be cleaner here to simply jump straight to shutdown_device if =

AlwaysOnline is set.

> +		if (!param)
> +			return -ENOMEM;
>
> -	if (qmi_service_send(data->dms, QMI_DMS_SET_OPER_MODE, param,
> -					power_disable_cb, modem, NULL) > 0)
> -		return -EINPROGRESS;
> +		if (qmi_service_send(data->dms, QMI_DMS_SET_OPER_MODE, param,
> +						power_disable_cb, modem, NULL) > 0)
> +			return -EINPROGRESS;
> +	}
>
>  	shutdown_device(modem);
>
> @@ -390,6 +404,17 @@ static void gobi_set_online(struct ofono_modem *mode=
m, ofono_bool_t online,
>
>  	DBG("%p %s", modem, online ? "online" : "offline");
>
> +	/*
> +	 * Telit QMI modem must remain online. If powered down, it also
> +	 * powers down the sim card, and QMI interface has no way to bring
> +	 * it back alive.
> +	 */
> +	if (ofono_modem_get_boolean(modem, "AlwaysOnline")) {
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		g_free(cbd);
> +		return;
> +	}
> +

The effect here is that the modem object will never show Modem.Online =3D =

True.  So applications will think the modem is in Flight mode, e.g. =

radio circuits off.  I don't think this is what you want.

oFono does support modems which have no concept of offline mode, but for =

that a new driver must be implemented with .set_online method being =

NULL.  In this case oFono immediately goes into the post_online state =

after the post_sim state.

Maybe the right way to handle all this is to implement a =

"gobi-always-online" driver instead.  It can live inside gobi.c and =

share most of the function calls.  But the ofono_modem_driver definition =

would modify / implement its own versions of .disable, .enable and leave =

.set_online NULL.

>  	if (online)
>  		mode =3D QMI_DMS_OPER_MODE_ONLINE;
>  	else
>

Regards,
-Denis

--===============1050316435998209349==--

