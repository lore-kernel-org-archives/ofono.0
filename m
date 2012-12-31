Content-Type: multipart/mixed; boundary="===============4892527753682513971=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/8] sierramodem: Add skeleton cdma netreg driver
Date: Sun, 30 Dec 2012 20:11:21 -0600
Message-ID: <50E0F449.1080907@gmail.com>
In-Reply-To: <20121228193458.GH18339@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4892527753682513971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Forest,

> +static int sierra_cdma_netreg_probe(struct ofono_cdma_netreg *netreg,
> +				unsigned int vendor, void *chat)
> +{
> +	struct sierra_netreg_data *data;
> +
> +	data =3D g_try_new0(struct sierra_netreg_data, 1);
> +	if (data =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	ofono_cdma_netreg_set_data(netreg, data);
> +
> +	data->chat =3D g_at_chat_clone(chat);
> +
> +	ofono_cdma_netreg_register(netreg);

In general one cannot call register from the probe function.  You should =

be using an idle callback here

> +
> +	return 0;
> +}

Regards,
-Denis

--===============4892527753682513971==--

