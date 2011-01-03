Content-Type: multipart/mixed; boundary="===============3959321131397908072=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC sim-authenticate PATCH 2/3] Added
 doc/sim-authentication-api.txt.
Date: Mon, 03 Jan 2011 12:22:23 -0800
Message-ID: <1294086143.5852.4.camel@aeonflux>
In-Reply-To: <1294066701-27298-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3959321131397908072==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> The EAP applications on SIM should be handled separately. The
> EapSimAuthenticate and EapAkaAuthenticate do not require a special EAP
> application on SIM, but they use ordinary cellular authentication.
> ---
>  doc/sim-authentication-api.txt |   66 ++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 66 insertions(+), 0 deletions(-)
>  create mode 100644 doc/sim-authentication-api.txt
> =

> diff --git a/doc/sim-authentication-api.txt b/doc/sim-authentication-api.=
txt
> new file mode 100644
> index 0000000..9a033bf
> --- /dev/null
> +++ b/doc/sim-authentication-api.txt
> @@ -0,0 +1,66 @@
> +SimAuthentication hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +Service		org.ofono
> +Interface	org.ofono.SimAuthentication
> +Object path	[variable prefix]/{modem0,modem1,...}
> +
> +Methods		byte{array} EapSimAuthenticate(array{byte} rand)
> +
> +			Executes the SIM authentication algorithm for
> +			RFC 4186 EAP SIM authentication method.
> +
> +			The input parameter is RAND, a 16-byte array.
> +			In case of successful authentication operation
> +			the SRES parameter is returned as a 4-byte array.
> +
> +			Possible Errors: [service].Error.InvalidArguments
> +				 	 [service].Error.NotImplemented
> +
> +		dict EapAkaAuthenticate(array{byte} rand, array{byte} autn)

so I would rather have an interface where you can discover the supported
authentication applications on the SIM card and then have one interface
to execute them.

The application using this interface needs somehow to know what methods
are available and not do some try and error execution.

The EAP SIM is a subset of any proper AKA mechanism, but that should be
fine as well. Just having an empty AUTN array seems fine to me.

Regards

Marcel



--===============3959321131397908072==--

