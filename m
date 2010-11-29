Content-Type: multipart/mixed; boundary="===============6257904847586426278=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] configure: do not hard-code the C run-time library name
Date: Mon, 29 Nov 2010 10:20:01 +0100
Message-ID: <1291022401.4795.14.camel@aeonflux>
In-Reply-To: <1291019342-20747-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6257904847586426278==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> Since oFono does (obviously) not use -nostdlib, this only broke support
> for alternative C run-times.
> ---
>  configure.ac |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

looks good enough to me. Patch has been applied.

Regards

Marcel



--===============6257904847586426278==--

