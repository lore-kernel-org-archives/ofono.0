Content-Type: multipart/mixed; boundary="===============0965796040291141702=="
MIME-Version: 1.0
From: Antti =?unknown-8bit?q?Kaijanm=C3=A4ki?= <antti.kaijanmaki@canonical.com>
Subject: Re: [PATCH 1/2] Allow users to specify dbus name replacement
 behaviour.
Date: Fri, 04 Apr 2014 02:45:18 +0300
Message-ID: <533DF28E.9080209@canonical.com>
In-Reply-To: <1D42A55E-765D-45A5-843D-AA092474C7F2@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0965796040291141702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03.04.2014 20:55, Marcel Holtmann wrote:
>> Indeed, and this combined with commit 5f765259 one can easily run
>> a series of tests (let's say dialer UI, messaging..) with
>> different phonesim configurations changing the number of modems and
>> phonesim .xml files for each modem.
> =

> this argument does not really fly with me. You can just
> disable/enable the phonesim modem over D-Bus and it allows you to
> connect to a total different phonesim instance with a new
> phonesim.xml.

Oh, didn't know that. That sounds great!
We were under the impression that the phonesim instances have to be
running before phonesim plugin loads and the modem .xml configurations
can't be changed on the fly.

This new information now removes the need to be able to restart ofono
just for updating the phonesim modem .xml configurations.


> Or go the route of plugins/stktest.c and tools/stktest.c that we used
> for unit testing SIM Toolkit.

The only problem that remains is that there seems to be no way of
changing the number of modems on the fly as they are read upon phonesim
plugin initialization from phonesim.conf.

Now looking at stktest.c I see it opens a socket to communicate with an
external process.


Would it be acceptable if we implement the following:

Upon phonesim plugin init we check if a configuration file exists at
    /etc/ofono/phonesim-control.conf

The file would contain the following:

    [control]
    Port=3D715517
    LoadDefaultConfig=3D0

Only if the file exists phonesim plugin would then create a _listening_
socket on the specified port.

If LoadDefaultConfig is 0 the phonesim plugin would not load
/etc/ofono/phonesim.conf.

That socket would be used to issue control commands:
    ADD [sim name] [Address] [Port]
    REMOVE [sim name]
    RESET

ADD    - adds a modem, fields are consistent with phonesim.conf
REMOVE - remove [sim name] modem
RESET  - clear all modems,
         if LoadDefaultConfig =3D 1 then reload the phonesim.conf
         if LoadDefaultConfig =3D 0 then remove all modems

I would be intrigued to have LOAD [configuration file], but having it
possible to order a root process to read arbitrary files is probably too
much. :)


> And here as well. If you are allowed to own the D-Bus well know name,
> you normally can kill the current process and start a new one of your
> choice.

The idea was that we would not have to allow root access to the
automated tests to be able to change the phonesim configuration. If we
can figure out a solution how to change the number of modems phonesim
plugin exposes on the fly then by all means there is no need for the
original patches.


 -- Antti

--===============0965796040291141702==--

