Content-Type: multipart/mixed; boundary="===============5779352542380195892=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [n900 PATCH 0/5] n900 modem drivers
Date: Wed, 15 Sep 2010 19:59:29 +0300
Message-ID: <1284569974-22505-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5779352542380195892==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I did some restructuring on the isimodem side as proposed by Denis. Now
the driver/isimodem does not contain a modem driver, but it is in the
isigen plugin (=C3=A1 la atgen). The "isimodem" modem driver is removed.

The n900 modem driver seems to run on Nokia N900 with meego kernel and user=
space.

The n900maemo plugin is for Nokia N900s running Maemo userspace.

--Pekka


--===============5779352542380195892==--

