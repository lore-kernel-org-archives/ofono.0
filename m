Content-Type: multipart/mixed; boundary="===============3298781131161257472=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] Added functionality to remove modem from system,
 if needed.
Date: Thu, 29 Oct 2009 11:27:05 -0500
Message-ID: <200910291127.05401.denkenz@gmail.com>
In-Reply-To: <1256826011.5768.48.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3298781131161257472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> > I have tried toggling the power to the modem (has a switch on the board)
> > when the daemon was running, and the daemon was not able to return to a
> > known state.
>
> Weird. Might need some udev magic to do the right thing. Or some special
> handling inside the plugin.

What kind of modem is this?  If it is a UART modem then udev won't help her=
e.  =

Custom plugin handling is required.

Regards,
-Denis

--===============3298781131161257472==--

