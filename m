Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8197690F
	for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443028; cv=none; b=K52/yAYvRfby501n9mFbAxiAejXBs+1rgpsrApCsOzaCl1rogfpBDIHGeUzzfiEbq9frlpVmI9M/w69Hqv4hcTgAv3p8MDCgtHJG88qQ7OA1kbPHdYHQv79pPi3uCBe/f+4OdjqGoceeHD1v7pdbI1qQ3Ef5U7/mQIbcaHBLJSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443028; c=relaxed/simple;
	bh=XS3wCd5KkEW0h3CrlvTyu6/x7WAKhnlgLWT/wxPte14=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fcja0B2BYCfQqowxcIBcYxWd+Jfnw7sGWdQwZ/JCNYiD0MKJNdw/Fo3VGinbEvsS4PN1HbWCesTgr/HEqQHvp/KsAdbMuahigAiSjKPwhYTlJ2pZ2/H7JLUy1ugO05h5SXYB/IqW8M20Lcb7syYaE/oH5XrxdM5djMdC51RBiO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hi/GQj4Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hi/GQj4Z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 374ECC43390;
	Tue, 20 Feb 2024 15:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708443028;
	bh=XS3wCd5KkEW0h3CrlvTyu6/x7WAKhnlgLWT/wxPte14=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hi/GQj4ZHVuhGCtCXKVVwh7wJmuIsUHdOSsL90KRZZSlJRVxKKl7gBTdga2dBWGGL
	 xBIDxRft8/E6Fwjh92LMli3CM16cj0yCOT9zxJkZsJYEpvBxfne8kAeQ5uyq1osqp5
	 iGgD0qF2dFoQbkM/ujE/s5yvfkYx+keqRvYiNTIiM8l1OFxgJ0/ZOEtsawCLKw9QYN
	 EpUZQzDGcx8ZxHZpPzl99LdFtR8LfyMO94Mcak9KR9XP34Dv177TpDap/Yr+ctFgGG
	 JHbU5xjLes+XiqEgnHUmMDVk6dii4psfHyiT4NvEoi7UxQlQwRYDU1VLYVMNLMo8+Q
	 u9BmOqsza+ceQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E711D84BBB;
	Tue, 20 Feb 2024 15:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] smsutil: Remove g_string_* use
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170844302810.30347.13244944257670746888.git-patchwork-notify@kernel.org>
Date: Tue, 20 Feb 2024 15:30:28 +0000
References: <20240216163804.1206023-1-denkenz@gmail.com>
In-Reply-To: <20240216163804.1206023-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri, 16 Feb 2024 10:38:01 -0600 you wrote:
> Replace with l_string instead
> ---
>  src/smsutil.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [1/2] smsutil: Remove g_string_* use
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=600173832604
  - [2/2] phonebook: Remove g_string_* use
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=b72a40986eaf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


