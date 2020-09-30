Content-Type: multipart/mixed; boundary="===============7978011111595232005=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] quectel: Power on/off with a gpio pulse
Date: Wed, 30 Sep 2020 10:25:49 -0500
Message-ID: <ab241437-d40b-5ecd-c31c-4ff49b800560@gmail.com>
In-Reply-To: <20200930085055.jt3d2yhkhcwehlau@lem-wkst-02.lemonage>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7978011111595232005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

>> Can this be done using g_timeout instead?
> =

> This was indeed not the first solution I tried. But I used the l_timeout_
> thing that is used all over in quectel.c. I could not get this to work
> in a way I was satisfied with. When I send a SIGTERM to the ofono
> process close_serial is called but the timeout_callback never fires

It seems this is because you call ofono_modem_set_powered(..., FALSE) in =

close_serial().  What you should be doing is delaying this until your gpio =

operation is complete.

> and thus the modem does not power off. This is why I then tried usleep
> and this works reliably.
> Just to be sure I tried with g_timeout and this is the same like
> l_timeout. The callback is not called.

See above, l_timeout / g_timeout won't matter here...  The driver needs to =
tell =

the core when it is done powering up / powering down.  This is accomplished=
 by =

returning -EINPROGRESS from .enable/.disable and calling =

ofono_modem_set_powered() once the operation completes.

Regards,
-Denis
--===============7978011111595232005==--

