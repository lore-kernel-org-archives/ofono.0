Content-Type: multipart/mixed; boundary="===============3482142812199395397=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH] Introduction of HACKING file in phonesim
Date: Wed, 02 Jun 2010 10:14:19 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4731E11FF73@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1275384985-1653-1-git-send-email-nareshtechs@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3482142812199395397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Naresh,

>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>Naresh Mehta
>Sent: Tuesday, June 01, 2010 5:36 PM
>To: ofono(a)ofono.org
>Subject: [PATCH] Introduction of HACKING file in phonesim
>
>+
>+When using "./configure --enable-maintainer-mode" the automake scripts wi=
ll
>+use the plugins directly from within the repository. This removes the need
>+to use "make install" when testing "phonesim". The "bootstrap-configure"
>+automatically includes this option.
>+
>+  Run phonesim in foreground using the following options
>+    # ./src/phonesim -p 12345 -gui xml/default.xml

The "xml" directory has been removed. So here should be "src/default.xml".


Regards,
-Yang

--===============3482142812199395397==--

