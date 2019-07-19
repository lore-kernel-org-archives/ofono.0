Content-Type: multipart/mixed; boundary="===============4148916349238764620=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2] test: process-context-settings: add argument for
 default connection
Date: Fri, 19 Jul 2019 10:56:31 -0500
Message-ID: <71811641-476b-07e3-3c26-c8c5cdc59f4b@gmail.com>
In-Reply-To: <20190719084801.112610-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4148916349238764620==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 7/19/19 3:48 AM, Martin Hundeb=C3=B8ll wrote:
> Add an optional argument to specify an interface to as default
> connection for the system. This changes the constructed commands so that
> the gateway is configured as default route, and nameservers are written
> to resolv.conf.

Actually, I would forgo the argument completely, and always set the =

default route.  Just add a metric argument and set it low, like 600+ or =

so.  Or make the metric configurable.  That way if WWAN is your only =

route, then it becomes the default automagically.  And if it isn't, then =

it has a low enough priority that it won't be used.

e.g. ip route add default via $IP dev $FOO metric 600

One can do even fancier things with policy based routing, but this =

should be good enough for testing.

> ---
> =

> I decided to drop the print-instead-execute approach, and simply add the
> interface argument to get the default route and dns settings. These
> changes were mostly to enable easy setup of internet on my board...
> =

>   test/process-context-settings | 25 +++++++++++++++++++++----
>   1 file changed, 21 insertions(+), 4 deletions(-)
> =

> diff --git a/test/process-context-settings b/test/process-context-settings
> index 7ffb12b3..e0bc1083 100755
> --- a/test/process-context-settings
> +++ b/test/process-context-settings
> @@ -11,6 +11,11 @@ manager =3D dbus.Interface(bus.get_object('org.ofono',=
 '/'),
>   =

>   modems =3D manager.GetModems()
>   =

> +default =3D None
> +if len(sys.argv) > 1:
> +	default =3D sys.argv[1]
> +	print("Using %s as default link" % (default), file=3Dsys.stderr)
> +

I would not take the interface argument from the command line (for =

safety reasons) if I could help it.  And with udev renaming I can never =

(easily) type what it comes up with :)

>   for path, properties in modems:
>   	if "org.ofono.ConnectionManager" not in properties["Interfaces"]:
>   		continue
> @@ -50,11 +55,23 @@ for path, properties in modems:
>   			cmd +=3D "/32"
>   			os.system(cmd);
>   =

> -			for i in settings["DomainNameServers"]:
> -				print("    Nameserver is %s" % (i),
> +			if interface =3D=3D default:
> +				cmd =3D "ip route add default via " + gateway
> +				cmd +=3D " dev " + interface
> +				os.system(cmd)
> +
> +			for i,dns in enumerate(settings["DomainNameServers"]):
> +				print("    Nameserver is %s" % (dns),
>   					file=3Dsys.stderr)
>   =

> -				cmd =3D "ip route add  " + i
> -				cmd +=3D" dev " + interface
> +				if interface =3D=3D default:
> +					redirect =3D " > " if i =3D=3D 0 else " >> "
> +					cmd =3D "echo nameserver " + dns + redirect
> +					cmd +=3D "/etc/resolv.conf"

Maybe consider this as a separate command line option (e.g. whether to =

set the DNS to resolv.conf) ?

> +				else:
> +					cmd =3D "ip route add  " + dns
> +					cmd +=3D " dev " + interface

Don't you want to add a route to DNS in all cases?  DNS might not be on =

the same subnet as the IP obtained from the modem..

> +
>   				os.system(cmd);
> +
>   		print('', file=3Dsys.stderr)
> =


Regards,
-Denis

--===============4148916349238764620==--

