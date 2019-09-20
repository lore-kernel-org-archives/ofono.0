Content-Type: multipart/mixed; boundary="===============6601484540943910731=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Infinitely calling at_gprs_activate_primary after suspend and
 resume
Date: Fri, 20 Sep 2019 10:10:53 -0500
Message-ID: <13629999-55e8-92dd-e12a-70a872c73d33@gmail.com>
In-Reply-To: <AFA70583AB912E4AA797D4F844234B3201F211@NTQ-EXC.nanoteq.co.za>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6601484540943910731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christo,

On 9/5/19 5:35 AM, Christo Labuschagne wrote:
> Good day all
> =

> We are running ofono 1.29 with a Telit HE910 modem connected via HSIC =

> (USB).=C2=A0 When I suspend the kernel and wake again the following event=
s =

> happen:
> =

> gatio.c =E2=80=93 read_watcher_destroy_notify
> =

> gatchat.c =E2=80=93 io_disconnect
> =


So basically the kernel sends us a HUP and we think the underlying =

file-descriptor has been closed.

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 - chat_cleanup
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0- in chat_cleanup chat->command_queue is fr=
eed and =

> set to NULL
> =

> Then (I haven=E2=80=99t traced the root of this one)
> =

> drivers/atmodem/gprs-context.c =E2=80=93 at_gprs_activate_primary()
> =

> gatchat.c =E2=80=93 g_at_chat_send()
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 In here it fails because command_queue is null
> =

> It then continues forever to try and call at_gprs_activate_primary().

Probably caused by ConnMan?

> =

> I did not trace everything into glib, but I=E2=80=99m assuming that when =
going =

> to sleep and then waking removes and then re-adds the ttyACM=E2=80=99s fo=
r the =

> modem, which causes the destroy notify.
> =


I suspect this is the case, yes.

> There are two possible ways to fix the problem.=C2=A0 Fix it in ofono to =

> recreate the command_queue before actually calling =

> at_gprs_activate_primary (which in the long term should probably be the =


Curious.  How are you thinking of accomplishing that?  How would you =

distinguish between a real HUP and the weird suspend/resume HUP?  Also, =

are you sure your device isn't being rebooted as well?

> best fix) or try and prevent - on a driver level - to not remove the =

> ttyACM=E2=80=99s between sleep and resume.=C2=A0 The latter would then no=
t kick of =

> the destroy notify.

That's what oFono has always assumed, that the baseband is always alive =

during the time the host is suspended. ttys are always active and can =

even wake up the host as needed (e.g. incoming call, etc).

Regards,
-Denis

--===============6601484540943910731==--

