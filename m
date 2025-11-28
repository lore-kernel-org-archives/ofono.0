Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BAA32E72D
	for <ofono@lists.linux.dev>; Fri, 28 Nov 2025 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764350311; cv=none; b=ABWa08qiezdZtwLPZb54K7gycs3vPwi8A2iBVyyxcQKhKleaiaykdCrCR6SrggEmq2IUuWWxhIgngcKBNrI64cZO06HMGcXrSDORSufki88DJ7Kmv5YS95mE5kLUiEtgRv+r53REYsnoqLn9mMBXhZuJjSOA7LC/kXHQZxw573E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764350311; c=relaxed/simple;
	bh=qsPNpiDTz+5WtrHVCnYCVmPDwothfikNQMEUaivav+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6nrVLVjOIC8L5+rmthE6uHFX8ayq4812kte4pklgsfOL1ZdxKMbLFUZ63Yuti0D8piRLoveRLRy7hRp2JTFJQjeZ6kw9PV8XLfZTStzJPqQ+/4id77eut0EwN9b9vWW4RW+dNtzRn8AzbMSnB9qQ3qrsYvP1xHFPzyeFMzbkBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=RTjoNjMW; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="RTjoNjMW"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=RTjoNjMWJY0Wxw3ms+LHmzm9BYq7tr3nnxqdof/hIzWxgsyEYbtyNySn8M2dVJQucqZTu8IsjWmJNA/Kb7RgZ9j9AmTsq+TZT73tttjwD8L0EFmVSywdZbfnhsD1hRW/AqAPfH7UeR3axns13RItc1tjSsMMMEQhYsZyaHB9CvfwxyktPVeOMN9Rs0BqVAknT+qEjPnWQ8gNg9P1EnsxRUIK1mnYtfqozTuSrR99R3WEF3h5vNjKkoQmappPfMOORv56V7TfEQxTVCBMIwiFfbS/S/LJJ7XDDkl79kYBFE0B1vpF3OE7BbUSYRnVoAOpheke5nt07+QbDrwvm8WM9A==; s=purelymail2; d=purelymail.com; v=1; bh=qsPNpiDTz+5WtrHVCnYCVmPDwothfikNQMEUaivav+o=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2023556145;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 28 Nov 2025 17:18:25 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v6 5/9] mbimmodem: sim: add support for querying IMSI with MBIMEx 3
Date: Fri, 28 Nov 2025 22:17:43 +0500
Message-ID: <20251128171747.32679-6-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251128171747.32679-1-thevancedgamer@mentallysanemainliners.org>
References: <20251128171747.32679-1-thevancedgamer@mentallysanemainliners.org>
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

