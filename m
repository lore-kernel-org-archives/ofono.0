Content-Type: multipart/mixed; boundary="===============5767972256578530080=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v0 1/5] doc: Add bearer property
Date: Wed, 30 Nov 2011 03:30:23 -0600
Message-ID: <4ED5F7AF.5050908@gmail.com>
In-Reply-To: <1322834454-451-2-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5767972256578530080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 12/02/2011 08:00 AM, Guillaume Zajac wrote:
> ---
>  doc/cdma-connman-api.txt |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> =

> diff --git a/doc/cdma-connman-api.txt b/doc/cdma-connman-api.txt
> index 48699a3..bf1ec1e 100644
> --- a/doc/cdma-connman-api.txt
> +++ b/doc/cdma-connman-api.txt
> @@ -35,6 +35,14 @@ Properties	boolean Powered [readwrite]
>  			Contains whether the connection is dormant.  Will
>  			always be false if the connection is not powered.
>  =

> +		string Bearer [readonly, optional]
> +
> +			Contains the data bearer technology as reported by the
> +			service registration (if known).
> +
> +			Possible values are:
> +			"none", "1x", "evdo", "svdo"
> +

The 1X and EVDO registration status is already handled by the
NetworkRegistration interface (namely Strength for 1X and DataStrength
for EV-DO).

Whether we need an SVDO indicator is another question entirely, but it
definitely does not belong in ConnectionManager.  All SVDO indicates is
whether data + voice are possible simultaneously.

>  		string Username [readwrite]
>  =

>  			Holds the username to be used for authentication

Regards,
-Denis

--===============5767972256578530080==--

