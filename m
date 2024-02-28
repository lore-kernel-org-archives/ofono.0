Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DC91DFFA
	for <ofono@lists.linux.dev>; Wed, 28 Feb 2024 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709138434; cv=none; b=O4fTPkFCE11K8pMverincB3j3DQkGJWrK+D3iZkwpynrV313gro8GGncLskHVAFxa4CFrtbQvQxorRLhUz7tkCrHujuAhfC2bkWToFRShKDrApj0xi2nJoK5iUbyMg7qQLGd4VXoyMBOApzgc6VUYNmfzbSaXyyse8Bm4zhaxr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709138434; c=relaxed/simple;
	bh=XtDBtVui/r2KK9DuH+b6MfIVsdUlff7u9ClJeBqojFg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fW6ddRdm2K/oksFZRjM6+nTEC2If+Jtzq8PvBJo457OIVkZXisWEQYm5SVFoDvLEAIqj2qO0ToLhyicnaMtDkg2NZc3nHy7ZzFvhbazT6DoNPe1nMVs/9hSRerEgSvnsg2IeTfAz31dAmQVx5RFDU8i6yVTjvw3yw8C4pAayTwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s40JYHKx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s40JYHKx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50A9BC43390;
	Wed, 28 Feb 2024 16:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709138433;
	bh=XtDBtVui/r2KK9DuH+b6MfIVsdUlff7u9ClJeBqojFg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s40JYHKxnXWuQGUiy+DWjoRTTJhX8n0lxCoYIzi58DkRbCJiN8V0CodR2/seJprRx
	 nmf2vkZOB5Mkh88rax9e/XouGqFQFmFz3ONTget5dRZLNZ1ik1DgXIf+x9SEgQW6qr
	 EOaxME0XC9HPxLOsGYQPCi46KyNAeuM6W9Wc2k/L8xXTwToG8ps9NaNYMrgVwm3w/e
	 OKx7A0U1LNSSxkNaAEJOWS48MZ8Cr3qQHzee7NbHQIWP1dtM+dQ3avixRAfGjhLXiI
	 mLItLgfAODGK3P5gxpgd48p0Lpm74D93Udi1EiC29vcG0nIG2ViLtq65unC6K1seZK
	 W9erAWErDor7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 354FBD88FB1;
	Wed, 28 Feb 2024 16:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qmi: add QRTR services to the queue
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170913843321.9806.2792203235364463385.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 16:40:33 +0000
References: <20240228160239.148583-1-steve.schrock@getcruise.com>
In-Reply-To: <20240228160239.148583-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Wed, 28 Feb 2024 16:02:39 +0000 you wrote:
> ---
>  drivers/qmimodem/qmi.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Here is the summary with links:
  - qmi: add QRTR services to the queue
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=5a37098fa47c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


