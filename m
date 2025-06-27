Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE654260569
	for <ofono@lists.linux.dev>; Fri, 27 Jun 2025 21:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751059179; cv=none; b=nBEPCcvH8x9WfRsNtBpNSyPwDbStB/XzxStKPH2WCnmesbSJoUo6C240SzxB49k6MsnpB3pUV22caPvW0XF0CDfSaSfwVXkq1kSC+F1btmYuZDtt32ISD4yd+LyGLFRTYPAIXsUl5GHgntL3mF9lVyMUDFXL3k4J+tr1fb3yhkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751059179; c=relaxed/simple;
	bh=xRKiIjPSbDPaFmY4q3k3Ne3aSG/JSSMkx38shhDScnI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CnUO9nKCaXmttF6R+I36Ku8R3kVkJDKJmrGUYixcZprYhHv3k5zqptpUPCtMbKi38FiZ7PV8nd9MqFFUCq6kfknhVKHkDBr9uKjd3jB4rNlFGl3QwmPj8V6gDm5tv8BDgYrKOR6zxqC4vb9MlzRFWFvwP/fEgw822BVu3IdGBS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEvrXzMK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEvrXzMK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4896EC4CEED;
	Fri, 27 Jun 2025 21:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751059179;
	bh=xRKiIjPSbDPaFmY4q3k3Ne3aSG/JSSMkx38shhDScnI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bEvrXzMKTnLnhHFzeiDwdPdmOOa48XRQwhmJrEH22EQXzZcNfLgF4JnM+33CXrt0L
	 /aybFRe+uLvWcqbqHkfz/ZrO7fm7iZhKPWMRwHT73bd13M/11QcLLL4fz4Iqdz4Sa+
	 +Fi1AxJkvOAnjty3OKQKF8Sabs0nlgc3M77OKBpfKRs+XNDpOCuOSUwc3M1V6nGmxn
	 CZeNlnzJhVORJWwwD3hYq7SgVyyFQUEdWbbiYAkm1cl/nY6tlzldlDXLeIcFdsJkt0
	 T3cypQ7lCorMsRH+7TIKpED+02fG5Al90IQuIWB2QG/ecz/E3zJfob8oNCN2p/1CZx
	 iEkL0DyTnNDPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7110A38111CE;
	Fri, 27 Jun 2025 21:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qmi: avoid free of non heap object
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <175105920526.2062756.3028536748527933023.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 21:20:05 +0000
References: <20250626081625.1362728-1-sean@geanix.com>
In-Reply-To: <20250626081625.1362728-1-sean@geanix.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: denkenz@gmail.com, ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 26 Jun 2025 10:16:24 +0200 you wrote:
> qmux_create_client_timeout() free's a non heap object, avoid calling
> __request_free() and inline free_request() instead.
> 
> In function 'l_free',
>     inlined from '__request_free' at drivers/qmimodem/qmi.c:293:3,
>     inlined from 'qmux_create_client_timeout' at drivers/qmimodem/qmi.c:1427:2:
> ell/util.c:124:9: warning: 'free' called on pointer 'user_data_6(D)' with nonzero offset 28 [-Wfree-nonheap-object]
>   124 |         free(ptr);
>       |         ^
> 
> [...]

Here is the summary with links:
  - qmi: avoid free of non heap object
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=8d892785e47b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


