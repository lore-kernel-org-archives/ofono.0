Content-Type: multipart/mixed; boundary="===============0503684597437108703=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/2] dunmodem: Add stub for gprs.
Date: Wed, 03 Aug 2011 14:48:35 +0200
Message-ID: <1312375716.3373.29.camel@aeonflux>
In-Reply-To: <1312372110-23541-3-git-send-email-mario@tokarz.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0503684597437108703==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mario,

<snip>

> +static void dun_gprs_set_attached(struct ofono_gprs *gprs, int attached,
> +						ofono_gprs_cb_t cb, void *data)
> +{
> +	DBG("");
> +
> +	CALLBACK_WITH_SUCCESS(cb, data);
> +}
> +
> +static gboolean dun_gprs_finish_registration(gpointer user_data)
> +{
> +	struct ofono_gprs *gprs =3D user_data;
> +
> +	ofono_gprs_register(gprs);
> +
> +	return FALSE;
> +}
> +
> +static int dun_gprs_probe(struct ofono_gprs *gprs,
> +					unsigned int vendor, void *data)
> +{
> +	DBG("");
> +
> +	g_timeout_add(500, dun_gprs_finish_registration, gprs);
> +
> +	return 0;
> +}

Why 500 milliseconds? Why not just g_timeout_add_seconds(0, ...) or
g_idle_add().

> +static void dun_gprs_remove(struct ofono_gprs *gprs)
> +{
> +	DBG("");
> +}
> +
> +static void dun_gprs_attached_status(struct ofono_gprs *gprs,
> +						ofono_gprs_status_cb_t cb,
> +						void *data)
> +{
> +	DBG("");
> +
> +	CALLBACK_WITH_SUCCESS(cb, 1, data);
> +}
> +
> +static struct ofono_gprs_driver driver =3D {
> +	.name			=3D "dunmodem",
> +	.probe			=3D dun_gprs_probe,
> +	.remove		=3D dun_gprs_remove,
> +	.set_attached		=3D dun_gprs_set_attached,
> +	.attached_status	=3D dun_gprs_attached_status,
> +};
> +
> +void dun_gprs_init(void)
> +{
> +	ofono_gprs_driver_register(&driver);
> +}
> +
> +void dun_gprs_exit(void)
> +{
> +	ofono_gprs_driver_unregister(&driver);
> +}

Regards

Marcel



--===============0503684597437108703==--

