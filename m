Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7665FF18
	for <ofono@lists.linux.dev>; Tue, 13 Feb 2024 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838574; cv=none; b=l7X1f1jCg7V/6Lt8o/GqFnbqRdbBF/lFwRgFmOFBQxqkz1XxqjsEjMWAdXzlzOgZ7e5gjHarYkVckf88Ehd50HWhOVn+RjZWLyvP/yLHwSZi36NUqTgvEA1aQhyPsIOpzn7V/Lz5zOk397j6BS+p/X769mz3Q2YsnIQz+Al4vq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838574; c=relaxed/simple;
	bh=+EVAxLMO+PfbilI2o6Yzx5GIE07Z0j+hnPEKifAYhqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CKwsHEvKTJ+ptJ0dZpUsxk5YkTD+W/Otd2u8GjiV8GiY2yulX8U8swOQttv9TXbNPYb+jPIqc8d0kjb5teefpM8y6cNfBbJ4bMq4aebhQp/p0OaZdW6VtZSbOjNwr6qJ4gpy4Dwff5fDfkRUALniQiaFK/G0hFp2v4eufiF7++E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h19Q7Egk; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h19Q7Egk"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c0449eaadaso778468b6e.1
        for <ofono@lists.linux.dev>; Tue, 13 Feb 2024 07:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707838572; x=1708443372; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KdFTkdy8sVoQJ1BpsIrIdTM3Q0WaZNcs+I2zHkvL5zo=;
        b=h19Q7EgkieOzgKjwRzq8sDIFt2Xt4R7tl6/d/vEiYFZ5cuTtpHVHD36IQV3yUbB2IA
         Zafz+TU3Rktqnj7g2jGrIOIoPR1EkLq02HtLKaRssjPO7Oh0TdPlkuZrfgByS36rhG2k
         L0jE+zK0FpxA8GmBzHryHc7uWpkKlqkilZwSMhuyE69ay7taA97PuXDPo5WisztiLy3w
         +aGzeTs8fFjAmOdDnHhIUkN2YDUPfv7dYUWoYd4CZn+zEvZEHcogB05YIJIs7PiPk6K3
         xUarduSSv6p9AQ+YEnBL3bG1LauGf1jsffjF+YMoaM3tVryCYshhSAhBFqat/4Wzjijo
         pY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707838572; x=1708443372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KdFTkdy8sVoQJ1BpsIrIdTM3Q0WaZNcs+I2zHkvL5zo=;
        b=S3wS8Mo+X4YH5sYwapj4H127G3vO1EXhPNFCdxKdBygtZqWuYn3byQiby+DxrJDON8
         qAkRYM6Mhqp61pdGP9ALbnck6t2QFLTTiIeXEzte9NJQzPzh8O8UhN16dgMhNJ64Ap0l
         tfVOnyXDXB0qcpSRqLWnvkeWJJh9xudtHH6G0fvptTxRvQeYJos8Uk0xWWWNMuQ4WSc/
         F3FT2mFfsaVxl9m6bhNkGncJUYidoCpIZSNGaivCNGPQI4XVjrECzbDa1yJJVnDqoftl
         8zYo/lFxlrHECRsZBP62q2lAddZDF1tZE3X6XRMlA+ZI1lAfBXaLi+XY6UPETaaVUZLj
         X0sw==
X-Gm-Message-State: AOJu0YyjKIoDkoBNEZUwTt9FLGGKUGvVjO0J2HuICc/0OQt2C8mmt8An
	n/e7N80EkzCyTeNJgOqjmsx+baOKvEW6Qc+AIFH9IGytGGEaqFIjdAyEtcvg
X-Google-Smtp-Source: AGHT+IGpT10BabIgawb6UMinGqFUkjx1zk9pS/R4LdGGzxlxqT4HAZybkNAWj0pUPDw6TMqu2IsY0g==
X-Received: by 2002:a05:6870:b09:b0:219:7535:8d50 with SMTP id lh9-20020a0568700b0900b0021975358d50mr10714845oab.23.1707838571878;
        Tue, 13 Feb 2024 07:36:11 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id dx19-20020a056870769300b0021a0f032341sm1861999oab.22.2024.02.13.07.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 07:36:11 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/6] sim: Drop glib use from sim_efli_format
Date: Tue, 13 Feb 2024 09:35:05 -0600
Message-ID: <20240213153524.1085649-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the return signature to use bool instead of gboolean.
Also, change g_ascii_isalpha use to l_ascii_isalpha.
While here, also update array subscripts to follow the coding style,
item M3
---
 src/sim.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 33d00ac9a615..55ff5f448647 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -2155,15 +2155,15 @@ static void sim_efli_read_cb(int ok, int length, int record,
 }
 
 /* Detect whether the file is in EFli format, as opposed to 51.011 EFlp */
-static gboolean sim_efli_format(const unsigned char *ef, int length)
+static bool sim_efli_format(const unsigned char *ef, int length)
 {
 	int i;
 
 	if (length & 1)
-		return FALSE;
+		return false;
 
 	for (i = 0; i < length; i += 2) {
-		if (ef[i] == 0xff && ef[i+1] == 0xff)
+		if (ef[i] == 0xff && ef[i + 1] == 0xff)
 			continue;
 
 		/*
@@ -2171,14 +2171,14 @@ static gboolean sim_efli_format(const unsigned char *ef, int length)
 		 * characters while CB DCS language codes are in ranges
 		 * (0 - 15) or (32 - 47), so the ranges don't overlap
 		 */
-		if (g_ascii_isalpha(ef[i]) == 0)
-			return FALSE;
+		if (l_ascii_isalpha(ef[i]) == 0)
+			return false;
 
-		if (g_ascii_isalpha(ef[i+1]) == 0)
-			return FALSE;
+		if (l_ascii_isalpha(ef[i + 1]) == 0)
+			return false;
 	}
 
-	return TRUE;
+	return true;
 }
 
 static GSList *parse_language_list(const unsigned char *ef, int length)
@@ -2261,7 +2261,7 @@ static void sim_efpl_read_cb(int ok, int length, int record,
 	struct ofono_sim *sim = userdata;
 	const char *path = __ofono_atom_get_path(sim->atom);
 	DBusConnection *conn = ofono_dbus_get_connection();
-	gboolean efli_format = TRUE;
+	bool efli_format = true;
 	GSList *efli = NULL;
 	GSList *efpl = NULL;
 
-- 
2.43.0

