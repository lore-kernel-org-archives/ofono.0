Content-Type: multipart/mixed; boundary="===============4638242327121280981=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 2/3] hfp_ag: fix SDP record
Date: Mon, 20 Jun 2011 17:13:47 +0200
Message-ID: <1308582828-3806-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1308582828-3806-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4638242327121280981==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

HFP AG supports 3 way calls
---
 plugins/hfp_ag.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/hfp_ag.c b/plugins/hfp_ag.c
index 17751ad..191708b 100644
--- a/plugins/hfp_ag.c
+++ b/plugins/hfp_ag.c
@@ -81,7 +81,7 @@ static const gchar *hfp_ag_record =3D
 "  </attribute>\n"
 "\n"
 "  <attribute id=3D\"0x0311\">\n"
-"    <uint16 value=3D\"0x0000\" />\n"
+"    <uint16 value=3D\"0x0001\" />\n"
 "  </attribute>\n"
 "</record>\n";
 =

-- =

1.7.1


--===============4638242327121280981==--

