Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20DA395D87
	for <ofono@lists.linux.dev>; Fri,  6 Mar 2026 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772803381; cv=none; b=XIiXv4X8JtOArZmi/oqCzeDJWKi54HbVtGF/Vf5BvhSFTm40ta3SHuPdR5PKkGrbAoobi7WPP2/GPHdwU6LmK8elog3zdnLEyMUFIiuRMog4Tz8yEyrfngUqzjoVXbshVEAFSXt2QzMDpaaJRIzuueryoBkTPJuPTOrDXebAONQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772803381; c=relaxed/simple;
	bh=7tws449/XF8sD03fAYEnFL5u0UspFFmTEd/ltBQTISI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3i9fQvHyYGby2ra0vV7hMmoQpUc4ojMr84+2UgCk9gD1WEmLrUV/w6dIjP74Dc+hkNqKGg+MLMLxjG3LOzC7M7+eLXFfOZjIWYKvgNi/aqtFgVYzR8BP69ymU8VaqQhkbFowgpbPO1or1sBH/USIy8/tRMfWIanXn2b3xER3hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=U2YcCRfJ; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="U2YcCRfJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1772803362; x=1773062562;
	bh=ahervfWfa5frPMqcsPOztrGHSGh7NAVDQ2UnLn7S0xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=U2YcCRfJJ9+jYToPhG0BlFNhiSA3c6C0Fmt1aIjilQ/T8REZkOmf34mX0VXlhe6ar
	 u1GAlqLygxlEO0P/r/aWHJLqS3xMfzx1rXMg1QZzquTnaJVvOUB30Zd/pbo9l23gI4
	 Eaha1Zv5/IhMCKTekj+opRjJv/o+rW/cCEsyjddNDbsR468mqLWheVG1QXallQcIRz
	 NhwwUja0AuQ2qHnmhRtMvQRKkdE6wVE8kiueOI8S6fMi5ZCn8iqtuVEt2kUtAOh++o
	 mVjpoyRuhTF5E0MKJbp7LFkVvGkF3MNdvttaONVLa+wDkhCo0OZx/6XDnp0E9jB5o5
	 ewRhGVqRtkQ8Q==
X-Pm-Submission-Id: 4fS6XK5PMjz2ScPP
From: Sean Nyekjaer <sean@geanix.com>
To: denkenz@gmail.com,
	ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH 2/2] doc: netmon: fix indentation
Date: Fri,  6 Mar 2026 14:22:35 +0100
Message-ID: <20260306132237.1300366-2-sean@geanix.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260306132237.1300366-1-sean@geanix.com>
References: <20260306132237.1300366-1-sean@geanix.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 doc/networkmonitor-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/networkmonitor-api.txt b/doc/networkmonitor-api.txt
index af56f04b..f029d96d 100644
--- a/doc/networkmonitor-api.txt
+++ b/doc/networkmonitor-api.txt
@@ -22,7 +22,7 @@ Methods		a{sv} GetServingCellInformation()
 			are available, their valid value ranges and
 			applicability to different cell types.
 
-			a{a{sv}} GetNeighbouringCellsInformation()
+		a{a{sv}} GetNeighbouringCellsInformation()
 
 			Requests the neighbouring cells information and basic
 			measurements from oFono.  The returned value is a
-- 
2.52.0

