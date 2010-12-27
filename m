Content-Type: multipart/mixed; boundary="===============1233116166833406779=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: Fix minor issue in set up menu handling
Date: Mon, 27 Dec 2010 21:07:01 +0200
Message-ID: <1293476822-2532-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1233116166833406779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 menu_changed signal is emitted incase of stk_menu_create_from_set_up_menu
failure as well. This patch changes the order of menu_changed signal and
also introduces NULL check.

Regards,
Jeevaka

badrjee (1):
  stk: fix issue in set up menu handling

 src/stk.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)


--===============1233116166833406779==--

