Content-Type: multipart/mixed; boundary="===============8083265504316828855=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH 3/3] Add: online and post_online methods to isimodem driver
Date: Tue, 25 May 2010 23:24:21 +0300
Message-ID: <1274819061.3755.381.camel@tucson.research.nokia.com>
In-Reply-To: <1274451941-10573-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8083265504316828855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On Fri, 2010-05-21 at 16:25 +0200, Pessi Pekka (Nokia-D/Helsinki) wrote:
> ---
>  drivers/isimodem/isimodem.c |  120 +++++++++++++++++++++++++++++++++++++=
++++--
>  1 files changed, 115 insertions(+), 5 deletions(-)
> =

> diff --git a/drivers/isimodem/isimodem.c b/drivers/isimodem/isimodem.c
> index 4085a55..99ba440 100644
> --- a/drivers/isimodem/isimodem.c
> +++ b/drivers/isimodem/isimodem.c
> @@ -68,6 +68,11 @@ struct isi_data {
>  	unsigned interval;
>  	int reported;
>  	int mtc_state;
> +	int online;
> +	struct {
> +		ofono_modem_online_cb callback;
> +		void *data;
> +	} online_request;
>  };
>  =

>  static void report_powered(struct isi_data *isi, ofono_bool_t powered)
> @@ -76,9 +81,33 @@ static void report_powered(struct isi_data *isi, ofono=
_bool_t powered)
>  		ofono_modem_set_powered(isi->modem, isi->reported =3D powered);
>  }
>  =

> -static void set_power_by_mtc_state(struct isi_data *isi, int state)
> +static void report_online(struct isi_data *isi, uint8_t mtc_state)
>  {
> -	switch (isi->mtc_state =3D state) {
> +	ofono_modem_online_cb cb =3D isi->online_request.callback;
> +	struct ofono_error error =3D {
> +		(isi->online
> +			? mtc_state =3D=3D MTC_NORMAL
> +			: mtc_state !=3D MTC_NORMAL)
> +		? OFONO_ERROR_TYPE_NO_ERROR
> +		: OFONO_ERROR_TYPE_FAILURE,
> +	};

I can't parse this.

> +	void *data =3D isi->online_request.data;
> +
> +	isi->online_request.callback =3D 0;
> +	isi->online_request.data =3D 0;
> +
> +	if (cb)
> +		cb(&error, data);
> +}
> +
> +
> +static void set_power_by_mtc_state(struct isi_data *isi, int mtc_state)
> +{
> +	isi->mtc_state =3D mtc_state;
> +
> +	report_online(isi, mtc_state);

Should we check first for isi->mtc_state =3D=3D mtc_state, and return?
Otherwise, what's the point in storing mtc_state?

> +	switch (mtc_state) {
>  	case MTC_STATE_NONE:
>  	case MTC_POWER_OFF:
>  	case MTC_CHARGING:
> @@ -87,6 +116,9 @@ static void set_power_by_mtc_state(struct isi_data *is=
i, int state)
>  		break;
>  =

>  	case MTC_RF_INACTIVE:
> +		report_powered(isi, 1);
> +		break;
> +
>  	case MTC_NORMAL:
>  		report_powered(isi, 1);
>  		break;

Can't we fold all of these cases, including default, into one single
report_powered() call?

> @@ -96,6 +128,7 @@ static void set_power_by_mtc_state(struct isi_data *is=
i, int state)
>  	}
>  }
>  =

> +

Extra line feed here.

>  static void mtc_state_ind_cb(GIsiClient *client, const void *restrict da=
ta,
>  				size_t len, uint16_t object, void *opaque)
>  {
> @@ -155,7 +188,8 @@ static bool mtc_poll_query_cb(GIsiClient *client, con=
st void *restrict data,
>  	DBG("target modem state: %s (0x%02X)",
>  		mtc_modem_state_name(msg[2]), msg[2]);
>  =

> -	set_power_by_mtc_state(isi, msg[1]);
> +	if (msg[1] =3D=3D msg[2])
> +		set_power_by_mtc_state(isi, msg[1]);
>  =

>  	return true;
>  }
> @@ -179,7 +213,8 @@ static bool mtc_query_cb(GIsiClient *client, const vo=
id *restrict data,
>  	DBG("target modem state: %s (0x%02X)",
>  		mtc_modem_state_name(msg[2]), msg[2]);
>  =

> -	set_power_by_mtc_state(isi, msg[1]);
> +	if (msg[1] =3D=3D msg[2])
> +		set_power_by_mtc_state(isi, msg[1]);
>  =

>  	return true;
>  }
> @@ -276,6 +311,7 @@ static int isi_modem_probe(struct ofono_modem *modem)
>  	isi->ifname =3D ifname;
>  	isi->link =3D link;
>  	isi->client =3D g_isi_client_create(isi->idx, PN_MTC);
> +	isi->reported =3D -1;
>  =

>  	return 0;
>  }
> @@ -292,6 +328,70 @@ static void isi_modem_remove(struct ofono_modem *mod=
em)
>  	g_free(isi);
>  }
>  =

> +static bool mtc_state_cb(GIsiClient *client, const void *restrict data,
> +			size_t len, uint16_t object, void *opaque)
> +{
> +	struct isi_data *isi =3D opaque;
> +	const unsigned char *msg =3D data;
> +
> +	if (!msg) {
> +		DBG("ISI client error: %d", g_isi_client_error(client));
> +		goto err;
> +	}
> +
> +	if (len < 3 || msg[0] !=3D MTC_STATE_RESP)
> +		return false;

Add line feed here.

> +	DBG("cause: %s (0x%02X)", mtc_isi_cause_name(msg[1]), msg[1]);

And here.

> +	if (msg[1] =3D=3D MTC_OK)
> +		return true;
> +
> +err:
> +	if (isi->online_request.callback) {
> +		ofono_modem_online_cb cb =3D isi->online_request.callback;
> +		struct ofono_error error =3D {
> +			msg && msg[1] =3D=3D MTC_ALREADY_ACTIVE
> +			? OFONO_ERROR_TYPE_NO_ERROR
> +			: OFONO_ERROR_TYPE_FAILURE,
> +		};

This is hard to parse. Maybe use the CALLBACK_WITH_* macros, or separate
success/failure reporting to separate functions, or both.

> +		void *cbdata =3D isi->online_request.data;
> +		isi->online_request.callback =3D 0;
> +		isi->online_request.data =3D 0;
> +		cb(&error, cbdata);
> +	}

BTW, why aren't you using struct isi_cb_data? It can hold user data,
too, if a reference to struct isi_data is needed (although it isn't
needed here).

(If it is to avoid heap allocation for outgoing requests, then that is
futile anyway, because the current GIsiClient implementation already
does that.)

> +	return true;
> +}
> +
> +static int mtc_state_req(struct isi_data *isi, uint8_t state)
> +{
> +	const unsigned char req[] =3D {
> +		MTC_STATE_REQ, state, 0x00
> +	};
> +
> +	if (g_isi_request_make(isi->client, req, sizeof(req), MTC_TIMEOUT,
> +					mtc_state_cb, isi))
> +		return 0;
> +	else
> +		return -errno;
> +}

Why doesn't this simply return a boolean?

> +static void isi_modem_online(struct ofono_modem *modem, ofono_bool_t onl=
ine,
> +			ofono_modem_online_cb callback, void *data)
> +{
> +	struct isi_data *isi =3D ofono_modem_get_data(modem);
> +	int err;
> +
> +	DBG("(%p) with %s", modem, isi->ifname);
> +	isi->online =3D online;
> +	isi->online_request.callback =3D callback;
> +	isi->online_request.data =3D data;
> +
> +	err =3D mtc_state_req(isi, online ? MTC_NORMAL : MTC_RF_INACTIVE);
> +
> +	if (err)
> +		report_online(isi, MTC_STATE_NONE);
> +}

...especially since the errno isn't even logged here.

>  static void isi_modem_pre_sim(struct ofono_modem *modem)
>  {
>  	struct isi_data *isi =3D ofono_modem_get_data(modem);
> @@ -306,12 +406,20 @@ static void isi_modem_pre_sim(struct ofono_modem *m=
odem)
>  static void isi_modem_post_sim(struct ofono_modem *modem)
>  {
>  	struct isi_data *isi =3D ofono_modem_get_data(modem);
> +
> +	DBG("(%p) with %s", modem, isi->ifname);
> +
> +	ofono_phonebook_create(isi->modem, 0, "isimodem", isi->idx);
> +}
> +
> +static void isi_modem_post_online(struct ofono_modem *modem)
> +{
> +	struct isi_data *isi =3D ofono_modem_get_data(modem);
>  	struct ofono_gprs *gprs;
>  	struct ofono_gprs_context *gc;
>  =

>  	DBG("(%p) with %s", modem, isi->ifname);
>  =

> -	ofono_phonebook_create(isi->modem, 0, "isimodem", isi->idx);
>  	ofono_netreg_create(isi->modem, 0, "isimodem", isi->idx);
>  	ofono_sms_create(isi->modem, 0, "isimodem", isi->idx);
>  	ofono_cbs_create(isi->modem, 0, "isimodem", isi->idx);
> @@ -335,8 +443,10 @@ static struct ofono_modem_driver driver =3D {
>  	.name =3D "isimodem",
>  	.probe =3D isi_modem_probe,
>  	.remove =3D isi_modem_remove,
> +	.online =3D isi_modem_online,
>  	.pre_sim =3D isi_modem_pre_sim,
>  	.post_sim =3D isi_modem_post_sim,
> +	.post_online =3D isi_modem_post_online,
>  };
>  =

>  static int isimodem_init(void)

Cheers,
Aki


--===============8083265504316828855==--

