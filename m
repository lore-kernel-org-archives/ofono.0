Content-Type: multipart/mixed; boundary="===============4914621128607027630=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 0/9] html text attribute patches 
Date: Fri, 02 Jul 2010 06:45:59 -0700
Message-ID: <1278078368-32565-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4914621128607027630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changes since last version:

* made utf8 safe
* changed signature to use 16 bit arrays for attributes
* changed signature to use number of attributes rather than length of attri=
bute
* assume attributes are always 4 bytes
* incorporated other feedback from last review
* added unit test for utf8 text

Kristen Carlson Accardi (9):
  stkutil: display text attributes as html
  test-stkutil: add unit test for html text attributes
  test-stkutil: add html attribute test for Display Text tests
  test-stkutil: add html attribute tests for get_inkey_test
  test-stkutil: add html attribute tests for get_input_test
  test-stkutil: add html attribute tests for play_tone_test
  test-stkutil: add html attribute test for setup_menu_test
  test-stkutil: add html attribute test for select_item_test
  test-stkutil: add html attribute tests for setup idle mode tests

 src/stkutil.c       |  229 ++++++++++++++++
 src/stkutil.h       |    2 +
 unit/test-stkutil.c |  714 ++++++++++++++++++++++++++++++++++++++++++++---=
----
 3 files changed, 853 insertions(+), 92 deletions(-)


--===============4914621128607027630==--

