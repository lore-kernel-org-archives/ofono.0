Content-Type: multipart/mixed; boundary="===============4936045218207225123=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 0/8]  External HFP: Add SCO
Date: Mon, 28 Jan 2013 18:11:00 -0300
Message-ID: <1359407468-5110-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1359384259-5384-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4936045218207225123==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series adds Bluetooth SCO socket declaration and the initial =

code to manage HF audio connections.

Bluetooth headers is being declared locally since the objective in the
future is to remove this dependency.

Changes between v0-v1:
* merged sco_init and sco_listen
* set sockt flags when the socket is created
* removed bt_getsockpeers
* other minor fixes

Pending:
* g_hash_table_find vs g_hash_table_lookup: It is not feasible
to use lookup. It will require to use another hash table key for the
modem or create an additional adapter hash table.

Claudio Takahasi (8):
  bluez5: Add SCO socket declarations
  bluez5: Add bt_bacpy()
  hfp_hf_bluez5: Add SCO listen socket
  bluez5: Add bt_ba2str()
  bluez5: Add bt_bacmp()
  bluez5: Add RFCOMM socket address declaration
  hfp_hf_bluez5: Add rejecting SCO connection
  hfp_hf_bluez5: Fix missing fd close

 plugins/bluez5.c        |  21 +++++++
 plugins/bluez5.h        |  41 +++++++++++++
 plugins/hfp_hf_bluez5.c | 156 ++++++++++++++++++++++++++++++++++++++++++++=
----
 3 files changed, 208 insertions(+), 10 deletions(-)

-- =

1.7.11.7


--===============4936045218207225123==--

