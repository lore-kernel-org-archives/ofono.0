Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647B4178CC5
	for <ofono@lists.linux.dev>; Tue, 28 May 2024 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925832; cv=none; b=pVu3iwHXsDGPNz3D4duy4917/xjxp12gVeLSdxhSi6xAWg1DrVy3nztV/M5VRuMPVBwSRRriJqJnmLFiqNhYQ4WFH9l8g1SNsIQy9hIeeSm0I+cG5Cm7VyOviqpRG9o+m7ERX2j9bJgF4p8w7l3+gkm9V9e86XF9zkvYByHRrn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925832; c=relaxed/simple;
	bh=DYMJvyEEBKVoo5Qki4v3LNVkSmzfLsaxfyDSmYsKF64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U5n3fmJRy/E9QdCwBl4j+3Qie8ZbBLYI/g278P9NoKersQkYtIF3sbi9L7Unz03qm5GkyqgRw+4fXMXOQNa8h/g0ab90oMfvjPTn4IXZFcVhhTzxvPsPlH6VsW79UWveQEXd1Y9FfHXlUl1SR+9zIBRqTQUrptTfCFfNj2E/27s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEfUlRVO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEfUlRVO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 144FFC32786;
	Tue, 28 May 2024 19:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716925832;
	bh=DYMJvyEEBKVoo5Qki4v3LNVkSmzfLsaxfyDSmYsKF64=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VEfUlRVOf6lsCgncAiz4YZ4i90Z5w7ZZEq6yGVDdwjRZuF62gmv3grHwzyG1+jrs1
	 EgDl8aan1cB4ly3L4sLSG0xp7u2qJbvNnGjzXpXlxVg2prB7w0rNO3vC6LYhN/eTv8
	 RgaUSr/jlMbPtgj89WHGPltKsTkIhXJpfrktQmmsfWsNVX8ilkPXov4WR7SmeulZa1
	 sUfe5oN/i7pIUhmMAuHq+xYLzHaJBZF22HorNrogPrPEFm86z/yo2+a77XqMu/e72S
	 5BiDWB6FgEFKQBu+78wE0SPj3SrVAb4juTfQRmeitxEwM+t9ESMYju/4SwLijk9OVl
	 4wqntepkON3TA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 008CAC4361B;
	Tue, 28 May 2024 19:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/3] build: link dundee with ell
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171692583199.23106.278323622951200630.git-patchwork-notify@kernel.org>
Date: Tue, 28 May 2024 19:50:31 +0000
References: <20240528193229.225499-1-denkenz@gmail.com>
In-Reply-To: <20240528193229.225499-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 28 May 2024 14:32:19 -0500 you wrote:
> ---
>  Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [v2,1/3] build: link dundee with ell
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=59322e4d77ff
  - [v2,2/3] log: Use l_basename instead of basename
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=47165d458c32
  - [v2,3/3] qmi: Use l_basename instead of basename
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=0ef66f551977

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


