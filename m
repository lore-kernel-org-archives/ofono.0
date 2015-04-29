Content-Type: multipart/mixed; boundary="===============0186763734505551175=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: Cinterion EHS6 support
Date: Wed, 29 Apr 2015 18:45:32 +0200
Message-ID: <55410AAC.6090609@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0186763734505551175==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I've created a patch which adds support for the Cinterion EHS6 to Ofono.

This is based on the TC65 source code with some changes to address an
issue with +CIND handling

The patch is currently in a GitHub fork here

https://github.com/DynamicDevices/ofono/commit/06c374b94bef2b3b23c9531c2297=
7976ab7f6e99.patch

This enables me to configure an "ehs6" rule in udev and bring up a GPRS
connection successfully with Connman.

Would it be possible to contribute this to Ofono? If so could somebody
let me know what, if anything, needs to be done to the patch?

Many thanks,

Alex


--===============0186763734505551175==--

