Content-Type: multipart/mixed; boundary="===============6017410771486122790=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH_v3] speedupcdma: add speedup cdma skeleton plugin
Date: Wed, 20 Jul 2011 13:47:42 +0200
Message-ID: <1311162463.21109.211.camel@aeonflux>
In-Reply-To: <1311159814-15997-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6017410771486122790==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

> Remove unused variable into speedupcdma_remove()

<snip>

> +static void speedupcdma_remove(struct ofono_modem *modem)
> +{
> +	DBG("%p", modem);
> +
> +	ofono_modem_set_data(modem, NULL);
> +}

You do actually have to free the data. Otherwise you are leaking memory.

Regards

Marcel



--===============6017410771486122790==--

