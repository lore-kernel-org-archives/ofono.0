Content-Type: multipart/mixed; boundary="===============3277646210305895949=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 13/15] hfpmodem: devinfo atom added to export BT address
Date: Thu, 20 Oct 2011 20:40:29 -0500
Message-ID: <4EA0CD8D.6000201@gmail.com>
In-Reply-To: <1319128700-15841-14-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3277646210305895949==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

<snip>

> +
> +struct devinfo_data {
> +	char *device_address;
> +	guint register_event_id;

Please use register_source here

> +};
> +
> +static void hfp_query_manufacturer(struct ofono_devinfo *info,
> +					ofono_devinfo_query_cb_t cb,
> +					void *data)
> +{
> +	CALLBACK_WITH_FAILURE(cb, "", data);
> +}
> +
> +static void hfp_query_model(struct ofono_devinfo *info,
> +				ofono_devinfo_query_cb_t cb,
> +				void *data)
> +{
> +	CALLBACK_WITH_FAILURE(cb, "", data);
> +}
> +
> +static void hfp_query_revision(struct ofono_devinfo *info,
> +				ofono_devinfo_query_cb_t cb,
> +				void *data)
> +{
> +	CALLBACK_WITH_FAILURE(cb, "", data);
> +}
> +

Please omit these functions, the devinfo atom should handle the absence
of these gracefully.

> +static void hfp_query_serial(struct ofono_devinfo *info,
> +				ofono_devinfo_query_cb_t cb,
> +				void *data)
> +{
> +	struct devinfo_data *dev =3D ofono_devinfo_get_data(info);
> +	CALLBACK_WITH_SUCCESS(cb, dev->device_address, data);
> +}
> +
> +static gboolean hfp_devinfo_register(gpointer user_data)
> +{
> +	struct ofono_devinfo *info =3D user_data;
> +	struct devinfo_data *dd =3D ofono_devinfo_get_data(info);
> +
> +	dd->register_event_id =3D 0;
> +
> +	ofono_devinfo_register(info);
> +
> +	return FALSE;
> +}
> +
> +static int hfp_devinfo_probe(struct ofono_devinfo *info, unsigned int ve=
ndor,
> +				void *user)
> +{
> +	struct hfp_devinfo_params *devinfo_params =3D user;
> +	struct devinfo_data *dd;
> +
> +	dd =3D g_new0(struct devinfo_data, 1);
> +	dd->device_address =3D g_strdup(devinfo_params->device_address);
> +
> +	ofono_devinfo_set_data(info, dd);
> +
> +	dd->register_event_id =3D g_idle_add(hfp_devinfo_register, info);
> +	return 0;
> +}
> +
> +static void hfp_devinfo_remove(struct ofono_devinfo *info)
> +{
> +	struct devinfo_data *dd =3D ofono_devinfo_get_data(info);
> +
> +	ofono_devinfo_set_data(info, NULL);
> +	if (dd =3D=3D NULL)
> +		return;
> +
> +	if (dd->register_event_id !=3D 0)
> +		g_source_remove(dd->register_event_id);
> +
> +	g_free(dd->device_address);
> +	g_free(dd);
> +}
> +
> +static struct ofono_devinfo_driver driver =3D {
> +	.name			=3D "hfpmodem",
> +	.probe			=3D hfp_devinfo_probe,
> +	.remove			=3D hfp_devinfo_remove,
> +	.query_manufacturer	=3D hfp_query_manufacturer,
> +	.query_model		=3D hfp_query_model,
> +	.query_revision		=3D hfp_query_revision,
> +	.query_serial		=3D hfp_query_serial
> +};
> +
> +void hfp_devinfo_init(void)
> +{
> +	ofono_devinfo_driver_register(&driver);
> +}
> +
> +void hfp_devinfo_exit(void)
> +{
> +	ofono_devinfo_driver_unregister(&driver);
> +}

<snip>

Regards,
-Denis

--===============3277646210305895949==--

