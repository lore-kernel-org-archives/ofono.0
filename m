Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8AC3DD50D
	for <ofono@lists.linux.dev>; Fri, 17 Jul 2026 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275574; cv=none; b=qa6bM+PjKvIWVWXe6K3EUgIqJpNSRCqlkEFEohggGzhBCdAS98TgjStdBlAdZKRVD+jSPPk2pVUrVn9B2xuHTCdRiljPwNLiEADktGty8in+tbhF+H9gP98/k7gIh1qc65Pgv+UAxkY0WtxQbhwA7UPmAvUWJtKh+bGzhMkLTH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275574; c=relaxed/simple;
	bh=fLFvUJRlzIFyDS76C1xmMH+1cBhip+P7I4UHOzxdNqw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ci+yBMg4OR1RHuEuvPMlQH1OAiEk+d74XmbioHCQt32Xj5z7jQklUYchGBiaz/LzdXR5nZZrl+9k+vh1yi+IUup9PTPfKVOjGoHEGaViJjtDAv6RVKdW1YLNIqKX0SX/Me2kECDK+ZbQMkOBIHeuAWouvbFRAtDYfIK7norjwA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E9SsCrwA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E9SsCrwA"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6cfuW1078349
	for <ofono@lists.linux.dev>; Fri, 17 Jul 2026 08:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=diRCsZLD6TjlWOEOvx347Jsxitt18gXS26b
	C8uqmxMA=; b=E9SsCrwAtP1i3wzbC361pO8LK3Q6/hn6CtOhbnUS8hLIqjXLZ9h
	Cgc70+W6hbPaFVf57mN4m49hlK/RZrSvyo3wReUfHfjYeuYAsV9FIBJFE/506dY/
	Vpp49UZk7T0+jpzOZnAyeSyJPcpSfonq4rt1SHWq42pcZZ9OuDFhW/1Vo+1Jboch
	27a2UEHwJIuH8UKr8m5LpADTvN9pzKIAS7MP6EWSK9SfJdGRfjB+EDURu+XtxZFh
	G5qWRrEHeppQwrA3Xg7jwtNMLbJXKBMcG4mIeSm/yv/gOAcbefvzH5JaOAMOpC8B
	f85z/FzBcn8QEPMFZTwP0qt43zksoRcLhyw==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feym1c3u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 17 Jul 2026 08:06:11 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66H867E5030186;
	Fri, 17 Jul 2026 08:06:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4fbewk0ra7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 17 Jul 2026 08:06:07 +0000 (GMT)
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66H867Ip030180
	for <ofono@lists.linux.dev>; Fri, 17 Jul 2026 08:06:07 GMT
Received: from shuaz-gv.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 66H866v6030178
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 08:06:06 +0000 (GMT)
Received: by shuaz-gv.ap.qualcomm.com (Postfix, from userid 4467449)
	id CB547630; Fri, 17 Jul 2026 16:06:05 +0800 (CST)
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
To: ofono@lists.linux.dev
Cc: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Subject: [PATCH v1] test: Add optional modem path argument to volume scripts
Date: Fri, 17 Jul 2026 16:06:05 +0800
Message-Id: <20260717080605.3876414-1-shuai.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=KPRqylFo c=1 sm=1 tr=0 ts=6a59e273 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=Ot8o-RpjL9V9HF4GAycA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA3OSBTYWx0ZWRfXzq7TKAK2vlni
 fpO3ovamYNDoO2+z28GcYhzjwWjl0IGxJPg1SLii7jRkMpQFOBtDtvV8vJez6sk9EkqNVTlnK5S
 NVgX2OXCPe9aEt5M22EZsRYAk1yymDPoviC+2JG7d2zY9nkfzHCyfuyw+Lpl+zYR9ehvLU+r0ra
 kIAfnfucPhBZbh5bJSfxkkgzAl1T3SQrvzAYKe/9PfmcCgcZXQjmerhPXIQUyu7kfdjqzXbc+eS
 1ztidqHGXAEA8BPdObJ6Qw4ISAH+pvV5/tQVH5Hu4BFzQSFPUcfkLDyOMbyBl8SIEG3nFBi327t
 O2CDuKrjbP1ZGnCXG+oVPmB4wPLh5SUNne+r5S1Xq5qabFDiGPh3VeHmGH3DdSKnlsbEBHCzrNe
 foJuI7rljCl58sT6/6MB0ULHbo/8YBUquqXC7jSJGM+YfQ3Amk6PDFo8JfiN1LINB3hvUmI8X7T
 vXVlxvuaCgv0+QLmcwQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA3OSBTYWx0ZWRfX9JN5s96o9na2
 JXHFj8xEuwynUrYCOj1BIyJjp9Z0zyA4ylonzE+EYTffxwAuY50M+UrO8D7LmEcXqSDYH+3aRtI
 dKZBedQigdAgmUl8k+bOtg8iq6dZJis=
X-Proofpoint-GUID: 3kAwg6c10wAsaWmVW3P3Otv4wz0snl4V
X-Proofpoint-ORIG-GUID: 3kAwg6c10wAsaWmVW3P3Otv4wz0snl4V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170079

set-mic-volume and set-speaker-volume scripts hardcode the call
path to modems[0][0], the first modem in the list. When the DUT is
paired with multiple devices and the active call is not on
modem[0], the scripts fail to target the correct modem.

Add an optional modem path first argument to both scripts,
following the same pattern already used in hangup-all, allowing
the caller to explicitly specify the target modem path.
---
 test/set-mic-volume     | 8 +++++++-
 test/set-speaker-volume | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/test/set-mic-volume b/test/set-mic-volume
index cd6c73fa..4cdf2c99 100755
--- a/test/set-mic-volume
+++ b/test/set-mic-volume
@@ -11,7 +11,13 @@ manager = dbus.Interface(bus.get_object('org.ofono', '/'),
 modems = manager.GetModems()
 path = modems[0][0]
 
+if (len(sys.argv) == 3):
+	path = sys.argv[1]
+	volume = sys.argv[2]
+else:
+	volume = sys.argv[1]
+
 cv = dbus.Interface(bus.get_object('org.ofono', path),
 						'org.ofono.CallVolume')
 
-cv.SetProperty("MicrophoneVolume", dbus.Byte(int(sys.argv[1])))
+cv.SetProperty("MicrophoneVolume", dbus.Byte(int(volume)))
diff --git a/test/set-speaker-volume b/test/set-speaker-volume
index 6d4e3019..3f468da0 100755
--- a/test/set-speaker-volume
+++ b/test/set-speaker-volume
@@ -11,7 +11,13 @@ manager = dbus.Interface(bus.get_object('org.ofono', '/'),
 modems = manager.GetModems()
 path = modems[0][0]
 
+if (len(sys.argv) == 3):
+	path = sys.argv[1]
+	volume = sys.argv[2]
+else:
+	volume = sys.argv[1]
+
 cv = dbus.Interface(bus.get_object('org.ofono', path),
 						'org.ofono.CallVolume')
 
-cv.SetProperty("SpeakerVolume", dbus.Byte(int(sys.argv[1])))
+cv.SetProperty("SpeakerVolume", dbus.Byte(int(volume)))
-- 
2.34.1

