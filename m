Content-Type: multipart/mixed; boundary="===============2795227655944428669=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 3/9] gps: add public header
Date: Thu, 13 Jan 2011 11:33:22 -0600
Message-ID: <4D2F3762.3030604@gmail.com>
In-Reply-To: <1294716238-21218-4-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2795227655944428669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

> +
> +#include <ofono/types.h>
> +
> +struct ofono_gps;
> +
> +enum ofono_gps_device_type {
> +	OFONO_GPS_DEVICE_TYPE_NMEA =3D 0,
> +};
> +
> +typedef void (*ofono_gps_enable_cb_t)(const struct ofono_error *error,
> +					enum ofono_gps_device_type type,
> +					const char *device,
> +					void *data);

This function's signature would be modified to receive an int fd instead
of type and device.

> +typedef void (*ofono_gps_disable_cb_t)(const struct ofono_error *error,
> +								void *data);
> +
> +struct ofono_gps_driver {
> +	const char *name;

This structure should contain enum ofono_gps_device_type type member.

> +	int (*probe)(struct ofono_gps *gps, unsigned int vendor, void *data);
> +	void (*remove)(struct ofono_gps *gps);
> +	void (*enable)(struct ofono_gps *gps,
> +					ofono_gps_enable_cb_t cb, void *data);
> +	void (*disable)(struct ofono_gps *gps,
> +					ofono_gps_disable_cb_t cb, void *data);
> +};
> +

The rest is left more or less as is.

Regards,
-Denis

--===============2795227655944428669==--

