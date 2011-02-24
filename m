Content-Type: multipart/mixed; boundary="===============5776181907919620935=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofono crash (setting offline while connected)
Date: Thu, 24 Feb 2011 11:31:35 -0600
Message-ID: <4D6695F7.2080607@gmail.com>
In-Reply-To: <AANLkTimFFgUbOiYJs6=+Y1E_ik3xmeFNR0q=r7XJHYo1@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5776181907919620935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Amit,

On 02/23/2011 11:07 PM, Amit Mendapara wrote:
> Hi,
> =

> While testing the Linktop driver I observed that ofono is crashing if I
> try to set modem offline while it is connected (using
> test/offline-modem.py script). After some debugging, I found that
> `linktop_disconnect` function is being called twice (see the attached
> debug log).
> =

> What could be the reason here? I have seen some hack in mbm driver (in
> mbm_disconnect) having `reopen_callback`. I have tried this but then
> having another crash (this time when creating gprs context). Anyone,
> please clarify how to deal with the issue properly?

Some of these modems HUP the tty for x seconds.  So if you try to open
them too fast, they will be HUPed again, leading to various issues.

When posting backtraces, please give them directly from gdb, or use the
backtrace script to 'prettify' them.  e.g.:

test/backtrace src/ofonod your_log

Regards,
-Denis

--===============5776181907919620935==--

