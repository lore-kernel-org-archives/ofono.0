Content-Type: multipart/mixed; boundary="===============3616249255879531261=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] gprs-provision: add driver API header
Date: Tue, 25 Jan 2011 14:59:12 -0600
Message-ID: <4D3F39A0.6080602@gmail.com>
In-Reply-To: <1295957714-21053-2-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3616249255879531261==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

> +/* For gprs */
> +void __ofono_gprs_provision_get_settings(const char *mcc, const char *mn=
c,
> +			const char *spn,
> +			struct ofono_gprs_provision_data **settings,
> +			int *count);

The __ofono prefix implies that this is private ofono API.  Things
declared in include/foo.h are public oFono API.  Since this does not
seem to be a good candidate for public consumption, can you move this
down to src/ofono.h?

> +void provision_settings_free(struct ofono_gprs_provision_data *settings,
> +				int count);

I suggest renaming this to __ofono_gprs_provision_free_settings() and
moving this to src/ofono.h.

Regards,
-Denis

--===============3616249255879531261==--

