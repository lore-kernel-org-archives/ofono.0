Content-Type: multipart/mixed; boundary="===============5018655015286456894=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/7] Interrogation of a barring does not require password.
Date: Thu, 18 Mar 2010 11:44:09 -0500
Message-ID: <201003181144.09852.denkenz@gmail.com>
In-Reply-To: <1268923471-29059-5-git-send-email-ppessi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5018655015286456894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> +	if (type !=3D SS_CONTROL_TYPE_QUERY && !is_valid_password(sia))
>  		goto bad_format;

I applied this patch with slight modification until is_valid_pin is fixed.

Regards,
-Denis

--===============5018655015286456894==--

