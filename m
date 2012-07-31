Content-Type: multipart/mixed; boundary="===============3657108767456782623=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 0/2] Add new scripts for GCF testing
Date: Tue, 31 Jul 2012 11:45:25 +0200
Message-ID: <1343727927-15424-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3657108767456782623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

1st patch adds hold-and-answer script needed GPP test cases:
31.3.2.1, 31.3.2.2 and 31.3.2.3 in 3GPP 51.010.

2nd patch adds hangup <call_state> script needed for 3GPP test case 31.3.1.=
3.1
in 3GPP 51.0.10.

Guillaume Zajac (2):
  test: Add hold-and-answer script for GCF testing
  test: Add hangup script for GCF testing

 Makefile.am          |    4 ++-
 test/hangup          |   53 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 test/hold-and-answer |   20 ++++++++++++++++++
 3 files changed, 76 insertions(+), 1 deletions(-)
 create mode 100755 test/hangup
 create mode 100755 test/hold-and-answer

-- =

1.7.5.4


--===============3657108767456782623==--

