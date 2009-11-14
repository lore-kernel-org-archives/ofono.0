Content-Type: multipart/mixed; boundary="===============5968065951589737002=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: ppp
Date: Sat, 14 Nov 2009 19:50:02 +0100
Message-ID: <fb249edb0911141050m6432fe81qa492ceb8f7c1ae61@mail.gmail.com>
In-Reply-To: <20091113115311.19074lc2vv2yavms@boatman.intrepid.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5968065951589737002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2009/11/13 Chris Pitchford <ofono@intrepid.cx>:
> Is the line discipline so much of an issue when using ppp connected to a
> fake tty? could that not be handed on the proxy side inside ofono?

I've not tried it on a non-tty but it definitely should work modulo
potential bugs that need to be squashed.  It's supposed to work.

However by using a separate process to do ppp you add overhead.  The
original idea in ofono as well as in other projects (think OpenMoko)
was to have both ppp and multiplexing in the kernel to avoid the
context switches when a lot of data is being sent, but this is not
very portable and causes lots of other problems.  Having both in a
single non-kernel process is going to be almost as fast and much more
portable at the expense of reimplementing part of pppd.

Regards

--===============5968065951589737002==--

