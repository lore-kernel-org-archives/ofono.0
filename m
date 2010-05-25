Content-Type: multipart/mixed; boundary="===============7259099134233612809=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH] Add: support for EF_ICCID in isimodem.
Date: Tue, 25 May 2010 14:18:16 +0300
Message-ID: <1274786296.1240.150.camel@tucson.research.nokia.com>
In-Reply-To: <1274457251-14490-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7259099134233612809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On Fri, 2010-05-21 at 17:54 +0200, Pessi Pekka (Nokia-D/Helsinki) wrote:
> ---
>  drivers/isimodem/sim.c |  160 +++++++++++++++++++++++++++++-------------=
------
>  1 files changed, 96 insertions(+), 64 deletions(-)
> =

> diff --git a/drivers/isimodem/sim.c b/drivers/isimodem/sim.c
> index 6cf73d2..bff35b3 100644
> --- a/drivers/isimodem/sim.c
> +++ b/drivers/isimodem/sim.c
> @@ -45,19 +45,29 @@
>  =

>  struct sim_data {
>  	GIsiClient *client;
> -	bool iccid;
>  	bool registered;
>  };
>  =

> +struct file_info {
> +	int length, structure, record_length;
> +	unsigned char access[3];
> +};
> +
>  /* Returns fake (static) file info for EFSPN */
> -static gboolean efspn_file_info(gpointer user)
> +static gboolean fake_file_info(gpointer user)
>  {
>  	struct isi_cb_data *cbd =3D user;
>  	ofono_sim_file_info_cb_t cb =3D cbd->cb;
> -	unsigned char access[3] =3D { 0x0f, 0xff, 0xff };
> -
> -	DBG("Returning dummy file_info for EFSPN");
> -	CALLBACK_WITH_SUCCESS(cb, 17, 0, 0, access, cbd->data);
> +	struct file_info const *fi =3D cbd->user;
> +
> +	if (fi) {
> +		DBG("Returning dummy file_info");
> +		CALLBACK_WITH_SUCCESS(cb,
> +				fi->length, fi->structure, fi->record_length,
> +				fi->access, cbd->data);
> +	} else {
> +		CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL, cbd->data);
> +	}
>  =

>  	g_free(cbd);
>  	return FALSE;
> @@ -66,15 +76,25 @@ static gboolean efspn_file_info(gpointer user)
>  static void isi_read_file_info(struct ofono_sim *sim, int fileid,
>  				ofono_sim_file_info_cb_t cb, void *data)
>  {
> +	struct isi_cb_data *cbd =3D isi_cb_data_new(NULL, cb, data);
> +
>  	if (fileid =3D=3D SIM_EFSPN_FILEID) {
> -		/* Fake response for EFSPN  */
> -		struct isi_cb_data *cbd =3D isi_cb_data_new(NULL, cb, data);
> -		g_idle_add(efspn_file_info, cbd);
> -		return;
> +		static struct file_info const info =3D {
> +			17, 0, 0, { 0x0f, 0xff, 0xff },
> +		};
> +		DBG("Faking file_info for EF_spn");
> +		cbd->user =3D (void *)&info;
> +	} else if (fileid =3D=3D SIM_EF_ICCID_FILEID) {
> +		static struct file_info const info =3D {
> +			10, 0, 0, { 0x0f, 0xff, 0xff },
> +		};
> +		DBG("Faking file_info for EF_iccid");
> +		cbd->user =3D (void *)&info;
> +	} else {
> +		DBG("Not implemented (fileid =3D %04x)", fileid);
>  	}

I'd prefer a switch here.

> -	DBG("Not implemented (fileid =3D %04x)", fileid);
> -	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL, data);
> +	g_idle_add(fake_file_info, cbd);
>  }
>  =

>  static bool spn_resp_cb(GIsiClient *client, const void *restrict data,
> @@ -127,12 +147,9 @@ out:
>  	return true;
>  }
>  =

> -static void isi_read_file_transparent(struct ofono_sim *sim, int fileid,
> -					int start, int length,
> -					ofono_sim_read_cb_t cb, void *data)
> +static bool isi_read_spn(struct ofono_sim *sim, struct isi_cb_data *cbd)
>  {
>  	struct sim_data *sd =3D ofono_sim_get_data(sim);
> -	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
>  =

>  	const unsigned char msg[] =3D {
>  		SIM_SERV_PROV_NAME_REQ,
> @@ -140,19 +157,72 @@ static void isi_read_file_transparent(struct ofono_=
sim *sim, int fileid,
>  		0
>  	};
>  =

> -	/* Hack support for EFSPN reading only */
> -	if (fileid !=3D SIM_EFSPN_FILEID)
> -		goto error;
> +	return g_isi_request_make(sd->client, msg, sizeof(msg),
> +				SIM_TIMEOUT, spn_resp_cb, cbd) !=3D NULL;
> +}

Missing tab.

> -	if (!cbd)
> -		goto error;
> +static bool read_iccid_resp_cb(GIsiClient *client, const void *restrict =
data,
> +				size_t len, uint16_t object, void *user)
> +{
> +	struct isi_cb_data *cbd =3D user;
> +	ofono_sim_read_cb_t cb =3D cbd->cb;
> +	const unsigned char *msg =3D data;
> +	const unsigned char *iccid =3D NULL;
>  =

> -	if (g_isi_request_make(sd->client, msg, sizeof(msg),
> -				SIM_TIMEOUT, spn_resp_cb, cbd))
> -		return;
> +	if (!msg) {
> +		DBG("ISI client error: %d", g_isi_client_error(client));
> +		goto done;
> +	}
> +
> +	if (len < 3 || msg[0] !=3D SIM_READ_FIELD_RESP || msg[1] !=3D 0x66)
> +		return false;
> +
> +	if (msg[2] =3D=3D SIM_SERV_OK && len >=3D 13)
> +		iccid =3D msg + 3;
> +	else
> +		DBG("Error reading ICC ID");
> +
> +done:
> +	if (iccid)
> +		CALLBACK_WITH_SUCCESS(cb, iccid, 10, cbd->data);
> +	else
> +		CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
> +
> +	return true;

This is inconsistent with spn_resp_cb(); either use two labels
(error/out) here or change both to use one.

Also, cbd leaks here.

> +}
> +
> +static bool isi_read_iccid(struct ofono_sim *sim, struct isi_cb_data *cb=
d)
> +{
> +	struct sim_data *sd =3D ofono_sim_get_data(sim);
> +
> +	const unsigned char req[] =3D {
> +		SIM_READ_FIELD_REQ,
> +		0x66 /* ICC ID */
> +	};
> +
> +	return g_isi_request_make(sd->client, req, sizeof(req), SIM_TIMEOUT,
> +				read_iccid_resp_cb, cbd) !=3D NULL;

One more tab needed here.

> +}
> +
> +static void isi_read_file_transparent(struct ofono_sim *sim, int fileid,
> +					int start, int length,
> +					ofono_sim_read_cb_t cb, void *data)
> +{
> +	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
> +
> +	switch (fileid) {
> +	case SIM_EFSPN_FILEID:
> +		if (isi_read_spn(sim, cbd))
> +			return;
> +		break;
> +	case SIM_EF_ICCID_FILEID:
> +		if (isi_read_iccid(sim, cbd))
> +			return;
> +		break;
> +	default:
> +		DBG("Not implemented (fileid =3D %04x)", fileid);
> +	}

Empty lines after break makes it more readable, IMO.
 =

> -error:
> -	DBG("Not implemented (fileid =3D %04x)", fileid);
>  	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
>  	g_free(cbd);
>  }
> @@ -287,40 +357,6 @@ static void isi_sim_register(struct ofono_sim *sim)
>  	}
>  }
>  =

> -static bool read_iccid_resp_cb(GIsiClient *client, const void *restrict =
data,
> -				size_t len, uint16_t object, void *opaque)
> -{
> -	struct ofono_sim *sim =3D opaque;
> -	struct sim_data *sd =3D ofono_sim_get_data(sim);
> -	const unsigned char *msg =3D data;
> -
> -	if (!msg) {
> -		DBG("ISI client error: %d", g_isi_client_error(client));
> -		return true;
> -	}
> -
> -	if (len < 3 || msg[0] !=3D SIM_READ_FIELD_RESP || msg[1] !=3D 0x66)
> -		return false;
> -
> -	if (msg[2] =3D=3D SIM_SERV_OK)
> -		sd->iccid =3D true;
> -
> -	return true;
> -}
> -
> -static void isi_read_iccid(struct ofono_sim *sim)
> -{
> -	struct sim_data *sd =3D ofono_sim_get_data(sim);
> -
> -	const unsigned char req[] =3D {
> -		SIM_READ_FIELD_REQ,
> -		0x66 /* ICC ID */
> -	};
> -
> -	g_isi_request_make(sd->client, req, sizeof(req), SIM_TIMEOUT,
> -				read_iccid_resp_cb, sim);
> -}
> -
>  static bool read_hplmn_resp_cb(GIsiClient *client, const void *restrict =
data,
>  				size_t len, uint16_t object, void *opaque)
>  {
> @@ -365,9 +401,6 @@ static void sim_ind_cb(GIsiClient *client, const void=
 *restrict data,
>  	if (sd->registered)
>  		return;
>  =

> -	if (!sd->iccid)
> -		isi_read_iccid(sim);
> -
>  	switch (msg[1]) {
>  	case SIM_ST_PIN:
>  		isi_sim_register(sim);
> @@ -397,7 +430,6 @@ static void sim_reachable_cb(GIsiClient *client, bool=
 alive,
>  	g_isi_subscribe(client, SIM_IND, sim_ind_cb, opaque);
>  =

>  	/* Check if SIM is ready. */
> -	isi_read_iccid(sim);
>  	isi_read_hplmn(sim);
>  }
>  =


Cheers,
Aki


--===============7259099134233612809==--

