Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7118612C7E0
	for <ofono@lists.linux.dev>; Fri,  2 Feb 2024 22:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914509; cv=none; b=IpUsCl0mfmB/p1scC3Rife/YHs5WJYNZod4CAlIKHYi77wOg4ULDCB/tYIYebOoWoe3FGPhAr9mUWw6101vnfSUx3ym7Qa5rTA902qyPe0HAvD27Dwn6GVKQTYRwjosGdX2mc8O6JNrYbjVUIgsrlv/1jpZuM4IbqvPNcPQDeWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914509; c=relaxed/simple;
	bh=IzXzFFgS3b8+0T+p2h8GAZfKn95E9budQkbShILeJmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/90AOWvoS1WmZyuSh9wpQCIow61FGUVjEx0gykfKzDwYq7pexa8Nd0N77dDfdJnlbhvOjWXd9/lUailup7KDjaYWAQ7yGBNm3lVZiNK+oSnM3bYjI+1gqkXV+uCSfjeefUzswQ7D5ALYtv2gFfwZjaoHDSn/X4LAWo+ajmLcR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDCtY5If; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDCtY5If"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e11cda9f6fso1469204a34.2
        for <ofono@lists.linux.dev>; Fri, 02 Feb 2024 14:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706914507; x=1707519307; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZBBICPga2eVDUp3Vr4DNhiKRGhVCNAias4ZQWusImY=;
        b=UDCtY5IfWe4pfXQE1eJfqTL/NuPspxPy/wbOhyIAbQlAM8w6nUthGS2NHVhoYkYcxT
         pGuNa4VJb7xgrKRiuYLr22w7jb7TU5TaSZ14AtPPgAstheoAu1VbjDpPpgvRwQFf5n9H
         UNbd88b4hJkPa5q7mCtOWLWTSZxlA9PDx/++3xyb43xiTYO8KI42NUz7poOzC67CP7gd
         1YPDiRuOiWoaiZjEh5/+M4KxGWMtP5MftkepQJZdZ0FID+b6GRvEUoHtipV6nVvRrP5v
         QqC3W5hDaJdgfe/OOAZ0B7zVUS12RKN3+l/jlpeeP0hASbLLJ6zOQn/EA8HKh8IEcqia
         elSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706914507; x=1707519307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZBBICPga2eVDUp3Vr4DNhiKRGhVCNAias4ZQWusImY=;
        b=Ya4/wk7JQE60LywJQ6+fW+1OZ9x5pFoVr21IHjvp9v1rS6RAMjY8QJL99m6povUHhG
         Hk8+b8HP97XvrgmrZ+ipVJn10a89IH2rXSQwyBcu3y9cTXL+yKMVe1+SLt6TQAVE0wRQ
         Ckk3i9cnF4wLcJ6g1zYSbG6CLsCmrHRG7QRuGjbqBtiCPGw7YSe74xIH+vpa2yT6eVfl
         Gj+wyoa0U2yiIruBFTHNJhwdzfCUOxAuzgppLWZnU9BSRNRwnGGGeFO3Emf4LlPC4Pv4
         P4Gg7GG3FTYPnfbr6cPy9Q1GDl2LYlHAqT/oXbzO7YfEuqwJvPE0zQvD1DNIgx48jSQ0
         KK5Q==
X-Gm-Message-State: AOJu0YyGejqKZMTEKzxBSUfZbtmstrEsHMHJ6vouvWIoqMP1fz4eRWFQ
	RXSN4g0lycahjD5k6/Cqml5PFKIDjS5TJYWObCkrbtOCguREQ2tbTq9Qf2kJ
X-Google-Smtp-Source: AGHT+IEL34JL8MaGPZz5ruWV4MOPLfuLbrWCuDt7E0OBhJTRMbBfWb+mhWYJ+mgnDyjRpy25i4UO8Q==
X-Received: by 2002:a05:6830:11c9:b0:6e1:eb2:af15 with SMTP id v9-20020a05683011c900b006e10eb2af15mr3628910otq.4.1706914507502;
        Fri, 02 Feb 2024 14:55:07 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j20-20020a9d7d94000000b006e1424847d2sm563485otn.12.2024.02.02.14.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:55:07 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 18/18] lte: Write provisioned info to disk
Date: Fri,  2 Feb 2024 16:53:50 -0600
Message-ID: <20240202225405.993792-18-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202225405.993792-1-denkenz@gmail.com>
References: <20240202225405.993792-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If provisioning succeeded, then save the information to disk.  Next time
the modem is powered, the saved information will be used instead of
being obtained via provisioning.
---
 src/lte.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/src/lte.c b/src/lte.c
index 706d596b59b2..05491c3a1391 100644
--- a/src/lte.c
+++ b/src/lte.c
@@ -450,11 +450,37 @@ static void spn_read_cb(const char *spn, const char *dc, void *data)
 	struct ofono_lte *lte = data;
 	struct ofono_modem *modem = __ofono_atom_get_modem(lte->atom);
 	struct ofono_sim *sim = __ofono_atom_find(OFONO_ATOM_TYPE_SIM, modem);
+	bool r;
 
 	ofono_sim_remove_spn_watch(sim, &lte->spn_watch);
 
-	provision_default_attach_info(lte, ofono_sim_get_mcc(sim),
-					ofono_sim_get_mnc(sim), spn);
+	r = provision_default_attach_info(lte, ofono_sim_get_mcc(sim),
+						ofono_sim_get_mnc(sim), spn);
+	if (r) {
+		const char *str;
+
+		if (lte->info.apn[0])
+			l_settings_set_string(lte->settings, SETTINGS_GROUP,
+						LTE_APN, lte->info.apn);
+
+		if (lte->info.username[0])
+			l_settings_set_string(lte->settings, SETTINGS_GROUP,
+					LTE_USERNAME, lte->info.username);
+
+		if (lte->info.password[0])
+			l_settings_set_string(lte->settings, SETTINGS_GROUP,
+					LTE_PASSWORD, lte->info.password);
+
+		str = gprs_proto_to_string(lte->info.proto);
+		l_settings_set_string(lte->settings, SETTINGS_GROUP,
+					LTE_PROTO, str);
+
+		str = gprs_auth_method_to_string(lte->info.auth_method);
+		l_settings_set_string(lte->settings, SETTINGS_GROUP,
+					LTE_AUTH_METHOD, str);
+
+		lte_save_settings(lte);
+	}
 
 	if (lte->driver->set_default_attach_info) {
 		lte->driver->set_default_attach_info(lte, &lte->info,
-- 
2.43.0

