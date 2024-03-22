Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87D44C84
	for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116591; cv=none; b=CbaZlL8FGXP7x6LEt9x6RaOF8m3PN0H2TP81TC3efERb88lPV8mi3ZW/tKk0j4TFybHZ8PFHxiZuHB4hvHkwyyIYVnJz/c2qSqjj4+ag4eVO+jpd2C7M9V8x09djcQtAb+HdEtcSwXExcL2pLR2Ga11UdFfXUGX8KVjybulQC2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116591; c=relaxed/simple;
	bh=j8l3Fp3PW4BOpy63MNEM9SvQN4B+Ywm2uNjjgwlpAoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jK71MX2XMJz5PLilWaDx9DdqW71ytk+bBvSDCDOH9oiVfiEqPuKa1Pim8tbl3u7OzPFLxepz+PNbTjyP8Njx2XxHYk2UgzlZy+AT6PnpIkyRfzBZUQcxnM0cSI2sj0rLbBvZwLyaP9tLmMEqNmYjZdzHEbhVHVe5XrRdAqVgsvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dO/ydKol; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dO/ydKol"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a496fde460so1018862eaf.1
        for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 07:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711116589; x=1711721389; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eMyaSEp4kL4adxi1Q9+/pXvSoD/evuGdShsvZRKch8=;
        b=dO/ydKolByhAMMDp1oF6g9vy30A0jscK0w9Ia7D7op2ZBm7gG8ujxO77Z5aDAyTxjH
         nI0X1z8zkfY0Pq9jZjmqTXfhCd1KGOlzWTTr/x6OphyDNl2WwJPCJCDqQGiPkTsKkomH
         z4u0UeVJO+Q8Ja7iN+Cn1jqnIPoidNguI4bV1/CB+3gOAotyoKWyLlWiK3iQjZhfWDti
         6iofpWDrxiCd8WbR6oNp+koYAN1YCvm72goFZQuDVMm4MiVxua0BMDHqXqQVqnpAaqX3
         0DuIcUossAgWeltmHL1aM487tXVGFXKojKwP8sjG6kkz9C+SxnL3Ae0GQJy3WhDMR6Zi
         xuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711116589; x=1711721389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eMyaSEp4kL4adxi1Q9+/pXvSoD/evuGdShsvZRKch8=;
        b=QGeViUhXC57pjtEIW4r2DQIS7BDSyKUR6J/an65OslG1+n3p+WN0MitdgPlJg3NhaB
         gDohsFc1AOxwzYMbiTcExjQlZi4hZtRgORINtBh8N+C56EiyR6Jn4g7OHY5uZkKSIFjZ
         sRYY6vzH4hnI9DxSl7KzZc864FyPUHovHOYmEUa5zH3IWEn+TE6eoN3uaOovRc5ePxUl
         lEJOkK+hUe4V/2pqgDcNpRNPWkCI2SorYOOlrmnFFIy0vxqvuCeJwFuGoL6Nu1asO6eF
         BYxMROPsSPYuRgTmYjhcSkLEG/CSHvVeS/g2wu7ZQpyoVUCnu+m0OIVZxibFoyT8YuYf
         tKFQ==
X-Gm-Message-State: AOJu0YyL3jPWkyX1bfe+7W5QhH6aaQ6IFcjqzwVYxvLrVu981G+3W+OB
	BN5/ECcC4bYEGlhSaoILVLjId4sAWg2Pv6zc4H760J6HwsN/X6+Aok3NcggH
X-Google-Smtp-Source: AGHT+IGB6dIzI/YWV7iBl7PB6UtXWOUXeArb1XJKTsAj2iBBd3E7dSEdUixhmj2A6mg7N2N49jpjmw==
X-Received: by 2002:a05:6820:2016:b0:5a5:27ab:189d with SMTP id by22-20020a056820201600b005a527ab189dmr807044oob.6.1711116589371;
        Fri, 22 Mar 2024 07:09:49 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id cs2-20020a056820258200b005a1f748f3edsm303673oob.30.2024.03.22.07.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:09:49 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 07/11] gemalto: Set modem lte capable
Date: Fri, 22 Mar 2024 09:09:08 -0500
Message-ID: <20240322140942.2703042-7-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322140942.2703042-1-denkenz@gmail.com>
References: <20240322140942.2703042-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 plugins/gemalto.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index 358d56a7aaf1..219354f7300e 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -217,11 +217,17 @@ static void sim_state_cb(gboolean present, gpointer user_data)
 {
 	struct ofono_modem *modem = user_data;
 	struct gemalto_data *data = ofono_modem_get_data(modem);
+	const char *model = ofono_modem_get_string(modem, "Model");
 
 	at_util_sim_state_query_free(data->sim_state_query);
 	data->sim_state_query = NULL;
 
 	data->have_sim = present;
+
+	if (!g_strcmp0(model, GEMALTO_MODEL_ALS3_PLS8x) ||
+			!g_strcmp0(model, GEMALTO_MODEL_ELS81x))
+		ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
+
 	ofono_modem_set_powered(modem, TRUE);
 
 	/* Register for specific sim status reports */
@@ -609,7 +615,7 @@ static void gemalto_post_sim(struct ofono_modem *modem)
 		ofono_gprs_add_context(gprs, gc);
 
 	if (!g_strcmp0(model, GEMALTO_MODEL_ALS3_PLS8x) ||
-	    !g_strcmp0(model, GEMALTO_MODEL_ELS81x))
+			!g_strcmp0(model, GEMALTO_MODEL_ELS81x))
 		ofono_lte_create(modem, OFONO_VENDOR_GEMALTO,
 						"atmodem", data->app);
 }
-- 
2.43.0

