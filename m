Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF302136E01
	for <ofono@lists.linux.dev>; Tue, 23 Apr 2024 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880717; cv=none; b=l/KWY8N8VnT54vCFASUIs6ZCqX/yjrpszeJVebSWxyE7JjVipoMoSODXI0RPqWeS6kcjfjRjOdLy9tk4oTIS/ep/z/mqBClzzlZIzx3634AWlI6gmC7FbQuesbbSZGY4Ftsl4vEhxHMLE32j+zsKhhKBpi6hW9q03K26doRZzk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880717; c=relaxed/simple;
	bh=MqKNSwqKRGw9hkuLe1cxUotkEqqfavLlsaOSwG9nJIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aPmX8gJh8TSDANA6xxii8gyQFZ3zra6TFLn/T0ekkdEZ2WyD1X9pFGw0Wh4pqEbWjO7wxAvzUx5vnbZUFauMHvndROzccVFSMvYJYVOODevELTO7H43Bjz4m90xeX0yfUTuo7zGh29DTZybEYjg4YaKVbB57KQd09qXxS0pULSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=Pc6Pprc3; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=JqEMIpVD; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="Pc6Pprc3";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="JqEMIpVD"
Received: from pps.filterd (m0286618.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NCFcKG001495
	for <ofono@lists.linux.dev>; Tue, 23 Apr 2024 06:58:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=CE1ZY8wJYZP+zkoBqSlogB
	8CxMvPZgssY5vITH/af3U=; b=Pc6Pprc3w1nXSHlnvZd3RgqekeVSZTT/WPOm24
	xOaVVisoTnNcXrcCHDG8me50YKuv0mXv7Z8CpxQFrP84ZbHvdP8mtC0/lyBQ1Sdf
	z3pieLUYT/0M4Ms1dQ1XmasMMWceqYk5Ovj5AgesxdgsROSvVuIYDU3uu0tioygv
	MGVP2+VQO61Syy+vXOTFBAGtxt3L5iBQoI6SiqwhxxvMfCNx6kQ9waztVh170d/j
	cPIxn8DsjAvNkDD7P1KGQaFJGa/yy3j0QImm0ti9f+j3GMxNUQwXBsWR0AsP7BxA
	HdMzd0pmHhqHdF9zpEcPBHzenkhhebRWuV5gn3JY29KrVtbA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xmbdsa013-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Tue, 23 Apr 2024 06:58:29 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6eb7e2c6c53so7692094a34.2
        for <ofono@lists.linux.dev>; Tue, 23 Apr 2024 06:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1713880708; x=1714485508; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CE1ZY8wJYZP+zkoBqSlogB8CxMvPZgssY5vITH/af3U=;
        b=JqEMIpVD3IU8wfIEcCh11A2Rjd/G0QxNTVZjEKxZUMyBOXEymqJb09YWqSHGS63O94
         ysGZxyAPoPhL5+nwdoM85xKhDB3MgIPTOUigIqFrewH7iXFvDCYDDYFVw3fKac/3IlaJ
         IhwimbBOr5kOZfWrDdPHsH8KOt/LoKUftVOJ+QQxEi2Sy7mbaDIadCq+m/otRFvTXHyZ
         MAhyXDZJehZIFSyfIXQmsdNm73NG6DIjNxQpMHl8rBIbnV0/+Za+9QnrxbuK9BEeM/gs
         I+t9JDaQaTCdEFqVS6jfeZUxI2kuHEd6gHJFZ/nmNW8eEAPHOM1gfTD3IrKYSl/r7Kj+
         0QWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713880708; x=1714485508;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CE1ZY8wJYZP+zkoBqSlogB8CxMvPZgssY5vITH/af3U=;
        b=AaGRQoNEIm823dRTr3hI/OcI1cxa8HGjrbl+XwF73mDeOsSMP3OmSqG/lBbuvzKDva
         +M8Uq8hg+Qi7JeoBayW171MueQKxyAikuhqdfjGJS1kwTXGAd1bUib+lmA+0kad5IN7l
         /dR8dMSzn7A3owco0122kvNq32BMK8dXBMO3kiliHW+94iPVGC4+n0FWcJ+XXSjsfTrd
         WXAwZ3SB5enBs4Oa64vu1s7XB0zBHzMUf7I/DUb2YqMibhWnUFx7vO1UiZlsa2wTPXch
         r7h0S66ntBfT83GzTWglaucS7j6aNWUMOqFI0wkQE8rp+8WmnXLF0jiNY/6rQNfy72t6
         X4OQ==
X-Gm-Message-State: AOJu0Yz7EuHsNcyOLmEIedxKMaB0BOz/KV/vVr//vx4+NDNrPk5nVpWb
	UJ3P/t8rd/IRUPMyLr9YJSNXbypr+jXxnQmGFL4usglTKL5ZcZ3Vaf/YHUmDiA9jHGQliM95fzh
	+mk1WgSzbCwPIrseMcHZl7qFSIxalFqM3ytVmmjFFiaNbtkXp5Nsnki5j9Gm0YfC9+fEKMvQZ/S
	WelE6fEf5Xq/Q71gPk3YLvkL6+1caDdRoq2YtJGlhaD06cl+E=
X-Received: by 2002:a05:6830:2007:b0:6eb:7d5e:81a4 with SMTP id e7-20020a056830200700b006eb7d5e81a4mr15469276otp.30.1713880708166;
        Tue, 23 Apr 2024 06:58:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvOGzVR4I9DoGw0iTtmwY6y604IJK4v5Wn+AHICoOenDrQ+IgwwcaYpw+aoga8d7lrMXb2kA==
X-Received: by 2002:a05:6830:2007:b0:6eb:7d5e:81a4 with SMTP id e7-20020a056830200700b006eb7d5e81a4mr15469249otp.30.1713880707640;
        Tue, 23 Apr 2024 06:58:27 -0700 (PDT)
Received: from localhost.localdomain ([140.141.152.103])
        by smtp.gmail.com with ESMTPSA id u10-20020a05620a084a00b0078a04882ac2sm5220454qku.53.2024.04.23.06.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 06:58:27 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 2/2] qmimodem: Eliminate qmi_service reference counting
Date: Tue, 23 Apr 2024 13:57:11 +0000
Message-Id: <20240423135711.272881-2-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240423135711.272881-1-steve.schrock@getcruise.com>
References: <20240423135711.272881-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: V1JlqMp-dsEiP5j3CuADYg9RT0S1KQaK
X-Proofpoint-ORIG-GUID: V1JlqMp-dsEiP5j3CuADYg9RT0S1KQaK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_12,2024-04-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxlogscore=777 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404230035

Now that each client gets its own qmi_service object, there is no need
to perform reference counting. qmi_service_ref has been removed and
qmi_service_unref has been renamed to qmi_service_free.
---
 drivers/qmimodem/call-barring.c         |  4 ++--
 drivers/qmimodem/call-forwarding.c      |  4 ++--
 drivers/qmimodem/call-settings.c        |  4 ++--
 drivers/qmimodem/devinfo.c              |  4 ++--
 drivers/qmimodem/gprs-context.c         |  4 ++--
 drivers/qmimodem/gprs.c                 |  8 ++++----
 drivers/qmimodem/location-reporting.c   |  4 ++--
 drivers/qmimodem/lte.c                  |  4 ++--
 drivers/qmimodem/netmon.c               |  4 ++--
 drivers/qmimodem/network-registration.c |  4 ++--
 drivers/qmimodem/qmi.c                  | 17 +----------------
 drivers/qmimodem/qmi.h                  |  4 +---
 drivers/qmimodem/radio-settings.c       |  8 ++++----
 drivers/qmimodem/sim-legacy.c           |  4 ++--
 drivers/qmimodem/sim.c                  |  8 ++++----
 drivers/qmimodem/sms.c                  |  4 ++--
 drivers/qmimodem/ussd.c                 |  4 ++--
 drivers/qmimodem/voicecall.c            |  4 ++--
 plugins/gobi.c                          |  8 ++++----
 unit/test-qmimodem-qmi.c                | 15 +++++++--------
 20 files changed, 51 insertions(+), 69 deletions(-)

diff --git a/drivers/qmimodem/call-barring.c b/drivers/qmimodem/call-barring.c
index 6224893871a0..3852c92f89ad 100644
--- a/drivers/qmimodem/call-barring.c
+++ b/drivers/qmimodem/call-barring.c
@@ -216,7 +216,7 @@ static void create_voice_cb(struct qmi_service *service, void *user_data)
 		return;
 	}
 
-	bd->voice = qmi_service_ref(service);
+	bd->voice = service;
 
 	ofono_call_barring_register(barr);
 }
@@ -248,7 +248,7 @@ static void qmi_call_barring_remove(struct ofono_call_barring *barr)
 	ofono_call_barring_set_data(barr, NULL);
 
 	if (bd->voice)
-		qmi_service_unref(bd->voice);
+		qmi_service_free(bd->voice);
 
 	l_free(bd);
 }
diff --git a/drivers/qmimodem/call-forwarding.c b/drivers/qmimodem/call-forwarding.c
index 2a415b2a9c11..dea8a29cfd84 100644
--- a/drivers/qmimodem/call-forwarding.c
+++ b/drivers/qmimodem/call-forwarding.c
@@ -302,7 +302,7 @@ static void create_voice_cb(struct qmi_service *service, void *user_data)
 		return;
 	}
 
-	cfd->voice = qmi_service_ref(service);
+	cfd->voice = service;
 
 	ofono_call_forwarding_register(cf);
 }
@@ -334,7 +334,7 @@ static void qmi_call_forwarding_remove(struct ofono_call_forwarding *cf)
 	ofono_call_forwarding_set_data(cf, NULL);
 
 	if (cfd->voice)
-		qmi_service_unref(cfd->voice);
+		qmi_service_free(cfd->voice);
 
 	l_free(cfd);
 }
diff --git a/drivers/qmimodem/call-settings.c b/drivers/qmimodem/call-settings.c
index 53b2f1f21fc9..66956cf33d83 100644
--- a/drivers/qmimodem/call-settings.c
+++ b/drivers/qmimodem/call-settings.c
@@ -288,7 +288,7 @@ static void create_voice_cb(struct qmi_service *service, void *user_data)
 		return;
 	}
 
-	csd->voice = qmi_service_ref(service);
+	csd->voice = service;
 
 	csd->sups_ind_id = qmi_service_register(csd->voice, QMI_VOICE_SUPS_IND,
 						sups_ind, cs, NULL);
@@ -324,7 +324,7 @@ static void qmi_call_settings_remove(struct ofono_call_settings *cs)
 
 	if (csd->voice) {
 		qmi_service_unregister(csd->voice, csd->sups_ind_id);
-		qmi_service_unref(csd->voice);
+		qmi_service_free(csd->voice);
 	}
 
 	l_free(csd);
diff --git a/drivers/qmimodem/devinfo.c b/drivers/qmimodem/devinfo.c
index 0172614b8aae..3b976858a409 100644
--- a/drivers/qmimodem/devinfo.c
+++ b/drivers/qmimodem/devinfo.c
@@ -232,7 +232,7 @@ static void create_dms_cb(struct qmi_service *service, void *user_data)
 		return;
 	}
 
-	data->dms = qmi_service_ref(service);
+	data->dms = service;
 	data->device_is_3gpp = false;
 
 	qmi_query_caps(devinfo);
@@ -264,7 +264,7 @@ static void qmi_devinfo_remove(struct ofono_devinfo *devinfo)
 
 	ofono_devinfo_set_data(devinfo, NULL);
 
-	qmi_service_unref(data->dms);
+	qmi_service_free(data->dms);
 
 	l_free(data);
 }
diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index d248761f92d6..055378dc102f 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -467,7 +467,7 @@ static void create_wds_cb(struct qmi_service *service, void *user_data)
 		return;
 	}
 
-	data->wds = qmi_service_ref(service);
+	data->wds = service;
 
 	qmi_service_register(data->wds, QMI_WDS_PACKET_SERVICE_STATUS,
 					pkt_status_notify, gc, NULL);
@@ -504,7 +504,7 @@ static void qmi_gprs_context_remove(struct ofono_gprs_context *gc)
 	ofono_gprs_context_set_data(gc, NULL);
 
 	if (data->wds)
-		qmi_service_unref(data->wds);
+		qmi_service_free(data->wds);
 
 	l_free(data);
 }
diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index a66863834a5f..72509d433bc6 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -350,7 +350,7 @@ static void create_wds_cb(struct qmi_service *service, void *user_data)
 		return;
 	}
 
-	data->wds = qmi_service_ref(service);
+	data->wds = service;
 
 	/*
 	 * First get the SS info - the modem may already be connected,
@@ -382,7 +382,7 @@ static void create_nas_cb(struct qmi_service *service, void *user_data)
 		return;
 	}
 
-	data->nas = qmi_service_ref(service);
+	data->nas = service;
 
 	qmi_service_create_shared(data->dev, QMI_SERVICE_WDS,
 						create_wds_cb, gprs, NULL);
@@ -416,7 +416,7 @@ static void qmi_gprs_remove(struct ofono_gprs *gprs)
 
 	ofono_gprs_set_data(gprs, NULL);
 
-	qmi_service_unref(data->wds);
+	qmi_service_free(data->wds);
 
 	if (data->serving_system_indication_id) {
 		qmi_service_unregister(data->nas,
@@ -424,7 +424,7 @@ static void qmi_gprs_remove(struct ofono_gprs *gprs)
 		data->serving_system_indication_id = 0;
 	}
 
-	qmi_service_unref(data->nas);
+	qmi_service_free(data->nas);
 
 	l_free(data);
 }
diff --git a/drivers/qmimodem/location-reporting.c b/drivers/qmimodem/location-reporting.c
index 549bd5740613..e83fd10eae5d 100644
--- a/drivers/qmimodem/location-reporting.c
+++ b/drivers/qmimodem/location-reporting.c
@@ -208,7 +208,7 @@ static void create_pds_cb(struct qmi_service *service, void *user_data)
 		return;
 	}
 
-	data->pds = qmi_service_ref(service);
+	data->pds = service;
 
 	qmi_service_register(data->pds, QMI_PDS_EVENT,
 					event_notify, lr, NULL);
@@ -257,7 +257,7 @@ static void qmi_location_reporting_remove(struct ofono_location_reporting *lr)
 
 	ofono_location_reporting_set_data(lr, NULL);
 
-	qmi_service_unref(data->pds);
+	qmi_service_free(data->pds);
 
 	l_free(data);
 }
diff --git a/drivers/qmimodem/lte.c b/drivers/qmimodem/lte.c
index 921d6e81933e..6c08c312b3cb 100644
--- a/drivers/qmimodem/lte.c
+++ b/drivers/qmimodem/lte.c
@@ -183,7 +183,7 @@ static void create_wds_cb(struct qmi_service *service, void *user_data)
 		return;
 	}
 
-	ldd->wds = qmi_service_ref(service);
+	ldd->wds = service;
 
 	/* Query the default profile */
 	param = qmi_param_new();
@@ -228,7 +228,7 @@ static void qmimodem_lte_remove(struct ofono_lte *lte)
 
 	ofono_lte_set_data(lte, NULL);
 
-	qmi_service_unref(ldd->wds);
+	qmi_service_free(ldd->wds);
 
 	l_free(ldd);
 }
diff --git a/drivers/qmimodem/netmon.c b/drivers/qmimodem/netmon.c
index e8a020d734e8..1097bd32f232 100644
--- a/drivers/qmimodem/netmon.c
+++ b/drivers/qmimodem/netmon.c
@@ -222,7 +222,7 @@ static void create_nas_cb(struct qmi_service *service, void *user_data)
 		return;
 	}
 
-	nmd->nas = qmi_service_ref(service);
+	nmd->nas = service;
 
 	ofono_netmon_register(netmon);
 }
@@ -253,7 +253,7 @@ static void qmi_netmon_remove(struct ofono_netmon *netmon)
 
 	ofono_netmon_set_data(netmon, NULL);
 
-	qmi_service_unref(nmd->nas);
+	qmi_service_free(nmd->nas);
 
 	l_free(nmd);
 }
diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/network-registration.c
index c37e4f4f4938..2e2e4a10dbf8 100644
--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -657,7 +657,7 @@ static void create_nas_cb(struct qmi_service *service, void *user_data)
 		goto error;
 	}
 
-	data->nas = qmi_service_ref(service);
+	data->nas = service;
 
 	param = qmi_param_new();
 
@@ -733,7 +733,7 @@ static void qmi_netreg_remove(struct ofono_netreg *netreg)
 		data->signal_info_indication_id = 0;
 	}
 
-	qmi_service_unref(data->nas);
+	qmi_service_free(data->nas);
 
 	l_free(data);
 }
diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index dfd41317651c..74fcf3c8927e 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -133,7 +133,6 @@ struct service_family {
 };
 
 struct qmi_service {
-	int ref_count;
 	unsigned int handle;	/* Uniquely identifies this client's reqs */
 	struct service_family *family;
 };
@@ -1510,7 +1509,6 @@ static struct qmi_service *service_create(struct service_family *family)
 		device->next_service_handle = 1;
 
 	service = l_new(struct qmi_service, 1);
-	service->ref_count = 1;
 	service->handle = device->next_service_handle++;
 	service->family = service_family_ref(family);
 
@@ -1531,7 +1529,6 @@ static void service_create_shared_reply(struct l_idle *idle, void *user_data)
 
 	service = service_create(data->family);
 	DISCOVERY_DONE(data, service, data->user_data);
-	qmi_service_unref(service);
 }
 
 static void service_create_shared_pending_reply(struct qmi_device *device,
@@ -1844,7 +1841,6 @@ done:
 	service_create_shared_pending_reply(device, data->type, family);
 
 	DISCOVERY_DONE(data, service, data->user_data);
-	qmi_service_unref(service);
 }
 
 static int qmi_device_qmux_client_create(struct qmi_device *device,
@@ -2724,22 +2720,11 @@ bool qmi_service_create(struct qmi_device *device,
 						user_data, destroy);
 }
 
-struct qmi_service *qmi_service_ref(struct qmi_service *service)
-{
-	if (service)
-		service->ref_count++;
-
-	return service;
-}
-
-void qmi_service_unref(struct qmi_service *service)
+void qmi_service_free(struct qmi_service *service)
 {
 	if (!service)
 		return;
 
-	if (--service->ref_count)
-		return;
-
 	qmi_service_cancel_all(service);
 	qmi_service_unregister_all(service);
 
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 506fed6b3a66..921136f384db 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -156,9 +156,7 @@ bool qmi_service_create(struct qmi_device *device,
 bool qmi_service_create_shared(struct qmi_device *device,
 				uint16_t type, qmi_create_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
-
-struct qmi_service *qmi_service_ref(struct qmi_service *service);
-void qmi_service_unref(struct qmi_service *service);
+void qmi_service_free(struct qmi_service *service);
 
 const char *qmi_service_get_identifier(struct qmi_service *service);
 bool qmi_service_get_version(struct qmi_service *service,
diff --git a/drivers/qmimodem/radio-settings.c b/drivers/qmimodem/radio-settings.c
index 08e08f50b113..b0d6a4f8647f 100644
--- a/drivers/qmimodem/radio-settings.c
+++ b/drivers/qmimodem/radio-settings.c
@@ -222,7 +222,7 @@ static void create_dms_cb(struct qmi_service *service, void *user_data)
 	if (!service)
 		return;
 
-	data->dms = qmi_service_ref(service);
+	data->dms = service;
 }
 
 static void create_nas_cb(struct qmi_service *service, void *user_data)
@@ -244,7 +244,7 @@ static void create_nas_cb(struct qmi_service *service, void *user_data)
 		return;
 	}
 
-	data->nas = qmi_service_ref(service);
+	data->nas = service;
 
 	ofono_radio_settings_register(rs);
 }
@@ -277,8 +277,8 @@ static void qmi_radio_settings_remove(struct ofono_radio_settings *rs)
 
 	ofono_radio_settings_set_data(rs, NULL);
 
-	qmi_service_unref(data->dms);
-	qmi_service_unref(data->nas);
+	qmi_service_free(data->dms);
+	qmi_service_free(data->nas);
 
 	l_free(data);
 }
diff --git a/drivers/qmimodem/sim-legacy.c b/drivers/qmimodem/sim-legacy.c
index fd05f219ea52..8d069e25965c 100644
--- a/drivers/qmimodem/sim-legacy.c
+++ b/drivers/qmimodem/sim-legacy.c
@@ -323,7 +323,7 @@ static void create_dms_cb(struct qmi_service *service, void *user_data)
 		return;
 	}
 
-	data->dms = qmi_service_ref(service);
+	data->dms = service;
 
 	data->event_indication_id =
 		qmi_service_register(data->dms, QMI_DMS_EVENT,
@@ -379,7 +379,7 @@ static void qmi_sim_remove(struct ofono_sim *sim)
 		data->event_indication_id = 0;
 	}
 
-	qmi_service_unref(data->dms);
+	qmi_service_free(data->dms);
 
 	l_free(data);
 }
diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index e561e269f1f2..4137a432d3d2 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -869,7 +869,7 @@ static void create_uim_cb(struct qmi_service *service, void *user_data)
 		goto error;
 	}
 
-	data->uim = qmi_service_ref(service);
+	data->uim = service;
 
 	param = qmi_param_new_uint32(QMI_UIM_PARAM_EVENT_MASK, mask);
 
@@ -894,7 +894,7 @@ static void create_dms_cb(struct qmi_service *service, void *user_data)
 		return;
 	}
 
-	data->dms = qmi_service_ref(service);
+	data->dms = service;
 
 	qmi_service_create(data->qmi_dev, QMI_SERVICE_UIM, create_uim_cb, sim,
 					NULL);
@@ -938,12 +938,12 @@ static void qmi_sim_remove(struct ofono_sim *sim)
 			data->card_status_indication_id = 0;
 		}
 
-		qmi_service_unref(data->uim);
+		qmi_service_free(data->uim);
 		data->uim = NULL;
 	}
 
 	if (data->dms) {
-		qmi_service_unref(data->dms);
+		qmi_service_free(data->dms);
 		data->dms = NULL;
 	}
 
diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
index 12f5d6726d48..c6252d9d12cb 100644
--- a/drivers/qmimodem/sms.c
+++ b/drivers/qmimodem/sms.c
@@ -759,7 +759,7 @@ static void create_wms_cb(struct qmi_service *service, void *user_data)
 		return;
 	}
 
-	data->wms = qmi_service_ref(service);
+	data->wms = service;
 
 	memset(&data->rd_msg_id, 0, sizeof(data->rd_msg_id));
 	data->msg_mode = QMI_WMS_MESSAGE_MODE_GSMWCDMA;
@@ -801,7 +801,7 @@ static void qmi_sms_remove(struct ofono_sms *sms)
 
 	ofono_sms_set_data(sms, NULL);
 
-	qmi_service_unref(data->wms);
+	qmi_service_free(data->wms);
 
 	if (data->msg_list)
 		l_free(data->msg_list);
diff --git a/drivers/qmimodem/ussd.c b/drivers/qmimodem/ussd.c
index 67dd649f360b..cecd5f13e99b 100644
--- a/drivers/qmimodem/ussd.c
+++ b/drivers/qmimodem/ussd.c
@@ -178,7 +178,7 @@ static void create_voice_cb(struct qmi_service *service, void *user_data)
 		return;
 	}
 
-	data->voice = qmi_service_ref(service);
+	data->voice = service;
 
 	qmi_service_register(data->voice, QMI_VOICE_USSD_IND,
 					async_ind, ussd, NULL);
@@ -215,7 +215,7 @@ static void qmi_ussd_remove(struct ofono_ussd *ussd)
 
 	ofono_ussd_set_data(ussd, NULL);
 
-	qmi_service_unref(data->voice);
+	qmi_service_free(data->voice);
 
 	l_free(data);
 }
diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
index 02376c3df447..7c9326fef28a 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -618,7 +618,7 @@ static void create_voice_cb(struct qmi_service *service, void *user_data)
 		return;
 	}
 
-	data->voice = qmi_service_ref(service);
+	data->voice = service;
 
 	qmi_service_register(data->voice, QMI_VOICE_ALL_CALL_STATUS_IND,
 				all_call_status_ind, vc, NULL);
@@ -653,7 +653,7 @@ static void qmi_voicecall_remove(struct ofono_voicecall *vc)
 
 	ofono_voicecall_set_data(vc, NULL);
 
-	qmi_service_unref(data->voice);
+	qmi_service_free(data->voice);
 
 	l_queue_destroy(data->call_list, l_free);
 	l_free(data);
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 9ab561010912..76507cd7f299 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -124,10 +124,10 @@ static int gobi_probe(struct ofono_modem *modem)
 
 static void cleanup_services(struct gobi_data *data)
 {
-	qmi_service_unref(data->dms);
+	qmi_service_free(data->dms);
 	data->dms = NULL;
 
-	qmi_service_unref(data->wda);
+	qmi_service_free(data->wda);
 	data->wda = NULL;
 }
 
@@ -330,7 +330,7 @@ static void create_wda_cb(struct qmi_service *service, void *user_data)
 		goto error;
 	}
 
-	data->wda = qmi_service_ref(service);
+	data->wda = service;
 
 	if (qmi_service_send(data->wda, QMI_WDA_GET_DATA_FORMAT, NULL,
 				get_data_format_cb, modem, NULL) > 0)
@@ -354,7 +354,7 @@ static void create_dms_cb(struct qmi_service *service, void *user_data)
 	if (!service)
 		goto error;
 
-	data->dms = qmi_service_ref(service);
+	data->dms = service;
 
 	if (qmi_service_create(data->device, QMI_SERVICE_WDA,
 					create_wda_cb, modem, NULL))
diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
index 7d1a33eff9b1..00bd135683cd 100644
--- a/unit/test-qmimodem-qmi.c
+++ b/unit/test-qmimodem-qmi.c
@@ -173,7 +173,7 @@ static void test_cleanup(struct test_info *info)
 	l_free(info->received);
 	l_timeout_remove(info->timeout);
 	l_queue_destroy(info->services,
-				(l_queue_destroy_func_t) qmi_service_unref);
+				(l_queue_destroy_func_t) qmi_service_free);
 	qmi_device_free(info->device);
 
 	/* The qrtr services will be destroyed automatically. */
@@ -220,7 +220,6 @@ static void create_service_cb(struct qmi_service *service, void *user_data)
 {
 	struct test_info *info = user_data;
 
-	service = qmi_service_ref(service);
 	l_queue_push_tail(info->services, service);
 }
 
@@ -259,7 +258,7 @@ static void test_create_services(const void *data)
 		assert(major == unique_service_version(i));
 		assert(minor == 0);
 
-		qmi_service_unref(service);
+		qmi_service_free(service);
 	}
 
 	/*
@@ -286,7 +285,7 @@ static void test_create_services(const void *data)
 	}
 
 	for (i = 0; i < L_ARRAY_SIZE(services); i++)
-		qmi_service_unref(services[i]);
+		qmi_service_free(services[i]);
 
 	test_cleanup(info);
 }
@@ -470,7 +469,7 @@ static void test_send_data(const void *data)
 	send_response_to_client(info, io);
 
 	l_io_destroy(io);
-	qmi_service_unref(service);
+	qmi_service_free(service);
 
 	test_cleanup(info);
 }
@@ -528,7 +527,7 @@ static void test_notifications(const void *data)
 	while (!info->notify_callback_called)
 		l_main_iterate(-1);
 
-	qmi_service_unref(service);
+	qmi_service_free(service);
 
 	/* Confirm no notifications received after the service is destroyed */
 	info->notify_callback_called = false;
@@ -583,7 +582,7 @@ static void test_service_notification_independence(const void *data)
 		info_clear_received(info);
 	}
 
-	qmi_service_unref(services[0]);
+	qmi_service_free(services[0]);
 
 	send_message_to_client(&info->sender, io, QMI_MESSAGE_TYPE_IND, 0,
 						TEST_IND_MESSAGE_ID,
@@ -593,7 +592,7 @@ static void test_service_notification_independence(const void *data)
 		l_main_iterate(-1);
 
 	for (i = 1; i < L_ARRAY_SIZE(services); i++)
-		qmi_service_unref(services[i]);
+		qmi_service_free(services[i]);
 
 	l_io_destroy(io);
 	test_cleanup(info);
-- 
2.40.1


-- 


*Confidentiality Note:* We care about protecting our proprietary 
information, confidential material, and trade secrets. This message may 
contain some or all of those things. Cruise will suffer material harm if 
anyone other than the intended recipient disseminates or takes any action 
based on this message. If you have received this message (including any 
attachments) in error, please delete it immediately and notify the sender 
promptly.
