Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9D0428495
	for <ofono@lists.linux.dev>; Wed, 13 May 2026 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677191; cv=none; b=aEAoUF/An4pQrojdVDKaTLcFN0QVF2OyL/ipBcUAWIhc9L+f9V9ot2prmtvOhRYRKOkQXeSrqzaj2AToExMOv1PIxc7C3L9ls1CGhE3XUh3lvPuwTfyXyJDt4we9Qm4Sd6Jeyuv++ECi6fTF/RIff7FV7vwGxXqTrLVHzjTaUfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677191; c=relaxed/simple;
	bh=K0HDvXJ8ntrkDi66Hb1ep/UKuwbOwgdGcyc6MxqNgTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdE1CZ9FcrwYyReEbrr+amzLA7a9TxSlm37L61c4wUvHqtjbnDSmJjHvjAGBEoEEz93HzdbBvJ0/EiUHKiTqa+29oPV94Oqh5Py6xDsK2bMIe0VZfB7K9U3uYEjX9jDSOGcMPU7DlVK8PWtzs33oDSiN6QkWeeyKITt/pJWZkO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Gmimpa0u; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Gmimpa0u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1778677177; x=1778936377;
	bh=wvD33sLBqBPDBdvcQm27DDAX/PUs0B4tJT8aXAg+nvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Gmimpa0uYeRLlW8qA1UZ+CjEuRWVe5sR9ZMybMp5Zab5Q5OmFESgHD2oXANY0xzCA
	 nmivibYETIlMt8fpju5nWiJFI+up0oBNiCFEV8S3jtbhD3X3dMrUajIWwwubYuig3C
	 bNmAyy2zj90MEsiXVYatmjfeqYyrrb7oPVp5ahAuLRwIsUfLVk3opEDAfOKzbHiwW5
	 iQHKw1T66JYLU6tJBgp0KqUg/1dRY39BzahhFVX4mIlnkJhYbk6p8CZIYeBgnFejpE
	 kiwTE6cg8Lb9r1JhOAEgGu6SCIHimgFde+kHrXq0+gP5FaIPjFUwfCtpKdjr9iePNN
	 /PtaiLqp6epNw==
X-Pm-Submission-Id: 4gFtpH2WP1z1DF7P
From: Sean Nyekjaer <sean@geanix.com>
To: denkenz@gmail.com,
	ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH 2/3] sim7100: disable unsupported features on A7671
Date: Wed, 13 May 2026 14:59:22 +0200
Message-ID: <20260513125925.2164959-2-sean@geanix.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513125925.2164959-1-sean@geanix.com>
References: <20260513125925.2164959-1-sean@geanix.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SimCom A7671 does not support anything related to calls.
---
 plugins/sim7100.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/plugins/sim7100.c b/plugins/sim7100.c
index 1e892007..01620e31 100644
--- a/plugins/sim7100.c
+++ b/plugins/sim7100.c
@@ -367,12 +367,14 @@ static void sim7100_post_sim(struct ofono_modem *modem)
 
 	DBG("");
 
-	ofono_ussd_create(modem, 0, "atmodem", data->at);
-	ofono_call_forwarding_create(modem, 0, "atmodem", data->at);
-	ofono_call_settings_create(modem, 0, "atmodem", data->at);
-	ofono_call_meter_create(modem, 0, "atmodem", data->at);
-	ofono_call_barring_create(modem, 0, "atmodem", data->at);
-	ofono_phonebook_create(modem, 0, "atmodem", data->at);
+	if (data->model != SIMCOM_A7671) {
+		ofono_ussd_create(modem, 0, "atmodem", data->at);
+		ofono_call_forwarding_create(modem, 0, "atmodem", data->at);
+		ofono_call_settings_create(modem, 0, "atmodem", data->at);
+		ofono_call_meter_create(modem, 0, "atmodem", data->at);
+		ofono_call_barring_create(modem, 0, "atmodem", data->at);
+		ofono_phonebook_create(modem, 0, "atmodem", data->at);
+	}
 
 	switch (data->model) {
 	case SIMCOM_A7671:
-- 
2.52.0

