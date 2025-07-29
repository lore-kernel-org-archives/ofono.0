Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1B638B
	for <ofono@lists.linux.dev>; Tue, 29 Jul 2025 05:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753766518; cv=none; b=MvJ3N+mrF/K27+IZZJuXcNTgb1N/+OUanEOTunWGI/MN6AR3gJDG38ImNwMO3dKfeUNhzVp9zSBs3V/7pEGfKqEfUPQjvMgA6g4VicYTeI8KNrXvbw8xBhtpj3svFjxz9R4bxWhCla+mLwyAWl9FSu6yaeXAu/Z9i0VL2cif4a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753766518; c=relaxed/simple;
	bh=GIyzcRljitopB6FApxQjoox+6ofhWpWiXACvZCixY+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pqQrKDSVfzL3enC17e3yTbcxi+okLhrXfiDtNvdnv6bRoIjz8FpevL0ESWjpJA5IWdNvM9W08mIWFxxcMUROQY7LsQ2452sCMMUSgt5GP/W8AfOL3FLBoEfSgudfyuOA7yiIQ2DNZbFK1jFLi8IGA/sKJtpiecgw4koyrR1SuCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHP9DEnb; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHP9DEnb"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6088d856c6eso10046117a12.0
        for <ofono@lists.linux.dev>; Mon, 28 Jul 2025 22:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753766515; x=1754371315; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8C9e7PGN5XRp+kWZ8Q298L67bWyg/HjGxgWCbeSQUcY=;
        b=iHP9DEnbMVY1l02eHR46srDYxIHhZN9L7j0Gnn21hzl6SOrT+r6kymokT9DuBEOgvI
         hCcXkfSmJ/wzyOmvymloCOB5bXZ7JbmD39CuQifuu3COtwAacuTYv5uSnQd8hoqIFHzi
         gKtRz4cMvVOMt/pQAbro01JDHAhGMiuQS/ZQuX294lLgDwP8TzjJ2tRPzbMshtLRYarP
         NR8SgNKcuN1hw/L/090nb9uREwY3wZXlguidrSfmTmDhgG5U8x+w+Y8iNQ67LleTaWOt
         L1HhltobixlTEtyLUHt0zHWFK/3ZwT2trn+3EQ3+Vfc0SK557jI4weg4DQrpOP2o13C6
         2jsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753766515; x=1754371315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8C9e7PGN5XRp+kWZ8Q298L67bWyg/HjGxgWCbeSQUcY=;
        b=Wa/9w39mvFuUEECnlgpsc2Q1xODhKpZw/w+h7gCM2LSo9eEvBbvDztLSr1p05eUWZ7
         PuEZdQR7OJj4KcoCwAgOhGsC9cKNTK24V+JbehadFmrnhQL534OZSh8opVrQxKfx0z4w
         UoxrJZeytD6NnCrlqwCC6x2rLPG9y/60mdDP6p64yaAt2yJSFYRsNYPiIV4GJkHbCkLg
         GIIojRDUdtbIXym/vjDeD6UmIZGSBfUAC/z2obvyXz2etgdhRC/bZi5YBTdhpXMc73F4
         BjjYy2sCcbzhdcSYVAlo2qefDFXxjkqEzJv1uH1R/rueh0AcVOPwbwL5IBf4YKHwu3OM
         hHNA==
X-Gm-Message-State: AOJu0Yw03QpAJ4sQYTiBzU2KaPI9GUKZguzQhJKoYtnZ2SQMCP/eNqcC
	Uf2Imh5mGs2FPg6zGAa+yFOJCrs/U1E01qffpFbhMf4tBNlxdNQwy0BYdTf0wg==
X-Gm-Gg: ASbGncv0cOMKdl/hwueXYe7AqbVvD79kD0l/khfiiXbmvXMdM33/Y3i9H8FjJFyzVvu
	GHu7Kk76Ss1IKz+/iBNHioR5VQXOmRaDmK0h9/y00MSAFkQjntxlMEZmIUwSochB/xMglSgWaLb
	2yTe+/RfPU63GIvIwabm0EklZ3ZYzCKi7MV0Ll4dA57A4163hY+kDczw4GSg1Up9J8bWdyI5nfF
	iZ8KqFZyB1m0DANe0E6mtMesHwCbQs/Wj2ruHjdOQ03Co40wYVbtsxjIiBZMeDg6xcF2YKMRPLS
	bhu5u1mpqLUkqi6new7+flwqI3FcfkrJk2S4n5QbfZBzcOJ62IHXZ01C3xuUlBgt1/HYVtIBtQc
	W82tCTOtKY3f7kc5uRcVGFhmK6F7C4vqcIwjKg82RQlSu
X-Google-Smtp-Source: AGHT+IGzDnH1U4kBIPkosNx7YF/u/vCrH34KfuWmjv75mDR3lxLAaH+BaWGRGCWvsoK+Qxvt/FUPVw==
X-Received: by 2002:a17:907:3cc4:b0:ae0:b3cd:b7f8 with SMTP id a640c23a62f3a-af619608944mr1589213366b.40.1753766514311;
        Mon, 28 Jul 2025 22:21:54 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af63589cab0sm525110266b.38.2025.07.28.22.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 22:21:53 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 1/3] gobi: do not assume LTE is supported, detect it
Date: Tue, 29 Jul 2025 08:21:30 +0300
Message-Id: <20250729052132.779994-2-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250729052132.779994-1-ivo.g.dimitrov.75@gmail.com>
References: <20250729052132.779994-1-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 plugins/gobi.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 3d4d133c..d5a7fc18 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -57,6 +57,7 @@
 #define GOBI_UIM	(1 << 5)
 #define GOBI_VOICE	(1 << 6)
 #define GOBI_WDA	(1 << 7)
+#define GOBI_LTE	(1 << 8)
 
 #define MAX_CONTEXTS 4
 #define DEFAULT_MTU 1400
@@ -263,7 +264,6 @@ static int gobi_probe(struct ofono_modem *modem)
 	data->max_aggregation_size = 16384;
 
 	ofono_modem_set_data(modem, data);
-	ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
 
 	return 0;
 }
@@ -480,8 +480,17 @@ static void get_caps_cb(struct qmi_result *result, void *user_data)
         DBG("service capabilities %d", caps->data_capa);
         DBG("sim supported %d", caps->sim_supported);
 
-        for (i = 0; i < caps->radio_if_count; i++)
-                DBG("radio = %d", caps->radio_if[i]);
+	for (i = 0; i < caps->radio_if_count; i++) {
+		uint8_t iface = caps->radio_if[i];
+
+		DBG("radio = %d", iface);
+
+		if (iface & QMI_DMS_RADIO_IF_LTE)
+			data->features |= GOBI_LTE;
+	}
+
+	if (data->features & GOBI_LTE)
+		ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
 
 	if (qmi_service_send(data->dms, QMI_DMS_GET_OPER_MODE, NULL,
 					get_oper_mode_cb, modem, NULL) > 0)
@@ -1144,7 +1153,7 @@ static void gobi_post_sim(struct ofono_modem *modem)
 
 	DBG("%p", modem);
 
-	if (data->features & GOBI_WDS)
+	if (data->features & GOBI_WDS && data->features & GOBI_LTE)
 		ofono_lte_create(modem, 0, "qmimodem",
 					qmi_service_clone(data->wds));
 
-- 
2.25.1

