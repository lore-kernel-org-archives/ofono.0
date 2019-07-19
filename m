Content-Type: multipart/mixed; boundary="===============7266495786968881224=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] test: process-context-settings: print commands
 instead of running them
Date: Fri, 19 Jul 2019 01:28:31 -0500
Message-ID: <f48efdaf-7b03-3635-6e08-7c371d467dce@gmail.com>
In-Reply-To: <20190718114937.60921-3-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7266495786968881224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 7/18/19 6:49 AM, Martin Hundeb=C3=B8ll wrote:
> Collect the setup commands and print them to stdout at the end of the
> script. This allows users to evaluate the standard output to apply
> settings.
> ---
>   test/process-context-settings | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> =

> diff --git a/test/process-context-settings b/test/process-context-settings
> index 7ffb12b3..ee3f17d3 100755
> --- a/test/process-context-settings
> +++ b/test/process-context-settings
> @@ -1,6 +1,5 @@
>   #!/usr/bin/python3
>   =

> -import os
>   import sys
>   import dbus
>   =

> @@ -11,6 +10,8 @@ manager =3D dbus.Interface(bus.get_object('org.ofono', =
'/'),
>   =

>   modems =3D manager.GetModems()
>   =

> +commands =3D []
> +
>   for path, properties in modems:
>   	if "org.ofono.ConnectionManager" not in properties["Interfaces"]:
>   		continue
> @@ -48,7 +49,7 @@ for path, properties in modems:
>   =

>   			cmd =3D "ip address add dev " + interface + " " + address
>   			cmd +=3D "/32"
> -			os.system(cmd);
> +			commands.append(cmd)
>   =

>   			for i in settings["DomainNameServers"]:
>   				print("    Nameserver is %s" % (i),
> @@ -56,5 +57,10 @@ for path, properties in modems:
>   =

>   				cmd =3D "ip route add  " + i
>   				cmd +=3D" dev " + interface
> -				os.system(cmd);
> +
> +				commands.append(cmd)
> +
>   		print('', file=3Dsys.stderr)
> +
> +
> +print("\n".join(commands))
> =


Can we actually keep the current behavior of executing all the generated =

commands?  process-context-settings is used in testing and it is a pain =

to unlearn the old way.  Perhaps you can add a command line option to =

only print the commands.  E.g. --dry-run or --print-only or something.

Regards,
-Denis

--===============7266495786968881224==--

