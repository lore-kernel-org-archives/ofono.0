Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BB62C08AC
	for <ofono@lists.linux.dev>; Fri, 12 Dec 2025 21:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765573403; cv=none; b=IivsUOF8Ou8TPFREd1G/2U6CxkBEdyfjMKEPfz9Zh7I2OAIAltKTJ402owJFEyIBnuIq1CfuVTf7wI9qrwEuiRYCF3iPyzmGxTPxsIE5dFraawGOCcw1u495oQHiM7rh6n7SfKI2+fn+MkgRNMZI7SHoPT0OICNX8YOMro00FdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765573403; c=relaxed/simple;
	bh=RNuFvJv6M21+zlpgLEW0IQaJWzU3MXWyjblEvBRKIU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nf8NBah1yUvWsaz9xdxZDsapmUDbBQsigQ+wLRVtzehirVEOn+VlmWb3VeT4mgHHyI7ZGvP0QlABVOLRYdeU+PjZgvuJHFL6MWAV4mWQgDB4p5Rc6AZGKwSpZprM7whgqjqud/aF8voLU3DBKKUF8Y2g3T+ZAGKW4uQs50PlJzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Z63BaZlj; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Z63BaZlj"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=Z63BaZljsoGLaNPc0M4Z7fztdeejZqZ478TJW/LUNUxykTACVgZjqsoK48hIhxYbcs+d3aKScMyEHMRUUiv78S2vHhyXZHhDs8SFsyPOSS6XUTcYtOw1iZ6H/ak0m9pErMr/nLgvOkuBuHJBBm7/TMSGMvyHvYu8XqWgAueY5uJ7prcX7U2tOz4Rf0p1/kXVehvpfBHKiv448C1FOto4ScrPgwqALu2IVKQ1c3J5820he+VD514VljG47ZHYMuib83sPYApiaYVZPm0ULmKs6BEyTs4RR573+JYsvMHwWXjSSjRgTXCPsmzj+RJD/gIsybrMJCAyOV8ZaFFh8Paj/A==; s=purelymail1; d=purelymail.com; v=1; bh=RNuFvJv6M21+zlpgLEW0IQaJWzU3MXWyjblEvBRKIU0=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 511728581;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 12 Dec 2025 21:03:07 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v8 1/8] sim: add ofono_sim_get_modem method
Date: Sat, 13 Dec 2025 02:02:42 +0500
Message-ID: <20251212210249.95597-2-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251212210249.95597-1-thevancedgamer@mentallysanemainliners.org>
References: <20251212210249.95597-1-thevancedgamer@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Align with the other ofono structures for fetching ofono_modem from atoms
---
 include/sim.h | 2 ++
 src/sim.c     | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/sim.h b/include/sim.h
index 84592fc9..c0fc364f 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -211,6 +211,8 @@ void ofono_sim_remove(struct ofono_sim *sim);
=20
 void ofono_sim_set_data(struct ofono_sim *sim, void *data);
 void *ofono_sim_get_data(struct ofono_sim *sim);
+struct ofono_modem *ofono_sim_get_modem(struct ofono_sim *sim);
+
 void ofono_sim_set_card_slot_count(struct ofono_sim *sim, unsigned int val=
);
 void ofono_sim_set_active_card_slot(struct ofono_sim *sim,
 =09=09=09=09=09unsigned int val);
diff --git a/src/sim.c b/src/sim.c
index dedb7d8d..cc33e864 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -3423,6 +3423,11 @@ void *ofono_sim_get_data(struct ofono_sim *sim)
 =09return sim->driver_data;
 }
=20
+struct ofono_modem *ofono_sim_get_modem(struct ofono_sim *sim)
+{
+=09return __ofono_atom_get_modem(sim->atom);
+}
+
 static ofono_bool_t is_valid_pin(const char *pin, unsigned int min,
 =09=09=09=09=09unsigned int max)
 {
--=20
2.52.0

