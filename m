Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6B8B663
	for <ofono@lists.linux.dev>; Mon,  4 Mar 2024 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709584510; cv=none; b=Lg/zWSd4Q2QDXZjtBdAasNFKKEIn6GdE4APtj1GeJbHSh1SAdYntdQHnUkuBdTVEmeS4THTBnJKxCuzQShT4vOj+vaMCN635ppCkgkWvhoF2O40wf9vf65G7m3zLu+u6/fO8Fqhpe5sgzmhF2Id+g+Wl/UWbxoAnV1jHW+NJ8XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709584510; c=relaxed/simple;
	bh=ZsmRnj5Wa5iL3Gd8c0Xgj2+OfnXqypxIUPd5PAlHpWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pgehe5w5/ekv5gW/Z19+xru4hxdxW8GSyndGff4K5tsf55ucs5Ogwz12RUJ8E7yK4PNichGMoIIkluVi/8WwbFvtoA1/ZKXRVZ6irhE4sYiGfjlhfV54ZYQPG6HRG7eh/ATW4C9n5ZSqBLSZkAlSRM7O1bgeJkKCGvVPGelL0OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcAp3fBE; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcAp3fBE"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so3478314b6e.3
        for <ofono@lists.linux.dev>; Mon, 04 Mar 2024 12:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709584508; x=1710189308; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HkOL7xyau4DAmDVT2dgN1CHRnwZ+IbhHoKAd1/N7lCU=;
        b=fcAp3fBE/fvzveMHaN3seIQ/hltSthM5l5JH0Ob4jDj/2RGpqVPjXFxTdu52pv5Ut6
         KV2tSikm22vb1S+BxlLXM6XugYmfROZFLMEQmPHc7BMhLdVqFvGmgnBqpRR+Ve3niB9l
         ICZ9aTt/vHWGgWCuuVZ+qRIdzrLqjvik2ej4yBeOTRiKomL1tIwEBtDG/6k1fAhBPN3B
         f0EVI1NNr43wKmhZNgqcvZhU6dVHSXNBVFDNCn+5Ra/NrUqavVG2WRru0PnHuWONzjX+
         yJxqHXnp5qHnoshuPQ4PJfjKe83opQ15qVlquzze683olj5sV+0UHNodibVPWXxrSl2D
         fIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709584508; x=1710189308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HkOL7xyau4DAmDVT2dgN1CHRnwZ+IbhHoKAd1/N7lCU=;
        b=kFb93XKbU9FBw2NXv5A/vJ8/hBlEZfDq2AEggcLHxsoisowU1wMr/f3m2BmBrDRSrZ
         SLbzYSoR72KDnwyO8HIOXJh/VjzxDE2pwHB7II40BAO57NANYd5ox/JdU6K//NI6uhyS
         55LsecVdricR7GCVJd2Cop0VeCalsRTCkLJ6fJmqKCnBLbPAcnhhapUGyB7lyK6QIey7
         qW7dGYOHi4+NYIkvAEqEL0SV2fFMAljQ+W9UKLQ+r55Hr9oifS/kVqa+qsz1vchLiLcs
         Zj7gDembIuGO3M3YKN49TeoOJVd65arhoSl+RU62TZM6zYaPMkb6afu+sl2nviYmQxuM
         DwRQ==
X-Gm-Message-State: AOJu0Yw1zaeO+mjid/2jkT50AqrE4veIXgvbQ87u3sHcd06rITk8dSi0
	sNV96tweLoh16o63e5HjQNud+vhxuOj2kNkiwUPI6Cr80QLrl98SzcCSSNg0
X-Google-Smtp-Source: AGHT+IGGLe3dpb2oHbJynCcxM8grLxiRkrArey5pBUpCkNyzl0fqKI7bxMiER8MUl/b4f4FxWJfhww==
X-Received: by 2002:a05:6808:398d:b0:3c1:cbe9:e153 with SMTP id gq13-20020a056808398d00b003c1cbe9e153mr13987630oib.17.1709584508310;
        Mon, 04 Mar 2024 12:35:08 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 1-20020aca2101000000b003c0408e5b06sm1642582oiz.55.2024.03.04.12.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 12:35:08 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/5] qmimodem: Use stdbool instead of gboolean
Date: Mon,  4 Mar 2024 14:34:49 -0600
Message-ID: <20240304203506.1725220-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/qmimodem/sim-legacy.c |  4 ++--
 drivers/qmimodem/sim.c        | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/qmimodem/sim-legacy.c b/drivers/qmimodem/sim-legacy.c
index cb4ad0646037..12e5ab079111 100644
--- a/drivers/qmimodem/sim-legacy.c
+++ b/drivers/qmimodem/sim-legacy.c
@@ -250,13 +250,13 @@ static void process_uim_state(struct ofono_sim *sim, uint8_t state)
 
 	switch (state) {
 	case QMI_DMS_UIM_STATE_INIT_COMPLETE:
-		ofono_sim_inserted_notify(sim, TRUE);
+		ofono_sim_inserted_notify(sim, true);
 		ofono_sim_initialized_notify(sim);
 		break;
 	case QMI_DMS_UIM_STATE_INIT_FAILED:
 	case QMI_DMS_UIM_STATE_NOT_PRESENT:
 	case QMI_DMS_UIM_STATE_INVALID:
-		ofono_sim_inserted_notify(sim, FALSE);
+		ofono_sim_inserted_notify(sim, false);
 		break;
 	}
 }
diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 625846c5efd9..0b73b3c7598b 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -121,7 +121,7 @@ static void get_file_attributes_cb(struct qmi_result *result, void *user_data)
 	int flen, rlen, str;
 	unsigned char access[3];
 	unsigned char file_status;
-	gboolean ok;
+	bool ok;
 
 	DBG("");
 
@@ -146,7 +146,7 @@ static void get_file_attributes_cb(struct qmi_result *result, void *user_data)
 		file_status = EF_STATUS_VALID;
 		break;
 	default:
-		ok = FALSE;
+		ok = false;
 		break;
 	}
 
@@ -608,7 +608,7 @@ static void query_passwd_state_cb(struct qmi_result *result,
 		data->retry_count = 0;
 		if (sim_stat.passwd_state == OFONO_SIM_PASSWORD_INVALID) {
 			CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-			ofono_sim_inserted_notify(sim, FALSE);
+			ofono_sim_inserted_notify(sim, false);
 		} else
 			CALLBACK_WITH_SUCCESS(cb, sim_stat.passwd_state,
 								cbd->data);
@@ -621,7 +621,7 @@ static void query_passwd_state_cb(struct qmi_result *result,
 							sim_stat.card_state);
 			data->retry_count = 0;
 			CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-			ofono_sim_inserted_notify(sim, FALSE);
+			ofono_sim_inserted_notify(sim, false);
 		} else {
 			DBG("Retry command");
 			retry_cbd = cb_data_new(cb, cbd->data);
@@ -635,7 +635,7 @@ static void query_passwd_state_cb(struct qmi_result *result,
 		DBG("Command failed");
 		data->retry_count = 0;
 		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-		ofono_sim_inserted_notify(sim, FALSE);
+		ofono_sim_inserted_notify(sim, false);
 		break;
 	}
 }
@@ -781,7 +781,7 @@ static void get_card_status_cb(struct qmi_result *result, void *user_data)
 	case 0x02:	/* Error */
 		break;
 	case 0x01:	/* Present */
-		ofono_sim_inserted_notify(sim, TRUE);
+		ofono_sim_inserted_notify(sim, true);
 		ofono_sim_initialized_notify(sim);
 		break;
 	}
@@ -806,10 +806,10 @@ static void card_status_notify(struct qmi_result *result, void *user_data)
 	switch (sim_stat.card_state) {
 	case 0x00:	/* Absent */
 	case 0x02:	/* Error */
-		ofono_sim_inserted_notify(sim, FALSE);
+		ofono_sim_inserted_notify(sim, false);
 		break;
 	case 0x01:	/* Present */
-		ofono_sim_inserted_notify(sim, TRUE);
+		ofono_sim_inserted_notify(sim, true);
 		break;
 	}
 }
-- 
2.43.0

