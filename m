Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAB0135A53
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545182; cv=none; b=H0xPBj2bvnb3bIIP+pD/O4x2P9R+onzpA5UjoLEbWuDR8/kd8TKdbFeYeRwSodCfiCc4ki5/GOkjLCuLaRDm43a+hli74f5jEa25SvjqKQWm9Vx8NnovApWd5OUTvhF8nPaM4p7zibMt+46FJV9MJMZH18dhN7y2k9PUJNOH+io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545182; c=relaxed/simple;
	bh=oOzKEu8v/dbN3erXUWCSo4kTIG/KoxtjlVkCe/qTOKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atLGgG+vx2wkNuiaxPZWatayTMnz0zEFqpFOhwCbX3ZlsgCYKCUKWIJI59uvk0K+jb0HcfeUzHjBRVeXg56U60wQ3e//YDlvalD+w6JLD7kzkgxRGxpRYy4aiWy3sGI6IP48i5K8UU5k/Jik3rOpoQ7pdW1LFkH+XEYS/giHSYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=L8hgnYCq; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=FiV3qdpJ; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="L8hgnYCq";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="FiV3qdpJ"
Received: from pps.filterd (m0286619.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JEQnBk002949
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 09:46:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=cupkaHrkFB8Zd95O0Nz/JN
	FpMJjNzDMV/8Tznzi9+B4=; b=L8hgnYCq7JxgIc9nr/plM58FR9gjO2t57d7V5w
	MWecRB4dmSSjd5HJBQGGOUP1BgWH6Zs5Xu4QBNJgyGNB6mbcteGaVHjaV6VRR5/M
	F5ElOMxJsT30HXqqwPMeSbSkQ4CS23GKpkBonfjsH8uj/QMKVooRbAj47yBorwxa
	QwusuaYqyT9DBd/2Kbat7Oq4u3vFtMPdP8zYRbBJaqzMoufQg1GhNwwvc3pTxCLi
	CMRhtXwNRMn2l4Pv8vX7C8IWB5qX/9pk1JjKc01RMIUBH9Hbt884WgamSx+dghem
	Qkmk3xzZ9q2sFHiaVhG5hY754RCWJsyG80e7LXPmh3jD6HNQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xks4w8584-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 09:46:19 -0700 (PDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-43689467973so30401731cf.1
        for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 09:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1713545178; x=1714149978; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cupkaHrkFB8Zd95O0Nz/JNFpMJjNzDMV/8Tznzi9+B4=;
        b=FiV3qdpJN65pf8CEoIo9Apr2ie5btzsmue+1l8WVxhnjhjYQub9dfgFZknWGyb+omW
         UwycdsDgYA2yzyOKx9gU6+yy1ZyLgW/uotLiBxo66YXQyxvvYoAfHMkEtLrxY7cYFyG4
         AVuwMHdwUNQVcT8g3CmSf+gDsv2OcsxLP8Lg6IgTWPfmcmR47aFAeTBO7VWc4CWbZhOz
         LQ0qwu3Ov9fQH2p4xU+ZmeX8JZoncMe5zh9AYzAgFMIQyHwNsYfoHxPICF0DRUaa6M0U
         waE1EBYAlmEYfxPw4GA1n7wD3Q/rjZEI+Gc+DG0Fe4buMm9ob47F4j7pp09y2Figy1bk
         Q4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713545178; x=1714149978;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cupkaHrkFB8Zd95O0Nz/JNFpMJjNzDMV/8Tznzi9+B4=;
        b=keFTj2DoDUFV3J606nDDaGHhu9oktQTktgR51qv+rUOrspV4AgKbdVDEW0Ar8e/ZHq
         x5A+vXy+90mGv1yeuncavx+VHsGygAKCHUkz7tPJPKfsxJyyvGCcA/wRcXxSTuY2K1gl
         BSvzNXUVf7sRklMLMeJ08kc0baVoXIBC36KtmJ48VQv+CFLn5kr+ydZuZHSHadEkrkCv
         +lQgTahljUhkgcFJKC06LDRSHtVsLipQVgelHX0pRky8WJ4sJJp9NCaHvuKPFhHYDib7
         jb5HtrvNqld9uyoB0L7k2LSLUI4oeFFz+mS8i9w1Gv7VCbwK7VvPXE2QoOmKg3MNBaoC
         eMHg==
X-Gm-Message-State: AOJu0YwQdiq0Xf0xWRG3XZpZMwwbhQMShdzYlF3l04Zf1LDMWBvbcNpv
	JislvnQL4rMOsCj81G3J4srpJdyd7QdCeDvP44cXDa5uTKqJgApS9GLf9XxYT6BKYEtfn1OPMCm
	bkfVdiTcljwEH0Nmi+r5kkaxXRcigjt8bfjeHgUFkIPbiDDYOajJUBThbIK0+rDaGnEMqxV/KrH
	dJuivwlFrSN4zF1Gbg0DeL+TtKfHsiuR33SzEoc1Bk4wwGT5g=
X-Received: by 2002:ac8:7f14:0:b0:437:b9fb:dcff with SMTP id f20-20020ac87f14000000b00437b9fbdcffmr3145577qtk.7.1713545178561;
        Fri, 19 Apr 2024 09:46:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEBHLgeK6IV+erma2VoWx/f9ldviqSqPxMgVE+v7mYSgrtEJJp2d7xR7wFLOiI2mQb9iqihw==
X-Received: by 2002:ac8:7f14:0:b0:437:b9fb:dcff with SMTP id f20-20020ac87f14000000b00437b9fbdcffmr3145552qtk.7.1713545178172;
        Fri, 19 Apr 2024 09:46:18 -0700 (PDT)
Received: from localhost.localdomain ([140.141.181.78])
        by smtp.gmail.com with ESMTPSA id n9-20020a05622a11c900b00437a0c8e662sm1577295qtk.20.2024.04.19.09.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 09:46:17 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 5/8] qmi: Prevent clients from unregistering for others
Date: Fri, 19 Apr 2024 16:44:55 +0000
Message-Id: <20240419164458.36078-5-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240419164458.36078-1-steve.schrock@getcruise.com>
References: <20240419164458.36078-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: aYZmILNG4Mz1w9KLJiPMD7sIMbQNKZGr
X-Proofpoint-GUID: aYZmILNG4Mz1w9KLJiPMD7sIMbQNKZGr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_11,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=920
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404190127

qmi_service_unregister was removing the registration that matched an
integer ID. This would allow a client to unregister a different
client's notification. While this is unlikely it could lead to very
confusing bugs. This is easy to prevent by checking both the ID and
the service handle.
---
 drivers/qmimodem/qmi.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index f406d01a8df6..5032233ec1ec 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -330,12 +330,18 @@ static void __notify_free(void *data)
 	l_free(notify);
 }
 
+struct notify_compare_details {
+	uint16_t id;
+	unsigned int service_handle;
+};
+
 static bool __notify_compare(const void *data, const void *user_data)
 {
 	const struct qmi_notify *notify = data;
-	uint16_t id = L_PTR_TO_UINT(user_data);
+	const struct notify_compare_details *details = user_data;
 
-	return notify->id == id;
+	return notify->id == details->id &&
+			notify->service_handle == details->service_handle;
 }
 
 struct service_find_by_type_data {
@@ -2962,16 +2968,17 @@ uint16_t qmi_service_register(struct qmi_service *service,
 
 bool qmi_service_unregister(struct qmi_service *service, uint16_t id)
 {
-	struct service_family *family;
 	struct qmi_notify *notify;
+	struct notify_compare_details details;
 
 	if (!service || !id)
 		return false;
 
-	family = service->family;
+	details.id = id;
+	details.service_handle = service->handle;
 
-	notify = l_queue_remove_if(family->notify_list, __notify_compare,
-					L_UINT_TO_PTR(id));
+	notify = l_queue_remove_if(service->family->notify_list,
+						__notify_compare, &details);
 
 	if (!notify)
 		return false;
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
