Content-Type: multipart/mixed; boundary="===============5567955838828813133=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 04/14] Add OFONO_ERROR_TYPE_SIM for negative SIM statuses.
Date: Wed, 07 Jul 2010 00:38:59 +0200
Message-ID: <1278455949-2823-5-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1278455949-2823-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5567955838828813133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Expected value of the .error field is status word 1 and status word 2
in bits 8:15 and 0:7 of the field.
---
 include/types.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/types.h b/include/types.h
index 2b154f0..6098cba 100644
--- a/include/types.h
+++ b/include/types.h
@@ -60,6 +60,7 @@ enum ofono_error_type {
 	OFONO_ERROR_TYPE_CME,
 	OFONO_ERROR_TYPE_CMS,
 	OFONO_ERROR_TYPE_CEER,
+	OFONO_ERROR_TYPE_SIM,
 	OFONO_ERROR_TYPE_FAILURE
 };
 =

-- =

1.7.1.86.g0e460.dirty


--===============5567955838828813133==--

