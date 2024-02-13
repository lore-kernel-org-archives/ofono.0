Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A1033E1
	for <ofono@lists.linux.dev>; Tue, 13 Feb 2024 02:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707792624; cv=none; b=eB8Go8RyWmRmg9F/8b9B4/GHDR13FkxCLAar5BPztQbEw3P54dASbxo3+rRDaKugOvydPNTN25sdOjqyGc4jQolRI05bPYX5vfjQfWP4eo2rrGCXFOO084CA2QM0wMouS3E6EgTJuq0rikGv6LzZkvgrD7STjfG3/z/lRhtTtuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707792624; c=relaxed/simple;
	bh=JxQKN+Oafq0GdJeqfLh1xQxGzihhFf/66spZXm7A9Io=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nc4Z3DPHCa4BTdH861t7rPEh/QW/HWQbfLSKhuyYPqzhs8YFKsEVRb8qdg9aVZJu7Vm00lbvmBgDuCLZG22xgxN12lPXCY2OCieYwY5D8fxAifXT+7Y4sQY3Z6b+2gZHpIYqdP9SBtZciLI6XbXTPc0Fyu3Fqea+XqYyMA0N80A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWlzvCf2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWlzvCf2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85F59C43390;
	Tue, 13 Feb 2024 02:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707792624;
	bh=JxQKN+Oafq0GdJeqfLh1xQxGzihhFf/66spZXm7A9Io=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aWlzvCf2Ku0dGVPBzJ6XqTebeoV23IuDWvUT4VrxRIB6K6HwLNKoECYUtQUfHD4vI
	 Vx+ZFfRZ8sNO5IXF3t5pZVT9AORESjVYsRyRrGCamf99GvHGgd/8UvIa8MKBP6bWog
	 jlDlPL4E/tvoPDAl8yRH5jPmhAXwTAV+oeTLFDTrl+oRG8WB4o364hDCPQADh+t8rt
	 sTXllgg3qG9+0rhbtIiXZE4S9WOfCWtCYVO7GGP0s+uPREJacm5kE1X5Nu7qiOf/kb
	 PglkWlVzo6vDKc45oA+51u+V0sPgFSOFT4UxmZxrRGxr0klG60XjRORHUKaLYQ+QwO
	 7FaiHdSQzxgfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C6D8D84BC6;
	Tue, 13 Feb 2024 02:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] common: Drop GLib use from gprs_proto_to_string
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170779262443.16179.9073956041195888707.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 02:50:24 +0000
References: <1707770140-20746-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <1707770140-20746-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: ofono@lists.linux.dev, denkenz@gmail.com, absicsz@gmail.com

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon, 12 Feb 2024 22:35:40 +0200 you wrote:
> there is one more g_str_equal usage(), fix that
> 
> Fixes 6f63dbbb ("common: Drop GLib use from gprs_auth_proto_to_string")
> ---
>  src/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - common: Drop GLib use from gprs_proto_to_string
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=1d7f24b5c15d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


