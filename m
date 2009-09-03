Content-Type: multipart/mixed; boundary="===============8611756630952966515=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: [PATCH] G1: Add an SMS quirk for CNMI mode
Date: Thu, 03 Sep 2009 08:42:52 -0700
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C968003A49@orsmsx508.amr.corp.intel.com>
In-Reply-To: <20090902215909.7b7a6c52@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8611756630952966515==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> -	/* Mode doesn't matter, but sounds like 2 is the sanest option */
> -	if (!append_cnmi_element(buf, &len, cnmi_opts[0], "2310", FALSE))
> +	if (data->vendor =3D=3D OFONO_VENDOR_HTC_G1)
> +		/* The G1 advertises support for mode 2, but returns an error
> +		 * if we attempt to actually use it. */
> +		mode =3D "1";
> +	else
> +		/* Sounds like 2 is the sanest mode */
> +		mode =3D "2310";
> +
> +	if (!append_cnmi_element(buf, &len, cnmi_opts[0], mode, FALSE))
>  		return FALSE;

Instead of having vendor checks all over the place, wouldn't it be cleaner =
if the plugin had a way to provide/fix cnmi_opts?

Cheers,
Waldo

--===============8611756630952966515==--

