Content-Type: multipart/mixed; boundary="===============9137404443143835235=="
MIME-Version: 1.0
From: Marit Henriksen <maritsofie.henriksen8@gmail.com>
Subject: [PATCH] stemodem: Removed defaults in switches.
Date: Fri, 14 Jan 2011 12:18:47 +0100
Message-ID: <1295003927-11283-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9137404443143835235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marit Henriksen <marit.henriksen@stericsson.com>

Coding style guidline M12.
---
 drivers/stemodem/voicecall.c |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index 99383cf..2ce315c 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -76,7 +76,7 @@ struct change_state_req {
 };
 =

 /* Translate from the ECAV-based STE-status to CLCC based status */
-static int call_status_ste_to_ofono(int status)
+static int call_status_ste_to_ofono(enum call_status_ste status)
 {
 	switch (status) {
 	case STE_CALL_STATUS_IDLE:
@@ -95,9 +95,9 @@ static int call_status_ste_to_ofono(int status)
 		return CALL_STATUS_INCOMING;
 	case STE_CALL_STATUS_BUSY:
 		return CALL_STATUS_DISCONNECTED;
-	default:
-		return CALL_STATUS_DISCONNECTED;
 	}
+
+	return CALL_STATUS_DISCONNECTED;
 }
 =

 static struct ofono_call *create_call(struct ofono_voicecall *vc, int type,
@@ -198,22 +198,22 @@ static void ste_dial(struct ofono_voicecall *vc,
 		snprintf(buf, sizeof(buf), "ATD%s", ph->number);
 =

 	switch (clir) {
+	case OFONO_CLIR_OPTION_DEFAULT:
+		break;
 	case OFONO_CLIR_OPTION_INVOCATION:
 		strcat(buf, "I");
 		break;
 	case OFONO_CLIR_OPTION_SUPPRESSION:
 		strcat(buf, "i");
 		break;
-	default:
-		break;
 	}
 =

 	switch (cug) {
+	case OFONO_CUG_OPTION_DEFAULT:
+		break;
 	case OFONO_CUG_OPTION_INVOCATION:
 		strcat(buf, "G");
 		break;
-	default:
-		break;
 	}
 =

 	strcat(buf, ";");
@@ -528,9 +528,6 @@ static void ecav_notify(GAtResult *result, gpointer use=
r_data)
 		existing_call->status =3D status;
 		ofono_voicecall_notify(vc, existing_call);
 		break;
-
-	default:
-		break;
 	}
 }
 =

-- =

1.7.1


--===============9137404443143835235==--

