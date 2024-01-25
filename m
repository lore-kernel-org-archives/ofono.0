Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797F51118A
	for <ofono@lists.linux.dev>; Thu, 25 Jan 2024 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706222428; cv=none; b=uKQEWyaMp43mdy0aWyA6bioKUg81i4Ide28flWobQkFmT106FpIx1sOHvVDPFRadKetjROWPEsEhnh0w2blHaY0YNUYdKJEoyoJs0UW9dEUre7Ur86syOqHE0TJ/LhmUpFOXJmMaY+eWQ2o9n45hbTRbCPvgjHYzcLlDtW1XiI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706222428; c=relaxed/simple;
	bh=Vw3bOJvcJ/UQpAGwey9YKT77SLEtjq+yQhI054EJrXE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zwxw8pu+v/d1/Yf+njAeOB0/OZfIo2f30448/F+hdtD8aTtgYhVLPrwmq+LtuGjY5cHvB6AXi9O9zK0J9BLXtjltraggorObn1KgDtwT+wW53UC0znAfwQhsE3I8eY+uQndYJjewb5cDM+lO8utMmh5seykADoNWXqnddy/rB/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMdxOzTI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMdxOzTI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F4C4C43390;
	Thu, 25 Jan 2024 22:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706222428;
	bh=Vw3bOJvcJ/UQpAGwey9YKT77SLEtjq+yQhI054EJrXE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JMdxOzTItXV2keMCXzpyCza/RekdG6oGQS/sjUZ8g8PBlywOW0OXjtqUR6tfzSMyk
	 i0j9rsKmk+YLign7DoxTY38IDToCRU7osDU7AMyvwCajZ0frLNE21BYwExZqadVTzw
	 lIvjsN5x7iQWeyz+lxUedcQIZwINCUFMK+k8b06iPm1eXiWHL82yZHDQm/LWnL7BYy
	 K/wdB9gsyLgev8iT6cNg6F9IMQb8COtYF8MjyhejnN8ZjRYXQo+tECXdxf4/gKVcp6
	 4XhpyGXcGOGuaOXQkvbuVg9pfdrqXmTYQBHTod9v4du7/ykoyxtEALWN1PcmViCeIf
	 FYQSVHcL6IobA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07312DFF765;
	Thu, 25 Jan 2024 22:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] gatchat: fix g_at_chat_unref in notify handler
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170622242802.17249.915335241490090244.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 22:40:28 +0000
References: <20240124164838.605025-1-denkenz@gmail.com>
In-Reply-To: <20240124164838.605025-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev, m.lyubimov@aqsi.ru

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Wed, 24 Jan 2024 10:47:07 -0600 you wrote:
> From: Maxim Lyubimov <m.lyubimov@aqsi.ru>
> 
> If the new_bytes handler processes a modem shutdown URC, it results in
> a call to the g_at_chat_unref function, which includes a call to the
> chat_cleanup function, which clears the list of URC handlers that
> continue to be traversed after the current handler has completed, and
> may lead to errors. To correct the situation, the chat_cleanup function
> is not called in the at_chat_unref function if the in_read_handler flag
> is set. In the new_bytes function, if the destroyed flag is set, the
> chat_cleanup function is called before calling g_free. Additional
> checks have been added to the chat_cleanup function.
> 
> [...]

Here is the summary with links:
  - [v3] gatchat: fix g_at_chat_unref in notify handler
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=c994bc96d9c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


