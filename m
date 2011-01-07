Content-Type: multipart/mixed; boundary="===============0585848271830297898=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] Bearer documentation
Date: Fri, 07 Jan 2011 10:23:25 -0600
Message-ID: <4D273DFD.7020408@gmail.com>
In-Reply-To: <1294416127-22432-3-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0585848271830297898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

On 01/07/2011 10:02 AM, R=C3=A9mi Denis-Courmont wrote:
> ---
>  doc/connman-api.txt |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> =

> diff --git a/doc/connman-api.txt b/doc/connman-api.txt
> index b13efd1..18185d7 100644
> --- a/doc/connman-api.txt
> +++ b/doc/connman-api.txt
> @@ -150,6 +150,16 @@ Properties	boolean Active [readwrite]
>  			Holds whether the context is activated.  This value
>  			can be set to activate / deactivate the context.
>  =

> +		string Bearer [readonly, optional]
> +
> +			Contains the current packet switched bearer of the
> +			connection context.
> +
> +			Possible values are the same as for the Technology
> +			property the NetworkRegistration object, plus
> +			"none" if no data activity is ongoing, or "unknown"
> +			if not known.
> +

Please remove this "unknown" bit.  The property is already optional, so
if it is never reported by the driver we shouldn't report it up, even if
the context is active.

The other question I have is whether we should report this at the
context level or at the ConnectionManager level.  Can different contexts
truly have different bearers?

>  		string AccessPointName [readwrite]
>  =

>  			Holds the name of the access point.  This is

Regards,
-Denis

--===============0585848271830297898==--

