Content-Type: multipart/mixed; boundary="===============3150904706551136688=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gatchat: export gatchat at_chat_finish_command
Date: Sat, 20 Oct 2018 11:23:27 -0500
Message-ID: <2a3d913d-c011-8dea-469c-65cb58577aeb@gmail.com>
In-Reply-To: <CAKSBH7GdXVfM_ngUuvUZH6GoXPQ_C5aA=gA=gQfJPeah8HUDEw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3150904706551136688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> I need to probe with 'AT' once per second the modem and the
> application port, one after the other.
> It needs to be repeated a few times, because the device might be
> booting up, but it could also be that the device is not responding
> (because, for example, mapped on the RS232).

Ugh.  Doesn't your firmware provide some sort of ready notification?

But anyway, you can still accomplish this with =

g_at_chat_send/g_timeout_add/g_at_chat_cancel...

> =

> Another use could be to abort a long-running command (eg: SMS sending,
> which can take up to 3 minutes), to allow the application to do
> something else, eg: emergency call.

This is why they invented the multiplexer.  Also note that we don't =

implement actual AT command abortions.  So it depends on the behavior of =

your AT command interpreter whether this works as you think.

I'm not taking this patch as things stand right now.

Regards,
-Denis

--===============3150904706551136688==--

