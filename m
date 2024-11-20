Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43F81ABEA2
	for <ofono@lists.linux.dev>; Wed, 20 Nov 2024 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732134625; cv=none; b=RE3LrZjFXTwgSOW3kbyxReRs5UN/9NWsqrZFExcs53Vsi6pvbAZfnw3CZl03Fv4Wcc40IwOqeswoVh/xh13F8qPCKU4oc5H4fqzjkemrZNUBQOFohpqBxxhQanPb/SRrfklFxK3M6kqNweSflSqjQgN+OQDSvSWmpAt8Se5mSlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732134625; c=relaxed/simple;
	bh=DlyxC+FR+dWURyEMfRGwWm5JO1GXg7W3GcFOa5ZBF/I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E8GHr/mXGGmy054SMTc5YqznJAfkkorSUIt/nnYLljvngp0xAXarZIr8XBdx9G8Cu5d09wsy4iwbvHJvzLrgnSLhuHDfkP4/qanfislHNmQyX++Oyqgh6swa4XWzMEzdgirsChXnj1DkITOdZPYZCay72gptdFKMN8351elxqV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6/nhDvZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6/nhDvZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8029CC4CECD;
	Wed, 20 Nov 2024 20:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732134625;
	bh=DlyxC+FR+dWURyEMfRGwWm5JO1GXg7W3GcFOa5ZBF/I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b6/nhDvZ22dZHcWwEa1UAoOOJ2XvS3nA5ktE6JK/9fLf8h1PMU3Y7i3eB03anSh2u
	 FqxkGm6t9IvZ8OuXMrkYaEwHJoweKCbBYG9lqxREnbBOVN2bygbNwH4zgk8PP/Tpzb
	 KQnIrWN5h9cj0Pq31tHjgHyJtiOoemrZOtSoIaDJBkF+t6+Ti4rOF+j2FYbqlHJlmg
	 +SyQ333Z3KidQv9H5gkoaV4dauWa0V32nxKbg/dRiXcF0TJ/B1r9HlvXltYlBXdR1v
	 c5aGvQx+VO5vIBjV/fnqSjDEjXrsrdWxfE3hl9V9w+++9C6TAjt7MKbDPc04rnh+Py
	 MwIozJZ57ugzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CCB3809A80;
	Wed, 20 Nov 2024 20:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/8] rmnet: Add skeleton
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <173213463723.1339331.11103757423014979754.git-patchwork-notify@kernel.org>
Date: Wed, 20 Nov 2024 20:30:37 +0000
References: <20241119171832.1119-1-denkenz@gmail.com>
In-Reply-To: <20241119171832.1119-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 19 Nov 2024 11:18:12 -0600 you wrote:
> Add skeleton of the RMNet interface management module.  Implement the
> basic API structure and register the module with oFono core.
> ---
>  Makefile.am |  2 ++
>  src/rmnet.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/rmnet.h | 25 +++++++++++++++++++++++
>  3 files changed, 86 insertions(+)
>  create mode 100644 src/rmnet.c
>  create mode 100644 src/rmnet.h

Here is the summary with links:
  - [v2,1/8] rmnet: Add skeleton
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=ad000eabb49a
  - [v2,2/8] rmnet: Add logic to dump out RMNet interfaces
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=5f5b3b65efdd
  - [v2,3/8] rmnet: Track link notifications
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=cfb78944ec4f
  - [v2,4/8] rmnet: Track used mux ids
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=db18da4b4e91
  - [v2,5/8] rmnet: Delete stale RMnet links at startup
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=0cc9a035a8d1
  - [v2,6/8] rmnet: Implement rmnet_del_interfaces
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=982aa444b98e
  - [v2,7/8] rmnet: Implement getting new interfaces
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=99a68a774de0
  - [v2,8/8] rmnet: Implement cancel
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=a0d8117a04c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


