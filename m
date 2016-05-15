Content-Type: multipart/mixed; boundary="===============5479303171180627585=="
MIME-Version: 1.0
From: Marco Trapanese <marcotrapanese@gmail.com>
Subject: Re: Method "Register" with signature "oay" doesn't exist
Date: Sun, 15 May 2016 12:36:55 +0200
Message-ID: <57385147.6030701@gmail.com>
In-Reply-To: <5738505B.4040908@chini.tk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5479303171180627585==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Il 15/05/2016 12:32, Georg Chini ha scritto:

> Yes, loopback modules are created automatically. The error message you =

> are getting is relevant,
> but the problem is rather somewhere on the bluetooth side. From my =

> experience the fact that
> you get A2DP connected does not mean that HFP is working as well. Take =

> a look at the debug
> logs of ofono, pulseaudio  and bluetoothd and at the dbus messages =

> that are passing between
> the different components. Maybe you'll find a hint there what is going =

> wrong.

I sent the logs on the pulseaudio mailing-list.
Unfortunately I haven't enough knowledge to understand what's happening.

I will try again to get fresh logs and I will post them here.

> Did you set headset=3Dofono for module-bluetooth-discover?

Yes, I did


--===============5479303171180627585==--

