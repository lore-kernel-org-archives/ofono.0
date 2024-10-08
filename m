Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FBE166F29
	for <ofono@lists.linux.dev>; Tue,  8 Oct 2024 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378640; cv=none; b=WQSge7Uv4/DNoOCY56rkgdW3fayI/rgo3iK1BMfr+HS+TZJGvKLrww4cvdTLOSY9ZeDfxh8GKmR52hD2kuFhV66A+W+8NwClVFMMLALGpqM6F/rvHaxWOZQ3GyQ60yB2BTsWEu03CcMlqdeiBH1MVZxqtRK0/QI3ePpupEH9O2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378640; c=relaxed/simple;
	bh=aJepc69ExJ5zFi82YJvFSu1wWI6OkR5vy8DhZIG6NJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NGfr3gm47AvOPpO5jYIzv55OBJ3cz94FaGzPErOei0YLuwmNTQ2h/CIIxovCDwa8BzjHqY3XbHleKP796NtxtX1EeEYigURL6lSWA//CLJhMLm5h0xs9t2WxMVEbM7Qi6zoIDl8LGZbEaE3Ke3BQiu372Ym+juq4DaXYP34G66s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=URlFZ89G; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="URlFZ89G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=cIuPLrGo+Ylx272g4AFXSL/C0WKACFQ5zzVW1F9C7E4=; b=URlFZ89GVbg/7AN8zT4B7CBpme
	EBd5zfpV+KH53zSbjcuLxqPSaFW7o4oJFlbI/dQsu5okTP9htO5vOqGSw3EP8cdlEg73mvWSSqwy5
	dV9z7qajr9L8se7HILD/YdnnR893ATBWhuX+DdWUlybpVio3YovkNcfPUoi7jBmZg/ble7gslRh4v
	cQHYTWYtVNR8XOQ8HN/6WoS+b0T1UajLmxsnPzW27uNQ4ThiXy+nzoVHYwofDNSiM02zcucsavrHT
	S3UlBFbJzzHq1xI62k3Lwy0vp+ZTwQKHYVzy7bg85D00Yg0U5najjQnWdk1lM19nzMTNyBjydrQwg
	fzjFwkYg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1sy6Ee-000MR2-5X; Tue, 08 Oct 2024 11:10:28 +0200
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1sy6Ed-000Mun-2r;
	Tue, 08 Oct 2024 11:10:27 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>,
	denkenz@gmail.com
Subject: [RFC] atmodem: let +COPS: report access technology
Date: Tue,  8 Oct 2024 11:10:07 +0200
Message-ID: <20241008091009.1567305-1-sean@geanix.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27420/Mon Oct  7 10:43:46 2024)

When using the SIMCom A7672E-FASE in gsm mode, gsm is never reported as
access technology. Fix this by letting +COPS: report it.
---
For EUTRAN networks at_creg_cb() is setting the correct technology.
But as I read it, CREG doesn't differentiate between GSM and UMTS.
Can we fix this by using the technology from +COPS: ?

 drivers/atmodem/network-registration.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/network-registration.c
index 46b8512a..ccd01234 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -353,6 +353,9 @@ static void cops_cb(gboolean ok, GAtResult *result, gpointer user_data)
 	op.status = 2;
 	op.tech = tech;
 
+	/* Set current access technology */
+	nd->tech = tech;
+
 	DBG("cops_cb: %s, %s %s %d", name, nd->mcc, nd->mnc, tech);
 
 	cb(&error, &op, cbd->data);
-- 
2.46.2

