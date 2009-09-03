Content-Type: multipart/mixed; boundary="===============5285373196275941658=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] G1: Add an SMS quirk for CNMI mode
Date: Thu, 03 Sep 2009 10:56:15 -0500
Message-ID: <200909031056.16232.denkenz@gmail.com>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C968003A49@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5285373196275941658==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Waldo,

> Instead of having vendor checks all over the place, wouldn't it be cleaner
> if the plugin had a way to provide/fix cnmi_opts?

For now we decided to do it this way, since providing arbitrary properties =
per =

atom seemed to be too much.  The hope is that there are not many modems tha=
t =

blatantly lie about what they can do (like the G1)  If quirks get out of ha=
nd =

we can revisit this.

In the meantime if you need to override the entire cnmi string, do somethin=
g =

like:
	if (data->vendor =3D=3D OFONO_VENDOR_WALDOS_MODEM) {
		sprintf(buf, "AT+CNMI=3D....");
		supported =3D TRUE;
	} else if (build_cnmi_string(buf, cnmi_opts, data))
		supported =3D TRUE;

Regards,
-Denis

--===============5285373196275941658==--

