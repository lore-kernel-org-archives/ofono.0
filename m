Content-Type: multipart/mixed; boundary="===============4834785609293945290=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v0] Read EF_ICCID property of SIM
Date: Mon, 26 Apr 2010 12:11:54 -0500
Message-ID: <201004261211.54532.denkenz@gmail.com>
In-Reply-To: <20100426153824.GA19346@aao-dell>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4834785609293945290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

> Read out Intergrated Cicruit Card Identifier from SIM.
> ---
>  v0: initial version
> =

>  doc/sim-api.txt |    5 +++++
>  include/types.h |    2 ++
>  src/sim.c       |   29 +++++++++++++++++++++++++++++
>  src/simutil.h   |    1 +
>  4 files changed, 37 insertions(+), 0 deletions(-)
> =

> diff --git a/doc/sim-api.txt b/doc/sim-api.txt
> index fd02396..d608205 100644
> --- a/doc/sim-api.txt
> +++ b/doc/sim-api.txt
> @@ -115,3 +115,8 @@ Properties	string SubscriberIdentity [readonly,
>  optional]
> =

>  			The list contains elements of the same format as the
>  			PinRequired property.
> +
> +		string IntegratedCircuitCardIdentifier [readonly]

I'd like to name this CardIdentifier, ICCID is too ugly and the full name i=
s =

just too long.

> +static void sim_iccid_read_cb(const struct ofono_error *error,
> +				const unsigned char *data, int len, void *user)
> +{
> +	struct ofono_sim *sim =3D user;
> +	char number[OFONO_MAX_ICCID_LENGTH+ 1];
> +
> +	if (!error || error->type !=3D OFONO_ERROR_TYPE_NO_ERROR || len !=3D 10)
> +		return;

No need to check for error being NULL, we don't allow that.

> +
> +	extract_bcd_number(data, len, number);
> +	number[OFONO_MAX_ICCID_LENGTH] =3D '\0';
> +	sim->iccid =3D g_strdup(number);
> +
> +	DBG("ICCID %s", sim->iccid);
> +}
> +

You might want to emit the property changed signal with the new ICCID value =

here.

>  static void sim_efphase_read_cb(const struct ofono_error *error,
>  				const unsigned char *data, int len, void *user)
>  {
> @@ -1320,6 +1341,9 @@ static void sim_determine_phase(struct ofono_sim
>  *sim)
> =

>  static void sim_initialize(struct ofono_sim *sim)
>  {
> +	sim->driver->read_file_transparent(sim, SIM_EF_ICCID_FILEID, 0, 10,
> +					   sim_iccid_read_cb, sim);
> +

Please use the sim file queue like EFpl does, no need to invent your own =

solution.  The phase check is a very specific case because we cache SIM fil=
es by =

phase of the SIM, so it needs to be known / guessed before the rest of sim =
file =

queue runs.

Regards,
-Denis

--===============4834785609293945290==--

