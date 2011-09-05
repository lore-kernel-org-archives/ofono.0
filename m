Content-Type: multipart/mixed; boundary="===============7355458488590314340=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 00/20] Bluetooth SAP Client support
Date: Mon, 05 Sep 2011 15:03:29 -0300
Message-ID: <1315245829-6887-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7355458488590314340==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

Hi,

The following patches add supports for the SAP Client in oFono. Currently o=
nly
Telit UC864-G is supported, but the sap plugin implementation has a modular
approach and support for other hardwares could be easily added.

Please review!

Gustavo F. Padovan (20):
  udevng: look also to VID
  sap: add basic SAP plugin
  telit: add support to enable SAP client
  sap: add support to connect the RFCOMM link
  telit: add #RSEN notify
  sap: add watch for the Bluetooth Link
  sap: add support to open the channel for SAP data
  sap: connect the hw and the bluetooth link
  telit: add telit_sap_disable()
  sap: add support to the disable the SAP client
  telit: add aux GAtChat
  sap: enable modem only when #RSEN is 1
  telit: enable the telit modem when SAP is enabled.
  sap: add pre_sim handling
  sap: add set_online handling
  sap: add post_sim handling
  sap: add post_online handling
  telit: improve sap disable
  sap: disconnect link if enable() fails
  sap: do a proper shutdown of the channels

 Makefile.am         |    3 +
 plugins/bluetooth.c |    1 -
 plugins/bluetooth.h |   23 ++
 plugins/hfp_hf.c    |    2 -
 plugins/sap.c       |  576 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/telit.c     |  315 +++++++++++++++++++++-------
 plugins/udevng.c    |   14 +-
 7 files changed, 847 insertions(+), 87 deletions(-)
 create mode 100644 plugins/sap.c

-- =

1.7.6.1


--===============7355458488590314340==--

