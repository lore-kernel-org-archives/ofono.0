Content-Type: multipart/mixed; boundary="===============1831744452586614479=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 1/2] Make function reset_available() return void
Date: Thu, 19 Aug 2010 14:05:34 +0800
Message-ID: <1282197935-9118-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1831744452586614479==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This change is to dispel compiler's complaint.
---
 src/network.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/network.c b/src/network.c
index f5b9a5e..190eba9 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1175,7 +1175,7 @@ static void notify_status_watches(struct ofono_netreg=
 *netreg)
 	}
 }
 =

-static gboolean reset_available(struct network_operator_data *old,
+static void reset_available(struct network_operator_data *old,
 				const struct ofono_network_operator *new)
 {
 	if (old =3D=3D NULL)
-- =

1.7.0.4


--===============1831744452586614479==--

