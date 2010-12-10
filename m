Content-Type: multipart/mixed; boundary="===============8136137029991005853=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 0/4 v2] Network Time plugin
Date: Fri, 10 Dec 2010 09:53:54 +0200
Message-ID: <1291967638-12371-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8136137029991005853==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 This series of patches introduces the network time part of the NITZ featur=
e =

 as outlined in 3GPP spec 22.042. The Network Time plugin has two DBUS =

 interfaces for client applications: notification signal and polling method =

 call. The time information consists of three dictionary entries: 1) time a=
nd =

 date in seconds from epoch (renormalized to time indicatation arrival time=
);
 2) daylight saving time; 3) timezone.
 =

 include/dbus.h |    1 +
 plugins/nettime.c | 285 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++
 Makefile.am |   10 ++++++++--
 test/get-nettime |   25 +++++++++++++++++++++++++
 test/test-nettime |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 doc/network-time-api.txt |   31 +++++++++++++++++++++++++++++++

--===============8136137029991005853==--

