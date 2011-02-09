Content-Type: multipart/mixed; boundary="===============0119647226319210840=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 0/3 v5] Network Time Plugin
Date: Wed, 09 Feb 2011 21:12:48 +0200
Message-ID: <1297278771-14468-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0119647226319210840==
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

Antti Paila (3):
  nettime: Network time plugin implementation
  nettime: Makefile.am modification
  nettime: Mock Timed for testing

 Makefile.am             |    6 +-
 plugins/meego-nettime.c |  321 +++++++++++++++++++++++++++++++++++++++++++=
++++
 test/test-nettime       |   35 +++++
 3 files changed, 361 insertions(+), 1 deletions(-)
 create mode 100644 plugins/meego-nettime.c
 create mode 100755 test/test-nettime


--===============0119647226319210840==--

