Content-Type: multipart/mixed; boundary="===============7473820772847233058=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/9] doc: add lte atom documentation
Date: Wed, 09 Nov 2016 14:41:04 -0600
Message-ID: <582389E0.3070309@gmail.com>
In-Reply-To: <1478713402-30780-7-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7473820772847233058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dragos,

On 11/09/2016 11:43 AM, Dragos Tatulea wrote:
> ---
>   doc/lte-api.txt | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
>   create mode 100644 doc/lte-api.txt
>
> diff --git a/doc/lte-api.txt b/doc/lte-api.txt
> new file mode 100644
> index 0000000..dfefaf4
> --- /dev/null
> +++ b/doc/lte-api.txt
> @@ -0,0 +1,35 @@
> +LTE Hierarchy
> +
> +Service		org.ofono
> +Interface	org.ofono.LTE

So oFono tries not to use abbreviations in its API.  How about we simply =

name this LongTermEvolution

> +Object path	[variable prefix]/{modem0,modem1,...}
> +
> +
> +Methods		dict GetProperties()
> +
> +			Returns all LTE configuration properties.
> +
> +		void SetProperty(string property, variant value)
> +
> +			Changes the value of the specified property. Only
> +			properties that are listed as readwrite are
> +			changeable. On success a PropertyChanged signal
> +			will be emitted.
> +
> +			Possible Errors: [service].Error.InProgress
> +					 [service].Error.InvalidArguments
> +					 [service].Error.Failed
> +
> +Signals		PropertyChanged(string property, variant value)
> +
> +			This signal indicates a changed value of the given
> +			property.
> +
> +Properties	string DefaultAPN [readwrite]

To be consistent with ConnectionContext, which spells out APN as =

'AccessPointName', we do something like DefaultAccessPointName

> +
> +			On LTE, contexts activate automatically. This property
> +			allows selection of an APN to be used on next
> +			automatic activation.
> +
> +			Setting this property to an empty string clears the
> +			default APN from the modem.
>

Why do you have the protocol in Patch 1?  Do you want to include this here ?

Regards,
-Denis

--===============7473820772847233058==--

