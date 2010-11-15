Content-Type: multipart/mixed; boundary="===============3426966571130941521=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 5/5] Makefile: add call counters to the build
Date: Mon, 15 Nov 2010 17:13:55 +0100
Message-ID: <1289837635.3266.126.camel@aeonflux>
In-Reply-To: <c00e972ede1dd58920d80c763b05a5d871637358.1289819191.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3426966571130941521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

>  Makefile.am |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> =

> diff --git a/Makefile.am b/Makefile.am
> index f841b4c..a1c6097 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -295,6 +295,9 @@ builtin_modules +=3D example_nettime
>  builtin_sources +=3D examples/nettime.c
>  endif
>  =

> +builtin_modules +=3D cc
> +builtin_sources +=3D src/callcounters.c
> +

what is this? Plugins do not belong under src/. That is reserved for
oFono core functionality only.

Regards

Marcel



--===============3426966571130941521==--

