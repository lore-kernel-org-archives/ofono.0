Content-Type: multipart/mixed; boundary="===============4803746106406089574=="
MIME-Version: 1.0
From: Holger Freyther <holger@freyther.de>
Subject: Re: Timeout/Reliability issue with my plugin
Date: Sat, 12 Mar 2016 19:20:57 +0000
Message-ID: <loom.20160312T201452-815@post.gmane.org>
In-Reply-To: <56E450A6.90600@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4803746106406089574==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis Kenzior <denkenz@...> writes:

> =

> Hi Holger,

Denis!


> You could do a timer, or forcefully unref the g_at_chat object if the =

> GAtChat already exists when set_powered() is being called.  However, its =

> best to drive a modem in such a way that the firmware doesn't reset and =

> keeps responding to AT commands properly.
> =

> Sometimes this is easier said than done :)

yes, please keep in mind that this is in an infinite loop to enable/disable=
 the
modem. I have opted for unrefing the atchat. In terms from a driver model
the "tiemout" could be communicated to the plugin? E.g. a _reset?



> =

> Doesn't this second ,1 parameter cause a reset?

Yes, it does. I think AT+CFUN=3D1,0 didn't always work. I will retry it. Sa=
dly
I have to go to AT+CFUN=3D1 and only then can switch to CFUN=3D4



> The set_powered() method should succeed in a second or two, maybe 5.  I =

> think the core uses a 20 second timer, so if you're hitting that, then =

> there's something fundamentally wrong.
> =

> Fundamentally the driver needs to ensure that the core callback is =

> called within a decent time frame.  The timeout handling in the core is =

> just a failsafe for the applications to be notified that the hardware is =

> not available.

It is a "load" test right now. The modem might do intensive wear leveling
of the flash. In general it is a lot closer to the 5s seconds (it would be =
cool
if OFONO_DEBUG_AT would print timing and 'modem or at least the atchat).

Okay, so I am sticking with checking if the atchat is present, cancel every=
thing
and then unref it.

thank you for the quick responses!

  holger


--===============4803746106406089574==--

