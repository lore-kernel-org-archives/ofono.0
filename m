Content-Type: multipart/mixed; boundary="===============3871702957392172566=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 2/4] netreg: add get signal strength API
Date: Fri, 18 Feb 2011 17:34:06 +0100
Message-ID: <1298046848-24622-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1298046848-24622-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3871702957392172566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/netreg.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/netreg.h b/include/netreg.h
index 26a3442..871fe6d 100644
--- a/include/netreg.h
+++ b/include/netreg.h
@@ -111,6 +111,7 @@ void *ofono_netreg_get_data(struct ofono_netreg *netreg=
);
 int ofono_netreg_get_location(struct ofono_netreg *netreg);
 int ofono_netreg_get_cellid(struct ofono_netreg *netreg);
 int ofono_netreg_get_status(struct ofono_netreg *netreg);
+int ofono_netreg_get_strength(struct ofono_netreg *netreg);
 int ofono_netreg_get_technology(struct ofono_netreg *netreg);
 const char *ofono_netreg_get_mcc(struct ofono_netreg *netreg);
 const char *ofono_netreg_get_mnc(struct ofono_netreg *netreg);
-- =

1.7.1


--===============3871702957392172566==--

