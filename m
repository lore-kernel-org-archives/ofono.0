Content-Type: multipart/mixed; boundary="===============5591103515443709042=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/8] gps: add public header
Date: Wed, 22 Dec 2010 15:53:45 -0600
Message-ID: <4D127369.60008@gmail.com>
In-Reply-To: <1292531423-22316-4-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5591103515443709042==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

<snip>

> +struct ofono_gps_driver {
> +	const char *name;
> +	int (*probe)(struct ofono_gps *gps, unsigned int vendor, void *data);
> +	void (*remove)(struct ofono_gps *gps);
> +	void (*set_gps)(struct ofono_gps *gps, ofono_bool_t enable,
> +				ofono_gps_set_cb_t, void *data);

I would suggest breaking this up into enable and disable methods.  With
the enable providing additional information to the core, namely:

- NMEA / whatever device node to use
- type of the device

For the type information I suggest defining an enum with the possible
types.  Right now nmea is probably the only thing we want to support...

> +	void (*query_gps)(struct ofono_gps *gps, ofono_gps_query_cb_t cb,
> +				void *data);

I'm currently not sure this query function is really needed.  I think we
should just assume that the gps device is always powered=3Dfalse when the
atom is created.

Regards,
-Denis

--===============5591103515443709042==--

