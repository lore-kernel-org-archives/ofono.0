Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8A615E9C
	for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709224832; cv=none; b=HrNgY3HnhRT2YzTDPNbAjqSQFQk+3gJ5cS2g2C92QlgcSXSph/EEqPRBOgIxjC74RKGIYFeoannwAIOdnKVkD52TJnEsMXutgSxEVFIlxsT5u8KMOvNHEigo7g6o2/jCanE4mSUQeYUwD5dkc1Mavz1RqxDkaIWf+8qwdZbtD7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709224832; c=relaxed/simple;
	bh=J8USe792oFQiW5aofTd5uTaknyEagRvS+UXF/QavOzQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ox11WDbR0qkJz+GZpes1b1KJmGYN5d3f1xLzArXZEn2ft53Ax/CLQAmCpUPC6Af0nXuEm5KKUlrajcjKEFewYp/SduCcNo74V2cYihhwgUp/dvdzItdcGoDEMccXk4CQFHeznorNoiIVb5O6HwL/dMR+SdcRrIAkb1mueSRfSsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8eW3ojA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8eW3ojA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BA6EC433C7;
	Thu, 29 Feb 2024 16:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709224832;
	bh=J8USe792oFQiW5aofTd5uTaknyEagRvS+UXF/QavOzQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O8eW3ojA5/DLTlSgrrb2X57wmAx/k1RTFOVzKHAmS/f/MAVKDgLaX+d7KGp3XmCR9
	 7jEY0dE6PasSpx8CIByOM660XljDxn/VrGLqSShIbbzPpLI9jNt2ODMhpEpF4QwPzl
	 Bg01I5LgiNv6bQWT6aVYMoMlzkb+5SYM1yJFIFVp6rH5m3kGI6RbKX1a+kIOpBK990
	 aYLy+L9A2qeMMdeLefvQ0cTOffEiS+pBZ/Slb6dWp+/CPhjL0vksp2INGPCdcOpF+j
	 YZZErnwqpI46itwiCbr/bGf5/zLpXkTmvMGu4+LyMwogYxiZUB3BZHa4+IssPIjCyb
	 EpjNVZ3vP+Bdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21127C595D2;
	Thu, 29 Feb 2024 16:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/4] qmi: Create a method to find a service by type
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170922483212.1749.198134481800968108.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 16:40:32 +0000
References: <20240229153151.36410-1-steve.schrock@getcruise.com>
In-Reply-To: <20240229153151.36410-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 29 Feb 2024 09:31:38 -0600 you wrote:
> ---
>  drivers/qmimodem/qmi.c | 41 ++++++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 19 deletions(-)

Here is the summary with links:
  - [v2,1/4] qmi: Create a method to find a service by type
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=fa411b89f282
  - [v2,2/4] qmi: Add more service info to qmi_service
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=8cdc1511f519
  - [v2,3/4] qmi: Allow for 16-bit service types in the type hash
    (no matching commit)
  - [v2,4/4] qmi: Enable basic client creation if it is not subclassed
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=03160ab1fc34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


