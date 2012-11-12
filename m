Content-Type: multipart/mixed; boundary="===============3961084057372091123=="
MIME-Version: 1.0
From: Holger Hans Peter Freyther <holger@freyther.de>
Subject: Re: Memory corruption when submitting a huge number of SMS
Date: Tue, 13 Nov 2012 00:02:43 +0100
Message-ID: <20121112230243.GN31742@xiaoyu.lan>
In-Reply-To: <50A14E06.5020204@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3961084057372091123==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 12, 2012 at 01:29:10PM -0600, Denis Kenzior wrote:
> Hi Holger,
> =

> Not a whole lot to go on.  Looks like the crash happens in gdbus.
> Is the dbus daemon crashing or bumping ofono off the bus by any
> chance?

the dbus-daemon is running since the start of my laptop.

> =

> Have you tried making a debug build and seeing if you get slightly
> better debug information?  Just set CFLAGS to -O0 and --enable-debug
> when configuring.

not yet. I might need to travel this week so it might take until Wed or Fri
to test this. Is ofono using multiple threads? this somehow sounds like a m=
ismatch
of first deregister from the glib event loop and then free...

holger

--===============3961084057372091123==--

