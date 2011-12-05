Content-Type: multipart/mixed; boundary="===============6352785520371957718=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH_v1 1/2] doc: Add RoamingAllowed property
Date: Mon, 05 Dec 2011 15:03:49 +0100
Message-ID: <4EDCCF45.9080207@linux.intel.com>
In-Reply-To: <1323083042-24416-2-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6352785520371957718==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 05/12/2011 12:04, Guillaume Zajac wrote:
> ---
>   doc/cdma-connman-api.txt |    8 ++++++++
>   1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/doc/cdma-connman-api.txt b/doc/cdma-connman-api.txt
> index 48699a3..319c973 100644
> --- a/doc/cdma-connman-api.txt
> +++ b/doc/cdma-connman-api.txt
> @@ -45,6 +45,14 @@ Properties	boolean Powered [readwrite]
>   			Holds the password to be used for authentication
>   			purposes.
>
> +		boolean RoamingAllowed [readwrite]
> +
> +			Contains whether data roaming is allowed.  In the off
> +			setting, if the packet radio registration state
> +			indicates that the modem is roaming, oFono will
> +			automatically shutdown connection and no further
> +			connection establishment will be possible.
> +

The documentation is not up-to-date with the implementation.
Please ignore this set of patches, I will send a v2.

>   		dict Settings [readonly, optional]
>
>   			Holds all the IP network settings

Kind regards,
Guillaume

--===============6352785520371957718==--

