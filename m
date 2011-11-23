Content-Type: multipart/mixed; boundary="===============4725518078925510295=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v0 32/32] modem: Update documation on ModemType
Date: Tue, 22 Nov 2011 20:44:02 -0600
Message-ID: <4ECC5DF2.3030309@gmail.com>
In-Reply-To: <1321981801-5452-33-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4725518078925510295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On 11/22/2011 11:10 AM, Daniel Wagner wrote:
> From: Daniel Wagner <daniel.wagner@bmw-carit.de>
> =

> Indicate the kind of modem it is before it is powered up.
> ---
>  doc/modem-api.txt |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> =


I applied this patch, but changed...

> diff --git a/doc/modem-api.txt b/doc/modem-api.txt
> index fa400a2..8a11bd4 100644
> --- a/doc/modem-api.txt
> +++ b/doc/modem-api.txt
> @@ -98,3 +98,14 @@ Properties	boolean Powered [readwrite]
>  =

>  			TODO: Better to split this into Status and
>  			      Capabilites properties?
> +
> +		string ModemType [readonly]

this to use 'Type' instead of 'ModemType'

> +
> +			Indicates whether the modem is virtual or a real
> +			hardware one. This information should only be used
> +			to identify which componet (e.g. ConnMan or a phone
> +			dialer) should take control over the modem. It does
> +			not give any hints on which Interfaces will be
> +			supported by this modem.
> +
> +			Possible values are "hfp", "sap" and "hardware".

Regards,
-Denis

--===============4725518078925510295==--

