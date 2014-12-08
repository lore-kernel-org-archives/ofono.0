Content-Type: multipart/mixed; boundary="===============8337949853200611871=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] doc: Add ModemTechnologies property
Date: Sun, 07 Dec 2014 22:11:48 -0600
Message-ID: <54852504.1000500@gmail.com>
In-Reply-To: <1417797991-19700-2-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8337949853200611871==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alfonso,

On 12/05/2014 10:46 AM, Alfonso Sanchez-Beato wrote:
> This new property in org.ofono.RadioSettings interface will hold the
> possible values for radio access technology for the modem.
> ---
>   doc/radio-settings-api.txt | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/doc/radio-settings-api.txt b/doc/radio-settings-api.txt
> index 9f9256f..cbeac3b 100644
> --- a/doc/radio-settings-api.txt
> +++ b/doc/radio-settings-api.txt
> @@ -45,6 +45,11 @@ Properties	string TechnologyPreference [readwrite]
>   				"umts"	Only UMTS used for radio access.
>   				"lte"	Only LTE used for radio access.
>
> +		array{string} ModemTechnologies [readonly, optional]
> +

Lets name this AvailableTechnologies

> +			List of values for TechnologyPreference property
> +			supported by the modem.
> +
>   		string GsmBand [readwrite, optional]
>
>   			Frequency band in which the modem is allowed to
>

Regards,
-Denis

--===============8337949853200611871==--

