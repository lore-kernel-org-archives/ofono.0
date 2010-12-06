Content-Type: multipart/mixed; boundary="===============7968751688967890854=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 09/14] call-settings: fix coding style
Date: Mon, 06 Dec 2010 18:12:37 -0200
Message-ID: <1291666362-19128-9-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291666362-19128-8-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7968751688967890854==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-settings.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/src/call-settings.c b/src/call-settings.c
index 49a7fb0..2bf54d3 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -103,9 +103,9 @@ static const char *clip_status_to_string(int status)
 		return "disabled";
 	case CLIP_STATUS_PROVISIONED:
 		return "enabled";
-	default:
-		return "unknown";
 	}
+
+	return "unknown";
 }
 =

 static const char *colp_status_to_string(int status)
@@ -115,9 +115,9 @@ static const char *colp_status_to_string(int status)
 		return "disabled";
 	case COLP_STATUS_PROVISIONED:
 		return "enabled";
-	default:
-		return "unknown";
 	}
+
+	return "unknown";
 }
 =

 static const char *colr_status_to_string(int status)
@@ -127,9 +127,9 @@ static const char *colr_status_to_string(int status)
 		return "disabled";
 	case COLR_STATUS_PROVISIONED:
 		return "enabled";
-	default:
-		return "unknown";
 	}
+
+	return "unknown";
 }
 =

 static const char *hide_callerid_to_string(int status)
@@ -141,9 +141,9 @@ static const char *hide_callerid_to_string(int status)
 		return "enabled";
 	case OFONO_CLIR_OPTION_SUPPRESSION:
 		return "disabled";
-	default:
-		return "default";
 	}
+
+	return "default";
 }
 =

 static const char *clir_status_to_string(int status)
@@ -157,9 +157,9 @@ static const char *clir_status_to_string(int status)
 		return "on";
 	case CLIR_STATUS_TEMPORARY_ALLOWED:
 		return "off";
-	default:
-		return "unknown";
 	}
+
+	return "unknown";
 }
 =

 static void set_clir_network(struct ofono_call_settings *cs, int clir)
-- =

1.7.3.2


--===============7968751688967890854==--

