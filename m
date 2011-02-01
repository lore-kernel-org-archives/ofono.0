Content-Type: multipart/mixed; boundary="===============6146488240111856499=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] atmodem: implement standard PIN retries
Date: Tue, 01 Feb 2011 13:52:12 +0100
Message-ID: <1296564732.1520.264.camel@aeonflux>
In-Reply-To: <1296478100-24306-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6146488240111856499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

>  drivers/atmodem/sim.c |   48 +++++++++++++++++++++++++++++++++++++++++++=
+++++
>  1 files changed, 48 insertions(+), 0 deletions(-)
> =

> diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
> index 0938998..dfd40f8 100644
> --- a/drivers/atmodem/sim.c
> +++ b/drivers/atmodem/sim.c
> @@ -57,6 +57,7 @@ static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
>  static const char *clck_prefix[] =3D { "+CLCK:", NULL };
>  static const char *huawei_cpin_prefix[] =3D { "^CPIN:", NULL };
>  static const char *xpincnt_prefix[] =3D { "+XPINCNT:", NULL };
> +static const char *cpinr_prefixes[] =3D { "+CPINR:", "+CPINRE:", NULL };
>  static const char *none_prefix[] =3D { NULL };

let's leave it like this. Patch has been applied.

Regards

Marcel



--===============6146488240111856499==--

