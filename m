Content-Type: multipart/mixed; boundary="===============0009669339827784571=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/6] sim: read EFimg
Date: Wed, 25 Aug 2010 13:52:10 -0500
Message-ID: <4C75665A.6070104@gmail.com>
In-Reply-To: <1282734025-3375-4-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0009669339827784571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> +static void sim_efimg_read_cb(int ok, int length, int record,
> +				const unsigned char *data,
> +				int record_length, void *userdata)
> +{
> +	struct ofono_sim *sim =3D userdata;
> +	unsigned char *efimg;
> +	int num_records;
> +
> +	if (!ok)
> +		return;
> +
> +	num_records =3D length / record_length;
> +
> +	/*
> +	 * EFimg descriptors are 9 bytes long.
> +	 * Byte 1 of the record is the number of descriptors per record.
> +	 */
> +	if (record_length < 10)
> +		return;
> +

See my reply to the previous version regarding being more pedantic.  Fix
that and lets get this one upstream.

Regards,
-Denis

--===============0009669339827784571==--

