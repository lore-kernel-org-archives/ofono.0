Content-Type: multipart/mixed; boundary="===============8643814429726870867=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/8] gprs-provision: add driver API header
Date: Tue, 18 Jan 2011 15:48:35 +0100
Message-ID: <1295362115.3873.190.camel@aeonflux>
In-Reply-To: <1295338172-12773-2-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8643814429726870867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

<snip>

> +/*
> + * Callback from provisioning plugin.
> + * settings: list of struct ofono_gprs_provision_data
> + *
> + * It is responsibility of callback function to free settings-list
> + * settings-list elements must be freed with ofono_gprs_provision_data_f=
ree()
> + */
> +typedef void (*ofono_gprs_provision_cb_t)(GSList *settings, void *userda=
ta);

so our general rule is no GLib types in oFono public APIs.

> +struct ofono_gprs_provision_driver {
> +	const char *name;
> +	int priority;
> +	int (*probe)(struct ofono_gprs_provision_context *context);
> +	void (*remove)(struct ofono_gprs_provision_context *context);
> +	void (*get_settings) (struct ofono_gprs_provision_context *context,

No space between (get_settings) and (struct please.

> +				ofono_gprs_provision_cb_t cb,
> +				void *user_data);
> +};
> +
> +/* For provisioning drivers/plugins */
> +int ofono_gprs_provision_driver_register(
> +			const struct ofono_gprs_provision_driver *driver);
> +void ofono_gprs_provision_driver_unregister(
> +			const struct ofono_gprs_provision_driver *driver);
> +
> +/* For gprs */
> +void ofono_gprs_provision_data_free(struct ofono_gprs_provision_data *da=
ta);

This sounds more like an __ofono_* internal API kind of thing.

Regards

Marcel



--===============8643814429726870867==--

