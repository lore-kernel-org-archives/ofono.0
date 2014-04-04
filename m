Content-Type: multipart/mixed; boundary="===============7394992015278087235=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] Allow users to specify dbus name replacement
 behaviour.
Date: Thu, 03 Apr 2014 19:11:11 -0500
Message-ID: <533DF89F.8030003@gmail.com>
In-Reply-To: <533DF28E.9080209@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7394992015278087235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

> Oh, didn't know that. That sounds great!
> We were under the impression that the phonesim instances have to be
> running before phonesim plugin loads and the modem .xml configurations
> can't be changed on the fly.

What modem .xml configurations?  I'm lost now.

You have phonesim plugin inside oFono that simply creates modem driver
instances that essentially know two things:
  - IP Address
  - Port number.

When you enable the modem on path /phonesimN, a TCP connection is
established.
When you disable the modem, a TCP connection is killed.

> =

> This new information now removes the need to be able to restart ofono
> just for updating the phonesim modem .xml configurations.
> =


Just restart phonesim on the same port with a new XML file and be done
with it.

> =

>> Or go the route of plugins/stktest.c and tools/stktest.c that we used
>> for unit testing SIM Toolkit.
> =

> The only problem that remains is that there seems to be no way of
> changing the number of modems on the fly as they are read upon phonesim
> plugin initialization from phonesim.conf.

Why is this a problem?

> =

> Now looking at stktest.c I see it opens a socket to communicate with an
> external process.
> =


If by external process you mean oFono... then yes.  The setup is exactly
the same as phonesim, just automated.  Think of stktest as a phonesim
instance with a very limited AT command set, but tells oFono when to
connect ;)

> =

> Would it be acceptable if we implement the following:
> =

> Upon phonesim plugin init we check if a configuration file exists at
>     /etc/ofono/phonesim-control.conf
> =

> The file would contain the following:
> =

>     [control]
>     Port=3D715517
>     LoadDefaultConfig=3D0
> =

> Only if the file exists phonesim plugin would then create a _listening_
> socket on the specified port.
> =

> If LoadDefaultConfig is 0 the phonesim plugin would not load
> /etc/ofono/phonesim.conf.
> =

> That socket would be used to issue control commands:
>     ADD [sim name] [Address] [Port]
>     REMOVE [sim name]
>     RESET

You want to create and remove phonesim modems on the fly? Why?  That
seems utterly pointless.

Regards,
-Denis

--===============7394992015278087235==--

