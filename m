Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2FB2741B7
	for <ofono@lists.linux.dev>; Wed, 14 May 2025 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747238994; cv=none; b=EKgpp8VQARodgIvDe0rsQJU0gZ4NKFZ/iIZz1GlmTY5Xx2Q3XdIFL9kSOBSPvrWDhb5t+t/fjxKtUtCgoFDL/YRf76WQNQcQEKEm1K29/pGMBTEYJluYVnK7tWVlbeJaSzJ7yThJMEofj2a+aapQDUK5fxaPlauYqdEKxk5tzTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747238994; c=relaxed/simple;
	bh=adpnGKYT8b1RRqqWkoUGc5zedwWpidyCpUy9hFBMZWg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dLzIdPyadZb90/aqIXc9wT/qPGmxDKsj72HAH7CAMtBzwL0yo1yz/MaPBXiSE83C3Q7ralrOPMwRZjnKcAXUw3G13/T4gL1fUsZlc2wtdktrdOEy3+5gqxS9KfUlGCIeA3c4fy8AzCyaJPPm1gxYQkm5v7KBrw2qqpe74nnR8y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXUzGjEk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXUzGjEk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27639C4CEE9;
	Wed, 14 May 2025 16:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747238994;
	bh=adpnGKYT8b1RRqqWkoUGc5zedwWpidyCpUy9hFBMZWg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FXUzGjEkR8B0Oq28wV5be8V0wIm9YvCjYlCqo7pXIypaX7mWlrQddSWKEOQtQEUJ9
	 lv7TZ1b0B1Zxw0W0n+bfskkNcqexJpRf3huA9LsjbFRVh/oxDOy7APpQrAETm2rdr0
	 HyNP2Hi7KLDw7+LGW+AZneuXHdUeEYE/TQGEcr0plaDnj/XqAueQcX1wwlvSOmCPw/
	 mvtWoE4BjYo3b7Bu3sv2pFCKsaQRKJzKaRqtn+QN2vJeyCQ5cfEVAZxNbIkYOExO6K
	 WW9fuFV6yxZT2O8Q4PP60bRC0Z0n6VPyRXZzem7l7Gl4pDVXyMpJt40Ao4gQjp9deL
	 zRjqIqCmYw3KA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC53380AA66;
	Wed, 14 May 2025 16:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/5] udevng: Record devnode even for non-USB devices
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <174723903152.2422148.11684028287525685460.git-patchwork-notify@kernel.org>
Date: Wed, 14 May 2025 16:10:31 +0000
References: <20250509200131.42020-1-denkenz@gmail.com>
In-Reply-To: <20250509200131.42020-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri,  9 May 2025 15:01:08 -0500 you wrote:
> This is useful for WWAN AT/MBIM/QCDM ports that are being created by PCI
> based devices.
> ---
>  plugins/udevng.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [1/5] udevng: Record devnode even for non-USB devices
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=0ede8e3300d8
  - [2/5] udevng: mhi: Collect WWAN net devices as well
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=1d1f9cda1b53
  - [3/5] udevng: mhi: Detect MBIM mode devices
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=92f6fe8c1b87
  - [4/5] mbim: Do not require the DescriptorsFile property
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=597bcbcbb9ae
  - [5/5] mbim: Print the device as a string
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=3fc849113f3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


