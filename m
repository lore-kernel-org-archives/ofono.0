Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94011F427D
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 05:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339590; cv=none; b=f6YfJDy8RT5gQNIpxdDHdszBlYifNvSmFaIrrIJq9QVhRyvXpIcatGoj7Nq1KWRi1sYkjM0Pdh6o0PKE7X6b6N+Z/updFnAUXGG81Jc1mwdfeMq0aGjbrjrlNahqbGlLmwvkIzomZpzuDKwZwps8lQPm8PzosSi0u9383ITQmUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339590; c=relaxed/simple;
	bh=8HGIebPe42iNyqoUdfrmP/sFDzGP0IXYa/ttDJ80N7M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=a4zOXCYN20xqbzpcLqNIs0j1UtwGcRTEWjALXsxoF4rTGCZKRplGmtB/B7K0eY/V8tHaPdoTeR5nHtt8xxZbwFBUJia4XMLytf79VmekFTladl4ceARCgRzfZSnjsIbeYqR3XOseFwowC2pmbwLLm7lzxuTXtuCcW9T1ME9nIC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=eLly3GH8; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="eLly3GH8"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 908FE1648AC
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 00:53:01 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 3CDC5124C08
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 00:53:01 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 00/10] Add QMI Device Service Request Rate-limit Option
Date: Tue, 11 Feb 2025 21:52:49 -0800
Message-ID: <cover.1739339173.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=9CZV7i6y7wjJi9Uxt8cpiRzDFTkdxajG7G53xWGpGHY=; b=eLly3GH8A652yymqNQTw/ZCTflyAfPC/W6pCYzTAwvOZK7BfMPDd3GCKxW3j5MZUWeE20eHAkeU0gSdUqNGcJzqLCgQp5wTJKDssAXShY4Vw22Q0F7nIGEUoj94v4ovNAFN6sRFitLj3KlH2qbFvEj6GfS3hJGZOpSe56xlolhNBRXPTnlrWiWi0AcKzz8ZHLr+kE7WaNLTiTgfiQGRJsiKyoU+TZcxxLh1PYyfqqOkd1J9EBSMHyFV7SHvnIqYVc7tAkho43kMqbWQPLOqXnFhtgIjG6up5h5wanYg21UMB+U4tSVKwA72Co8uQ1kCj5OnZ2Di/pxVmDJJiTm19IQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Certain modems, among them the Quectel Wireless Solutions Co.,
Ltd. (2c7c) BG96 CAT-M1/NB-IoT modem (0296), have a firmware issue
where they can lock up and hang (not responding to subsequent
commands) due to high QMI service request arrival rates.

QMI service request rate limiting is achieved by:

1. Adding a new, optional options structure to qmi_qmux_device_new
   that has its rate-limit "quirk" and minimum request period fields
   set when the modem "QMIMinReqPeriodUs" integer property is set.

2. Adding logic to the QMI driver that, when a minimum request period
   is set, limits the QMI service request rate accordingly.

(1) and (2) are used by the udevng and gobi plugins such that when the
modem vendor and model match 2c7c/0296, then the option to rate limit
QMI service requests is set to no more than one every 2,000 us.

Grant Erickson (10):
  qmi: Added minimum service request period property string.
  qmi: Added enumeration for device quirk flags.
  qmi: Added structure for device options.
  qmi: Added device options parameter to 'qmi_qmux_device_new'.
  qmi: Added minimum request period data member to 'qmi_transport'.
  qmi: Added last request time data member to 'qmi_transport'.
  qmi: Handle request rate limit option in 'qmi_qmux_device_new'.
  qmi: Implement QMI service request rate limiting in 'can_write_data'.
  udevng: Set the QMI minimum service request period for Quectel BG96
    modems.
  gobi: Pass QMI qmux device options to 'qmi_qmux_device_new'.

 drivers/qmimodem/qmi.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 drivers/qmimodem/qmi.h | 42 +++++++++++++++++++++++++++++++++++++++++-
 plugins/gobi.c         | 14 +++++++++++++-
 plugins/udevng.c       | 14 ++++++++++++++
 4 files changed, 109 insertions(+), 3 deletions(-)

-- 
2.45.0

