Content-Type: multipart/mixed; boundary="===============5742290912312973344=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 06/17] Add parser for device filter objects
Date: Tue, 20 Apr 2010 16:56:44 -0500
Message-ID: <201004201656.45147.denkenz@gmail.com>
In-Reply-To: <1271744112-32285-6-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5742290912312973344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> +	df->dev_filter =3D g_try_malloc(df->len);
> +	if (df->dev_filter =3D=3D NULL)
> +		return FALSE;

Again, you might want to handle 0 byte objects here or error out.

Regards,
-Denis

--===============5742290912312973344==--

