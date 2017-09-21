Content-Type: multipart/mixed; boundary="===============8357326787982681215=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/7] doc: documentation for SimAuth dbus interfaces
Date: Thu, 21 Sep 2017 18:02:27 -0500
Message-ID: <b552baf5-83c1-cb8e-0816-9a43d51c7dbe@gmail.com>
In-Reply-To: <1506017520-22482-7-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8357326787982681215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 09/21/2017 01:12 PM, James Prestwood wrote:
> ---
>   doc/sim-auth-api.txt | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>   create mode 100644 doc/sim-auth-api.txt
> =

> diff --git a/doc/sim-auth-api.txt b/doc/sim-auth-api.txt
> new file mode 100644
> index 0000000..466ca3a
> --- /dev/null
> +++ b/doc/sim-auth-api.txt
> @@ -0,0 +1,27 @@
> +SimAuth USIM application heiarchy [experimental]
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service		org.ofono
> +
> +Interface	org.ofono.USimApplication
> +Object path	[variable prefix]/{modem0,modem1,...}
> +
> +Methods		array{byte},array{byte} GSMAuthenticate(array{byte} rand)

We like our CamelCase, so GsmAuthenticate

> +
> +			Run the USIM application GSM AUTHENTICATE algorithm
> +			with the random challenge 'rand'. Returns the derived
> +			SRES and KC values as two arrays of bytes.
> +
> +			Possible Errors: [service].Error.NotSupported

USim Application can run both the GSM (if service 38 is available) and =

3G security context, right?  So there might need to be two methods here:
	GsmAuthenticate
	UmtsAuthenticate

> +
> +Interface	org.ofono.ISimApplication
> +
> +Methods		dict UMTSAuthenticate(array{byte} rand, array{byte} autn)

UmtsAuthenticate

> +
> +			Run the ISIM applications UMTS AUTHENTICATE algorithm
> +			with 'rand' and 'autn'. A dictionary will be returned
> +			containing either 'res', 'ck' and 'ik' OR 'auts'.

Also, according to 31.102 the Kc could also be returned.

> +			A dict containing 'auts' signifies there was a sync
> +			failure.

ISimApplication runs AKA-IMS security context, so maybe 'ImsAuthenticate'?

> +
> +			Possible Errors: [service].Error.NotSupported
> =


So to summarize.  USimApplication would have two methods, and =

ISimApplication would have one.  Eventually we can add SimApplication =

for 2G SIMs, but that isn't a priority.

Regards,
-Denis

--===============8357326787982681215==--

