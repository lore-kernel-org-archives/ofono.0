Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196BC166F29
	for <ofono@lists.linux.dev>; Tue,  8 Oct 2024 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378650; cv=none; b=m/c90HP9B1+w/+UZbJXYgyGMZszHxiqzDCtDxCfJswLCxNKxycaLrTH50JQIntW8Xmpdc5eCnoHo3NO7DwEzJF97LMw3zgIoKOLO9jSyjZAeYMbRZZkPyHPVLYVqr3O4KkMN+ilRBOtoXpTAhCGvLeYvZETtApViPqZn9+D63sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378650; c=relaxed/simple;
	bh=rDv9DuV7nRWtXriGhBXKxvSfzkpsfbSMOGq0h8fmSJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eDgJG1IxkUBwqilWdALruI1aRwMpPc/GGuJ+VjCxdWhObuUBr9L/KCL/7niH9mv6wICZZEHn4pAbY6BRLj8Tubr8dwMf4a5fi7Vp7KnTuSgryWee/5hZZJj+Z+qmLRalk5Y8dXFns7Mboee5by50DD4fOIRpfC2bOcGRquSaXKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Hq5uiObx; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Hq5uiObx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=6mMRVSo129lASwyj8g9/9UIGWT20G94SzPLN5Zj3ZQ8=; b=Hq5uiObxkPUMCqAmPt5caPJ1IX
	/Z/+WMPd04FDDthQvqYhLR3vGlOyYvYvfGtwTdm/lDAHpZx4MxXZa0sMT8LcTlzvkGi5OKTEI+x1f
	8lBhXxrL1ExUgPdFQuzc5miErd+Gk/+u2CXph4gIVjO4GFMB8N/EsogzkmkOFeQfZw3dDRk6+TjOv
	OnczMIF53IxgexSlqKy0NOhAPz9nOeNkYXt9jK3IewEuSGrZ3M+n2XKKXFDc8QWGxPHO+BadYF28M
	s+bpm7XfHJgjImWHigL6TYiYv8wZxZGwxaTDT8Lixcw3mEbqDMek8PUAC8A7ECGOnddT34/kI4gOf
	3FAJLQqQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1sy6Ev-000MTM-01; Tue, 08 Oct 2024 11:10:45 +0200
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1sy6Eu-000P2R-26;
	Tue, 08 Oct 2024 11:10:44 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>,
	denkenz@gmail.com
Subject: [PATCH 1/3] drivers: simcommodem: create rat to radio_access_mode function
Date: Tue,  8 Oct 2024 11:10:34 +0200
Message-ID: <20241008091038.1567406-1-sean@geanix.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27420/Mon Oct  7 10:43:46 2024)

This is done in preparation for querying available rat modes
---
 drivers/simcommodem/radio-settings.c | 44 +++++++++++++++++-----------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/simcommodem/radio-settings.c b/drivers/simcommodem/radio-settings.c
index 0feba960..2a9dbaa2 100644
--- a/drivers/simcommodem/radio-settings.c
+++ b/drivers/simcommodem/radio-settings.c
@@ -33,6 +33,30 @@ struct radio_settings_data {
 	GAtChat *chat;
 };
 
+int r_mode_to_radio_access_mode(int r_mode)
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
@@ -61,23 +85,9 @@ static void cnmp_query_cb(gboolean ok, GAtResult *result, gpointer user_data)
 
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
+	mode = r_mode_to_radio_access_mode(r_mode);
+	if (mode < 0)
+		goto error;
 
 	cb(&error, mode, cbd->data);
 
-- 
2.46.2

