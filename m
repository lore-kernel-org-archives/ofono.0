Content-Type: multipart/mixed; boundary="===============2845352795514802568=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 3/4] hfp_ag: update SDP record to version 1.6
Date: Wed, 31 Aug 2011 17:21:32 +0200
Message-ID: <1314804093-12504-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1314804093-12504-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2845352795514802568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_ag.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/hfp_ag.c b/plugins/hfp_ag.c
index dc65fde..96230fc 100644
--- a/plugins/hfp_ag.c
+++ b/plugins/hfp_ag.c
@@ -68,7 +68,7 @@ static const gchar *hfp_ag_record =3D
 "    <sequence>\n"
 "      <sequence>\n"
 "        <uuid value=3D\"0x111E\"/>\n"
-"        <uint16 value=3D\"0x0105\" name=3D\"version\"/>\n"
+"        <uint16 value=3D\"0x0106\" name=3D\"version\"/>\n"
 "      </sequence>\n"
 "    </sequence>\n"
 "  </attribute>\n"
-- =

1.7.1


--===============2845352795514802568==--

