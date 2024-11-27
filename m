Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C49190499
	for <ofono@lists.linux.dev>; Wed, 27 Nov 2024 21:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732743129; cv=none; b=bQ9XJjXYRM0XOUVxG2g9eeuSlyIekkPOEkiFu2HCFVvqcaUW0ClG6n6rO9pG+s5H9+bXFtfGLbsrpLFfaypzq9Ey/sJ+eQjohhstGmKsf6LqzQDRdA1+0FdHroMQt3ZVqSR4NGQqJxBS7qhavIYPfDMoDz7xcId5cndQ4Rw3oGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732743129; c=relaxed/simple;
	bh=NK0suka3bC9cQrBYmvrmBx8NLKrCUhbAEm5KakH7I+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbL+gGc8DhB+jkbCsR5VtyNpJHDsgH7LumMLrEffYMziYX0ax1jL3CH9CgdwHyJgK/RyVfgSb9jIxKYDBdqTetHKa6JGbw8io1BzgqGxSPh+3lpRbnO++1eGMj6ly98BcwfMkjoN5pkqIGUMXh0jDpIq4K9CVygfMiCI3Pt64oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ozqms14U; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ozqms14U"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5f1cec20a77so93680eaf.1
        for <ofono@lists.linux.dev>; Wed, 27 Nov 2024 13:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732743127; x=1733347927; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LES2CKeCTqrrwjhdcdiTowqliXIiyyUxO8tED5Lh1XU=;
        b=Ozqms14UfknBafsANFSYTpwsnDOkJeIiPmqz2jSaQ7zrODm5dKHClCVieRvORVcfNv
         Yn6kc1ccErBtfcCPjOKmeVvn9JuHAiO761tpZQsS/px91k1bHbPreFB5qHRi4xDM+xNm
         L4NgNu4HKmeGXQLstzyw1wAM13/RPy5lMiw7oWMBOw7vu8RUloxjQzWCQuDagIzU8piI
         h5E7LcUVtzrxwrbwrLG03G0nk/Q+2k6z/ozifu51HrY8/8940CxCsqkb74taZq1DvstN
         x6Gkmq9JP8jN4KxrnpuigtUURsBmlWApP06JHrGsHVbYzk/Ov1RBlVc6ppEqmfk7ubxL
         fF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732743127; x=1733347927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LES2CKeCTqrrwjhdcdiTowqliXIiyyUxO8tED5Lh1XU=;
        b=vwsEs43FN6Fkkgs2qGHXDncW3NK7bhK1nWjrRA9UwHsSYuMaFC+PaOWbOZhjsRFWpF
         6sdaFUNRFajxMxJIfpFHS+6wfbDM7uUiVE9nfHnfk+l2r/i00woPVOmibG+EiRoTIBUO
         HS/HGMaQNrGEFqMo7dKqb4ITp6PpgzU2XWxQXkGegVR96SDwPtemHb1HxXqsxgpBdEu1
         IGIMtr6u9HTKTRnl6I5Pv2i98UoYH0t9FR8PgEIwgs25UjYVGHIyEkbVfN/+y84c+bUZ
         4HZjfOf9KnxPGiynLxLLEZkr9A6UXBZHhoWpgTx3wyv5IDDpgmqTloODHKFnHB1iKNor
         Sf8Q==
X-Gm-Message-State: AOJu0YwHUZezW+D1V0Ot0zTtobBJXLhFAmbYklI41dqH7NUzTWfzXVGH
	el9p9N5AbetU1bdyNmsMyoiSrlpkPYzrPdNCB1UeLzs6sSTpppTzwasmyg==
X-Gm-Gg: ASbGncuLUkIrXiSbQC9ubmORty1Y3b1S1eOKSA/Emr6btr+/w3M3iQmy7qRJDOxgUXX
	7Gy5usgkHjl0ykU85ZCCkpA4IlMdZcgR6wa8wWgcxGSFPY4dDD/i50OfKvuAtMbEUuhB7SXCMNp
	MUDleclHufkOLO9bQjsjJGV7JcQGKqqmPypGRyUEF+wqtPBREZ3GPJNBMjrax1kAm6Z9WjqPCid
	YY/x7FY4kHIGFy2duUc3xohrSkYydjpNl94VhOMtdnnvbS2Anr/Lu7Gf0UyLlK08ZLnoi/SBwoN
	ucrWbt/XD5gnnINfc0h2BzgZ
X-Google-Smtp-Source: AGHT+IEV383SSJymOun4Nml2A9C0L4VobpZQ8Wvit9y5m9COmjq6Ls0frepDQNTNM2PTYtw9bgiLIw==
X-Received: by 2002:a05:6870:1704:b0:29d:c937:8a2a with SMTP id 586e51a60fabf-29dc9378b13mr4169952fac.9.1732743126776;
        Wed, 27 Nov 2024 13:32:06 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29de9ba6bbfsm29114fac.48.2024.11.27.13.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 13:32:06 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 4/4] qrtrqmi: Manage main netdev as part of .set_online
Date: Wed, 27 Nov 2024 15:31:51 -0600
Message-ID: <20241127213200.202536-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127213200.202536-1-denkenz@gmail.com>
References: <20241127213200.202536-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mhi_hwipX interface is created with IFF_UP not set.  It must be set
IFF_UP when the modem is brought into online state, otherwise packets
will not flow properly.  Similarly, when bring the modem into offline
state, bring down the main network device for consistency.
---
 plugins/qrtrqmi.c | 73 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 8 deletions(-)

diff --git a/plugins/qrtrqmi.c b/plugins/qrtrqmi.c
index 4a00fa45a110..27d071aa8284 100644
--- a/plugins/qrtrqmi.c
+++ b/plugins/qrtrqmi.c
@@ -61,6 +61,7 @@ struct qrtrqmi_data {
 	struct rmnet_ifinfo rmnet_interfaces[MAX_CONTEXTS];
 	uint8_t n_premux;
 	int rmnet_id;
+	uint32_t set_powered_id;
 	bool have_voice : 1;
 	bool soc_premux : 1;
 };
@@ -206,6 +207,12 @@ static void qrtrqmi_remove(struct ofono_modem *modem)
 	}
 
 	qrtrqmi_deinit(data);
+
+	if (data->set_powered_id) {
+		l_netlink_cancel(l_rtnl_get(), data->set_powered_id);
+		data->set_powered_id = 0;
+	}
+
 	l_free(data);
 }
 
@@ -460,25 +467,75 @@ static void set_online_cb(struct qmi_result *result, void *user_data)
 		CALLBACK_WITH_SUCCESS(cb, cbd->data);
 }
 
-static void qrtrqmi_set_online(struct ofono_modem *modem, ofono_bool_t online,
-				ofono_modem_online_cb_t cb, void *user_data)
+static void powered_common_cb(int error, bool online, struct cb_data *cbd)
 {
-	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
-	struct cb_data *cbd = cb_data_new(cb, user_data);
+	struct qrtrqmi_data *data = cbd->user;
 	struct qmi_param *param;
+	ofono_modem_online_cb_t cb = cbd->cb;
 
-	DBG("%p %s", modem, online ? "online" : "offline");
+	data->set_powered_id = 0;
+
+	if (error)
+		goto error;
 
 	param = qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
 					online ? QMI_DMS_OPER_MODE_ONLINE :
 						QMI_DMS_OPER_MODE_LOW_POWER);
 
-	if (qmi_service_send(data->dms, QMI_DMS_SET_OPER_MODE, param,
-				set_online_cb, cbd, l_free) > 0)
+	if (qmi_service_send(data->dms, QMI_DMS_SET_OPER_MODE,
+					param, set_online_cb,
+					cb_data_ref(cbd), cb_data_unref) > 0)
 		return;
 
 	qmi_param_free(param);
-	l_free(cbd);
+	cb_data_unref(cbd);
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void powered_up_cb(int error, uint16_t type, const void *msg,
+				uint32_t len, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+
+	DBG("error: %d: %s", error, strerror(-error));
+	powered_common_cb(error, true, cbd);
+}
+
+static void powered_down_cb(int error, uint16_t type, const void *msg,
+				uint32_t len, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+
+	DBG("error: %d: %s", error, strerror(-error));
+	powered_common_cb(error, false, cbd);
+}
+
+static void qrtrqmi_set_online(struct ofono_modem *modem, ofono_bool_t online,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
+	struct l_netlink *rtnl = l_rtnl_get();
+	struct cb_data *cbd = cb_data_new(cb, user_data);
+	l_netlink_command_func_t powered_cb;
+
+	DBG("%p %s", modem, online ? "online" : "offline");
+
+	cbd->user = data;
+
+	if (online)
+		powered_cb = powered_up_cb;
+	else
+		powered_cb = powered_down_cb;
+
+	data->set_powered_id = l_rtnl_set_powered(rtnl, data->main_net_ifindex,
+							online, powered_cb,
+							cbd, cb_data_unref);
+	if (data->set_powered_id)
+		return;
+
+	cb_data_unref(cbd);
+	CALLBACK_WITH_FAILURE(cb, user_data);
 }
 
 static void qrtrqmi_pre_sim(struct ofono_modem *modem)
-- 
2.47.0

