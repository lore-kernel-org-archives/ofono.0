Content-Type: multipart/mixed; boundary="===============2765756484732569549=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH 1/4] gisi: Changes to prepare for isimodem2.5
Date: Wed, 08 Dec 2010 16:32:31 +0200
Message-ID: <1291818751.25976.173.camel@tucson>
In-Reply-To: <4CFF8586.1060000@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2765756484732569549==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2010-12-08 at 14:17 +0100, ext Jessica Nilsson wrote:
> > Also is this in sync with the GISI re-write Aki is doing?
> thank you for your comments.
> We are studying what Aki is doing and are in contact with him and will =

> get back to this.

One item I can see is missing is the ability to set the remote spn_dev
and spn_obj for GIsiPipe and GIsiModem. For the N900 modem, these both
default to zero, but are something different for the STE modem.

We should simply create new constructors that let these be set to
non-zero values.

Cheers,
Aki


--===============2765756484732569549==--

