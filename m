Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F3A54F9D
	for <ofono@lists.linux.dev>; Fri,  1 Mar 2024 20:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326190; cv=none; b=Sss1qjbCW79T3lQkO2zXUeosHqvOEEIy9vO5FQ2dds2xEB1GCd/NZnmQ1zOi5TqYM322rvXuy1Xa5LnFWl+W+Kq3Z8aAmCzZcpJoTm36OJc06UioxflTGhCfjbheqxUW6aq16UhKl1heoHE3kdEEh0BuFXmT5dK5U1pi/xnF2FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326190; c=relaxed/simple;
	bh=I09cZ/GC1UkwE0fVTz5ImFy7Cwjs9t/d4yt+iLlLNB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VX19RMDhQU0qBfTrWUd3LZ5UudGK1jA3XfCG+MAnPgR/rJq6tCJnfIIPyx+YLvi269fpFhEU62rmdq4Y3p5Seel7h12SQFXaQVirIHCbybsp5rrNNnqSCMoZB1M7PR92A9ctfwA/Q0suflTKq0rfKVjueOqYhwUkW25W3XONgO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=tR2Lu0iT; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=rHUDCbrV; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="tR2Lu0iT";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="rHUDCbrV"
Received: from pps.filterd (m0286614.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 421E0Tkw014882
	for <ofono@lists.linux.dev>; Fri, 1 Mar 2024 12:49:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=LCU1eG8EV/KA1Fsuq9N/hs
	UuOmavG040JN3juy73AnI=; b=tR2Lu0iTGNYKHhCQxm5J8/8Yzez70g0q3I4cKO
	PonB9WE83IbfFfsdvsV8tirw8UgtIHOB4Gdt6RH+1O7N2AkAZSN73etM44zQRBIQ
	nVgwWoVK+g7pQjehaUPrQK2ylRvFQdzPXcfpDNNNY1XQPHLqINWg+HXUtg1sh/HQ
	mzzbmNDK4/XgIm3Jo1HCRnLrgNUBQ17uCktfoBpe3xK93i1+aj5LSCQZxh40MfSH
	Gp6KF9hJYvIUIqzeTgZFBTK9YWQowQ3k2FikX1Vv46Ei1yg1S60oDq7fnmfKJQ/z
	wV19Px8qMnn2/zwtVxVqdroAOtSuOWE/uH7yEgjU4pERDnoA==
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wj1bqamhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 12:49:42 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36527824ab9so27562985ab.1
        for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 12:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709326181; x=1709930981; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LCU1eG8EV/KA1Fsuq9N/hsUuOmavG040JN3juy73AnI=;
        b=rHUDCbrV1ZUlGd6Cv1xU/EpCazu1TBb58qkuC2YJDINdDRReHjKXUgqpJbCrwwBmzT
         N6tLNY85dQ/1Y8351NK5KwGtEKAqkjaz7bhhvoiTtvwaqU/CmnLf5QHTlpn+gnchhMpy
         5m+ckGKCysI9K6kZpz38/SNRN0BQAoTjyn3eCsEOuMZJH5Zn9YEXQDTE5LBXXB6g4OVP
         VaOLswEZrUDoDLgCLyf6Av2h+fdmf3cxWLyiAQe+p1OgxeA5W9R+I4wZer8R+gApDDxa
         uueTnBOdN2b0TrrOgjlfyPdKuAI7xPXUpP0NvB8GDiXbd9nCv3Pj6jGxEd5SjWpuDDpv
         A+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709326181; x=1709930981;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LCU1eG8EV/KA1Fsuq9N/hsUuOmavG040JN3juy73AnI=;
        b=oaN7Te7rg7hnHbZrim+WetknOMs9uUk0S5piQE1fk3rWSavxf0b9qlPgGIQae3uvBf
         OZKoyg6CD74e4JQjGSJo4Cf8xLfkmbc5kUPKdJXl1fbvZPJQZzomS5wjmAgufpHcj+rR
         5BTu942p6IjeUFWBsQZERDXfSolGQi7aB0AU8IchKhYc/a1RssUq2LXPC3Z09CLC7+9Y
         hPiE1bvqEIX2mCE5p4J7jcHEsBgnYSKMo+pfp2t/EHZ9mvmI+5rxqjgkCQ9Ls8iVZlnA
         BL5i9DNOfeQAQgzJ7utdZq6FX+pnVj3dv+9+5kw0KOw5SJZ8omMtaWmkRuT23VJVo9FX
         xXRw==
X-Gm-Message-State: AOJu0YzW2syxLO8hKvDlcyYeDz/XBD+lT0KYLfeDuiooq4awAaMYyuX6
	5zezQ4WM+qCSIUDdOck3fUb9P/u/AzX3kfsfe3Pq/n3PfPmgF93EeI631hlrV7XUIy5s9T0tH8B
	mGueTXTFKsdrg8Rbn3VOFW5EzXUZdZEKEOJR46VKotAnXlwto8k4NKvqK0xZH3tT/Cu3JFN4+ry
	x41VlL1o2olw6Hz0IqFAXn8d9OFH65KiRk2xD7sdGEtGCQ2wRVKg==
X-Received: by 2002:a05:6e02:12c1:b0:365:1174:6e18 with SMTP id i1-20020a056e0212c100b0036511746e18mr3237844ilm.10.1709326180777;
        Fri, 01 Mar 2024 12:49:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHia4z8jarrxwI5Juin1SdiLHlPIRekwig5qz2O69Z8QKWAMRjOnNPfmKytIxJm4RrkIxSzTg==
X-Received: by 2002:a05:6e02:12c1:b0:365:1174:6e18 with SMTP id i1-20020a056e0212c100b0036511746e18mr3237829ilm.10.1709326180388;
        Fri, 01 Mar 2024 12:49:40 -0800 (PST)
Received: from cs-1zgl0npt-heavy-homedir-303475.corp.robot.car (122.32.128.34.bc.googleusercontent.com. [34.128.32.122])
        by smtp.gmail.com with ESMTPSA id o2-20020a92dac2000000b0036581060910sm1089407ilq.6.2024.03.01.12.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:49:40 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v2 2/3] qmi: Store the service info in the request
Date: Fri,  1 Mar 2024 14:49:25 -0600
Message-ID: <20240301204929.87220-2-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301204929.87220-1-steve.schrock@getcruise.com>
References: <20240301204929.87220-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: c4zbX0We1vYR7wyXwVJ_ncdMsDrR-xY_
X-Proofpoint-ORIG-GUID: c4zbX0We1vYR7wyXwVJ_ncdMsDrR-xY_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_21,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403010173

QRTR will need this to write to the appropriate node and port.
While here create helper functions to simplify request allocation.
---
 drivers/qmimodem/qmi.c | 60 +++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index be598007..349cead9 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -63,6 +63,7 @@ struct qmi_request {
 	uint16_t tid;
 	unsigned int group_id;		/* Always 0 for control */
 	uint8_t client;
+	struct qmi_service_info info;	/* Not used for control requests */
 	qmi_message_func_t callback;
 	void *user_data;
 	uint16_t len;
@@ -262,6 +263,31 @@ static struct qmi_request *__request_alloc(uint8_t service,
 	return req;
 }
 
+static struct qmi_request *__control_request_alloc(uint16_t message,
+				const void *data, uint16_t length,
+				qmi_message_func_t func, void *user_data)
+{
+	return __request_alloc(QMI_SERVICE_CONTROL, 0, 0x00, message,
+					data, length, func, user_data);
+
+}
+
+static struct qmi_request *__service_request_alloc(
+				struct qmi_service_info *info,
+				unsigned int service_id, uint8_t client,
+				uint16_t message,
+				const void *data, uint16_t length,
+				qmi_message_func_t func, void *user_data)
+{
+	struct qmi_request *req;
+
+	req = __request_alloc(info->service_type, service_id, client, message,
+						data, length, func, user_data);
+	memcpy(&req->info, info, sizeof(req->info));
+
+	return req;
+}
+
 static void __request_free(void *data)
 {
 	struct qmi_request *req = data;
@@ -1494,9 +1520,8 @@ static bool qmi_device_qmux_sync(struct qmi_device_qmux *qmux,
 
 	__debug_device(&qmux->super, "Sending sync to reset QMI");
 
-	req = __request_alloc(QMI_SERVICE_CONTROL, 0, 0x00,
-				QMI_CTL_SYNC, NULL, 0,
-				qmux_sync_callback, data);
+	req = __control_request_alloc(QMI_CTL_SYNC, NULL, 0,
+					qmux_sync_callback, data);
 
 	__ctl_request_submit(qmux, req);
 
@@ -1622,9 +1647,8 @@ static int qmi_device_qmux_discover(struct qmi_device *device,
 	data->user_data = user_data;
 	data->destroy = destroy;
 
-	req = __request_alloc(QMI_SERVICE_CONTROL, 0, 0x00,
-			QMI_CTL_GET_VERSION_INFO,
-			NULL, 0, qmux_discover_callback, data);
+	req = __control_request_alloc(QMI_CTL_GET_VERSION_INFO, NULL, 0,
+						qmux_discover_callback, data);
 
 	data->tid = __ctl_request_submit(qmux, req);
 	data->timeout = l_timeout_create(5, qmux_discover_reply_timeout,
@@ -1768,10 +1792,9 @@ static int qmi_device_qmux_client_create(struct qmi_device *device,
 	qmi_device_get_service_version(device, data->type,
 						&data->major, &data->minor);
 
-	req = __request_alloc(QMI_SERVICE_CONTROL, 0, 0x00,
-			QMI_CTL_GET_CLIENT_ID,
-			client_req, sizeof(client_req),
-			qmux_client_create_callback, data);
+	req = __control_request_alloc(QMI_CTL_GET_CLIENT_ID,
+					client_req, sizeof(client_req),
+					qmux_client_create_callback, data);
 
 	data->tid = __ctl_request_submit(qmux, req);
 	data->timeout = l_timeout_create(8, qmux_client_create_reply,
@@ -1805,10 +1828,9 @@ static void qmi_device_qmux_client_release(struct qmi_device *device,
 
 	qmux->release_users++;
 
-	req = __request_alloc(QMI_SERVICE_CONTROL, 0, 0x00,
-			QMI_CTL_RELEASE_CLIENT_ID,
-			release_req, sizeof(release_req),
-			qmux_client_release_callback, qmux);
+	req = __control_request_alloc(QMI_CTL_RELEASE_CLIENT_ID,
+					release_req, sizeof(release_req),
+					qmux_client_release_callback, qmux);
 
 	__ctl_request_submit(qmux, req);
 }
@@ -2690,11 +2712,11 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	data->user_data = user_data;
 	data->destroy = destroy;
 
-	req = __request_alloc(service->info.service_type, service->group_id,
-				service->client_id, message,
-				param ? param->data : NULL,
-				param ? param->length : 0,
-				service_send_callback, data);
+	req = __service_request_alloc(&service->info, service->group_id,
+					service->client_id, message,
+					param ? param->data : NULL,
+					param ? param->length : 0,
+					service_send_callback, data);
 
 	qmi_param_free(param);
 
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
