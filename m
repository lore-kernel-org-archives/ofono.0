Content-Type: multipart/mixed; boundary="===============4917997132073800607=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] voicecall: send CallRemoved for calls when voicecall atom
 is unregistered
Date: Thu, 19 Apr 2012 09:02:02 -0500
Message-ID: <4F901ADA.8010808@gmail.com>
In-Reply-To: <CAB7rCThu4QsYXn+R9JTRSgfcP5xo1XffrBc0WsqFtOxDi4psLg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4917997132073800607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mike,

> =

> The only reason I added it is 4 hours of debugging my GUI and ofono to
> figure out why the GUI didn't notice the D-Bus path for the voice call
> was no longer around.  The documentation for CallRemoved says "Signal
> that is sent when a voice call has been released."  This implies it
> should be sent every time it is released.  If you update the
> documentation to make it clear that this is not always the case, then
> it's fine by me.
> =


Please check that commit 7f51df4d satisfies your requirements.

Regards,
-Denis

--===============4917997132073800607==--

