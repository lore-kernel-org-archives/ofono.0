Content-Type: multipart/mixed; boundary="===============6855116668258659746=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/4] radio settings: document FastDormancy property
Date: Thu, 07 Oct 2010 17:34:28 +0200
Message-ID: <1286465668.6145.155.camel@aeonflux>
In-Reply-To: <1286458653-12096-4-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6855116668258659746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

> diff --git a/doc/radio-settings-api.txt b/doc/radio-settings-api.txt
> index 3372abd..f1b91ad 100644
> --- a/doc/radio-settings-api.txt
> +++ b/doc/radio-settings-api.txt
> @@ -41,3 +41,25 @@ Properties	string TechnologyPreference [read-write]
>  				"gsm"	Only GSM used for radio access.
>  				"umts"	Only UMTS used for radio access.
>  				"lte"	Only LTE used for radio acccess.
> +
> +		boolean	FastDormancy [read-write, optional]
> +
> +			This property will enable or disable fast
> +			dormancy. Fast dormancy refers to UE initiated
> +			release of radio resources quickly after a
> +			burst of data transfer has ended. Normally,
> +			radio resources are released by the network
> +			after a timeout configured by the network
> +			operator. Fast dormancy allows the modem to
> +			release radio resources more quickly.
> +			Typically, fast dormancy would be enabled if
> +			no data transfer is predicted to occur in the
> +			near future, for instance, when the end user
> +			is not actively using the device. This is a
> +			major power-saving feature for mobile devices,
> +			but can be ignored for USB sticks or PCI
> +			devices.

so how does the future prediction is suppose to work. Are we shipping a
time machine together with oFono ;)

Regards

Marcel



--===============6855116668258659746==--

