Content-Type: multipart/mixed; boundary="===============8576713971162904068=="
MIME-Version: 1.0
From: Nicola Mfb <nicola.mfb@gmail.com>
Subject: calypso does not power up from 0.17
Date: Wed, 14 Apr 2010 10:52:56 +0200
Message-ID: <t2g359c5481004140152gdc106afcpfaaf00df4c75e9a@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8576713971162904068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

0.16 is the last release that works (well) on the openmoko freerunner
while from 0.17 to 0.20 I have:

root(a)om-gta02 ~ $ dbus-send --system --dest=3Dorg.ofono --print-reply
/freerunner org.ofono.Modem.SetProperty string:Powered
variant:boolean:true
Error org.ofono.Error.Timedout: Operation failure due to timeout

I'm sorry I do not have much time in this period to dig deeply, anyway
I found the commit that introduced the problem with git bisect.

Thanks and Regards

     Niko

commit aec5b8a44fa2fbece87441656eaf7ffb9a53fc6e
Author: Denis Kenzior <denkenz@gmail.com>
Date:   Thu Jan 14 10:25:14 2010 -0600

    Fix: Make remote disconnect detection work

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index ea17335..8af927e 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -801,7 +801,7 @@ static gboolean received_data(GIOChannel *channel,
GIOCondition cond,
        if (cond & (G_IO_HUP | G_IO_ERR))
                return FALSE;

-       if (err !=3D G_IO_ERROR_NONE && err !=3D G_IO_ERROR_AGAIN)
+       if (rbytes =3D=3D 0 && err !=3D G_IO_ERROR_AGAIN)
                return FALSE;

        return TRUE;

--===============8576713971162904068==--

