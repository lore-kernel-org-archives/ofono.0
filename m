Content-Type: multipart/mixed; boundary="===============1517855414988468962=="
MIME-Version: 1.0
From: Pasi Miettinen <pasi.miettinen@ixonos.com>
Subject: SMS status report
Date: Thu, 17 Jun 2010 16:14:53 +0300
Message-ID: <1276780498-7573-1-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1517855414988468962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi,

Here are the latest modifications for the status report.

Most common use cases are tested in practise. For example:
-Send concatenated message from ofono to phone that is
 powered off.
-Reboot ofono and ofono reads the persistent data from imsi file.
-Power on the phone.
-Ofono receives the status reports and handles them correctly.

Ofono was run under the supervision of valgrind during these tests
and no memory leaks were detected.

Br,
Pasi






--===============1517855414988468962==--

