Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B666A86244
	for <ofono@lists.linux.dev>; Wed, 28 Feb 2024 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157321; cv=none; b=Dfq7eCVqef1MVUbuz0ek/eP3y4M6CduY1ykikk8MqWDnv76Jb7HtRAP4ktVDkx8eoN238b12/Nkm/7rK+qkoU8+r811IkyiGAmyGvDaw1pzRzIiumsdtwE+hdItxvPygS6tSnAV0Q704PQIV1RuGtBpoAAop5ris91G9SpjsCFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157321; c=relaxed/simple;
	bh=AgWizmoOwgIUjqkAZUap5yVjPLRRZTlkGZIMQ3POeyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pI74X+dQgeiwNxhMkDEIUPJNh0ywTj+nVtl88cmhBL14NiCyJsAw5dRYWxdAIihZm6uO8Kb6FE9QYfpFF40KQgN78mIXUtSva2hHe0urgN0oen02Fb3czZu1fJbWjtBxcza41Ev46Fswot5o27WB3JwjozqV+Y0g+p+JIR++7xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=TghOZPla; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=JlqIS/8x; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="TghOZPla";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="JlqIS/8x"
Received: from pps.filterd (m0286614.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41SDTdCm030592
	for <ofono@lists.linux.dev>; Wed, 28 Feb 2024 13:55:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=hdjz1RCJfEntEHoKpfu4oy
	Sv6j2YfxSRh5DgvUyBHuc=; b=TghOZPla3IFJsaETOun4gNECdvbWwddLuqyEL4
	1O7autYcZDAYMUu2tFTm67mbjuZBJNppkED2w2Fe6PBSyrIfeQ3OR3czhud9lxCr
	3Z54TdkPK2ZBZD7ySGr7CaKaTYb9I5ZbWgRVNHt+iElE3irWUrF++ZGDqziTg/Vm
	wi5ukEVPz7dOClCJzForiMfjMvuWI3rtOLF2g866GCjsNbuLYj1oRVEB9E0nee0v
	ugUFkE3KggvS54+Glvo0tVkqsiiQPJwjhmKjrcmeVeU5YwgdniyERk0PmEFnykSH
	pOsAd2kXA9+UOScNrOnUuUUjCMWqvEoyW0kXNQ7EDVacP/jw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wj1bq8m80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Wed, 28 Feb 2024 13:55:13 -0800 (PST)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-787d1903812so22973585a.2
        for <ofono@lists.linux.dev>; Wed, 28 Feb 2024 13:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709157312; x=1709762112; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hdjz1RCJfEntEHoKpfu4oySv6j2YfxSRh5DgvUyBHuc=;
        b=JlqIS/8xTITIjJEIzHk8FJXoazRjqNQSfA/FeNLeJSqjRj5OzjLcRiE79F605OtrEO
         o5EaO5aHsqk0qyn7NJlQbvFT9k3uNW+miAYH8Ho4JSKNMlZcuRxDQ3IK0AI3wFfo1OCW
         AEm2XbYuhcfPuzR7SoNkFoAYoZieULusuDtg9kE5Oa+4KP8eAsTQMLjf3n3oTedddMd1
         YE/p/h414UohmBW7WPk/yq4NjHHJcrhfos0dN3+psZ0fBmCsOM13jihH/n/RTG1pOUvD
         oxxY0Wc+8sF84AvaxBUMcRwgocEHnBP86Vj9HXXF97VLVibGr8RusCpGUB7DX7UO8bg+
         ZfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709157312; x=1709762112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hdjz1RCJfEntEHoKpfu4oySv6j2YfxSRh5DgvUyBHuc=;
        b=I17Cc3WhA6HrGgUXqar8BDQMKVGuW4pJKHk0KorR8I+UTuxJ2jFI7bDsfCV9P/9eJG
         oRqgn2YpfktzTOYRIKod66c3XUkzt6wdlPvTeMuFYeXTvCa2/A7ScPLWU/mKIBP3F7k0
         4f3AJkxCsB5AtmyT6bxIZKbP7AhrQibvmtR6QNgsiTNkwKu3qF3q/uDFTt/BDmVWkFwZ
         jhXTI7h/Btaa4YNR8dn6BGJM1AmnPFb8d3aC8uERzmuHQ30ROIera4pIIxPjOhsgIwmb
         RuSgfowREN0uzBO7c4SYVpXrmhIlbIrtCisgCtTXkrsacXK7aQJxNwrp7bRysSjUqB72
         dKPg==
X-Gm-Message-State: AOJu0YzQHtobBp5ouH0et0D310V0vAKaiYLoauDmLKmUJY/Wy9/4EoDE
	Q5IQmk15qVn6z5vpDXq3Ec6ueL5+c9U+5s62C3C3osrZDTNlNQTpSRVAsqzbisTnMmRqQ9KYagv
	HZIxWPKYUwYaGG6dFx+B2d7cTL9mi5re75xABRiaP3DC54jHu4LF+pDibo0kuOEyvE++SkSuARJ
	vkLba0P5dc98tZPo4mPiWRQDCycB1uAAldD+ARSqnygRPaWCk=
X-Received: by 2002:a05:620a:5d91:b0:787:2727:6a7e with SMTP id xx17-20020a05620a5d9100b0078727276a7emr331244qkn.28.1709157311956;
        Wed, 28 Feb 2024 13:55:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTnUHXDo6EoncH/SDKuTXQ5oaV6NUVy883mMAJQ5JdHqjxoOQn+2ged5GLxhYL4CdBa61rjw==
X-Received: by 2002:a05:620a:5d91:b0:787:2727:6a7e with SMTP id xx17-20020a05620a5d9100b0078727276a7emr331230qkn.28.1709157311542;
        Wed, 28 Feb 2024 13:55:11 -0800 (PST)
Received: from localhost.localdomain ([140.177.178.112])
        by smtp.gmail.com with ESMTPSA id z8-20020ae9f448000000b00787c6ed9a68sm33963qkl.91.2024.02.28.13.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 13:55:11 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 3/4] qmi: Allow for 16-bit service types in the type hash
Date: Wed, 28 Feb 2024 21:53:18 +0000
Message-Id: <20240228215319.153068-3-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240228215319.153068-1-steve.schrock@getcruise.com>
References: <20240228215319.153068-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: 2Wyrm3orIVvpvsrXTE3yFG30KVwahJLT
X-Proofpoint-ORIG-GUID: 2Wyrm3orIVvpvsrXTE3yFG30KVwahJLT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280174

Only QMUX has client ids and they fit into 8 bits.
---
 drivers/qmimodem/qmi.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index a297a77f..afa7b962 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -734,6 +734,11 @@ static void service_notify(const void *key, void *value, void *user_data)
 				result);
 }
 
+static unsigned int service_list_create_hash(uint16_t service_type, uint8_t client_id)
+{
+	return (service_type | (client_id << 16));
+}
+
 static void handle_indication(struct qmi_device *device,
 			uint8_t service_type, uint8_t client_id,
 			uint16_t message, uint16_t length, const void *data)
@@ -757,8 +762,7 @@ static void handle_indication(struct qmi_device *device,
 		return;
 	}
 
-	hash_id = service_type | (client_id << 8);
-
+	hash_id = service_list_create_hash(service_type, client_id);
 	service = l_hashmap_lookup(device->service_list,
 					L_UINT_TO_PTR(hash_id));
 
@@ -1698,8 +1702,8 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
 					service->client_id,
 					service->info.service_type);
 
-	hash_id = service->info.service_type | (service->client_id << 8);
-
+	hash_id = service_list_create_hash(service->info.service_type,
+							service->client_id);
 	l_hashmap_replace(device->service_list, L_UINT_TO_PTR(hash_id),
 				service, (void **) &old_service);
 
@@ -2527,8 +2531,8 @@ void qmi_service_unref(struct qmi_service *service)
 	qmi_service_cancel_all(service);
 	qmi_service_unregister_all(service);
 
-	hash_id = service->info.service_type | (service->client_id << 8);
-
+	hash_id = service_list_create_hash(service->info.service_type,
+							service->client_id);
 	l_hashmap_remove(device->service_list, L_UINT_TO_PTR(hash_id));
 
 	if (device->ops->client_release)
-- 
2.43.2


-- 


*Confidentiality Note:* We care about protecting our proprietary 
information, confidential material, and trade secrets. This message may 
contain some or all of those things. Cruise will suffer material harm if 
anyone other than the intended recipient disseminates or takes any action 
based on this message. If you have received this message (including any 
attachments) in error, please delete it immediately and notify the sender 
promptly.
