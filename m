Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A37288537
	for <ofono@lists.linux.dev>; Fri, 28 Nov 2025 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764351440; cv=none; b=uYq1hM/DGvEEuh3+ep/WNvIqdZcOxFKTVWgDO5buNyZ3S8HNYdTfs/SfULfysG4+BSbOJrROpb7I2BMIWRqpbDB/nDjil76kumYZmRHi9EZy/ZWUAe40g8MVLWFqFGu+pekN09CPBwQ2uTIZaCxZ4vWxxiB6/0nJ5X3GXwJGfhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764351440; c=relaxed/simple;
	bh=qsPNpiDTz+5WtrHVCnYCVmPDwothfikNQMEUaivav+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/1PuUXNocOszOOSgneskSbNNOx03C2IK5cVARTKvxuHwyI90Pm7skstmQz09bO61gcO+hWEa3GjJN1rtWY34muVX84U9ImLt4vp5TsxIM9sIz+i/nv6zAU+ZzdTrcPyG6nejcvYFvPveLm9YHDv3Ejs+fn+K+tJec3akoQh9dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=vqgivcTw; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="vqgivcTw"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=vqgivcTw636sCvlpUeWNBwrcUpcfjxc6pIJ4hrVXqsW0hL/Z5ICK4v/SUvr1z8Cu3DWVCQU6Dsms3XqmsOXocYpl0g7MuhATJxGXIz6KHOHzPzl+w5OYaXUNDBmu0i999rAnidK8zqhaWCCaDX9JgTo4NQ9DpXwysEg0DEpeCZS0SNG7j2vb3zafI5/O89QxFB2CY5KEIeAwQeeBSIwRJ7E1rotR7DiIbB2zCveggiNWVXhduqKOemj7RHAavYnGSRTcC3Sb3If3aMtVC5Jph5O5hOAg76d2QskChvnnEQz9jxLp4Kf/RWJdS0dSSTkiBWb6nCg+ZvkblSbWGk5tcA==; s=purelymail2; d=purelymail.com; v=1; bh=qsPNpiDTz+5WtrHVCnYCVmPDwothfikNQMEUaivav+o=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1079628981;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 28 Nov 2025 17:37:16 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v7 05/10] mbimmodem: sim: add support for querying IMSI with MBIMEx 3
Date: Fri, 28 Nov 2025 22:36:51 +0500
Message-ID: <20251128173656.55692-6-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251128173656.55692-1-thevancedgamer@mentallysanemainliners.org>
References: <20251128173656.55692-1-thevancedgamer@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

This commit adds the ability to query IMSI with newer modems that use
the MBIMEx 3 protocol.
---
 drivers/mbimmodem/sim.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mbimmodem/sim.c b/drivers/mbimmodem/sim.c
index 1e932b76..9df34121 100644
--- a/drivers/mbimmodem/sim.c
+++ b/drivers/mbimmodem/sim.c
@@ -392,6 +392,8 @@ static void mbim_subscriber_ready_status_changed(struct=
 mbim_message *message,
 =09char *imsi;
 =09char *iccid;
 =09uint32_t ready_info;
+=09uint32_t ready_flags;
+=09bool r;
=20
 =09DBG("");
=20
@@ -430,6 +432,7 @@ static void mbim_subscriber_ready_status_cb(struct mbim=
_message *message,
 =09char *imsi;
 =09char *iccid;
 =09uint32_t ready_info;
+=09uint32_t ready_flags;
 =09bool r;
=20
 =09DBG("");
--=20
2.52.0

