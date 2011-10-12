Content-Type: multipart/mixed; boundary="===============1448013048436064478=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv9 08/16] provision: Add provisioning plugin
Date: Wed, 12 Oct 2011 16:56:21 -0500
Message-ID: <4E960D05.6020204@gmail.com>
In-Reply-To: <1317820719-23609-9-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1448013048436064478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

<snip>

> +static int provision_get_settings(const char *mcc, const char *mnc,
> +				const char *spn,
> +				struct ofono_gprs_provision_data **settings,
> +				int *count)
> +{
> +	GSList *l;
> +	GSList *apns;
> +	GError *error =3D NULL;
> +	int ap_count;
> +	int i;
> +
> +	DBG("Provisioning for MCC %s, MNC %s, SPN '%s'", mcc, mnc, spn);
> +
> +	apns =3D mbpi_lookup(mcc, mnc, FALSE, &error);
> +	if (apns =3D=3D NULL) {
> +		if (error !=3D NULL) {
> +			ofono_error("%s", error->message);
> +			g_error_free(error);
> +		}
> +
> +		return -ENOENT;
> +	}
> +
> +	ap_count =3D g_slist_length(apns);
> +
> +	DBG("Found %d APs", ap_count);
> +
> +	*settings =3D g_try_malloc_n(ap_count,
> +				sizeof(struct ofono_gprs_provision_data));

Please use g_try_new0 instead of g_try_malloc_n.  The result will be a
bit prettier.

> +	if (*settings =3D=3D NULL) {
> +		ofono_error("Provisioning failed: %s", g_strerror(errno));
> +
> +		for (l =3D apns; l; l =3D l->next)
> +			mbpi_provision_data_free(l->data);
> +
> +		g_slist_free(apns);
> +
> +		return -ENOMEM;
> +	}
> +
> +	*count =3D ap_count;
> +
> +	for (l =3D apns, i =3D 0; l; l =3D l->next, i++) {
> +		struct ofono_gprs_provision_data *ap =3D l->data;
> +
> +		DBG("Name: '%s'", ap->name);
> +		DBG("APN: '%s'", ap->apn);
> +		DBG("Username: '%s'", ap->username);
> +		DBG("Password: '%s'", ap->password);
> +
> +		*(*settings + i) =3D *ap;

Please don't use this particular syntax, we prefer using memcpy for this.

> +
> +		memset(*settings + i, 0,
> +			sizeof(struct ofono_gprs_provision_data));

Do you mean to memset the contents of ap here?  The way I read this code
you're setting an entry in the return array and immediately resetting it
to 0.

> +		mbpi_provision_data_free(ap);

using g_free(ap) might be the easier solution.

> +	}
> +
> +	g_slist_free(apns);
> +
> +	return 0;
> +}
> +
> +static struct ofono_gprs_provision_driver provision_driver =3D {
> +	.name		=3D "Provisioning",
> +	.get_settings	=3D provision_get_settings
> +};
> +
> +static int provision_init(void)
> +{
> +	return ofono_gprs_provision_driver_register(&provision_driver);
> +}
> +
> +static void provision_exit(void)
> +{
> +	ofono_gprs_provision_driver_unregister(&provision_driver);
> +}
> +
> +OFONO_PLUGIN_DEFINE(provision, "Provisioning Plugin", VERSION,
> +			OFONO_PLUGIN_PRIORITY_DEFAULT,
> +			provision_init, provision_exit)

Regards,
-Denis

--===============1448013048436064478==--

