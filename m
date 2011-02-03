Content-Type: multipart/mixed; boundary="===============3201573605778823251=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/6] doc: Add documentation for Alphabet property
Date: Thu, 03 Feb 2011 14:40:10 -0600
Message-ID: <4D4B12AA.8010502@gmail.com>
In-Reply-To: <1296739236-24391-7-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3201573605778823251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On 02/03/2011 07:20 AM, Aki Niemi wrote:
> ---
>  doc/message-api.txt |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> =

> diff --git a/doc/message-api.txt b/doc/message-api.txt
> index 1c68aee..d5a7b15 100644
> --- a/doc/message-api.txt
> +++ b/doc/message-api.txt
> @@ -24,3 +24,17 @@ Properties	string State
>  				"pending",
>  				"sent",
>  				"failed"
> +
> +		string Alphabet
> +
> +			Contains the alphabet setting for outgoing SMSs.
> +			Possible values are:
> +
> +				"default" - Default GSM alphabet
> +				"turkish" - Turkish alphabet
> +				"spanish" - Spanish alphabet
> +				"portuguese" - Portuguese alphabet
> +
> +			The standard, language-specific alphabets are defined in
> +			3GPP TS23.038, Annex A.  By default, oFono uses "default"
> +			setting.

Before I look at patch 5, are you sure you want this as a property? I
thought you were a proponent of hiding this in main.conf?

Regards,
-Denis

--===============3201573605778823251==--

