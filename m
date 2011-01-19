Content-Type: multipart/mixed; boundary="===============7106131778354963276=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/2] Use standard pkginclude directory
Date: Wed, 19 Jan 2011 12:19:08 +0100
Message-ID: <1295435948.3873.238.camel@aeonflux>
In-Reply-To: <1295433056-26470-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7106131778354963276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> automake automatically defines includedir to the base include directory
> and pkgincludedir to ./@PACKAGE@ from there. So lets use the later one
> instead of overriding automake.
> ---
>  Makefile.am |    9 ++++-----
>  1 files changed, 4 insertions(+), 5 deletions(-)

nice trick. I did not know about this one. Patch has been applied.

Regards

Marcel



--===============7106131778354963276==--

