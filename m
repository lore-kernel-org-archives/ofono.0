Content-Type: multipart/mixed; boundary="===============7488700896907428135=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: The very first oFono release
Date: Fri, 10 Jul 2009 11:56:00 -0700
Message-ID: <1247252160.9709.89.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7488700896907428135==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I just went ahead and tagged version 0.1 of oFono. We have announced
this project about 3 month ago, but the actual code base is a little bit
older of course. And at some point we have to start making releases :)

	http://www.kernel.org/pub/linux/network/ofono/

Not everything is fully functional at this point of time, but simple
voice call handling with an AT based modem (or phone simulator) should
be working fine. If anything fails, please send bug reports to the
mailing list and we will fix it.

Basic SMS support is available and within the next releases we will make
sure it works properly. After that the work on GPRS/HSPA with smooth
integration into ConnMan will start. Just to give everybody a heads up.

I also think it is a good time for package maintainers to look into
making oFono available in their distributions. And give feedback on
things that don't integrate well.

Regards

Marcel



--===============7488700896907428135==--

