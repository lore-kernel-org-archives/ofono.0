Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FB13207
	for <ofono@lists.linux.dev>; Tue, 19 Mar 2024 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867028; cv=none; b=sbCxzPnlu0e1YJGFFmFbq4gaEesQV6cz2gSYNPtrT5SoxVkSYAjXMHdeq4YXkSADEEyIZIhin4DRTaK4KYCKKGOynZ7tpft1eDtvV3m4n6GGDEGOK49eZJ9GElorrTZf08qAV2Oj8uj6IcunIQANm7DgKs2XlGAxa0QvPNfkvAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867028; c=relaxed/simple;
	bh=pU/geeeDWs/NBOViXcEDPS3aEVDXsO2z9VuyVADKUrU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rUj+BZIrMKegEQqGcmbxV4VIZYUCtZfLybhHnjSbbpfk/kJpJlI4zNCQJn+dc55po8gnzS2lJXNzpN5DmkMhHWLUmfBNxyvfrEYdKK2V65DWR4MqIItSHQ5VwwWIzVWlPfFsVtV10Bq5PZb6F2+5+3u7ZI+hdKRf8MtdaiwcMJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAgElwkR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAgElwkR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D189C43399;
	Tue, 19 Mar 2024 16:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710867028;
	bh=pU/geeeDWs/NBOViXcEDPS3aEVDXsO2z9VuyVADKUrU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fAgElwkRccM8g+vgfZ5p5k1gCGO4I0Vg2DPREIVKpv1cf4+1JvIAapzQXQw3RQjhW
	 qQBcvJ6G8X/FSm6QzKb69RBlTfDPxf6P79P+pefgHPJchljo0LOdeQPJhSZ0JKUhs6
	 omN3+1negbhpC58jDJRhpbLuybs5Qa1hu+tJ/o/10oqd4NRs0ONMd+lRUDRd2TsK73
	 BaY50cs8IauflosATu3oRAc9g1bgQ5QoLvggbg0tJdgV0l9gOYaXG7VYtKQ/L1L5d+
	 JPSPk6J8y6KR0z3oEt0YJ77lI98yZztAD5wnK6J8ciCRQGeItI1GFuKOrzJcdQx0Xg
	 Av3jXQuCcazYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 259BDD95060;
	Tue, 19 Mar 2024 16:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qmi: Initialize group_id for control requests
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171086702815.19628.67674889698835829.git-patchwork-notify@kernel.org>
Date: Tue, 19 Mar 2024 16:50:28 +0000
References: <20240319160639.42456-1-steve.schrock@getcruise.com>
In-Reply-To: <20240319160639.42456-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 19 Mar 2024 16:06:39 +0000 you wrote:
> valgrind found that for control requests, the group_id was not being
> set. The requests are being allocated using l_malloc which does not
> initialize memory to 0, unlike l_new. The impact is that cleanup of
> the requests during service closure or modem shutdown might
> incorrectly remove a control request from the queue. The fix is to
> always initialize this field to 0.
> 
> [...]

Here is the summary with links:
  - qmi: Initialize group_id for control requests
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=32f570c95930

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


