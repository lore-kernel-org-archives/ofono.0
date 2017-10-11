Content-Type: multipart/mixed; boundary="===============2779681406283643842=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 11/11] doc: documentation for SimAuth dbus interfaces
Date: Wed, 11 Oct 2017 10:57:15 -0500
Message-ID: <515bc63f-eccf-dee6-fa7b-ced58287fc26@gmail.com>
In-Reply-To: <1507671380-7625-11-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2779681406283643842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/10/2017 04:36 PM, James Prestwood wrote:
> ---
>   doc/sim-auth-api.txt | 78 +++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 78 insertions(+)
>   create mode 100644 doc/sim-auth-api.txt
> =

> diff --git a/doc/sim-auth-api.txt b/doc/sim-auth-api.txt
> new file mode 100644
> index 0000000..089a325
> --- /dev/null
> +++ b/doc/sim-auth-api.txt
> @@ -0,0 +1,78 @@
> +SimAuth authentication heiarchy [experimental]

SimAuthentication hierarchy

> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service		org.ofono
> +Interface	org.ofono.SimAuthentication
> +Object path	[variable prefix]/{modem0,modem1,...}
> +
> +Methods		array{object,dict} GetProperties()
> +
> +			Returns properties for SimAuthentication interface.
> +
> +Properties	array{object,dict} applications [readonly]

Actually lets not implement this as a property.  instead use =

array{object, dict} GetApplications().  This will be consistent with =

Manager.GetModems,  VoicecallManager.GetCalls, =

NetworkRegistration.GetOperators(), etc

> +
> +			Array of all SIM applications found during discovery.
> +			In the format "{o(ss)}" where 'o' is the object

This is inconsistent with how we generally handle this.  Usually the =

signature is a{oa{sv}}

o -> object path
a{sv} -> properties of the individual object

so a{sv} would contain
Name, 's' value inside the variant
Type, 's' value inside the variant

Look at how the GetFoo() methods above handle this.

> +			path for the application, 's' is the type, and 's'
> +			is the human readable name e.g.
> +
> +			o =3D "/modem1/A0000000871004FFFFFFFF8906190000"
> +			s =3D "Ims"
> +			s =3D "ISim"
> +
> +			For each application there will be a corresponding
> +			object that matches the path (o). The type will
> +			signify which interfaces are under that object (below).
> +
> +			type =3D Umts --> org.ofono.USimApplication
> +			type =3D Ims  --> org.ofono.ISimApplication
> +
> +SimAuth USIM application heiarchy [experimental]
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service		org.ofono
> +Interface	org.ofono.USimApplication
> +Object path	[variable prefix]/{modem0,modem1,...}/{AID name}
> +
> +Methods		array{string, dict} GsmAuthenticate(array{array{byte}} rands)
> +
> +			Run the USIM application GSM AUTHENTICATE algorithm
> +			with N random challenges 'rands'. This should be an
> +			array of an array of bytes ("aay").

Do you want to mention here that the array can be / should be of size n, =

where n =3D 2 or 3?

> +
> +			Returns the derived Kc/SRES values as an array of
> +			dictionaries. The index of each dictionary matches
> +			the index of the rand value in the method call. The
> +			keys for each dictionary are "kc" and "sres" and both
> +			are arrays of bytes.

Just a minor nitpick, but if the spec uses a particular capitalization =

for Kc/SRES, then use that as the dictionary key.  It is likely easier =

for readability and we are not limited to small caps.

> +
> +			Possible Errors:
> +				[service].Error.NotSupported
> +				[service].Error.Busy
> +
> +		dict UmtsAuthenticate(array{byte} rand, array{byte} autn)
> +
> +			Run the UMTS AUTHENTICATE algorithm in the 3G
> +			context with 'rand' and 'autn'. A dictionary will be
> +			returned containing 'res', 'ck', 'ik' and possibly
> +			'kc' if service 27 is available. If there was a
> +			sync error 'auts' will be returned.
> +
> +			Possible Errors: [service].Error.NotSupported

Just for API consistency, lets also add GetProperties() with 'Type' and =

'Name' as read-only properties.

> +
> +SimAuth ISIM application heiarchy [experimental]
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service		org.ofono
> +Interface	org.ofono.ISimApplication
> +Object		[variable prefix]/{modem0,modem1,...}/{AID name}
> +
> +Methods		dict ImsAuthenticate(array{byte} rand, array{byte} autn)
> +
> +			Run the UMTS AUTHENTICATE algorithm in the IMS
> +			context with 'rand' and 'autn'. A dictionary will be
> +			returned containing 'res', 'ck', 'ik' and possibly
> +			'kc' if service 27 is available. If there was a
> +			sync error 'auts' will be returned.

Same comments about capitalization of the dict keys as above

> +
> +			Possible Errors: [service].Error.NotSupported
> =


Add GetProperties() with 'Type' and 'Name' as read-only

Regards,
-Denis

--===============2779681406283643842==--

