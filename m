Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78101E48A
	for <ofono@lists.linux.dev>; Mon, 28 Oct 2024 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730140228; cv=none; b=LCcCtpq3R+Oml32uWLckKEOzQNbEixWloO5cHgYyMBKkTUKjJcu3o9LnI2OHsHYn3Cnpyo86VZDYhlEsaXXESZqCD8gXpQc67fWd+IIot1gTx2uZfBsut9zyZCWf7yM1TzTDjqR2py9OFr1GMA1BUEMMND58LJPDDR1hPprAVCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730140228; c=relaxed/simple;
	bh=klp6hFO/N4c1zKOdSMNSkTmIefiuPcJZTm4WOYh21zU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hbWTPhVNZdVszsDgNX/2Xwi1T7PdKhTa5jAwl62/HYL6Oy3QQg6umE9N52iVCjgwexoBZHZI0zeqG8AYsdPueMYlz9e8NjAuPAyJhgL/BwM2OSIPxEogX079m+i251BwT2gpuHUVNdEiR239PMHlunpb8aQx5NnD1RR9TS3qI/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwlJs4Hi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwlJs4Hi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593D0C4CEC3;
	Mon, 28 Oct 2024 18:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730140226;
	bh=klp6hFO/N4c1zKOdSMNSkTmIefiuPcJZTm4WOYh21zU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FwlJs4Hi5aBeSvJ4IJws7uUwodh6OSC45qiMFqdP+jX3ppmGY24+dtPYThb9fOtoW
	 xKmCMXqUGcDAnGnN7NHBqXjKhhWA9mFdSQxG4OmIA88n2mkKDpfkUKbtBDnzgBUOPs
	 LogrLwPYukV5O22HLTzjU3RVUR7qjsSYHTmF/qIVNJ0qkLF+UcOFqF7Ys3VEf6RBh1
	 zc3nIyGtFveG/KS35YQXRslP6SeE1P/IjFi//iXuaHwMMeYKPVk7clJttx1EaJLUvg
	 GWb8Kdeidq3JUNIBUNQifFbXLMenwuaCg/zAEBDJdIrvOb8GWie5gD8S88Feao8NHp
	 6pD/q8G1q9Viw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD6D380AC1C;
	Mon, 28 Oct 2024 18:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Revert "sim7100: create lte atom in post_sim()"
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <173014023376.140589.1347395796574971695.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 18:30:33 +0000
References: <20241025055558.2563056-1-sean@geanix.com>
In-Reply-To: <20241025055558.2563056-1-sean@geanix.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: ofono@lists.linux.dev, denkenz@gmail.com

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri, 25 Oct 2024 07:55:56 +0200 you wrote:
> SIMCom A7672E-FASE doesn't support initial PDP context (AT+CGAUTH=0,...
> and AT+CGDCONT=0,...) which is what the lte atom is enables.
> 
> This reverts commit 8869b39c1e3a1b76637ffb13fc5de800d7f88c2c.
> ---
> Kinda embarrassing sorry :)
> 
> [...]

Here is the summary with links:
  - Revert "sim7100: create lte atom in post_sim()"
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=0a2a43a39bf7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


