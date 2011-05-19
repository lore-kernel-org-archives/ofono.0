Content-Type: multipart/mixed; boundary="===============2694170900109151398=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Emulator not unregistered while sending ATH0
Date: Thu, 19 May 2011 12:13:25 +0200
Message-ID: <4DD4ED45.3050907@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2694170900109151398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I noticed that when I send +++ -> ATH0 during a PPP session the ppp =

server is well unregistered.
However when the physical layer is removed (bluetooht or TCP), the =

associated emulator is not unregistered.
As we used in gatutil.c set_close_on_unref(TRUE), it means there is =

still on reference on the GIOChannel.

In the case the PPP session is ended normally, we call =

ppp_ipcp_down_notify() to free the ppp_net interface.
Then the physical layer is removed and we got the emulator well =

unregistered.
Do you have any idea about what is happening there?
Maybe I forgot to do something into dun_ath_cb().

Kind regards,
Guillaume

--===============2694170900109151398==--

