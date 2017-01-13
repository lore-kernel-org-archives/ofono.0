Content-Type: multipart/mixed; boundary="===============4654533783409643715=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] qmimodem: query_passwd_state can be retried
Date: Fri, 13 Jan 2017 16:25:02 -0600
Message-ID: <9c2461b9-0b37-9b8d-ce56-833f4fb2e1fc@gmail.com>
In-Reply-To: <20170112140918.28845-2-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4654533783409643715==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

All of the patch looks fine, except:

> @@ -436,16 +458,36 @@ static void query_passwd_state_cb(struct qmi_result=
 *result,
>  {
>  	struct cb_data *cbd =3D user_data;
>  	ofono_sim_passwd_cb_t cb =3D cbd->cb;
> +	struct ofono_sim *sim =3D cbd->user;
> +	struct sim_data *data =3D ofono_sim_get_data(sim);
>  	struct sim_status sim_stat;
> -
> -	DBG("");
> -
> -	if (!handle_get_card_status_result(result, &sim_stat)) {
> +	enum get_card_status_result res;
> +
> +	res =3D handle_get_card_status_result(result, &sim_stat);
> +	switch (res) {
> +	case GET_CARD_STATUS_RESULT_OK:
> +		DBG("passwd state %d", sim_stat.passwd_state);
> +		data->retry_count =3D 0;
> +		CALLBACK_WITH_SUCCESS(cb, sim_stat.passwd_state, cbd->data);
> +		break;
> +	case GET_CARD_STATUS_RESULT_TEMP_ERROR:
> +		data->retry_count++;
> +		if (data->retry_count > MAX_RETRY_COUNT) {
> +			DBG("Failed after %d attempts", data->retry_count);
> +			data->retry_count =3D 0;
> +			CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
> +		} else {
> +			usleep(20000);

You cannot use usleep here.  usleep blocks, so the rest of the daemon is =

unable to process anything else.  So for example, if you have multiple =

modems, usleep would block oFono from receiving / sending any events to =

these, D-Bus API would be blocked, etc.

For an example of how to get around this using GLib timers, see =

drivers/atmodem/atutil.c.

The at_util_sim_state_query (at_util_sim_state_query_new()) is doing =

something extremely similar to what you're trying to do here.

Regards,
-Denis

--===============4654533783409643715==--

