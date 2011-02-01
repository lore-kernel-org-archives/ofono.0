Content-Type: multipart/mixed; boundary="===============3140459338907453521=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 0/4 v4] Network Time Plugin
Date: Tue, 01 Feb 2011 16:49:27 +0200
Message-ID: <1296571771-26513-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3140459338907453521==
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

Antti Paila (4):
  nettime: Network time plugin implementation
  nettime: Makefile.am modification
  nettime: Documentation
  nettime: Mock Timed for testing

 Makefile.am              |    9 +-
 doc/network-time-api.txt |   36 +++++
 plugins/nettime.c        |  326 ++++++++++++++++++++++++++++++++++++++++++=
++++
 test/test-nettime        |   35 +++++
 4 files changed, 404 insertions(+), 2 deletions(-)
 create mode 100644 doc/network-time-api.txt
 create mode 100644 plugins/nettime.c
 create mode 100755 test/test-nettime


--===============3140459338907453521==--

