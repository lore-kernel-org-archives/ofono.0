Content-Type: multipart/mixed; boundary="===============6974695793952426090=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] CDMA ConnMan API: add username and password for PPP
 authentication.
Date: Wed, 20 Jul 2011 11:40:08 +0200
Message-ID: <1311154809.21109.184.camel@aeonflux>
In-Reply-To: <1311149272-5251-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6974695793952426090==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

>  doc/cdma-connman-api.txt |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> =

> diff --git a/doc/cdma-connman-api.txt b/doc/cdma-connman-api.txt
> index e486c09..48699a3 100644
> --- a/doc/cdma-connman-api.txt
> +++ b/doc/cdma-connman-api.txt
> @@ -35,6 +35,16 @@ Properties	boolean Powered [readwrite]
>  			Contains whether the connection is dormant.  Will
>  			always be false if the connection is not powered.
>  =

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

as with the previous attempt to add these fields, are they really really
needed? Or is an empty username + password in CHAP also working just
fine?

For GPRS for example all operators are just ignoring these values. At
least the few I have known that required them, gave up on it by now.

So please try with an empty username + password and show us logs of what
is happening on a real network.

Regards

Marcel



--===============6974695793952426090==--

