Content-Type: multipart/mixed; boundary="===============1450456100569649912=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC 0/5] Add few conformance test cases to phonesim
Date: Mon, 03 Jan 2011 12:09:19 +0200
Message-ID: <1294049364-6621-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1450456100569649912==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 Following set of patches adds Display Text, Get Inkey, Get Input and =

MoreTime conformance test cases as specificed in ETSI TS 102 384 to
phonesim. Logging of the result in a file can be done but it is not
part of this patch.

Regards,
Jeevaka

badrjee (5):
  phonesim: Add conformance test to main menu
  phonesim: Add DisplayText conformance test cases
  phonesim: Add GetInkey conformance test cases
  phonesim: Add GetInput conformance test cases
  phonesim: Add MoreTime conformance test case

 src/simapplication.cpp | 1734 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/simapplication.h   |   21 +
 2 files changed, 1755 insertions(+), 0 deletions(-)


--===============1450456100569649912==--

