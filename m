Content-Type: multipart/mixed; boundary="===============1353824046792681543=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/4] test: process-context-settings: use ip instead of
 ifconfig/route
Date: Thu, 18 Jul 2019 18:38:21 +0200
Message-ID: <20190718163820.GB21502@amd>
In-Reply-To: <20190718114937.60921-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1353824046792681543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu 2019-07-18 13:49:34, Martin Hundeb=C3=B8ll wrote:
> ---
>  test/process-context-settings | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> =

> diff --git a/test/process-context-settings b/test/process-context-settings
> index 1d30b30d..a536a771 100755
> --- a/test/process-context-settings
> +++ b/test/process-context-settings
> @@ -41,14 +41,14 @@ for path, properties in modems:
>  			print("    IP address is %s" % (address))
>  			print("    Gateway is %s" % (gateway))
>  =

> -			cmd =3D "ifconfig " + interface + " " + address
> -			cmd +=3D " netmask 255.255.255.255"
> +			cmd =3D "ip address add dev " + interface + " " + address
> +			cmd +=3D "/32"
>  			os.system(cmd);
>  =

>  			for i in settings["DomainNameServers"]:
>  				print("    Nameserver is %s" % (i))
>  =

> -				cmd =3D "route add -host " + i
> +				cmd =3D "ip route add  " + i
>  				cmd +=3D" dev " + interface
>  				os.system(cmd);

So.. you move from one tool to another one, fixing it on some systems
and braking on some.

But I guess better solution would be to use python module, not execing
external programs.

...which certainly should not be executed using os.system(). Network
interface called `> /etc/passwd` would be a lot of phun, right? :-).

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============1353824046792681543==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsMHdvSHdBQ2drUU1PZndhcFhiK3ZKS1RnQ2RHR0NPTVlTZjZmd1V1eTBJc1lUb2NhMlYK
YllJQW9MeDc3QlJGc0lJbWNiWG1vdyswZ1NGaTBieGUKPXIzbEEKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============1353824046792681543==--

