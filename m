Content-Type: multipart/mixed; boundary="===============8084719320261960609=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v3 0/3] Add new scripts for GCF testing
Date: Thu, 02 Aug 2012 11:41:00 +0200
Message-ID: <1343900463-24917-1-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <$>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8084719320261960609==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Chnage log from v2:
	- adding hangup-call script to hangup a call in specifying its ID.
	  It is needed for 3GPP 51.010 test case 31.4.2.1.4
	- Fixing some indentation issue in hangup script
	- Renaming hangup script into hangup-call-state

Guillaume Zajac (3):
  test: Add hold-and-answer script for GCF testing
  test: Add hangup-call-state script for GCF testing
  test: Add hangup-call script for GCF testing

 Makefile.am            |    5 +++-
 test/hangup-call       |   39 +++++++++++++++++++++++++++++++++++
 test/hangup-call-state |   53 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 test/hold-and-answer   |   20 ++++++++++++++++++
 4 files changed, 116 insertions(+), 1 deletions(-)
 create mode 100755 test/hangup-call
 create mode 100755 test/hangup-call-state
 create mode 100755 test/hold-and-answer

-- =

1.7.5.4


--===============8084719320261960609==--

