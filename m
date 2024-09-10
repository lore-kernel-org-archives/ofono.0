Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E71B17C7C2
	for <ofono@lists.linux.dev>; Tue, 10 Sep 2024 07:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952962; cv=none; b=KDDanCiQP8ADZa1jAQEwIOnYoCQWjsCNiN+Fcx5z59x9trfcHpncKQbNU5gFiMpjMrV8H6g/RDwwN/BT171syYNVtnTDGM5YXGwr4f5P9fuViYIwm/T6Mh7rRT3RQ7eKmV0KzHOqgwTTM8doreSCZxZbd60lThLZ0O7JZ3pMAKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952962; c=relaxed/simple;
	bh=0cjSgPt2avxEsa3LgRUFKkceFkvM80LhsO967CpAaXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NBC9upovTGir6i9oUwdtU8ilIfzfFCuv1xHU0EDI2/z1aOQ0rGtPR+ixFlEMneA+F9xrZEnsWp6ga3ZLiZFcPt251yZ9kNDOnwzODV/yeq1H5zfpDLP2oo6CuD5w668kw4qQUgkO/mh694vD07n+hX5pBUnkRyJt7HN25a7els8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=OBFLLyID; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="OBFLLyID"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=S3FXlM64YpYaxM30ThV8s9rJE8G/Uw60Q09a97I8sCo=; b=OBFLLyIDaI3G6JbJRQUYsdbZ77
	ZzIWYBqso6e25B3HipZCb5GdphVvqVMJg+3U+A//bxMbY5iTVpjUJmuryPkj8hlxAcraFtM8ydimX
	a9/+TBuYpx2YCrjdEP4eSfdEQZdX49yUWU+Cj8AP7vcFraDvWwlPMFjPDqiZP+FDUZ92gP3yiEfXf
	PJKm2a28iTDM3RYo4BmJC71+spj2jgR1dRU+BB+/WLVHEXdCtQ3EGKEeNjhwiMmykmJjMP00Bn21x
	PZs6eg3eB4iqvl6NulE5IJ/OAiBF+7wGkxU2ShfXZBsJ/USZz9CT9k4nqZFoBWmNkshSaLjix3XUc
	zlIovI1w==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <benjamin@geanix.com>)
	id 1snvCv-0009YW-3m; Tue, 10 Sep 2024 09:22:37 +0200
Received: from [185.17.218.86] (helo=benjamin-ThinkPad.geanix.com)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <benjamin@geanix.com>)
	id 1snvCu-0005mq-1m;
	Tue, 10 Sep 2024 09:22:36 +0200
From: "Benjamin B. Frost" <benjamin@geanix.com>
To: ofono@lists.linux.dev
Cc: sean@geanix.com,
	martin@geanix.com,
	denkenz@gmail.com,
	"Benjamin B. Frost" <benjamin@geanix.com>
Subject: [PATCH 2/3] quectel: support for EG916Q-GL
Date: Tue, 10 Sep 2024 09:22:09 +0200
Message-Id: <20240910072210.2618396-3-benjamin@geanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910072210.2618396-1-benjamin@geanix.com>
References: <20240910072210.2618396-1-benjamin@geanix.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: benjamin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27393/Mon Sep  9 10:29:16 2024)

add support for Quectel EG916Q-GL
---
 plugins/quectel.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index cee802d7..72827097 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -50,7 +50,7 @@ static const char *cfun_prefix[] = { "+CFUN:", NULL };
 static const char *cpin_prefix[] = { "+CPIN:", NULL };
 static const char *cbc_prefix[] = { "+CBC:", NULL };
 static const char *qinistat_prefix[] = { "+QINISTAT:", NULL };
-static const char *cgmm_prefix[] = { "UC15", "Quectel_M95", "Quectel_MC60",
+static const char *cgmm_prefix[] = { "UC15", "Quectel_M95", "EG916Q-GL", "Quectel_MC60",
 					"EC21", "EC200", NULL };
 static const char *none_prefix[] = { NULL };
 
@@ -69,6 +69,7 @@ enum quectel_model {
 	QUECTEL_UNKNOWN,
 	QUECTEL_UC15,
 	QUECTEL_M95,
+	QUECTEL_EG916Q,
 	QUECTEL_MC60,
 	QUECTEL_EC21,
 	QUECTEL_EC200,
@@ -120,6 +121,7 @@ static ofono_bool_t quectel_model_supports_lte(enum quectel_model model)
 	switch (model) {
 	case QUECTEL_EC21:
 	case QUECTEL_EC200:
+	case QUECTEL_EG916Q:
 		return TRUE;
 	default:
 		return FALSE;
@@ -556,6 +558,7 @@ static void dbus_hw_enable(struct ofono_modem *modem)
 					NULL);
 		break;
 	case QUECTEL_M95:
+	case QUECTEL_EG916Q:
 	case QUECTEL_MC60:
 		g_at_chat_register(data->aux, "OVER_VOLTAGE POWER DOWN",
 					power_notify, FALSE, hw, NULL);
@@ -597,6 +600,7 @@ static void qinistat_cb(gboolean ok, GAtResult *result, gpointer user_data)
 	switch (data->model) {
 	case QUECTEL_UC15:
 	case QUECTEL_EC21:
+	case QUECTEL_EG916Q:
 		/* UC15 uses a bitmap of 1 + 2 + 4 = 7 */
 		ready = 7;
 		break;
@@ -865,6 +869,10 @@ static void cgmm_cb(int ok, GAtResult *result, void *user_data)
 		DBG("%p model M95", modem);
 		data->vendor = OFONO_VENDOR_QUECTEL_SERIAL;
 		data->model = QUECTEL_M95;
+	} else if (strcmp(model, "EG916Q-GL") == 0) {
+		DBG("%p model EG916Q-GL", modem);
+		data->vendor = OFONO_VENDOR_QUECTEL_EG91X;
+		data->model = QUECTEL_EG916Q;
 	} else if (strcmp(model, "Quectel_MC60") == 0) {
 		DBG("%p model MC60", modem);
 		data->vendor = OFONO_VENDOR_QUECTEL_SERIAL;
-- 
2.34.1

