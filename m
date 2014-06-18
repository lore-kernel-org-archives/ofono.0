Content-Type: multipart/mixed; boundary="===============7971576944535118680=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] gprs: make PPP authentication method configurable
Date: Wed, 18 Jun 2014 17:27:36 -0500
Message-ID: <53A21258.2080700@gmail.com>
In-Reply-To: <1403042279-20598-3-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7971576944535118680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philip,

On 06/17/2014 04:57 PM, Philip Paeps wrote:
> Add a new "AuthMethod" property to select between "pap" and "chap" PPP
> authentication, defaulting to "chap" (i.e.: previous behaviour).
> =

> Signed-off-by: Philip Paeps <philip@paeps.cx>

No signed-off-by please...

> ---
>  doc/connman-api.txt            |    4 ++
>  drivers/atmodem/gprs-context.c |   14 +++++++
>  include/gprs-context.h         |    6 +++
>  src/gprs.c                     |   81 ++++++++++++++++++++++++++++++++++=
++++++

Please break this up into separate patches.  See HACKING, 'Submitting
Patches' section.

>  4 files changed, 105 insertions(+)
> =

> diff --git a/doc/connman-api.txt b/doc/connman-api.txt
> index 2227ab8..6347a8c 100644
> --- a/doc/connman-api.txt
> +++ b/doc/connman-api.txt
> @@ -180,6 +180,10 @@ Properties	boolean Active [readwrite]
>  				"wap" - Used by WAP related services
>  				"ims" - Used by IMS related services
>  =

> +		string AuthMethod [readwrite]
> +			Holds the PPP authentication method to use.  Valid
> +			values are "pap" and "chap".  Defaults to "chap".
> +

Please name this AuthenticationType or AuthenticationMethod.

>  		string Username [readwrite]
>  =

>  			Holds the username to be used for authentication

Otherwise, the rest looks fine to me

Regards,
-Denis

--===============7971576944535118680==--

