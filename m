Content-Type: multipart/mixed; boundary="===============3222897194269727594=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] Define packet switched bearers
Date: Fri, 07 Jan 2011 10:23:34 -0600
Message-ID: <4D273E06.1000302@gmail.com>
In-Reply-To: <1294416127-22432-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3222897194269727594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

On 01/07/2011 10:02 AM, R=C3=A9mi Denis-Courmont wrote:
> ---
>  src/common.c |   14 ++++++++++++++
>  src/common.h |   13 +++++++++++++
>  2 files changed, 27 insertions(+), 0 deletions(-)
> =

> diff --git a/src/common.c b/src/common.c
> index d4e567b..6664007 100644
> --- a/src/common.c
> +++ b/src/common.c
> @@ -714,6 +714,20 @@ const char *registration_tech_to_string(int tech)
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
> +	return "unknown";

doc/coding-style.txt rule M1

Also, please drop the unknown bit and return ""

> +}
> +
>  gboolean is_valid_apn(const char *apn)
>  {
>  	int i;
> diff --git a/src/common.h b/src/common.h
> index 64f297e..d11cd8e 100644
> --- a/src/common.h
> +++ b/src/common.h
> @@ -87,6 +87,18 @@ enum bearer_class {
>  	BEARER_CLASS_PAD =3D 128
>  };
>  =

> +/* 27.007 Section 7.29 */
> +enum packet_bearer {
> +	PACKET_BEARER_NONE =3D 0,
> +	PACKET_BEARER_GPRS =3D 1,
> +	PACKET_BEARER_EDGE =3D 2,
> +	PACKET_BEARER_UMTS =3D 3,
> +	PACKET_BEARER_HSUPA =3D 4,
> +	PACKET_BEARER_HSDPA =3D 5,
> +	PACKET_BEARER_HSUPA_HSDPA =3D 6,
> +	PACKET_BEARER_LTE =3D 7,
> +};
> +

doc/coding-style.txt rule M11

>  /* 22.030 Section 6.5.2 */
>  enum ss_control_type {
>  	SS_CONTROL_TYPE_ACTIVATION,
> @@ -158,5 +170,6 @@ gboolean is_valid_pin(const char *pin, enum pin_type =
type);
>  =

>  const char *registration_status_to_string(int status);
>  const char *registration_tech_to_string(int tech);
> +const char *packet_bearer_to_string(int bearer);
>  =

>  gboolean is_valid_apn(const char *apn);

Regards,
-Denis

--===============3222897194269727594==--

