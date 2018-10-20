Content-Type: multipart/mixed; boundary="===============9205252465268857628=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gatchat: export gatchat at_chat_finish_command
Date: Sat, 20 Oct 2018 14:22:29 -0500
Message-ID: <a1c4f33a-d8be-b9c0-afd7-4bf665cd9b0f@gmail.com>
In-Reply-To: <CAKSBH7FBDLQf+HrH_EypGD0TT2j_73EXA_wua8bap0OgFQ1T+Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9205252465268857628==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> some chipsets have a single interpreter, even if accessible from
> multiple ports, but they allow aborting.
> Gemalto modules abort long-running commands simply sending any
> character on the line while waiting for a response,
> the module returns ERROR, and the flow can be resumed properly.
> I don't need this patch for that, I can just use directly GAtIO / GIOChan=
nel.

So if you're going through the trouble of implementing command abortion, =

then just implement it in GAtChat directly.

>> I've already had this conversation with someone from Gemalto or one of
>> your customers.  I don't see a reason why you can't use
>> g_at_chat_set_wakeup_command for this.  With perhaps an extension to
>> GAtChat API to reset/cancel the wakeup behavior once you don't need it.
> =

> g_at_chat_set_wakeup_command is blocking (I think), and it would be

Nothing in GAtChat is blocking.  Or well, what is your definition of =

blocking here?

> perfect because of that, only would need to add a timeout/number of
> attempts, and a return value (success/timed out).

That would work..

> But it seems complicated to do this because it is integrated in the
> big state machine of GAtChat.

But all the work is already done for you, so might as well just use this =

legacy feature if it gets you there...

> I prefer to go for GAtIO / GIOChannel instead.
> =

> By the way, g_at_chat_set_wakeup_command takes 2 timeouts (the first
> one for the period of the wakeup AT command), but the second never
> seems to expire, so I don't know if it is already fit.

It expires, you might not be triggering it though. The inactivity timer =

is used to keep track of how long ago a command was sent to the AT port. =

  So it is updated with every command sent.  The particular device that =

this was needed for would shutdown the AT port after a period of =

inactivity, e.g. 5 seconds or so.  So if no AT commands were sent for 5 =

seconds, it needed to be woken up.  It usually ate the first 2-3 'AT\r' =

commands sent to it.

The wakeup_timeout parameter specifies how long to wait for the 'AT\r' =

response before giving up and attempting again.

Regards,
-Denis

--===============9205252465268857628==--

