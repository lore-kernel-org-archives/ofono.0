Content-Type: multipart/mixed; boundary="===============4994150059644386647=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 05/10] Update documentation for GPRS technology
Date: Mon, 10 Jan 2011 16:31:00 -0800
Message-ID: <1294705860.3873.4.camel@aeonflux>
In-Reply-To: <1294665325-11937-5-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4994150059644386647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

>  doc/connman-api.txt |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> =

> diff --git a/doc/connman-api.txt b/doc/connman-api.txt
> index 22e02e5..b13efd1 100644
> --- a/doc/connman-api.txt
> +++ b/doc/connman-api.txt
> @@ -77,6 +77,14 @@ Properties	boolean Attached [readonly]
>  			be available, e.g. receiving SMS over packet radio
>  			or network initiated PDP activation.
>  =

> +		string Technology [readonly, optional]
> +
> +			Contains the data technology as reported by the
> +			GPRS service registration (if known).
> +
> +			Possible values are the same as for the Technology
> +			property the NetworkRegistration object.
> +

we used to have this value and then we removed it since it ended up
being not useful. So why do you wanna bring it back?

Regards

Marcel



--===============4994150059644386647==--

