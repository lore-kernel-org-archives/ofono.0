Content-Type: multipart/mixed; boundary="===============4323319106340823126=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 3/3] doc: Add SystemPath to Modem interface
Date: Mon, 19 Feb 2018 16:36:36 +0100
Message-ID: <ce6ae2ee-8c43-ef67-18a3-01b6436536cf@southpole.se>
In-Reply-To: <1519052234-13973-4-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4323319106340823126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 02/19/2018 03:57 PM, Christophe Ronco wrote:
> ---
>   doc/modem-api.txt | 8 ++++++++
>   1 file changed, 8 insertions(+)
> =

> diff --git a/doc/modem-api.txt b/doc/modem-api.txt
> index 89e6191..e03c64a 100644
> --- a/doc/modem-api.txt
> +++ b/doc/modem-api.txt
> @@ -95,6 +95,14 @@ Properties	boolean Powered [readwrite]
>   			String representing the software version number of the
>   			modem device.
>   =

> +		string SystemPath [readonly, optional]
> +
> +			String giving a consistent hardware path for the modem
> +			device. It will not change in case of reboot of modem
> +			or ofono.

Given that many modems are USB devices, I don't think you can actually =

promise this.  I can envision a (slightly pathological) hardware design =

whereby the presence or absence of an _external_ device at startup may =

change the device enumeration order and thereby the syspath...

/Jonas

> +			For modems detected by udev events, gives modem sysfs
> +			path.
> +
>   		array{string} Features [readonly]
>   =

>   			List of currently enabled features. It uses simple
> =



--===============4323319106340823126==--

