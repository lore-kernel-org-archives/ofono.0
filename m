Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6466271823
	for <ofono@lists.linux.dev>; Thu, 13 Feb 2025 00:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739406840; cv=none; b=KD+JgSFlymCF64NRV1KPj+W0EzmitrBWVGAgsTpppiGTTyxoEXMK/A9hY+aFRGjzf9mvuyfBMRMq3MLMbe9o5x4y2O2tlNcLTyiRAPjNmmJNpQ6uF85buLVBN8GWliFkYBzA8CZWtSL8yz7notibHuhDWxowcLwUvQd9LoQuRlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739406840; c=relaxed/simple;
	bh=t2w+mHm9EpzEx5GOapGHz05ZQHuDCgXEGIPBZD13Ho0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=C4kpq36QSmQm++U9AJKqzHp1/OcpecsV5vV+uM7BfyDDg6TREZksRwSfmCqBj+9y6A04cfDIfbV3tzlCS2ynHHry/1dai2MTMho+NFNhg4MJ9FurxyvCtUVCchAGa0/5RteGit/1TbIZAJfgkLh5sZGOklmNAW0+biWc9j+I07k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=RNA93E0b; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="RNA93E0b"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id CE0DE1648AC
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 19:33:57 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 7F764125167
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 19:33:57 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v2 0/7] Add QMI Device Service Request Rate-limit Option
Date: Wed, 12 Feb 2025 16:33:49 -0800
Message-ID: <cover.1739406657.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=fCgNOGN/t748N9NOlpGIkpBRVO9+ehf24yepVxFBHa8=; b=RNA93E0bZ+e97JUKxxk/bLeedZfJt9V38WpWjBmYBJqaR1F+ng7BR85BfW3wTuDbswcHRa7vBE18pTvJW7LxRqfMmTohm7tQYG5e2Tq0fQEl0lGxjypwN77y4PeNHkGVjd3gt1H+LjEHwdoZUk8lj13fkGLPO71NdGP38fehtT16T6eUy7+qpZ7xXOriDe0OboZtwGtMt9ReO2hvXo92BMNu1v6Y2VTwXsfSCr8Cj4PkxWFavfsgQucaj2C1iyqlGyQ5iI5pT4RaPIjJtzjm4anlJHWwnxDeSPQcZfLADVlr7X2AkSw23mkjHaHLY8Z2Y4I/J55AH/X2WrMY48MFtw==
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

 drivers/qmimodem/qmi.c | 45 +++++++++++++++++++++++++++++++++++++++++-
 drivers/qmimodem/qmi.h | 40 ++++++++++++++++++++++++++++++++++++-
 plugins/gobi.c         | 22 ++++++++++++++++++++-
 plugins/udevng.c       | 14 +++++++++++++
 4 files changed, 118 insertions(+), 3 deletions(-)

-- 
2.45.0

