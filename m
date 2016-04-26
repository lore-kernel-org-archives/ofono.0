Content-Type: multipart/mixed; boundary="===============1174576654856842941=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH v2 1/2] configure: Bump glib dependecy to 2.32
Date: Tue, 26 Apr 2016 09:39:30 +0200
Message-ID: <1444edf3-d876-9dd1-0cd2-0a84ed8760a2@monom.org>
In-Reply-To: <1461651574-31530-2-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1174576654856842941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 04/26/2016 08:19 AM, John Ernberg wrote:

> -PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.28, dummy=3Dyes,
> -				AC_MSG_ERROR(GLib >=3D 2.28 is required))
> +PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.32, dummy=3Dyes,
> +				AC_MSG_ERROR(GLib >=3D 2.32 is required))

Some time ago we had a discussion on the ConnMan mailing list doing the
same thing. IIRC, 2.32 has a larger memory footprint compared to 2.28.
That was an issue back than. Don't know if that is still relevant.

cheers,
daniel

--===============1174576654856842941==--

