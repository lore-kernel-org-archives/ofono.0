Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE27F210C07
	for <ofono@lists.linux.dev>; Fri, 11 Oct 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641945; cv=none; b=HQ9cR9MXUsmQercaL97+E7NNOlLpgMPjWozmshLU5xDQuzpaZ9aUOfsEQOTgWeC9S7NmmbRmutqSTeegiKgL57tv5OGzq6cVGRIfm/0dUPMrIBvs8MTmunMfrFKfAESz72wV2v+txJVHLTNRR8ms5sEyt4bxfMl33TePKaMAGlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641945; c=relaxed/simple;
	bh=rZHgP7XJCWrAuiL1XSbPmxZ0npa5vdR0A8TXea0ta8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bCeKH12Fv4ZaJDmdzeXY8peU4nv6qpgMV/cCHrJtNEhYOzgU0fWL67nPp9CghTKlYEqUybsMPgEk5kS5xfH74EqtDTS7AAukCqVEJEOUIl7Ci5DA5DIFQZwmdlWuOZIPnIHbFMkFPy6aIuEecDCb8a6k0x3nHpcqJ9D9fDFhc7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=aD82yDvH; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="aD82yDvH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=lCZLPnVNHDw4RxrTVRPXoctieHzE2UIl42Eth1hg5ZY=; b=aD82yDvHCxNFRS3izNdk8wEO0e
	V/ApCo89RzDVNLfRKRzrh9GUKlOW2MrZNFriSdjp8fCBQ/B+N9ODAgG9brWCYTOC/8oPDJtGJRvtA
	qwZ2hzzcncw5IBOjtpME9oas92rw1l1hu3r1b3Ahr+xtuIv8e07+L1FLnILpEF6/eh2MRioqrZrJw
	PW1zPSOo0n3QDFWFq+VPbMgziAnqssiy2PKXUiRWwMzQy6ZfPHz7HUTQxY9BIS0P3naPKpAPyj33w
	AXW4VH8qrfC+Z1HBcA38/5gXpAu8sJcgG633//LfuvSpJZDEI9k3sY54W5QBAXJayNYKdtwbB4uwQ
	caVrrLZg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1szCjX-000FFI-H1; Fri, 11 Oct 2024 12:18:55 +0200
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1szCjW-0002Ly-1R;
	Fri, 11 Oct 2024 12:18:54 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>,
	denkenz@gmail.com
Subject: [PATCH v2 1/3] drivers: simcommodem: create rat to radio_access_mode function
Date: Fri, 11 Oct 2024 12:18:34 +0200
Message-ID: <20241011101839.3646442-1-sean@geanix.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27424/Fri Oct 11 10:30:09 2024)

This is done in preparation for querying available rat modes
---
Changes since v1:
 - fixed function name
 - changed mode variable to int, to allow negative numbers

 drivers/simcommodem/radio-settings.c | 47 +++++++++++++++++-----------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/simcommodem/radio-settings.c b/drivers/simcommodem/radio-settings.c
index 0feba960..bf78c748 100644
--- a/drivers/simcommodem/radio-settings.c
+++ b/drivers/simcommodem/radio-settings.c
@@ -33,13 +33,36 @@ struct radio_settings_data {
 	GAtChat *chat;
 };
 
+static int cnmp_mode_to_radio_access_mode(int r_mode)
+{
+	int mode;
+
+	switch (r_mode) {
+	case 2:
+		mode = OFONO_RADIO_ACCESS_MODE_ANY;
+		break;
+	case 13:
+		mode = OFONO_RADIO_ACCESS_MODE_GSM;
+		break;
+	case 14:
+		mode = OFONO_RADIO_ACCESS_MODE_UMTS;
+		break;
+	case 38:
+		mode = OFONO_RADIO_ACCESS_MODE_LTE;
+		break;
+	default:
+		return -1;
+	}
+
+	return mode;
+}
+
 static void cnmp_query_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd = user_data;
 	ofono_radio_settings_rat_mode_query_cb_t cb = cbd->cb;
-	unsigned int mode;
 	struct ofono_error error;
-	int r_mode;
+	int r_mode, mode;
 	GAtResultIter iter;
 
 	DBG("ok %d", ok);
@@ -61,23 +84,9 @@ static void cnmp_query_cb(gboolean ok, GAtResult *result, gpointer user_data)
 
 	DBG("r_mode %d", r_mode);
 
-	switch (r_mode) {
-	case 2:
-		mode = OFONO_RADIO_ACCESS_MODE_ANY;
-		break;
-	case 13:
-		mode = OFONO_RADIO_ACCESS_MODE_GSM;
-		break;
-	case 14:
-		mode = OFONO_RADIO_ACCESS_MODE_UMTS;
-		break;
-	case 38:
-		mode = OFONO_RADIO_ACCESS_MODE_LTE;
-		break;
-	default:
-		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-		return;
-	}
+	mode = cnmp_mode_to_radio_access_mode(r_mode);
+	if (mode < 0)
+		goto error;
 
 	cb(&error, mode, cbd->data);
 
-- 
2.46.2

