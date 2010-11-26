Content-Type: multipart/mixed; boundary="===============8049232922151942105=="
MIME-Version: 1.0
From: Alexander Kanavin <alexander.kanavin@nokia.com>
Subject: [ANNOUNCE] introducing oFono Qt bindings
Date: Fri, 26 Nov 2010 16:55:00 +0200
Message-ID: <4CEFCA44.7030209@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8049232922151942105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

oFono Qt bindings is a Qt library that provides a directly-mapped API to =

oFono. It's licensed under LGPL 2.1 and available at

http://meego.gitorious.org/meego-cellular/ofono-qt

The library was written by me and Jukka Saunamaki with some input from =

Aki Niemi. It will be used by QtMobility for telephony access on =

Linux-based platforms.

Some features:
- it's possible to choose a modem manually or automatically; more =

fine-tuned modem selection policies could be added
- all operations that can take significant time are asynchronous
- there is a test suite to catch API breaks

The bindings should be available in MeeGo shortly.

Note that meego-handset-ux also has a project called ofono-qt, but that =

is a quick and unmaintained hack for the dialer. We have agreed with =

Intel that they would adapt the dialer to use our library and contribute =

to it.


Alex

--===============8049232922151942105==--

