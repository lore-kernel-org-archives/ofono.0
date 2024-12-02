Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79381DE2AB
	for <ofono@lists.linux.dev>; Mon,  2 Dec 2024 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733165348; cv=none; b=Cla94eVtWSJpEbUbnaZFa4MzeA7U4vMiPRnJe+Z9KRt7YEPJDLdOwIkugUfaKpDoLWZCuMsKp4KgsI9b2SXnfsLX76zdgzb/2y+cFLx8FurfxKzhcTfqDg3LP/N7B+INSbFqwmlaVuDhvsGzQTu2RRy5xw8Hve3g39qi543pB7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733165348; c=relaxed/simple;
	bh=Sa0mXLgJgyPVPaU8Zxnh+PCw+UmXkEw33c35HJPfYVo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NGeSDvtYiIE9JqaSra7dTHZm3UDnM8kaPY9RK5/c0xjvvnbNzowDasM84EUDLP7m/FjUQAVh6QSfB4sNCcP9gn6otbFWf9L0TIzftI9Dx0k8/18iC/Y0PnwTIQ28cm7nfN5L/kyp9fTNIRsKRL8/+S8Tvmmuh9xSo7EGwV6WxI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYDa8D93; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYDa8D93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0F5C4CED1;
	Mon,  2 Dec 2024 18:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733165347;
	bh=Sa0mXLgJgyPVPaU8Zxnh+PCw+UmXkEw33c35HJPfYVo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pYDa8D93eiY490Q3BG/5Juuo7KypiK54BnmiJ1lVsSY1OH+oPDMlxaV6EFSKTPq2C
	 uZK9Hbkas+Q1WQHlq8hfqt6KS8gJNN//2gtNPo63ISPrHg4wFC3CoEQlOn+MLLNPC7
	 W5q+psoh21T3lhSzKuJGqIvJtaoYp8be0PIAysrthfNapQNLstV9+V2NXpuhaJnJsL
	 vxB3Li8MAaTFGkjRgiM2WPbi96ZJHzILAEBG7G2Z8M1jzpCpdT2T+/mlLG72Kh5Moe
	 bfJ3fYg5u43miJlU/HNmjex9csPRfvjOfCy3ix4ZoMxIfWRmZ5CtQ9jdDVSJtFl236
	 GAizTjb3k7PDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE87F3806656;
	Mon,  2 Dec 2024 18:49:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/4] provision: Add 311 270 MCC/MNC as Verizon
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <173316536151.3771225.5658062354665027532.git-patchwork-notify@kernel.org>
Date: Mon, 02 Dec 2024 18:49:21 +0000
References: <20241127213200.202536-1-denkenz@gmail.com>
In-Reply-To: <20241127213200.202536-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Wed, 27 Nov 2024 15:31:48 -0600 you wrote:
> ---
>  data/provision.json | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [v2,1/4] provision: Add 311 270 MCC/MNC as Verizon
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=e2fd4487c346
  - [v2,2/4] rmnet: Default created interfaces to MTU of 1400
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=470a2b96d233
  - [v2,3/4] qrtrqmi: Add multiple bearer support on mhi_net
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=83155e3c747a
  - [v2,4/4] qrtrqmi: Manage main netdev as part of .set_online
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=571a6aefa39f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


