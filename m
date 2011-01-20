Content-Type: multipart/mixed; boundary="===============8985181057078608891=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] gprs-provision: add driver API header
Date: Thu, 20 Jan 2011 15:51:34 -0600
Message-ID: <4D38AE66.8030805@gmail.com>
In-Reply-To: <1295529099-21082-2-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8985181057078608891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

> +/*
> + * Callback from provisioning plugin.
> + */
> +typedef void (*ofono_gprs_provision_cb_t)(
> +			const struct ofono_gprs_provision_data settings[],
> +			int count, void *user_data);
> +
> +struct ofono_gprs_provision_driver {
> +	const char *name;
> +	int priority;
> +	int (*probe)(struct ofono_gprs_provision_context *context);
> +	void (*remove)(struct ofono_gprs_provision_context *context);
> +	void (*get_settings)(struct ofono_gprs_provision_context *context,
> +				ofono_gprs_provision_cb_t cb,
> +				void *user_data);
> +};

So I don't really see the point in an asynchronous provisioning driver.
 If you want to do this over D-Bus or something then you might as well
provision via the ConnectionManager interface.  The other problem with
being async is that is nearly impossible to support multiple
provisioning plugins properly.  I'd rather not deal with the race
conditions.

If we can't make the lookup fast enough to be done synchronously, then I
think we should give up.

I also don't see the point of instantiating these per modem.  The API
already has all the information it needs in the get_settings call.  So
having the plugin allocate its data in the plugin init function and free
it there seems enough to me.

Regards,
-Denis

--===============8985181057078608891==--

