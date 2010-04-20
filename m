Content-Type: multipart/mixed; boundary="===============1280210407046749704=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 05/17] Add parser for service record objects
Date: Tue, 20 Apr 2010 16:55:53 -0500
Message-ID: <201004201655.53317.denkenz@gmail.com>
In-Reply-To: <1271744112-32285-5-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1280210407046749704==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> +	sr->serv_rec =3D g_try_malloc(sr->len);
> +	if (sr->serv_rec =3D=3D NULL)
> +		return FALSE;

I suggest not trying to allocate 0 bytes.

Regards,
-Denis

--===============1280210407046749704==--

