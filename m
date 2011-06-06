Content-Type: multipart/mixed; boundary="===============8373048047225878165=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] fix can't attach GPRS issue
Date: Sun, 05 Jun 2011 21:00:13 -0500
Message-ID: <4DEC34AD.4080703@gmail.com>
In-Reply-To: <0E7E5CACD8E9F248AA009C292CC772A0755BE2@ALA-MBA.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8373048047225878165==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

> gprs_netreg_update() is the only place to change CGATT automatically.
> =

> Following are the code of gprs_netreg_update().
> =

> 	ofono_bool_t attach;
> =

> 	attach =3D gprs->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_REGIST=
ERED;
> =

> 	attach =3D attach || (gprs->roaming_allowed &&
> 		gprs->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING);
> =

> 	attach =3D attach && gprs->powered;
> =

> 	if (gprs->driver_attached =3D=3D attach)
> 		return;
> =

> As my comment above, because gprs->netreg_status is 1(NETWORK_REGISTRATIO=
N_STATUS_REGISTERED)
> and gprs->driver_attached is TRUE. So (gprs->driver_attached =3D=3D attac=
h). This function always
> return here, unless, the value of gprs->netreg_status or gprs->driver_att=
ached is changed.
> =


This is by design, I don't see anything inherently wrong here.
Remember, gprs_netreg_update is called from many places and this sanity
check is needed.

> As gprs_netreg_update() always returns here, so gprs->driver_attached won=
't be changed.
> So unless the network registration status changes to unregistered then re=
gistered again,
> it won't attach GPRS again.
> =


But the CREG status is being toggled like crazy. Once CREG goes to
unregistered / searching we detach and set driver_attached to FALSE.  It
sounds like your explanation isn't correct.

Regards,
-Denis

--===============8373048047225878165==--

