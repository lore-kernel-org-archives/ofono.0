Content-Type: multipart/mixed; boundary="===============7010958334559235672=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3] reopen once if open device failed
Date: Thu, 02 Jun 2011 04:27:54 -0500
Message-ID: <4DE7579A.6030009@gmail.com>
In-Reply-To: <1307068541-22433-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7010958334559235672==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 06/02/2011 09:35 PM, Caiwen Zhang wrote:
> Sometimes when open the data device, it may fail. If open the data device=
 failed,
> retry once one second later.
> =

> ---
>  plugins/huawei.c |   43 ++++++++++++++++++++++++++++++++++++++-----
>  1 files changed, 38 insertions(+), 5 deletions(-)
> =

> diff --git a/plugins/huawei.c b/plugins/huawei.c
> index e791718..96c9cc2 100644
> --- a/plugins/huawei.c
> +++ b/plugins/huawei.c
> @@ -80,6 +80,7 @@ struct huawei_data {
>  	gboolean ndis;
>  	guint sim_poll_timeout;
>  	guint sim_poll_count;
> +	guint reopen_timeout;
>  };
>  =

>  #define MAX_SIM_POLL_COUNT 5
> @@ -107,6 +108,11 @@ static void huawei_remove(struct ofono_modem *modem)
>  =

>  	DBG("%p", modem);
>  =

> +	if (data->reopen_timeout > 0) {
> +		g_source_remove(data->reopen_timeout);
> +		data->reopen_timeout =3D 0;
> +	}
> +
>  	ofono_modem_set_data(modem, NULL);
>  =

>  	if (data->modem)
> @@ -465,6 +471,20 @@ static GAtChat *open_device(struct ofono_modem *mode=
m,
>  	return chat;
>  }
>  =

> +static void huawei_disconnect(gpointer user_data);
> +
> +static gboolean reopen_callback(gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct huawei_data *data =3D ofono_modem_get_data(modem);
> +
> +	huawei_disconnect(user_data);
> +
> +	data->reopen_timeout =3D 0;
> +
> +	return FALSE;
> +}
> +
>  static void huawei_disconnect(gpointer user_data)
>  {
>  	struct ofono_modem *modem =3D user_data;
> @@ -476,8 +496,17 @@ static void huawei_disconnect(gpointer user_data)
>  	data->modem =3D NULL;
>  =

>  	data->modem =3D open_device(modem, "Modem", "Modem: ");
> -	if (data->modem =3D=3D NULL)
> +	/* retry once if failed */
> +	if (data->modem =3D=3D NULL) {
> +		if (data->reopen_timeout > 0)
> +			return;
> +
> +		data->reopen_timeout =3D g_timeout_add_seconds(1,
> +				reopen_callback, modem);
> +
> +		ofono_debug("open device failed, try to reopen it.");
>  		return;
> +	}
>  =

>  	g_at_chat_set_disconnect_function(data->modem,
>  						huawei_disconnect, modem);
> @@ -559,6 +588,11 @@ static int huawei_disable(struct ofono_modem *modem)
>  =

>  	DBG("%p", modem);
>  =

> +	if (data->reopen_timeout > 0) {
> +		g_source_remove(data->reopen_timeout);
> +		data->reopen_timeout =3D 0;
> +	}
> +
>  	if (data->sim_poll_timeout > 0) {
>  		g_source_remove(data->sim_poll_timeout);
>  		data->sim_poll_timeout =3D 0;
> @@ -682,16 +716,15 @@ static void huawei_post_online(struct ofono_modem *=
modem)
>  	ofono_ussd_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
>  						"atmodem", data->pcui);
>  =

> -	if ((data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
> -			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) &&
> -			data->modem !=3D NULL) {
> +	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
> +			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) {

What are you trying to accomplish here?  It sounds like you want to
separate the logic of creating the NDIS gprs context (which does not
depend on the modem port being available.)  Is this the case?  If so,
then you need to submit this as a separate patch...

>  		data->gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_HUAWEI,
>  						"atmodem", data->pcui);
>  =

>  		if (data->ndis =3D=3D TRUE)
>  			data->gc =3D ofono_gprs_context_create(modem, 0,
>  						"huaweimodem", data->pcui);
> -		else
> +		else if (data->modem !=3D NULL)
>  			data->gc =3D ofono_gprs_context_create(modem, 0,
>  						"atmodem", data->modem);
>  =


along with this chunk here, since they are not related to the issue
you're trying to fix.

Regards,
-Denis

--===============7010958334559235672==--

