Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4EE26F477
	for <ofono@lists.linux.dev>; Tue,  1 Jul 2025 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751362206; cv=none; b=ln03byZyavURGYl6NebkTiv2gPbVuc9UciKdHIjkZzLTBDPQ7YhW7qvqBAzMsnWBlkL7avxDxBSFksAIjqSXuz4e4uOen5a4olm2RpDVnIitE8YUw6hLp5JBmX2z60BxvP6VzLt6tIiuMFXZ04C82GelSWBgENSISWV6jFt1q2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751362206; c=relaxed/simple;
	bh=+8UeNV1102gT3fczXy9V2C/gngdSsJjvcZRa2meQbis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Z0HfEF7Bjx+ior5knM/moFS9p778z9V3TT0PI+QwXRnR7RXRNB7V93XkH59u3dxJW0siA02xAzWLLHBtX6+vL7nkGu1OXtfmgj8NbBY/q6tMsIJCeHFzMZuB9xVXCMYIJW/GKcJslgaRYRaovA/g8KVNzC1qSQ6CGrirWZKyFXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=kFezH+WS; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="kFezH+WS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1751362188; x=1751621388;
	bh=U2P0Us8uY8+4LxaliBvHufWDQT219uUuIld4vJgRDWc=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:From:To:Cc:
	 Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kFezH+WSwHa1bBHnW+TvLC41Yoync/W54Wd6QlmIr8HoEAl1yoNOR788Xy55rhWOA
	 sm2Yn6FVTc9TKBW3B+9jDxITZwoWXAaDdQ5tTV67DaJ9lHZ7am0m80VdfWtL7ZQmNy
	 vEl+7tb4humMhyv4ja8IXl62zwtFsnCeLPiQeQlA7i6qMhAVaGaQwTNlcCehaheqkn
	 XTvhHYs4pznsVnm4+PzSBZXAoYcpjSNqk4pBpLzquLV4DeyaSZIN04JMKt2VAUcrlq
	 PjlgLym5BQIs/5xcdLyNEFhHGEsqmzgYuzarAMaarm6YvZ5odnS1s7edqOFdj6rxM/
	 rLdWcEh/Bu3UA==
X-Pm-Submission-Id: 4bWd63061Zz1DDrM
From: Sean Nyekjaer <sean@geanix.com>
Date: Tue, 01 Jul 2025 11:29:28 +0200
Subject: [PATCH 1/4] simutil: Add Forbidden operatator list(PLMN) fileid
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-fplmn-v1-1-d7fe9c901b57@geanix.com>
References: <20250701-fplmn-v1-0-d7fe9c901b57@geanix.com>
In-Reply-To: <20250701-fplmn-v1-0-d7fe9c901b57@geanix.com>
To: denkenz@gmail.com, ofono@lists.linux.dev
X-Mailer: b4 0.14.2

---
 src/simutil.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/simutil.h b/src/simutil.h
index 91be5e2345d39bfe4f4f25f5f4c6b8dfd4e8c3ea..556412c4eaa089789092caa72fc3d8dd7ad5b00f 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -40,6 +40,7 @@ enum sim_fileid {
 	SIM_EFBDN_FILEID =			0x6F4D,
 	SIM_EFCBMIR_FILEID =			0x6F50,
 	SIM_EFEST_FILEID =			0x6F56,
+	SIM_EF_PLMN_FILEID =			0x6F7B,
 	SIM_EFAD_FILEID =			0x6FAD,
 	SIM_EFPHASE_FILEID =			0x6FAE,
 	SIM_EFECC_FILEID =			0x6FB7,

-- 
2.49.0

