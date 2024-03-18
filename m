Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5B04779F
	for <ofono@lists.linux.dev>; Mon, 18 Mar 2024 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710788385; cv=none; b=qaK8s8XUndydVSIKy7UxAkbkwyePmdsQ/HIIQaoZKo1e6bQzrg6IwLwNS2MRZAEEPbYDtEHakmftQH3IcRAr95UGNs8xVudaFt4bx0MPsokKdpc1aqYboiZ4rWSOcxqE2S54P1/9aAGJpyYbV3jinQhqdvMJUSp/7oTL9lhXkZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710788385; c=relaxed/simple;
	bh=P8/6TIhpY7GrfzPRSWwhmEzetFGcJPJ7InI4IXl3pQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bOHxGMiEnBwCqQ8WiUoBWuUV0sf+V/jC65xolVY2bzwjFoXXLmqwNzjBFbBgpg22/+fhZPZ00Ne4gCjpmMO0xXrUa2nmfMPqSeLUWvPeC+RQmhiPtL9y1AIRYhlMu7YBeVaoPa9x9FMLdsIraiu5YkiAxFKWvrZho1Fav/JKElk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=I9plU53l; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=aymOEc14; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="I9plU53l";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="aymOEc14"
Received: from pps.filterd (m0286620.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42IFm4S1001710
	for <ofono@lists.linux.dev>; Mon, 18 Mar 2024 11:38:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=KNaobGxm2ddtlWeAKK2x5B
	AYGK8ycGuGUHr1miMT/2A=; b=I9plU53lHEK1Qk48LG5pdDcwnhHxv7d5ou87+4
	E2Ie9hjX8Go5u7EWyiisGpq0pMY0Hf2Jpyv1qLuK+CiO6RsiAvnqstCS4cc6nPkz
	+IPMbph8DI3v1mQyNbZuXDfpMBw36sJPf2aYJ1vRz75idTaieqUW0J5oX7nJ2SfP
	gNlWiZ+IAdEdZwOOSQg5tyou95Bxv4l94bLQhbaA8zLLfZ3W7G9w6OfMTrsDxLFu
	RzI1Z8CzcHGEiGDM7tmvZkI6/PtdT1G9c+2AUZeePi17u7QbpK8HGKDePgpGJJaA
	oqXbV9Za998E8U8DwW9EsTTvKhQABNPY/uJNvosJtN/rS2Vg==
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wwayxhauw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Mon, 18 Mar 2024 11:38:18 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cbf2ff0e33so382797239f.1
        for <ofono@lists.linux.dev>; Mon, 18 Mar 2024 11:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1710787097; x=1711391897; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KNaobGxm2ddtlWeAKK2x5BAYGK8ycGuGUHr1miMT/2A=;
        b=aymOEc14GAJdBzY5nnKbgJW72h8gJ4SJiVXaC4lwIq08Vk7R0N8ozaqqpmX7VzOAs2
         ja9k4gokvpd9DDehqXsPOygunqGuuyCicrVbG0tTiYmZYrGL8raeC6Lyr3vrwttQoO2v
         9sOb50DkxmlbQGIgfcEwFu3uwV0oRzGPvDZy7q58SSbIF53qDePIoaDaRmzXRW77aVmZ
         K5rUIHui2NBHwiFWfKmq++rkPuNR1CjRsqMoFuY97QLz9w7b44XAuefux+adprI4dt+5
         48HAWZo+MbuBkTTR3c220GWzWcUshFxQql4reBoDdzz6JZSZ+z9fzpVkIEWeqVK2QgzW
         jmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710787097; x=1711391897;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KNaobGxm2ddtlWeAKK2x5BAYGK8ycGuGUHr1miMT/2A=;
        b=wVYCp21zk8/yfc6ziGR72jz54+GUug923h82mFS6kgfvzI7bOVkJQPW5gdUW7Q/FrG
         DDLmGLCTsU0FCxPojuQs4tWGAIYwO7rzbGcVQAMGar65nY6LA3d9JnMZAx1m1fY1YvU0
         EVLN9b0Lw592/8qjnBqPPBO9LXId2D5E14LW1dXsMz5E7V6dfcQSGJXuASRLzlvRZYyn
         Qa0TYeOK3ff5oWOnC8GeHSZ5Uzj3+QSAL3HHfSZsd9LJqQzeaqHHCQRRddtEwk29OHjN
         n8lo0t1lt5+bBhOT1Q6YD6msWD8aKpUXp/x+//mbd0D5rSYDeL9P2FtkryGZxXR89Hkz
         u2WQ==
X-Gm-Message-State: AOJu0Yz11RiPd13eZO5VtcY1AdJ7MkdL5Z+j2Rh+UvlQE3iBU2gwbGOv
	Ijifvsfl/+x7stXNZwBdQCEjw9igkdrPnorM7D1gli619QhMavTjrr0hTUNHOp5unEHMBsLT+c0
	h/2Yjt+MWot25ya8PO8sG5zKFYrRMNljUvW73qxTXSteedt794VlFMQlIdOQLLW+jT0zDXtjTTD
	8PYaUe5e/QbkcsQ8XzQjtjVl98yAdFvn3HNmRiu6rQQxU/TrM=
X-Received: by 2002:a5d:9591:0:b0:7c8:e934:5cca with SMTP id a17-20020a5d9591000000b007c8e9345ccamr12728558ioo.15.1710787097046;
        Mon, 18 Mar 2024 11:38:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGMKacoZZCyA93JJeaoaQ4oHqOVQB8lvVv9ncc2HYP4eWJY16ThN919l0Vx0gWWCKtD/u4DQ==
X-Received: by 2002:a5d:9591:0:b0:7c8:e934:5cca with SMTP id a17-20020a5d9591000000b007c8e9345ccamr12728539ioo.15.1710787096694;
        Mon, 18 Mar 2024 11:38:16 -0700 (PDT)
Received: from cs-1zgl0npt-heavy-homedir-768618.corp.robot.car (133.199.192.35.bc.googleusercontent.com. [35.192.199.133])
        by smtp.gmail.com with ESMTPSA id q6-20020a5d9f06000000b007cc6af6686esm873477iot.30.2024.03.18.11.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 11:38:16 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v2 3/3] qmi: Allow QRTR services to be destroyed
Date: Mon, 18 Mar 2024 13:37:48 -0500
Message-ID: <20240318183754.71578-3-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240318183754.71578-1-steve.schrock@getcruise.com>
References: <20240318183754.71578-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: K2Y5zyYx-FFl8hlGIaTEl1axz8TYUPiB
X-Proofpoint-GUID: K2Y5zyYx-FFl8hlGIaTEl1axz8TYUPiB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 mlxlogscore=792 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403180141

QRTR services were never being destroyed because they were being
created with a reference count of 1 and immediately incrementing the
count to 2.
---
 drivers/qmimodem/qmi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 555a4afe562e..69a28afd1a2a 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -2582,7 +2582,8 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 			service = service_create(device, info, 0);
 			l_hashmap_insert(device->service_list,
 					L_UINT_TO_PTR(type_val), service);
-		}
+		} else
+			service = qmi_service_ref(service);
 
 		data = l_new(struct service_create_shared_data, 1);
 
@@ -2591,8 +2592,8 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 		data->func = func;
 		data->user_data = user_data;
 		data->destroy = destroy;
+		data->service = service;
 
-		data->service = qmi_service_ref(service);
 		data->idle = l_idle_create(service_create_shared_reply,
 							data, NULL);
 
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
