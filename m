Content-Type: multipart/mixed; boundary="===============2634508589428985055=="
MIME-Version: 1.0
From: Piotr Haber <gluedig@gmail.com>
Subject: [PATCH 0/2] unify telit and xe910 plugins
Date: Thu, 02 Feb 2017 15:09:25 +0100
Message-ID: <20170202140927.8152-1-gluedig@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2634508589428985055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Expect of Bluetooth SAP related funcionality
most of the code in telit and xe910 plugins is the same.
Also unify udevng initialization code.

Piotr Haber (2):
  plugins: rename xe910 to telit
  udevng: unify telit and xe910

 Makefile.am      |   7 +-
 plugins/telit.c  | 550 +++++++++++++++++++++------------------------------=
----
 plugins/udevng.c |  44 +----
 plugins/xe910.c  | 546 ---------------------------------------------------=
---
 4 files changed, 213 insertions(+), 934 deletions(-)
 delete mode 100644 plugins/xe910.c

-- =

2.11.0


--===============2634508589428985055==--

