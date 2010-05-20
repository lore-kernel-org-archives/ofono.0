Content-Type: multipart/mixed; boundary="===============6950172157891624671=="
MIME-Version: 1.0
From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: Need your help - Few queries on ofono
Date: Thu, 20 May 2010 14:11:05 +0200
Message-ID: <20100520121105.GA18374@gumpy.localdomain>
In-Reply-To: <AANLkTiniwJUyo7UlOdYlPx-CX-D2B0Et_iXjw7N2qMzk@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6950172157891624671==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sankar,

On Thu, May 20, 2010 at 12:07:00PM +0200, Sankar wrote:
> Hi Daniel,
> =

> I have a few queries on ofono telephony stack. Can you please help me.
> Thanks for your time.
> =

> My question is:
> =

> 1. I downloaded the ofono source code from the web, Tried compiling it, a=
nd building it.
> 2. The code got successfully compiled and ofonod was generated. But looks=
 like no specific .so s got built for the drivers/plugins.


My usual steps are:

$ ./bootstrap-configure

(read the output of configure and check if there are missing
libraries. if yes install the missing dependencies)

$ make
$ sudo make install

> I tried launching the ofono deamon, but could not launch it. Can you plea=
se provide some inputs.

You have make sure to install the ofono.conf (dbus daemon
configuration) into /etc/dbus.1/system.d/ and then trigger dbus daemon
to reread the configuration (e.g. killall -HUP dbus-daemon)

Enable phonesim in /etc/ofono/modem.conf

And then you should be able to start ofono

$ sudo src/ofonod -n

with '-n' the daemon doesn't spawn into background

> Also, can you please provide some inputs on how to use phonesim with this.

$ ./boostrap-configure
$ make
$ sudo make install

$ phonesim -gui default.xml

and then you have to enable the modem with

$ ofono/test/enable-modem

cheers,
daniel

--===============6950172157891624671==--

