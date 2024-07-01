Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C4716C86B
	for <ofono@lists.linux.dev>; Mon,  1 Jul 2024 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847643; cv=none; b=p0f8zBsNzEbx6JrZ5+0DSfWa33Ts4oP7HojMLau5ZPPYHyJNw2X0CIs/qO5A4HxMh0xBDq2XxIYSkAsyT54LLYnut30LMt8P2Fbsqxk2HqVD5BlpXmUUu+TsxOlo35QWb9pJGZwR+1U7MVmIxnZ4HsRqWdfvOaFNTPj5w3+LTVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847643; c=relaxed/simple;
	bh=kwhSqC4sGAfMjjHfE324cad5Y4x7wB/6xaRkHuW7Jy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mUnpGU0v5qUDV/hmwQDAl8lOHIChaPeayhZSUN11HFtLk2vtbUN+LjqFf0/c9wZ1Ko6+iZINtehNacF8CenZKmPw9k3PJQowxGZTotLXgXatx36v/jEc5O6vY4pfwSaAnCIRhCaXQaQn3Jeb7JBf3elHdJsrhbTHGj7CuieMX5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=mY0LC0Py; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="mY0LC0Py"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7021f23d699so3666a34.3
        for <ofono@lists.linux.dev>; Mon, 01 Jul 2024 08:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1719847641; x=1720452441; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H1QJ8uP5Hz+TGbb9BK4aSEGrb1z9qI4focRuPPcQh2g=;
        b=mY0LC0PyPsNGbVrnu/DfNE91Hzlma2pGCp+7ouX5gQPPwtMjKKc2HEDWWepT9ckvon
         s3c1UoUyFliNHZEGnv6rjvAPld5pXIeNLpJAv+NEJGnanlcEMCAoIXZspD3YxzHsd8XH
         Ftsn/psq1OcYY84EVuArvKWsiT2CeDs/3kIs+6WoTpC+Ehm6Lm5XWv07UrufEwi1b5Dh
         ztZ075vHqe0viDRXUKPWRe0PmTlE1tLUOwfG9Ntm1BCTwdPSaQ6JNzJJoJ5T+FK+nZ29
         SwaIV47eFdfVKEOv/FOPL1o2KFOkJblXmtlz4SUwznTKO3EJ+EGf+TyACOX5eHnTTHp7
         AetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719847641; x=1720452441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1QJ8uP5Hz+TGbb9BK4aSEGrb1z9qI4focRuPPcQh2g=;
        b=W2HDJ/yd9yqSfzS85GXtod9tcGBOJcij6Tvf3I5cEdF13vp/WBCJWRdXHj15CveQFM
         piR7MCSrUcXPL2DoDr101ARdCVAfMi43x/whpvrdUUppreHRNgO/41vJc+Mydpq+mTxU
         TKEBSSbPodxgLxrgTtCC2kIWegZnxwN+w+G35tTH15tg4zNe5N3iuLD9H3T2bzBLDSZy
         IBZ0U62PTUK+1JrF5/VUUF7ajr02DLtITNloh5NPlw91czB/KvWTy9HRvkDFub1WIUSn
         QyeHcfmN+4OZMfrYthbgvg0vz/Ggq0JlfHpW0Y1lipsCo/2O6ZqBRYwQ13uuw0fIS6R1
         lTqg==
X-Gm-Message-State: AOJu0YyWh6LfF5kHBWD2C7t+6T+MSxfMfH1sohh0VTGYoV9IQ81aIOsN
	e6Mhgsw8oAKINzvDjpolkzQk1V75ibgh0odUkMmw1jp/0qzzYTnwe+6OlmNicMTkW7zKTSdjwjA
	buZuXeK0f1c26PYC+woK2VTmhDqpmfex6JFSyEzASdG7fIPkBu/W5RnkbjvIZHkHKaFzFk9QX77
	kEQt+l4RbZ4brSPvxUaQtTsV58E+Db675PQ7Qbt8am0dxZ7w==
X-Google-Smtp-Source: AGHT+IEr8r6XysCE6h18Dc1WRugxQwKx2JQyL6KoxX1ahs8dB6OjJxZkIEifVtb6vB91TD+Hlo4R9g==
X-Received: by 2002:a05:6830:1e8b:b0:700:d6d7:8f26 with SMTP id 46e09a7af769-702075f4abdmr6888210a34.10.1719847640902;
        Mon, 01 Jul 2024 08:27:20 -0700 (PDT)
Received: from localhost.localdomain ([140.177.136.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69262ab7sm356212085a.26.2024.07.01.08.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:27:20 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 1/3] udevng: Remove Modem setting from setup_gobi
Date: Mon,  1 Jul 2024 15:25:49 +0000
Message-ID: <20240701152553.23072-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gobi doesn't actually use the "Modem" setting since it communicates
using the qmi protocol. The fact that setup_gobi required this
interface actually caused certain modems to fail inside setup_gobi
since mdm was not being set.
---
 plugins/udevng.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 789592e6ec99..271d43b16336 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -355,7 +355,6 @@ static gboolean setup_gobi(struct modem_info *modem)
 {
 	const struct device_info *qmi = NULL;
 	const struct device_info *net = NULL;
-	const char *mdm = NULL;
 	const char *gps = NULL;
 	const char *diag = NULL;
 	GSList *list;
@@ -381,30 +380,25 @@ static gboolean setup_gobi(struct modem_info *modem)
 					diag = info->devnode; /* ec20 */
 				else if (g_strcmp0(info->number, "01") == 0)
 					diag = info->devnode; /* gobi */
-				else if (g_strcmp0(info->number, "02") == 0)
-					mdm = info->devnode; /* gobi */
 				else if (g_strcmp0(info->number, "03") == 0)
 					gps = info->devnode; /* gobi */
 			} else if (g_strcmp0(info->interface, "255/0/0") == 0) {
 				if (g_strcmp0(info->number, "01") == 0)
 					gps = info->devnode; /* ec20 */
-				if (g_strcmp0(info->number, "02") == 0)
-					mdm = info->devnode; /* ec20 */
 				/* ignore the 3rd device second AT/mdm iface */
 			}
 		}
 	}
 
-	if (qmi == NULL || mdm == NULL || net == NULL)
+	if (qmi == NULL || net == NULL)
 		return FALSE;
 
-	DBG("qmi=%s net=%s mdm=%s gps=%s diag=%s",
-			qmi->devnode, get_ifname(net), mdm, gps, diag);
+	DBG("qmi=%s net=%s gps=%s diag=%s",
+			qmi->devnode, get_ifname(net), gps, diag);
 
 	if (setup_qmi_qmux(modem, qmi, net) < 0)
 		return FALSE;
 
-	ofono_modem_set_string(modem->modem, "Modem", mdm);
 	ofono_modem_set_string(modem->modem, "Diag", diag);
 
 	return TRUE;
-- 
2.43.0

