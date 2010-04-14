Content-Type: multipart/mixed; boundary="===============7821086638169921617=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: calypso does not power up from 0.17
Date: Wed, 14 Apr 2010 05:43:05 -0500
Message-ID: <201004140543.06250.denkenz@gmail.com>
In-Reply-To: <t2g359c5481004140152gdc106afcpfaaf00df4c75e9a@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7821086638169921617==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Niko,

> Hi!
> =

> 0.16 is the last release that works (well) on the openmoko freerunner
> while from 0.17 to 0.20 I have:
> =

> root(a)om-gta02 ~ $ dbus-send --system --dest=3Dorg.ofono --print-reply
> /freerunner org.ofono.Modem.SetProperty string:Powered
> variant:boolean:true
> Error org.ofono.Error.Timedout: Operation failure due to timeout
> =

> I'm sorry I do not have much time in this period to dig deeply, anyway
> I found the commit that introduced the problem with git bisect.

I have a hunch that the GAtMux code might need some love.  Can you try the =

following patch?

diff --git a/gatchat/gatmux.c b/gatchat/gatmux.c
index b70f6a0..139edd2 100644
--- a/gatchat/gatmux.c
+++ b/gatchat/gatmux.c
@@ -433,6 +433,9 @@ static GIOStatus channel_read(GIOChannel *channel, gcha=
r =

*buf, gsize count,
 =

        *bytes_read =3D ring_buffer_read(mux_channel->buffer, buf, avail);
 =

+       if (*bytes_read =3D=3D 0)
+               return G_IO_STATUS_AGAIN;
+
        return G_IO_STATUS_NORMAL;
 }
 =

Regards,
-Denis

--===============7821086638169921617==--

