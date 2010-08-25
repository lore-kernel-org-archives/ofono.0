Content-Type: multipart/mixed; boundary="===============6897084157540790414=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: Read EFsst
Date: Wed, 25 Aug 2010 12:17:07 -0500
Message-ID: <4C755013.3040603@gmail.com>
In-Reply-To: <1282735748-23050-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6897084157540790414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> -static void sim_efust_read_cb(int ok, int length, int record,
> +static void sim_efsst_read_cb(int ok, int length, int record,
>  				const unsigned char *data,
>  				int record_length, void *userdata)
>  {
> @@ -1057,6 +1059,27 @@ static void sim_efust_read_cb(int ok, int length, =
int record,
>  	if (!ok)
>  		goto out;
>  =

> +	if (length < 2) {
> +		ofono_error("EFsst shall contain at least two bytes");
> +		goto out;
> +	}
> +
> +	sim->efsst =3D g_memdup(data, length);
> +	sim->efsst_length =3D length;
> +
> +out:
> +	sim_retrieve_imsi(sim);
> +}
> +
> +static void sim_efust_read_cb(int ok, int length, int record,
> +				const unsigned char *data,
> +				int record_length, void *userdata)
> +{
> +	struct ofono_sim *sim =3D userdata;
> +
> +	if (!ok)
> +		goto error;
> +
>  	if (length < 1) {
>  		ofono_error("EFust shall contain at least one byte");
>  		goto out;
> @@ -1073,6 +1096,12 @@ static void sim_efust_read_cb(int ok, int length, =
int record,
>  =

>  out:
>  	sim_retrieve_imsi(sim);
> +	return;
> +
> +error:
> +	ofono_sim_read(sim, SIM_EFSST_FILEID,
> +			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
> +			sim_efsst_read_cb, sim);
>  }

That is really not how it works.  If the file ID is the same then you
need some other information to determine whether this is a phase 3 or a
phase 2 SIM.  Look at how EFecc reading in voicecall.c is done.  In
other words, this function needs to make an intelligent decision whether
this is EFsst or EFust.

In your case the only heuristic we have is EFphase, which is mandatory
for all Phase 2 SIMs (and absent in all Phase 3 SIMs).

Regards,
-Denis

--===============6897084157540790414==--

