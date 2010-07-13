Content-Type: multipart/mixed; boundary="===============3573422195947357601=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 0/9] html text attribute patches 
Date: Tue, 13 Jul 2010 05:40:46 -0700
Message-ID: <1279024855-10586-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3573422195947357601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changed from last version:
* incorporated feedback from latest review
* dropped invalid test from html text attributes unit test

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

 src/stkutil.c       |  225 +++++++++++++++
 src/stkutil.h       |    2 +
 unit/test-stkutil.c |  765 ++++++++++++++++++++++++++++++++++++++++++++---=
---
 3 files changed, 900 insertions(+), 92 deletions(-)


--===============3573422195947357601==--

