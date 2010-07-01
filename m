Content-Type: multipart/mixed; boundary="===============6150942123203737437=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 00/10] html text attributes patches 
Date: Thu, 01 Jul 2010 08:31:15 -0700
Message-ID: <1277998285-30207-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6150942123203737437==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Incorporated feedback from last review.  Added requested
unit tests.

Kristen Carlson Accardi (10):
  stkutil: display text attributes as html
  test-stkutil: add unit test for html text attributes
  test-stkutil: add html attribute test for Display Text tests
  test-stkutil: add html attribute tests for get_inkey_test
  test-stkutil: add html attribute tests for get_input_test
  test-stkutil: add html attribute tests for play_tone_test
  test-stkutil: add html attribute test for setup_menu_test
  test-stkutil: add html attribute test for select_item_test
  test-stkutil: add html attribute tests for setup idle mode tests
  test-stkutil: add html_attr_test for special chars

 src/stkutil.c       |  219 ++++++++++++++++
 src/stkutil.h       |    2 +
 unit/test-stkutil.c |  687 ++++++++++++++++++++++++++++++++++++++++++++---=
----
 3 files changed, 816 insertions(+), 92 deletions(-)


--===============6150942123203737437==--

