Content-Type: multipart/mixed; boundary="===============4854118408240856868=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH v3] Add a driver for Quectel UC15 modems (rebased)
Date: Mon, 07 Jul 2014 11:54:46 +0200
Message-ID: <1404726887-35547-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4854118408240856868==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Forgot to send this last patch out with the rest before the weekend, sorry.

Changes since v2:
 o Rebased on master with ublox patch set applied
   - Should be a trivial 3-way merge on Makefile.am if
     the patches are applied out of order
 o Reworked the reset/enable code patch based on
   suggestions from Denis
   - Register for +CPIN: rather than polling
 o Used prefixes (even more) consistently


Philip Paeps (1):
  plugins: add a new driver for Quectel UC15 modems

 Makefile.am       |    3 +
 plugins/quectel.c |  379 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 382 insertions(+)
 create mode 100644 plugins/quectel.c

-- =

1.7.10.4


--===============4854118408240856868==--

