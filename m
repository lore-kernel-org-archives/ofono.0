Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59572367AE
	for <ofono@lists.linux.dev>; Thu, 21 Aug 2025 11:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775474; cv=none; b=X0HqKOoWgcQqjx98Mst1LjJQnm4brYbBJgC2L6FqCI3NKCSb6rzP8AyvRkILNfCs+66Oob+P6wP+vH9eFaReZdlUKwENQxXZsizQmYKQkeMaKYiNyw10Go21w0ihXhnm6UxYJN876ozB/NxLv9J6kgUmvhQWSbVn8hgVWPK9SEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775474; c=relaxed/simple;
	bh=678tzRpDMX3Xyh6vd9OMbcT+3NEpsok8XfWJ3FgAjaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=tgPxkXsk9dQ3Oj1vJIFBLPgsV9TZlCAJrOWiTskTtIob1VPr5QrzYOm/aqbltSx9wa0X32OIx+ad7pykTSX+0eO7SYYFylEjYgl/IeYmqwI5Nq981NyjaUbt/v/wEAatJ73AYhikRkPTjRjgkI+HRATvsl1yYCn32SEHZHWWduI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=x4gPigqw; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="x4gPigqw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1755775462; x=1756034662;
	bh=9lLtE1kTTIziKGHLwcTk6aetHSAh/ef8nb3GGP+cQLY=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:From:To:Cc:
	 Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=x4gPigqwKPHVpaCKtX4xCLlEEb4Xhg/qKj4WSZU7by6NTaOzKkrLEq94ulsy/BwY0
	 sZrYsHes1M2WgyJgmOkT8WFVj5QvFZ5RMAIO2BLPSA0nmkrHkPVhpy9lGcpGcR25PB
	 lpLw3sfMEPx7Cl9OfFk06xNQmjCvM319WzEprkcBqcZSvD0RX1HSP4b8WGXYfYSUy6
	 d9cDcUthDz0ikFxxr2ap/t/f0+ZO1ZlooIF3egYSAXXurEk7U2/yIR76zK8jA7qLyD
	 5yrTNFEQmBURzUYefhRn5f8wXB3mxb5GwiendS1R6SXCJ6c/7plu1Crmmj2M2dzYzu
	 Yt68PZNO2lIvw==
X-Pm-Submission-Id: 4c71Dk0vSkz1DDs2
From: Sean Nyekjaer <sean@geanix.com>
Date: Thu, 21 Aug 2025 13:24:12 +0200
Subject: [PATCH 4/5] atmodem: report cell technology capability for SIMCom
 A76XX
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-simcom-v1-4-6c794c5573c3@geanix.com>
References: <20250821-simcom-v1-0-6c794c5573c3@geanix.com>
In-Reply-To: <20250821-simcom-v1-0-6c794c5573c3@geanix.com>
To: denkenz@gmail.com, ofono@lists.linux.dev
X-Mailer: b4 0.14.2

---
 drivers/atmodem/network-registration.c | 80 ++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/network-registration.c
index 8087543117b7abfce87240940e47264283f95234..7f03759b83b3cf8c45cc885a450cdf24ac9aed92 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -38,6 +38,7 @@ static const char *csq_prefix[] = { "+CSQ:", NULL };
 static const char *cind_prefix[] = { "+CIND:", NULL };
 static const char *cmer_prefix[] = { "+CMER:", NULL };
 static const char *smoni_prefix[] = { "^SMONI:", NULL };
+static const char *simcom_tech_prefix[] = { "+CNSMOD:", NULL };
 static const char *zpas_prefix[] = { "+ZPAS:", NULL };
 static const char *option_tech_prefix[] = { "_OCTI:", "_OUWCTI:", NULL };
 
@@ -179,6 +180,45 @@ static int gemalto_parse_tech(GAtResult *result)
 	return tech;
 }
 
+static int simcom_parse_tech(GAtResult *result)
+{
+	GAtResultIter iter;
+	int s, stat, tech;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CNSMOD:"))
+		return -1;
+
+	if (!g_at_result_iter_next_number(&iter, &s))
+		return -1;
+
+	if (!g_at_result_iter_next_number(&iter, &stat))
+		return -1;
+
+	switch (stat) {
+	case 1: /* GSM */
+		tech = ACCESS_TECHNOLOGY_GSM;
+		break;
+	case 2: /* GPRS */
+		tech = ACCESS_TECHNOLOGY_GSM;
+		break;
+	case 3: /* EDGE */
+		tech = ACCESS_TECHNOLOGY_GSM_EGPRS;
+		break;
+	case 8: /* LTE */
+		tech = ACCESS_TECHNOLOGY_EUTRAN;
+		break;
+	default:
+		tech = -1;
+		break;
+	}
+
+	DBG("stat %d tech %d", stat, tech);
+
+	return tech;
+}
+
 static void at_creg_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd = user_data;
@@ -246,6 +286,18 @@ static void option_tech_cb(gboolean ok, GAtResult *result, gpointer user_data)
 		nd->tech = -1;
 }
 
+static void simcom_tech_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd = user_data;
+	struct ofono_netreg *netreg = cbd->data;
+	struct at_netreg_data *nd = ofono_netreg_get_data(netreg);
+
+	if (ok)
+		nd->tech = simcom_parse_tech(result);
+	else
+		nd->tech = -1;
+}
+
 void at_registration_status(struct ofono_netreg *netreg,
 					ofono_netreg_status_cb_t cb,
 					void *data)
@@ -299,6 +351,13 @@ void at_registration_status(struct ofono_netreg *netreg,
 					option_tech_cb, cbd, NULL) == 0)
 			nd->tech = -1;
 		break;
+	case OFONO_VENDOR_SIMCOM_A76XX:
+		/* Send AT+CNSMOD? to find out the current tech */
+		if (g_at_chat_send(nd->chat, "AT+CNSMOD?",
+					simcom_tech_prefix,
+					simcom_tech_cb, cbd, NULL) == 0)
+			nd->tech = -1;
+		break;
 	}
 
 	if (g_at_chat_send(nd->chat, "AT+CREG?", creg_prefix,
@@ -1561,6 +1620,21 @@ static void option_query_tech_cb(gboolean ok, GAtResult *result,
 			tq->status, tq->lac, tq->ci, tech);
 }
 
+static void simcom_query_tech_cb(gboolean ok, GAtResult *result,
+						gpointer user_data)
+{
+	struct tech_query *tq = user_data;
+	int tech;
+
+	if (ok)
+		tech = simcom_parse_tech(result);
+	else
+		tech = -1;
+
+	ofono_netreg_status_notify(tq->netreg,
+			tq->status, tq->lac, tq->ci, tech);
+}
+
 static void creg_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg = user_data;
@@ -1620,6 +1694,12 @@ static void creg_notify(GAtResult *result, gpointer user_data)
 					gemalto_query_tech_cb, tq, g_free) > 0)
 			return;
 		break;
+	case OFONO_VENDOR_SIMCOM_A76XX:
+		if (g_at_chat_send(nd->chat, "AT+CNSMOD?",
+					simcom_tech_prefix,
+					simcom_query_tech_cb, tq, g_free) > 0)
+			return;
+		break;
 	}
 
 	g_free(tq);

-- 
2.50.1

