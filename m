Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AA41F03F5
	for <ofono@lists.linux.dev>; Wed,  4 Dec 2024 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335219; cv=none; b=FUEGy3kihyNb89ndDwQBwbPDNCZv3sQ/K0ROaEIrERidgNuG8545fQXtP4H3Qn+MfnJYH9+Qnbdx1F+xf/ALBe5CQJbUl+il3YtyOVsNeb7nwG+9VouB94OQlZj/lbgxPbo+TGoHjst/53OJzbGyYuddmf1jqnpF+bY46PSJfXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335219; c=relaxed/simple;
	bh=H7VR69ikonOoUKJGLOpomc98Vq1bKVvqIFDligpIMEU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SLXmJHAwgqQWd2JqFHhPjMK/Po64//08TxBIEhwWQP5Yr2VbgWATlkaa9/s8E3x5+E643fWctz7tiwet2I8LCG8VB+OvJDRiv15hwotoyS1bx/twYSrtuSOUL8ZqfAreAfzvbd2xJ0F1dSP8TlYdbQKI7kgokgVnoiintAX6Q+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDWNsuEe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDWNsuEe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7710EC4CECD;
	Wed,  4 Dec 2024 18:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733335218;
	bh=H7VR69ikonOoUKJGLOpomc98Vq1bKVvqIFDligpIMEU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BDWNsuEe0I8In5c/sLLFgRAyjlG4lPzoFbl2yVgJK9Rt/cJzKCV6nG/76OPH/gNDr
	 7+E4+zj5iE/MbTWPFgBZCMKQFzW8zU9e6jRnsG6Y6yCncvU2sCxCIQKNJ6KNDhZ2Az
	 N1RTDzgGkJZeYpiCMM9MHlhfSAg6yGBlqsROpIW8ede14iBI55nXKoISjVy7riI51I
	 S3vww2RhiaD/5ThRlhCfoFP5WWuFPoZPwC+PJw8dFk/mglt/b0OdnRx4DFa27/ihSt
	 +qa52pXew8sJDr2bbVHJnEixDbzbjzwfLuW6ybYtOxoHMtpL9j8kNtjjCpGfxZ2Qdo
	 zAC7GfbS05tuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 349353806673;
	Wed,  4 Dec 2024 18:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/4] stkutil: Fix CVE-2024-7544
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <173333523301.1285999.11442052440770714946.git-patchwork-notify@kernel.org>
Date: Wed, 04 Dec 2024 18:00:33 +0000
References: <20241203194352.25514-1-ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20241203194352.25514-1-ivo.g.dimitrov.75@gmail.com>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: ofono@lists.linux.dev, denkenz@gmail.com, absicsz@gmail.com,
 merlijn@wizzup.org

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue,  3 Dec 2024 21:43:49 +0200 you wrote:
> ---
>  src/stkutil.c | 4 ++++
>  1 file changed, 4 insertions(+)

Here is the summary with links:
  - [1/4] stkutil: Fix CVE-2024-7544
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=a240705a0d5d
  - [2/4] stkutil: Fix CVE-2024-7543
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=90e60ada012d
  - [3/4] Fix CVE-2024-7547
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=305df050d02a
  - [4/4] Fix CVE-2024-7546
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=79ea6677669e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


