Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF881C863A
	for <ofono@lists.linux.dev>; Wed,  5 Mar 2025 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200600; cv=none; b=R5d9PmyGGheWRF5lE3kE/mPE07Z0BZ7IrZRnQ8yNc9p+qBCVcJFQjJ6UE/LSXUccSPSHjHVFbh6NaDtBjhu+lwwaCtRavNLDpj3C8VNoNClr3P/NnyNpFaQzAwB2BYjmwZuvmXK+Xe3B79/QTkSW6gWOiHyC5fDAAdgk5hVCx9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200600; c=relaxed/simple;
	bh=LUoYr4GNd03aefsLqg5lL9ZGUya9Td2Lv9GFIixNQg4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=umv3qjRD0OgRwJ/NG/eD4LqSVNUoceVc4tplugck6STOGTTU4QJWl1q0A00c951BCwfDiBtjBfs8WrSjw4lCbtTkQziM3sHdE2KfbWdAOHM+PomuZAaw8kfL8xpELLw7rQ8Hzo8cQj+rerVXMZULjGwv7IBAIY7Zoj1wJuIF3Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpvdLdfM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpvdLdfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21652C4CED1;
	Wed,  5 Mar 2025 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741200600;
	bh=LUoYr4GNd03aefsLqg5lL9ZGUya9Td2Lv9GFIixNQg4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YpvdLdfMESTq+vJ++PYH+MhJ+51tJ6mkZOnw/kAmHgndhukdNcnjFmAgzrYMukWlG
	 8L5N68aEBbp254RO1ZaVL8CxoZCBhZqkGSsIH9IzcK3U0tTdFG4i5GkzCLgf94VvoR
	 j9R788KSoE6udj3WHOJQ7NMbfM67KRmS0XLrOWaaA5kxMIH7K1xB6ePl64rI4Clk/o
	 +gI1Tv5U2hUWEBOS6isuqgNInGVBIgbEm5OOd4OSI1FbXOgs2GJbTvvxoSx59zcsuF
	 wOUt29kRsPzkPzAVNcp3snFf/pVYn5vawtkkmPRIcRDhdrP7RB1nibPsrnjUtqYTlB
	 JpEfv+pxdhC4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E72380CEDD;
	Wed,  5 Mar 2025 18:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Update contact information
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <174120063327.984061.2152109189199817064.git-patchwork-notify@kernel.org>
Date: Wed, 05 Mar 2025 18:50:33 +0000
References: <20250304152110.29976-1-absicsz@gmail.com>
In-Reply-To: <20250304152110.29976-1-absicsz@gmail.com>
To: Sicelo A. Mhlongo <absicsz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue,  4 Mar 2025 17:20:41 +0200 you wrote:
> Update links and remove IRC information since that is no longer used
> ---
>  README              | 6 ------
>  doc/ofono-paper.txt | 3 +--
>  2 files changed, 1 insertion(+), 8 deletions(-)

Here is the summary with links:
  - Update contact information
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=11b0628a68d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


