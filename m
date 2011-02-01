Content-Type: multipart/mixed; boundary="===============6880336138515770431=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 2/3] udev: u8500 support and style fix
Date: Tue, 01 Feb 2011 17:12:01 +0100
Message-ID: <1296576721.1520.274.camel@aeonflux>
In-Reply-To: <4D482CFE.2060801@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6880336138515770431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

> >> diff --git a/plugins/udev.c b/plugins/udev.c
> >> index ce1efe6..49b5eb8 100644
> >> --- a/plugins/udev.c
> >> +++ b/plugins/udev.c
> >> @@ -185,7 +185,8 @@ static void add_hso(struct ofono_modem *modem,
> >>   		devnode =3D udev_device_get_devnode(udev_device);
> >>
> >>   		if (g_str_has_suffix(type, "Application") =3D=3D TRUE)
> >> -			ofono_modem_set_string(modem, APPLICATION_PORT, devnode);
> >> +			ofono_modem_set_string(modem, APPLICATION_PORT,
> >> +						devnode);
> >
> > What is this part doing here?
> =

> Style fix, should it be removed ?

style fixes should always be a separate patch. Do not intermix totally
unrelated style fixes with actual changes.

Regards

Marcel



--===============6880336138515770431==--

