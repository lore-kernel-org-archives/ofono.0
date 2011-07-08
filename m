Content-Type: multipart/mixed; boundary="===============3752169681534414077=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 1/1] GPRS Provisioning Plugin.
Date: Fri, 08 Jul 2011 13:23:34 -0500
Message-ID: <4E174B26.3080004@gmail.com>
In-Reply-To: <1310124794-7880-2-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3752169681534414077==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

<snip>

> +static int gprs_provision(const char *mcc, const char *mnc,
> +				const char *spn,
> +				struct ofono_gprs_provision_data **settings,
> +				int *count)
> +{
> +	int i;
> +	struct parser_data *data;
> +	*settings =3D NULL;
> +
> +	DBG("Provisioning for MCC %s, MNC %s, SPN '%s'",
> +			mcc, mnc, spn);
> +
> +	data =3D g_try_new0(struct parser_data, 1);
> +	if (data =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	lookup_apn(mcc, mnc, NULL, data);

What I wonder is what is the overhead of the XML parser right now (e.g.
how long it takes on reasonable embedded hardware).  If this takes a
while, then it might be better to pre-parse the mobile-provider-info db
during plugin initialization and not every time gprs_provision is
called.  Otherwise we run the risk of hanging the daemon while the
provision settings are being looked up.

> +
> +	*count =3D data->count;
> +
> +	DBG("settings count: %d", *count);
> +
> +	if (!*count) {
> +		g_free(data);
> +		return -ENOENT;
> +	}
> +
> +	*settings =3D g_try_new0(struct ofono_gprs_provision_data, *count);
> +	if (*settings =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < *count; i++) {
> +		(*settings)[i] =3D *(data->settings[i]);
> +
> +		(*settings)[i].proto =3D OFONO_GPRS_PROTO_IP;
> +		(*settings)[i].type =3D OFONO_GPRS_CONTEXT_TYPE_INTERNET;
> +
> +		DBG("Name: %s", (*settings)[i].name);
> +		DBG("APN: %s", (*settings)[i].apn);
> +		DBG("Username: %s", (*settings)[i].username);
> +		DBG("Password: %s", (*settings)[i].password);
> +	}
> +
> +	g_free(data);
> +
> +	return 0;
> +}
> +

<snip>

Regards,
-Denis

--===============3752169681534414077==--

