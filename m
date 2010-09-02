Content-Type: multipart/mixed; boundary="===============8120935506811416495=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] Add documentation for the Alphabet property
Date: Thu, 02 Sep 2010 12:01:50 -0500
Message-ID: <4C7FD87E.8040905@gmail.com>
In-Reply-To: <1283413960-31490-4-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8120935506811416495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On 09/02/2010 02:52 AM, Aki Niemi wrote:
> ---
>  doc/message-api.txt |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> =

> diff --git a/doc/message-api.txt b/doc/message-api.txt
> index 693a111..9e8ea33 100644
> --- a/doc/message-api.txt
> +++ b/doc/message-api.txt
> @@ -64,3 +64,18 @@ Properties	string ServiceCenterAddress
>  				"ps-preferred" - Use CS if PS is unavailable
>  =

>  			By default oFono uses "cs-preferred" setting.
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
> +				"reduced" - Non-standard extension that adds
> +					translit support to the default alphabet
> +
> +			The standard, language-specific alphabets are defined in
> +			3GPP TS23.038, Annex A.

I want to hear everyone's thoughts on whether this should be in
ofono/main.conf or an actual property.  We still never decides this...

Regards,
-Denis

--===============8120935506811416495==--

