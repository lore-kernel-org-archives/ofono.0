Content-Type: multipart/mixed; boundary="===============2610706207768595509=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: basic connection howto
Date: Tue, 01 Sep 2015 16:03:35 -0500
Message-ID: <55E612A7.1040806@gmail.com>
In-Reply-To: <loom.20150901T213104-390@post.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2610706207768595509==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bo,

 > The man pages mention that:
>
> "oFono is controlled through D-Bus;
> for example, one can tell ofonod to send
> AT commands over /dev/rfcomm0 by calling
> the D-Bus method org.ofono.at.Manager.Create"

Well this is embarrassing.  That manpage is completely out of date. =

Please forget whatever you read in it.

USB Modem detection in oFono is handled by plugins/udevng.c.  Generally, =

things just work.  However, you might have a device that isn't =

supported.  At least the vendor id / product id you mention are missing =

from udevng.c.

Regards,
-Denis



--===============2610706207768595509==--

