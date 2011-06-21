Content-Type: multipart/mixed; boundary="===============7059421617351224163=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] doc: Add dial-number/username/password Property
Date: Tue, 21 Jun 2011 10:07:51 -0500
Message-ID: <4E00B3C7.6000405@gmail.com>
In-Reply-To: <1308649987-2438-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7059421617351224163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 06/21/2011 04:53 AM, Caiwen Zhang wrote:
> Some network's dial-number isn't #777 and user name and password
> are required when setup data connection. =

> =

> ---
>  doc/cdma-connman-api.txt |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> =

> diff --git a/doc/cdma-connman-api.txt b/doc/cdma-connman-api.txt
> index e486c09..f76a2c5 100644
> --- a/doc/cdma-connman-api.txt
> +++ b/doc/cdma-connman-api.txt
> @@ -35,6 +35,20 @@ Properties	boolean Powered [readwrite]
>  			Contains whether the connection is dormant.  Will
>  			always be false if the connection is not powered.
>  =

> +		string DialNumber [readwrite]
> +
> +			Holds the dialed number.
> +

We discussed this during the oFono CDMA workshop and the consensus was
that this is not needed in practice.

> +		string Username [readwrite]
> +
> +			Holds the username to be used for authentication
> +			purposes.
> +
> +		string Password [readwrite]
> +
> +			Holds the password to be used for authentication
> +			purposes.
> +

We discussed these as well and the consensus was that these are probably
not needed.  If we ever come across a network that does, then we can
re-examine this decision.

>  		dict Settings [readonly, optional]
>  =

>  			Holds all the IP network settings

Regards,
-Denis

--===============7059421617351224163==--

