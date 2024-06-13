Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90331474CC
	for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 21:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314911; cv=none; b=gubMlMoq8n5U70l4EZwUN1Ws4aYPVOwSqnH5fhL1ur5zs8FyWxyEd+ryfCMZgdEp2X+Z1kZSjx1/PSU+Eo24h9Io7JsdIILnQQ1K99gdu5lEY2rjQqHdE4jtYFGH45aIJ9n2m5eUiqJlACB/aJelQlbrMmOaFKT5OymDRkJgIgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314911; c=relaxed/simple;
	bh=wzYdTRlhE+T1Gsu4ILYj5EuMI5N7BiwPoA/D/2ZAL70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYR+vZEwWS/9tQ6LdofMJ0seZtNIwdgXDj1J/+GcDZuDOALWBw7a+GdD5ED037UdWF0YNCSNpLSH8f87KuyDTsL48bjwZE/iIcNqHeGwsCeK0m5yScoGw34TwqTXxMKghO4gWnBGISrhl8jcEBFcgkKN7DG/Epqfs13mmAyQQkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWikDrJj; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWikDrJj"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-24c9f628e71so692729fac.1
        for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 14:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718314909; x=1718919709; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vf4SpEpnoCllwXBGINv/+E8pq+psrDRzlKTFTwE7q94=;
        b=OWikDrJjIkXDeTWtYI9M6Lhg+GM51VIrHaRswRGGLM17foTIy3CvPcF8TEIq1+IUgC
         tlUsxb9B0yZbczaDhkh42VSB/CVo4SPt7IsIFG58gdHGcz8AZK5tybRvve2iw0n4ggQs
         U4/3xCHWzz8Fev7MaYUdyt3VXqNu4F7HER4MKRL4MP965nWNXb4Kzcs+pw7hyCxKe0dg
         HeNEucZsHp3T1jvD7L8H1trsl8VP8lyY8HZXXGBFU1Yzmzz4p5vcZaX+L5BAufPCNjVp
         xQBTxDLZx74RTA2lJOAaOSOwDGbyawGYKxf+Hs70QffUs38i9YTVDMDQpBquCdZl/W2x
         9ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718314909; x=1718919709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vf4SpEpnoCllwXBGINv/+E8pq+psrDRzlKTFTwE7q94=;
        b=pD1VcnZz1ceYmchmY7YHJLR3WTLJ4SeE01WOmi5Fmd79s3h9Ewx+GvXOZGpcJCdun2
         XmL6Vs5W4gu6W8Z4ZDLRURslAvGMHQOvj9TZHyO/YvU22NJLUaeaw6WwoPgoTqaYtiIE
         vw3ZqLn/0zEBjd08fxgHQ3340kxIyNYewMUQc0ilkwGEwZ0yB4gYOKu2jOSfJhYN5SF+
         roIT/AS86lA0Omr9etGY30fD1Z3FuzY0X7jtTboaBUJ9M6QoCWsYTR+kwzMohuddS8np
         JJZTZ47eT1EnyUHNZkfOWgWQ7GtzkxbKSAErJ7ObMgD1GDnxBi/RDQo4+DqpvPwMgISr
         Szuw==
X-Gm-Message-State: AOJu0YwfZ+6Qz9K5ZrLmGSgMTiP00Gfww/gRODi0edrjXTUlgCQdmUVs
	m0QA5/VvDsmgc1aH4GtAcx1eOHhlVOj7gwi9VP9UzsyOOrqjIfQvSH8OAA==
X-Google-Smtp-Source: AGHT+IGiM8v++Cq+iKVJ0PoAvJdlhRpVIu/4Ikj9fo0lEqkPD2qCnJCHy8wwg6a9SFI4ZVbzeyC7vA==
X-Received: by 2002:a05:6870:440e:b0:24f:e100:ba2d with SMTP id 586e51a60fabf-25842b9b48fmr863568fac.54.1718314908831;
        Thu, 13 Jun 2024 14:41:48 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f768sm601589fac.41.2024.06.13.14.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 14:41:48 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 18/23] qmi: netmon: Drop use of qmi_service_create_shared
Date: Thu, 13 Jun 2024 16:41:27 -0500
Message-ID: <20240613214134.1056517-18-denkenz@gmail.com>
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
 drivers/qmimodem/netmon.c | 26 +++-----------------------
 plugins/gobi.c            |  3 ++-
 2 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/qmimodem/netmon.c b/drivers/qmimodem/netmon.c
index f45a9efd6af8..82e0f2a4c737 100644
--- a/drivers/qmimodem/netmon.c
+++ b/drivers/qmimodem/netmon.c
@@ -195,39 +195,19 @@ static void qmi_netmon_request_update(struct ofono_netmon *netmon,
 	l_free(cbd);
 }
 
-static void create_nas_cb(struct qmi_service *service, void *user_data)
-{
-	struct ofono_netmon *netmon = user_data;
-	struct netmon_data *nmd = ofono_netmon_get_data(netmon);
-
-	DBG("");
-
-	if (!service) {
-		ofono_error("Failed to request NAS service");
-		ofono_netmon_remove(netmon);
-		return;
-	}
-
-	nmd->nas = service;
-
-	ofono_netmon_register(netmon);
-}
-
 static int qmi_netmon_probe(struct ofono_netmon *netmon,
 					unsigned int vendor, void *user_data)
 {
-	struct qmi_device *device = user_data;
+	struct qmi_service *nas = user_data;
 	struct netmon_data *nmd;
 
 	DBG("");
 
 	nmd = l_new(struct netmon_data, 1);
+	nmd->nas = nas;
 
 	ofono_netmon_set_data(netmon, nmd);
 
-	qmi_service_create_shared(device, QMI_SERVICE_NAS,
-					create_nas_cb, netmon, NULL);
-
 	return 0;
 }
 
@@ -240,11 +220,11 @@ static void qmi_netmon_remove(struct ofono_netmon *netmon)
 	ofono_netmon_set_data(netmon, NULL);
 
 	qmi_service_free(nmd->nas);
-
 	l_free(nmd);
 }
 
 static const struct ofono_netmon_driver driver = {
+	.flags			= OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE,
 	.probe			= qmi_netmon_probe,
 	.remove			= qmi_netmon_remove,
 	.request_update		= qmi_netmon_request_update,
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 34aa363cf82e..8e16e63cd6e2 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -831,7 +831,8 @@ static void gobi_post_online(struct ofono_modem *modem)
 	if (data->features & GOBI_NAS) {
 		ofono_netreg_create(modem, 0, "qmimodem",
 						qmi_service_clone(data->nas));
-		ofono_netmon_create(modem, 0, "qmimodem", data->device);
+		ofono_netmon_create(modem, 0, "qmimodem",
+						qmi_service_clone(data->nas));
 	}
 
 	if (data->features & GOBI_VOICE) {
-- 
2.45.0

