Content-Type: multipart/mixed; boundary="===============5470322353042405397=="
MIME-Version: 1.0
From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: Setting 'legacy' property for GSM modem
Date: Fri, 21 Mar 2014 15:51:32 -0700
Message-ID: <532CC274.6090309@boundarydevices.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5470322353042405397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm an Ofono N00b trying to figure out how configuration
should happen, and I'm a bit stuck.

I'm trying to get a Novatel 3G modem configured, and seem
to be quite close.

Using the nice OFONO_AT_DEBUG=3D1 switch, I can see what appears
to be proper traffic to the point of connection:

     ofonod[1928]: Modem: > AT+CGDATA=3D"PPP",1\r
     ofonod[1928]: Modem: < \r\nCONNECT HSDPA 3.6\r\n

And using strace, I see a bunch of writes following this:

         write(11, "~\377}#\300!}!}!} }$\321\265~", 17) =3D 17
         write(11, "\377}#\300!}!}!} }$\321\265~", 16) =3D 16

but no returned data.

If I contrast this with the same card in my laptop running
Network Manager, I see that the "ATD*99**1#\r" string is
used to make the connection:

     read(27, "\r\n+CGDCONT: 1,\"IP\",\"roam\",\"\",0,0"..., 1024) =3D 115
     read(27, 0x130f623, 1024)               =3D -1 EAGAIN (Resource =

temporarily unavailable)
     write(27, "A", 1)                       =3D 1
     write(27, "T", 1)                       =3D 1
     write(27, "D", 1)                       =3D 1
     write(27, "*", 1)                       =3D 1
     write(27, "9", 1)                       =3D 1
     write(27, "9", 1)                       =3D 1
     write(27, "*", 1)                       =3D 1
     write(27, "*", 1)                       =3D 1
     write(27, "*", 1)                       =3D 1
     write(27, "1", 1)                       =3D 1
     write(27, "#", 1)                       =3D 1
     write(27, "\r", 1)                      =3D 1
     read(27, "\r\nCONNECT HSDPA 3.6\r\n", 1024) =3D 21

And data flows thereafter.

Reading the code, it appears that this form of dialing string is
supported in Ofono, by using the 'legacy' option:
 =

http://git.kernel.org/cgit/network/ofono/ofono.git/tree/gatchat/gsmdial.c#n=
397

I'm just not sure where to put this (or if it will do the trick).

I get messages from connmand regarding a missing file
     /var/lib/connman/cellular_310260820143731_context1/settings

but I'm not really sure what should be in there. I've tried supplying
one, but the syntax isn't clear to me, and I think I'm barking
up the wrong tree.

Is there a template configuration file for a 3G modem somewhere?

Google doesn't seem to be doing it for me today, and the docs and
source code have me puzzled.

Thanks in advance for any pointers.

Regards,


Eric

--===============5470322353042405397==--

