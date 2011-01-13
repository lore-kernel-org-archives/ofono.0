Content-Type: multipart/mixed; boundary="===============0294586098709522398=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 0/5 v3] Network Time plugin
Date: Thu, 13 Jan 2011 11:49:30 +0200
Message-ID: <1294912175-12026-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0294586098709522398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 This series of patches introduces the network time part of
 the NITZ feature as outlined in 3GPP spec 22.042.
 The plugin is for delivering network indicated time information
 to timed process which is responsible for maintaining the system
 time. The delivery is achieved by timed implementing an interface
 with a method that is called by the nettime plugin with time related
 info as a parameter of the method.

Antti Paila (5):
  nettime: Header file for nettime plugins
  nettime: Network time plugin implementation
  nettime: DBUS and compilation configuration
  nettime: Documentation
  nettime: Mock Timed for testing

 Makefile.am              |    9 +-
 doc/network-time-api.txt |   36 +++++
 include/nettime.h        |    4 +
 plugins/nettime.c        |  317 ++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.conf           |    2 +
 test/test-nettime        |   35 +++++
 6 files changed, 401 insertions(+), 2 deletions(-)
 create mode 100644 doc/network-time-api.txt
 create mode 100644 plugins/nettime.c
 create mode 100755 test/test-nettime


--===============0294586098709522398==--

