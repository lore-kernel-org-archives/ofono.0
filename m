Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A422820DB
	for <ofono@lists.linux.dev>; Tue, 29 Jul 2025 22:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753827589; cv=none; b=rIe8knNPtIBdlG90ietnfZfa3DALbytH2btqFJAJZFciyUXFKH+GeTf9fRfHvlw3VHysvf3tzTacGzjgDvl7aZI4x9ifmFpgnzej5ZbmbJ7E37sW7sWVRCpDK5G8EMqXN1hFSJlhy9ubSEg0RDreJ2J7vZ5MS2Kx0UV2W8Dz24s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753827589; c=relaxed/simple;
	bh=XPCwQKdOfa1wLSvd/DKwCdh+xIKsHEd/hyXeF9ted2k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HNu1fgqfMwQEYWCSbiIuybtM5u6JVLovhE56SIc1xA6pxaQTcJkfaAqgQa23r/t7HrdwtW6n/RBDw6c7M0mtPbMn41dRUW8ngBfMo/4OBOERa1QmhoYWVkZ+MKWVzmodr5dIey4YTQBqZZq64mFD1hU2GwPBguTrkbg/WSR54nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyzjTGcZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyzjTGcZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D760C4CEEF;
	Tue, 29 Jul 2025 22:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753827589;
	bh=XPCwQKdOfa1wLSvd/DKwCdh+xIKsHEd/hyXeF9ted2k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lyzjTGcZFpfkWxGcSQADr1YpHW7w92m3FboQcxPtLG+JXuOuXRPpCIeds/NYVL9zO
	 rCeRgyCgpNqxayD+CpXyaUykMmVU4MtmzGNL/KmZS287UHIR74gg3b9b5TRyWgs119
	 MZkX3S3ARc9uBf7REk4F16vAxndi8y+uFkUBiq+0/WsZB5yq/zLDM7VDXpXBGOo9A6
	 CFEDTFnkZtCDuNJcQ2stTI/IMVBwyyrdiBgkaRDT/a/OkATIq4suW6tnfbtUr0unNr
	 AkyYtXQRPW3TLm1C3zl2eIv5JsnTcWqc+2jo0sQuFzMMRxyWIFXCqJ2s3CBCSIrkwl
	 pqrteIt1yrD2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF69383BF5F;
	Tue, 29 Jul 2025 22:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] droid: migrate to gobi QMI driver
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <175382760550.1661861.8772401833764645285.git-patchwork-notify@kernel.org>
Date: Tue, 29 Jul 2025 22:20:05 +0000
References: <20250729052132.779994-1-ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20250729052132.779994-1-ivo.g.dimitrov.75@gmail.com>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: ofono@lists.linux.dev, denkenz@gmail.com, absicsz@gmail.com,
 merlijn@wizzup.org

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 29 Jul 2025 08:21:29 +0300 you wrote:
> [PATCH 1/3] gobi: do not assume LTE is supported, detect it
> [PATCH 2/3] gobi: Add "OfflineOperatingMode" property
> [PATCH 3/3] plugins: drop droid and use gobi for droid4 modem instead

Here is the summary with links:
  - [1/3] gobi: do not assume LTE is supported, detect it
    (no matching commit)
  - [2/3] gobi: Add "OfflineOperatingMode" property
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=6e2b8a43d09b
  - [3/3] plugins: drop droid and use gobi for droid4 modem instead
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=3767c404af67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


