Content-Type: multipart/mixed; boundary="===============3868410895953508393=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/3] Add Palm Pre plugin
Date: Tue, 10 Nov 2009 09:15:45 +0100
Message-ID: <1257840945.3024.13.camel@violet>
In-Reply-To: <1257834623-22438-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3868410895953508393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrzej,

> +static void palmpre_remove(struct ofono_modem *modem)
> +{
> +	struct palmpre_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	g_free(data);
> +	ofono_modem_set_data(modem, NULL);
> +}

Never ever do it this way. The set_data(..., NULL) must come before
freeing the data. Otherwise it potentially opens a can of race
conditions.

Regards

Marcel



--===============3868410895953508393==--

