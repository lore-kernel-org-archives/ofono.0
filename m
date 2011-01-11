Content-Type: multipart/mixed; boundary="===============2390575199519875468=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 06/10] Define packet switched bearers
Date: Mon, 10 Jan 2011 16:42:58 -0800
Message-ID: <1294706578.3873.11.camel@aeonflux>
In-Reply-To: <1294665325-11937-6-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2390575199519875468==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

>  src/common.c |   15 +++++++++++++++
>  src/common.h |   13 +++++++++++++
>  2 files changed, 28 insertions(+), 0 deletions(-)
> =

> diff --git a/src/common.c b/src/common.c
> index d4e567b..595bc53 100644
> --- a/src/common.c
> +++ b/src/common.c
> @@ -714,6 +714,21 @@ const char *registration_tech_to_string(int tech)
>  	}
>  }
>  =

> +const char *packet_bearer_to_string(int bearer)
> +{
> +	static const char list[][6] =3D {
> +		"none",
> +		"gsm", "edge",
> +		"umts", "hsupa", "hsdpa", "hspa",
> +		"lte",
> +	};
> +
> +	if (((unsigned)bearer) < sizeof (list) / sizeof (list[0]))
> +		return list[bearer];
> +
> +	return "unknown";
> +}

since every other piece inside oFono uses a switch statement for this,
please do the same. And since packet bearer is an enum, please use that
enum as well. If we ever add an additional value, then the compiler will
tell us to adapt this code.

Regards

Marcel



--===============2390575199519875468==--

