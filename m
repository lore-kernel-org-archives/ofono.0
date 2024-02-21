Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBBB8003B
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530631; cv=none; b=tgEfa6rSFS8HEYnB9Z/T1CLPsPdrYTOBAJCyWLW+f/QAkg5G3TD4/hjRdSwF4LVsEYkBMyff1e95vueLf3diFUfKwO2vkzplfoAnBGv31ZK2vF8RV0eTowjpb0O1OK+i68IVU3jcQopEfswpX3QuuqKScp+KrAD/ifVHX7/JyUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530631; c=relaxed/simple;
	bh=vJVD3me6H0Bjsjd0UrmmC1SkPdjQleyZH81vGbuUufU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HG0hWKHDU6C6sq2PCP6veFxwJAPj/DvlS5PIY4jMCcKYzvkkGhQLwjPbDLBM4P7KFMOwg7n1zIYMoxKtgZ7r1hXGHGqsD5+u/0uQKldg6DkGW7tG3Trti1Wv5WfsxQRtQ+8Mb4DaXuWTPzcPMTIEPiMLdTrgMUKNgVOMk6mWgso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqbMgt+U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqbMgt+U"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCEB0C43390;
	Wed, 21 Feb 2024 15:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708530630;
	bh=vJVD3me6H0Bjsjd0UrmmC1SkPdjQleyZH81vGbuUufU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FqbMgt+UJD4Ty7+wX9XkANFPJjlkCYgXnzk7CSBI7VM9aEhzZVEscloOFg7eJK94x
	 PW0B6nhNF209Z5U2E/0sF+r+Luud052Xe4pWHdYdDVh3XSldKsjnaXcKtg/u9DOVkL
	 M+dedsAPVb2zQGDwhAEBPnHEjJYEKJA0nc+UWL8NfVAHgXH9wKuveIOk1Lh6C2ibPY
	 j9X2bnoG8R8HKBfXcgsc8yfzzyFcdFLlsraxG+dTmrwb1wVsYlxcyMmo1rPaasCIrs
	 dIiJKr9NRYU+fhrCla2YJagoCDvMFivf1+20qgPtbasCYQYzqo2wS3pxYxrt14kPii
	 Z4Ib1JcMTWFoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE815D84BB9;
	Wed, 21 Feb 2024 15:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/4] qmimodem: Use ell new, malloc, and free functions
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170853063070.10988.11129491498521492791.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 15:50:30 +0000
References: <20240220232529.128477-1-steve.schrock@getcruise.com>
In-Reply-To: <20240220232529.128477-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 20 Feb 2024 23:25:26 +0000 you wrote:
> ---
>  drivers/qmimodem/qmi.c | 109 +++++++++++++++++------------------------
>  1 file changed, 44 insertions(+), 65 deletions(-)

Here is the summary with links:
  - [1/4] qmimodem: Use ell new, malloc, and free functions
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=8b64c46779d9
  - [2/4] qmimodem: Use l_util_hexdump
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=46a2fde548a6
  - [3/4] qmimodem: Use l_queue instead of GQueue
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=7fbb3032b4b7
  - [4/4] qmimodem: Use l_hashmap instead of GHashTable
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=2ea7f60e1530

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


