Content-Type: multipart/mixed; boundary="===============8578303327343371011=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 4/4] Dummy example GPRS context provisioning driver
Date: Tue, 11 Jan 2011 22:48:54 -0800
Message-ID: <1294814934.3873.73.camel@aeonflux>
In-Reply-To: <1294665072-13630-5-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8578303327343371011==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

>  Makefile.am          |    3 +
>  examples/provision.c |  198 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 201 insertions(+), 0 deletions(-)
>  create mode 100644 examples/provision.c
> =

> diff --git a/Makefile.am b/Makefile.am
> index 0f330a7..d57509d 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -305,6 +305,9 @@ builtin_sources +=3D examples/history.c
>  =

>  builtin_modules +=3D example_nettime
>  builtin_sources +=3D examples/nettime.c
> +
> +builtin_modules +=3D example_gprs_provision
> +builtin_sources +=3D examples/provision.c
>  endif

I like to have these match. So just call it example_provision.

> +struct provisioning_request {
> +	struct ofono_modem *modem;
> +	ofono_gprs_provision_cb_t cb;
> +	void *userdata;

Same as I mentioned in the other patch. Please use user_data.

> +};
> +
> +static void sim_spn_read_cb(int ok, int length, int record,
> +				const unsigned char *data,
> +				int record_length, void *userdata)
> +{
> +	struct provisioning_request *req =3D userdata;
> +	char *spn =3D NULL;
> +
> +	struct ofono_atom *sim_atom;
> +	struct ofono_sim *sim;
> +	const char *imsi;
> +
> +	unsigned char mnc_length;
> +	char mcc[OFONO_MAX_MCC_LENGTH + 1];
> +	char mnc[OFONO_MAX_MNC_LENGTH + 1];
> +
> +	GSList *settings =3D NULL;
> +	struct ofono_gprs_provisioning_data *entry;
> +
> +	sim_atom =3D __ofono_modem_find_atom(req->modem, OFONO_ATOM_TYPE_SIM);
> +
> +	if (sim_atom =3D=3D NULL) {
> +		ofono_debug("No SIM atom");
> +		goto finish;
> +	}
> +
> +	sim =3D __ofono_atom_get_data(sim_atom);
> +	imsi =3D ofono_sim_get_imsi(sim);
> +	if (imsi =3D=3D NULL) {
> +		ofono_debug("No IMSI available");
> +		goto finish;
> +	}
> +
> +	mnc_length =3D ofono_sim_get_mnc_length(sim);
> +	if (mnc_length =3D=3D 0) {
> +		ofono_debug("No MNC length available");
> +		goto finish;
> +	}
> +
> +	strncpy(mcc, imsi, OFONO_MAX_MCC_LENGTH);
> +	mcc[OFONO_MAX_MCC_LENGTH] =3D '\0';
> +	strncpy(mnc, imsi + OFONO_MAX_MCC_LENGTH, mnc_length);
> +	mnc[mnc_length] =3D '\0';
> +
> +	if (ok)
> +		spn =3D sim_string_to_utf8(data + 1, length - 1);
> +
> +	ofono_debug("Finding settings for MCC %s, MNC %s, SPN '%s'",
> +			mcc, mnc, spn);
> +
> +	if (spn =3D=3D NULL || strcmp(spn, "oFono") !=3D 0)
> +		goto finish;

I think we need to also take some MCC and MNC into account. People will
be by accident compiling this plugin and I wanna make sure nothing bad
gets provisioned ;)

> +static void example_gprs_provision_get_settings(
> +	struct ofono_modem *modem,
> +	ofono_gprs_provision_cb_t cb,
> +	void *userdata)
> +{
> +	struct provisioning_request *req;
> +	struct ofono_atom *sim_atom;
> +	struct ofono_sim *sim =3D NULL;
> +
> +	ofono_debug("Provisioning...");
> +
> +	req =3D g_try_new0(struct provisioning_request, 1);
> +	if (req =3D=3D NULL)
> +		goto error;
> +
> +	req->modem =3D modem;
> +	req->cb =3D cb;
> +	req->userdata =3D userdata;
> +
> +	/* Start SPN query from SIM */
> +	sim_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
> +
> +	if (sim_atom !=3D NULL)
> +		sim =3D __ofono_atom_get_data(sim_atom);
> +
> +	if (sim !=3D NULL) {
> +		ofono_sim_read(sim, SIM_EFSPN_FILEID,
> +				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
> +				sim_spn_read_cb, req);
> +		return;
> +	}

Should this not be provided somehow by the SIM atom?

Denis, any idea why we are not keeping this information available?

Regards

Marcel



--===============8578303327343371011==--

