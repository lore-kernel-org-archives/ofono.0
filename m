Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B38014659E
	for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314906; cv=none; b=a1zjW4Y5Q0jERb1LNgKi8Mc9st1e8VVoV6XyM3S3tu9xidXYTIVn6/gc5VGwkx7Uwlj6JSzfue8dW2wmjQbORF+3GDDhesRTqyNSBVNJC4P1qk//YkohwF4zL9LwITgsY3ZdZPjqLsQh964/5749zo3jnET6VbnvhQBzP8oH45E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314906; c=relaxed/simple;
	bh=pz1PbvxYPyQZK4TtGlQZG6qYJbrPBWa4HMuGYxNGZOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/ixFDvGhRuNhISYc0X/B1p6wb/awgtP8oD8wPMV1EIKgYSI5iJh++w8CSfXTuFs2Za1iHUtdPOs8BuyfAb18lrfaIruUp1M/w1cXulgIgZzaw5EFLmqzhAbp8TB4/VrxuDAB2RFXngk8NfwY186QjQpsuT3A24NVu6cDmbEvZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=folHUOc2; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="folHUOc2"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5ba70a0ed75so798179eaf.1
        for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 14:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718314904; x=1718919704; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsCSjlaa3wCPXb4u3HSezyBvJMvklEuUA0nVMbJyLzk=;
        b=folHUOc2A5FdO8ZVtgXcmqi2N3a3VSJC0RI6ZUaTMeGGHMHzq57/lbd1SHkPKnQbKj
         lK1di5WOHdcqwnIGqehiSuTx/Q6mW3pOq8HjaHopTHfi/PXGM3sfPP8q5F388uAG+uqG
         Ffr8G2ZE2V2wq4O8sZjQRnbXKOOIhVLNcWg+YurIhZVbXJcspbE9YYrcfj7mED8isKtT
         1yVW+pvZAbTeTefxYgKDhdxz/XxZ+z9H22Lr+SjID5u/fCXscGMLjpmCQPQTunKNV1fe
         dnPokec0XnijwgbydFmixb46jLSLMLvKRGy/ZCRHQTHbrsqt4WcBEF69JdTV8zkucPqp
         LBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718314904; x=1718919704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsCSjlaa3wCPXb4u3HSezyBvJMvklEuUA0nVMbJyLzk=;
        b=GZ9/GZ1StubMqh5F2C0gFyoKB45N/p7nWeScY2ZpFkF0TH//VQ2DKBSsme/PaGrqzl
         4RUt3tdfKBCVd2BHrcrRlgS7l0Fq1qGEK+4Z1Prxc9Vi1OLdgr27xoStPZjO1jrf/9uQ
         SIQyMaOa3l4dpKN20LLvtAHEFkIQ7oVEouOSJsMtJDPyuyyoSKzOdf8osVWPleecbCCe
         qrmzqClnCK/26CF19LHwez1PMAYHfMO+v3MrQ+Oy834jmaneocwHdhQQSEdLogr46jst
         j1Cg3rAgakE1l/piBCD6w+KNQUxE1EGO7aDP7nAGVz/GT1bPYc5ezEEcYinQPZ3A1Y++
         dWag==
X-Gm-Message-State: AOJu0Yzwv/FSMT18O4MrcaVPodiz28t+QvXQza5HbKMzOFRF6RhXDyXt
	LcwijB82Cyg7Q0FJYbSUsRUES3+HWmKqDgRdhVzryPWo89IjNneoVA80bw==
X-Google-Smtp-Source: AGHT+IEEE9JG1j6seVY78eJVqtLqtx7QHmjgqgqu7vrC2OM/o75bOJhLnCAellTruyL/KmAFe7Je/Q==
X-Received: by 2002:a05:6870:46a1:b0:254:85e0:51c3 with SMTP id 586e51a60fabf-25842af71c6mr989872fac.47.1718314903988;
        Thu, 13 Jun 2024 14:41:43 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f768sm601589fac.41.2024.06.13.14.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 14:41:43 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 11/23] qmi: call-barring: Drop use of qmi_service_create_shared
Date: Thu, 13 Jun 2024 16:41:20 -0500
Message-ID: <20240613214134.1056517-11-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240613214134.1056517-1-denkenz@gmail.com>
References: <20240613214134.1056517-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/qmimodem/call-barring.c | 29 ++++-------------------------
 plugins/gobi.c                  |  3 ++-
 2 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/qmimodem/call-barring.c b/drivers/qmimodem/call-barring.c
index 2209b4049c13..8da805cfe6ca 100644
--- a/drivers/qmimodem/call-barring.c
+++ b/drivers/qmimodem/call-barring.c
@@ -190,39 +190,19 @@ error:
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 
-static void create_voice_cb(struct qmi_service *service, void *user_data)
-{
-	struct ofono_call_barring *barr = user_data;
-	struct call_barring_data *bd = ofono_call_barring_get_data(barr);
-
-	DBG("");
-
-	if (!service) {
-		ofono_error("Failed to request Voice service");
-		ofono_call_barring_remove(barr);
-		return;
-	}
-
-	bd->voice = service;
-
-	ofono_call_barring_register(barr);
-}
-
 static int qmi_call_barring_probe(struct ofono_call_barring *barr,
 					unsigned int vendor, void *user_data)
 {
-	struct qmi_device *device = user_data;
+	struct qmi_service *voice = user_data;
 	struct call_barring_data *bd;
 
 	DBG("");
 
 	bd = l_new(struct call_barring_data, 1);
+	bd->voice = voice;
 
 	ofono_call_barring_set_data(barr, bd);
 
-	qmi_service_create_shared(device, QMI_SERVICE_VOICE,
-					create_voice_cb, barr, NULL);
-
 	return 0;
 }
 
@@ -234,13 +214,12 @@ static void qmi_call_barring_remove(struct ofono_call_barring *barr)
 
 	ofono_call_barring_set_data(barr, NULL);
 
-	if (bd->voice)
-		qmi_service_free(bd->voice);
-
+	qmi_service_free(bd->voice);
 	l_free(bd);
 }
 
 static const struct ofono_call_barring_driver driver = {
+	.flags			= OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE,
 	.probe			= qmi_call_barring_probe,
 	.remove			= qmi_call_barring_remove,
 	.set			= qmi_set,
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 0494959dc838..7c6885b79c7c 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -835,7 +835,8 @@ static void gobi_post_online(struct ofono_modem *modem)
 	if (data->features & GOBI_VOICE) {
 		ofono_ussd_create(modem, 0, "qmimodem", data->device);
 		ofono_call_settings_create(modem, 0, "qmimodem", data->device);
-		ofono_call_barring_create(modem, 0, "qmimodem", data->device);
+		ofono_call_barring_create(modem, 0, "qmimodem",
+						qmi_service_clone(data->voice));
 		ofono_call_forwarding_create(modem, 0, "qmimodem",
 						data->device);
 	}
-- 
2.45.0

