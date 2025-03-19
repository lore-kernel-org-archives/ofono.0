Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E12212FBD
	for <ofono@lists.linux.dev>; Wed, 19 Mar 2025 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412625; cv=none; b=tce9t8U5GIyiEv1cqw4nlNURDTzvgPvFSJLr+CAA93Aq39ABMGqmRCc9hhhzC+aMHHxUOJtsidBJSsnZXF1LKOGB9a9Yt/8M55ZXvEu0vi5mHyTrRrPwiWLjIovB+coJ8YVYIPFhsE5J2Ew048TeMcO/ixcclV/bTImLdCnO8EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412625; c=relaxed/simple;
	bh=40BTaThAysqwF4VFqK3Qmr4127e5eCs90QxXxkCw75M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rALEkev4eqeJKNHrG6eqOEfTvq0/BgIWY+86FPMjdhqflsvoXRkowXBvRfXgktB+5Er2HvMXBj6KYPJrm6sCSrXLf91MwfD/ERsk+9mF47UGsx6awYuUApkKT1rtgtqszGakRIBb1g+Ecf8OjS3KegZJ7KnPlA1+dpdUqwEJDQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=X85iKuDr; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="X85iKuDr"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id DA9D1164A96
	for <ofono@lists.linux.dev>; Wed, 19 Mar 2025 15:22:35 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 8957F126099
	for <ofono@lists.linux.dev>; Wed, 19 Mar 2025 15:22:35 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v6 0/7] Add QMI Device Service Request Rate-limit Option
Date: Wed, 19 Mar 2025 12:22:27 -0700
Message-ID: <cover.1742411889.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=1Gx4Jp2z47Pxr6mXK+NJ1dTvrUq7NVhIxv7P2m4VAB4=; b=X85iKuDr2AKBgpYXA8J4p27Ovqs0jVLKRrRkgGhxIGHcRW0z6llrb3/MNtX7rGnAUReeMDrGvX4wzFD+fHBKA4ih/UjrVuYkb83rmji7aKWUYyWZRdDhMoucWXhnoJ5FvY8xGotBbhuAW22MCPXse282+TpZqc3hvEzsQlKltM4G/b1vrP8vTt8Q597YSAc/NNp+fZFZ6+gL59HyEuFZ2MJBrDhmLDqfZdmuq/gywdu/yy+00SA3FMr2W0kcZv8V8zPM5ffULl3poiCh9MQaNz1kp3DGFjMg7hy0R/BvxFUIPOBq+XoRP4uTzRxWZAKfoTrzy7CbGMr/kmhyr0wfkw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Certain modems, among them the Quectel Wireless Solutions Co.,
Ltd. (2c7c) BG96 CAT-M1/NB-IoT modem (0296), have a firmware issue
where they can lock up and hang (not responding to subsequent
commands) due to high QMI service request arrival rates.

QMI service request rate limiting is achieved by:

1. Adding a new, optional options structure to qmi_qmux_device_new
   that has its rate-limit "quirk" and minimum request period fields
   set when the modem "RequestThrottleTimeUs" integer property is set.

2. Adding logic to the QMI driver that, when a minimum request period
   is set, limits the QMI service request rate accordingly.

(1) and (2) are used by the udevng and gobi plugins such that when the
modem vendor and model match 2c7c/0296, then the option to rate limit
QMI service requests is set to no more than one every 2,000 us.

Grant Erickson (7):
  qmi: Added enumeration for device quirk flags.
  qmi: Added structure for device options.
  qmi: Added device options parameter to 'qmi_qmux_device_new'.
  qmi: Implement QMI service request rate limiting in 'can_write_data'.
  qmi: Handle request rate limit option in 'qmi_qmux_device_new'.
  udevng: Set the QMI minimum service request period for Quectel BG96
    modems.
  gobi: Pass QMI qmux device options to 'qmi_qmux_device_new'.

 drivers/qmimodem/qmi.c | 51 +++++++++++++++++++++++++++++++++++++++++-
 drivers/qmimodem/qmi.h | 40 ++++++++++++++++++++++++++++++++-
 plugins/gobi.c         | 22 +++++++++++++++++-
 plugins/udevng.c       | 14 ++++++++++++
 4 files changed, 124 insertions(+), 3 deletions(-)

-- 
2.45.0

