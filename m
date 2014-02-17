Content-Type: multipart/mixed; boundary="===============0703769354737668570=="
MIME-Version: 1.0
From: Brian Ruptash <bruptash@gmail.com>
Subject: RE: No D-Bus Reply to Activating Context
Date: Mon, 17 Feb 2014 09:40:25 +0100
Message-ID: <009101cf2bbb$e7eb4cf0$b7c1e6d0$@gmail.com>
In-Reply-To: <52FA5B6B.6020106@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0703769354737668570==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> > 09:20:42.611 gprs.c:863    pri_activate_callback
> > Activating context failed with error: Unknown error type
> =

> Looking at that line, we are sending a reply right after printing the
> message.  In case the message is NULL, you'd most likely crash inside
> D-Bus or get an assertion of some kind.
> =

> The pending variable is also not messed with anywhere else, so you
> should be getting a reply.
> =

> The only thing I can suggest is to try and simulate this behavior with
> phonesim and see if you can duplicate / debug it.

I traced the log and code and agree, which is why I can't understand why
the D-Bus reply is either not sent or perhaps not received, though it
only occurs in this particular sequence and is the only case a method
return is ever "lost".  dbus has a bug in that dbus-monitor can't trace
method returns, so I can't easily see what's happenning especially as
it's quite sporadic.

So I punted... I upgraded from ofono 1.12 to 1.14 which has a significant
overhaul to gdbus, though I can't find anything in the ofono mailing list
that explains what or why.  And I'll see if the issue persists.

> Regards,
> -Denis

Thanks, Denis.

-- Brian



--===============0703769354737668570==--

