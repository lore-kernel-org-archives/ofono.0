Content-Type: multipart/mixed; boundary="===============8593455968948817836=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 06/15] doc: Handsfree exposes supported AG features
Date: Thu, 20 Oct 2011 20:36:25 -0500
Message-ID: <4EA0CC99.80304@gmail.com>
In-Reply-To: <1319128700-15841-7-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8593455968948817836==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

On 10/20/2011 11:38 AM, Mikel Astiz wrote:
> ---
>  doc/handsfree-api.txt |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> =

> diff --git a/doc/handsfree-api.txt b/doc/handsfree-api.txt
> index 9355946..12cfe62 100644
> --- a/doc/handsfree-api.txt
> +++ b/doc/handsfree-api.txt
> @@ -38,7 +38,14 @@ Signals		PropertyChanged(string property, variant valu=
e)
>  			Signal is emitted whenever a property has changed.
>  			The new value is passed as the signal argument.
>  =

> -Properties	boolean InbandRinging [readonly]
> +Properties	array{string} Features [readonly]
> +
> +			List of features supported by the AG. The currently
> +			supported values are:
> +				"VoiceRecognition"
> +				"AttachVoiceTag"
> +

Please use small caps and hyphens for values, e.g. 'voice-recognition',
'attach-voice-tag', etc.  See other BlueZ/oFono/ConnMan style APIs for
details.  Only properties and functions are CamelCased.

> +		boolean InbandRinging [readonly]
>  =

>  			Boolean representing whether inband ringing is enabled.
>  =


Regards,
-Denis

--===============8593455968948817836==--

