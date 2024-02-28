Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E015D5C1
	for <ofono@lists.linux.dev>; Wed, 28 Feb 2024 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136241; cv=none; b=hsSh7oBBn1k7Ngukcjcj3JwbFbeGcbDKH69Wop4hrZ3+sy11LOd9kZE4cgR2kPffX30+qesmGvvHVjpwrkM8q+8ok2OAWkhLuFCxhv1NjsESwEHdVgd8++FopcjwGzRmGfxBD4ItyNI9W7EcOeH5DuVGCwASex9scBUcSDXC/YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136241; c=relaxed/simple;
	bh=olusDFsEkZ9cPdSD3vAIztl8uF18ZbUO6FF2kRbv5bE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fqEtGyilFf/GYDMRVQvXqdjRhrIaFb8BjCcOxGfFyKvlem4U6gyUPpP7+Yb/bvHhehVzLFsFB3ZAVcBae5tEDMjEB5zfsAGLl8tOXAR+IC5JqRTHUdhBtUcd4C5SOwspyWKrzLMvvLdglRVIv3Xkular5tTIaIW9w8X9OBLb4Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=a/hkYqEb; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=XjK3a+Up; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="a/hkYqEb";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="XjK3a+Up"
Received: from pps.filterd (m0286620.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41SEmJjZ001510
	for <ofono@lists.linux.dev>; Wed, 28 Feb 2024 08:03:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=y3WzssPK3gfaq0Q7M4RQjOkr0RHXR6Ju2A2y70ZCLj4=; b=a
	/hkYqEb3MP9VKqLCtVGcB//KB3gDIn1yxgo94tuzlip8Kdmeqn+nGrCCvISfrumc
	RO6hXHu8EGGQ8HDMvXHfLbpGCldEd2Q5wSnXyIFsqLLfN8KLNIfxC2RlqYjaxclg
	Irs/9zbKMlvpoXie24yY1NYWP8soONE6+UI44lvZQEUH6H2bPgWeOK3U58uPy5Lg
	4RV/6lTfmFso+Wr5VLUpMUdmxGLbmpfR0HRCFAJUbrtnhDNRNUhBRKYGbwXd6ozp
	P8bBxGymqUqZzdRtJIJj38ws9GdEKPSkjvVowoWkK0WbETSPJkFR6+RIH1Joq3Bi
	QbkRPlaIwqM19xv8vqTmw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wgygr22fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Wed, 28 Feb 2024 08:03:56 -0800 (PST)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-42e8784b9a2so39440061cf.3
        for <ofono@lists.linux.dev>; Wed, 28 Feb 2024 08:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709136235; x=1709741035; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y3WzssPK3gfaq0Q7M4RQjOkr0RHXR6Ju2A2y70ZCLj4=;
        b=XjK3a+UpjzOioKfizmjOSOeekaC1BX7Eja54ILpPxm6g86lomwP25UVag8jEqrqEu8
         dad7b8dXzPvEZdzIEUERnuguFSdyHDvwHjqG+nL/zxn55/kuHbidDsLWjIUpQNYnTpr7
         8n9JWqfwtdEwQPkpknyw0Uex4UGaeB92iy8N73MrpaxC4E1hlJ8wvPS2s12Ol8kmHibE
         TQLdLzsTHtzSvg7QFQ4qYUxnRPC3GydmxfSw3HnGTcgzGLec0LVrn0B/TfsnKbZWcS0B
         0PVOVD3QsemIwldFtm9xdp7l5gDElC7t3p3NXh3LrZIo3N3TQ3/HnmufVz52AsgwTORz
         mdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709136235; x=1709741035;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y3WzssPK3gfaq0Q7M4RQjOkr0RHXR6Ju2A2y70ZCLj4=;
        b=XCTe67w8JfejhBybanQeUFPa0tJdzqnO6p0c/z6pcOjMZtdedjbjPm0m79VEsdvBC/
         2lM1cnKvup6MiMOj3AbkuwaKDB1bxfGGGRMbp6wd3fuDQ9n0SEd11tFanCg8CnCodEOE
         lwdXXBXzbMXTvjKQajcEXh/oBvvMqTyKvrZiV6wfGH+Pzdp03f/+7e2dn/pKzry4G6J2
         +GDZz+WTYznkwnrPy76mjut1ej6Z/4oqBonI8zTqOdLUthe52bgiwYtFD65V+xGxLSI4
         CO2QqtKIX/R39HGRST247DqPF/ZvwssMZ7qnFiNsyfPMAEESLYkQWxtcMjzN97ACuOi1
         61iA==
X-Gm-Message-State: AOJu0YznCHQuCXJVHdOD4hk5kgZhMFX8b0W0xX2Zr2wieJOVnTGi2aSC
	35PQ9zXRGVKiiIyVB2Rj0SjXx7SrUPJJaCwgOnZHFtCc+LDo9ttEsbU03VjMHOHHZd0ARQ4S2l9
	CSUDLm+ll0h8UGTQ6G6H3J0ShXfD0CXENnxliiiYfGDRCAJeZrlHf8pUO9mROtpe7K9O0lim7Dp
	98iY9C+QqzkYpp7dzSu2kkbym1uNgClIA/TpF92sbSBN0I1ak=
X-Received: by 2002:ac8:7411:0:b0:42e:6f6a:1b03 with SMTP id p17-20020ac87411000000b0042e6f6a1b03mr13318361qtq.35.1709136235559;
        Wed, 28 Feb 2024 08:03:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+6miozd333tJa8q8ZAMH2uc0fujXxKkhOFSF6vtiVW3Bw1JGIRL3pvUdSdWHN+Hly564D1Q==
X-Received: by 2002:ac8:7411:0:b0:42e:6f6a:1b03 with SMTP id p17-20020ac87411000000b0042e6f6a1b03mr13318336qtq.35.1709136235165;
        Wed, 28 Feb 2024 08:03:55 -0800 (PST)
Received: from localhost.localdomain ([140.177.178.112])
        by smtp.gmail.com with ESMTPSA id ol8-20020a0562143d0800b0068fb9bdd7absm5406730qvb.74.2024.02.28.08.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:03:55 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH] qmi: add QRTR services to the queue
Date: Wed, 28 Feb 2024 16:02:39 +0000
Message-Id: <20240228160239.148583-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: smoCa1_F3PMXi5tLRhcUsYZuMx-WfQl5
X-Proofpoint-GUID: smoCa1_F3PMXi5tLRhcUsYZuMx-WfQl5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402280125

---
 drivers/qmimodem/qmi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 3eead9dc..ffb26326 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1957,8 +1957,19 @@ static void qrtr_handle_control_packet(struct qmi_device_qrtr *qrtr,
 	port = L_LE32_TO_CPU(packet->server.port);
 
 	if (cmd == QRTR_TYPE_NEW_SERVER) {
+		struct qmi_service_info info;
+
 		DBG("New server: Type: %d Version: %d Instance: %d Node: %d Port: %d",
 			type, version, instance, node, port);
+
+		memset(&info, 0, sizeof(info));
+		info.service_type = type;
+		info.qrtr_port = port;
+		info.qrtr_node = node;
+		info.major = version;
+		info.instance = instance;
+
+		__qmi_service_appeared(device, &info);
 	}
 }
 
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
