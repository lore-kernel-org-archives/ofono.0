Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD95364D4
	for <ofono@lists.linux.dev>; Tue, 19 Mar 2024 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710887429; cv=none; b=f0INjhZB4rQRs8ayyO/8ZmNNLz3HEcARrf6c2EXewOMPvuK0OohaGHUl1m880KZih96oGbntJx5mlJxOLFcbmS4Mbn8dyqbUcRMJ7iyTZgbHHZEBhvp/LLq6PTVytg7OWa9hKbZttPY0tnyGB8ohEYaGq2AF+zZWYI0aX2QS6bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710887429; c=relaxed/simple;
	bh=Utjri+BPf2Tx9NgkdDPjl5P7efcIinwyqDBaMgn/8g8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M+CMRPqbdzoxG564FA9hyuzLKKDL7+ukfsawQHkNxSmoWb3A9EN4iuFrir2al7YkIeaVr3ewgDFKVSSkLkV+wneVwYYgdmApvoBVwcdqtV5WreVo3ivI7yZAGnhD6VaJRxgOb7jiLKwHq8dRGj1h7+ZUidMi9KWAxDBuhvIGbNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHg0VI/+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHg0VI/+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F206C43390;
	Tue, 19 Mar 2024 22:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710887429;
	bh=Utjri+BPf2Tx9NgkdDPjl5P7efcIinwyqDBaMgn/8g8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dHg0VI/+frM0W9x1mdQZ0Hj9HZoKJmh3WZ8345qcitls5VhuETFcc/E3aSsxc+5TP
	 FhQFZ3FdrHfiDjOmIKW80gYDBKSp8lSctyHvQttEHmL+YW1LepfEaex5hlxAd2f7sy
	 eMcWAvy7JT7TMb6C5rRdsdSYkqGtHVbGIXy0MVbYwJVfDChV7gFtFHTJRrp0RXxfOr
	 VYPIY91Bwpv/m6gvnzRUOsjUUx1K0TIA35/JRi8h35SQN2IDXsV/jlF1orSrhucavm
	 NEo7FzWt3prdwKfOTTzxCD8ayO5AHliT2N9LZwmfnvKFlfeYC4XFioOmCBxSjm28Z5
	 +18qm0we5idfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4AE09D982E5;
	Tue, 19 Mar 2024 22:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] qmimodem: Rework GET_CARD_STATUS retry logic
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171088742930.29754.2808290138592394466.git-patchwork-notify@kernel.org>
Date: Tue, 19 Mar 2024 22:30:29 +0000
References: <20240319164309.2676887-1-denkenz@gmail.com>
In-Reply-To: <20240319164309.2676887-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 19 Mar 2024 11:42:53 -0500 you wrote:
> Port the retry logic from glib based implementation that uses
> g_timeout_add to use l_timeout instead.  While here, fix the existing
> logic to not leak memory when a retry is performed.  This happens in one
> of two ways:
> 
> - When retry_cbd is allocated via cb_data_new, it is never freed when
>   the timeout GSource fires.
> - If the timeout GSource is removed early (i.e. due to remove() being
>   called), the associated retry_cbd is not freed
> 
> [...]

Here is the summary with links:
  - [1/2] qmimodem: Rework GET_CARD_STATUS retry logic
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=559c224c4cd3
  - [2/2] qmimodem: sms: Silence valgrind warning
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=b0f808ccd6e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


