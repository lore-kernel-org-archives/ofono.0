Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696FD4EB23
	for <ofono@lists.linux.dev>; Tue, 27 Feb 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056230; cv=none; b=optpNM3t1PGcPaSP3zb2Hi1McGLQpRdVC9ECXl5y6JbVcvL+mNHEee4yV2ImxrR3VnpMPdt5czt6eCGaGXZOuCe/6vxukbV0gRIMtcBiWiX4EMf9VdVXAyzqM0F8Kg7OAJbzK9ky50OYJsdYU7p+KUIRAeUAOPat951OhlyNcw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056230; c=relaxed/simple;
	bh=I7YnP1bdgV/1AEJiYAoMSqIq9toeo5tzaApSwhRkQus=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=anAf8MnshmKLC3oMVYzzCgirgTNSDvu0+PgjuVKF0AQC+tB3pGeaLiBY0moj3EY7WY4zegxZGzJf1M/xTCRz0X4aHiGkjkxqcFjbHMVnLO1gq0D4qESFGoUblIcGo86cvb8Zpc9F8I4GS59RPVnau/bBZDO2OqMIxYVW8aLT3zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5FuO9PZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5FuO9PZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02760C43390;
	Tue, 27 Feb 2024 17:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709056230;
	bh=I7YnP1bdgV/1AEJiYAoMSqIq9toeo5tzaApSwhRkQus=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p5FuO9PZQQfWKTIALpfg8LxYxUJr/TZ2c4jqj37sKoFKSBh9Nzi6swb05Vxm/cJy/
	 U28IkUl9UdwhcSammeLu5NTEraG16TxaOhQ+TIcVPa2kE/dAWvXI98dF1IBqeOseT3
	 YFlPN06I51DHqjrFBjvw3cf3TgyEfnfgfr9WzKfXHE7M0ZzGeCEMUKp+bgwSBmgTSY
	 mrqe4LlZuNKBgsl5AQ21TyjPSOMh9Ipe+E8wzbApNwKoAK0prJYsgmIUhzqsMYinb+
	 LNR/uz6kmQKmLWl/ip4uMF793wCGSlDww8iiJRERyp9KD4gxs145bjnzW79PjQo14u
	 7gTkOjFe3Bjvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF8E8D88FB4;
	Tue, 27 Feb 2024 17:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] voicecall: Fix memory leak
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170905622990.4034.2390599092580763552.git-patchwork-notify@kernel.org>
Date: Tue, 27 Feb 2024 17:50:29 +0000
References: <20240227153314.1469536-1-denkenz@gmail.com>
In-Reply-To: <20240227153314.1469536-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 27 Feb 2024 09:33:02 -0600 you wrote:
> 'number' is obtained using g_key_file_get_string (which returns a newly
> allocated string), but is never freed.
> ---
>  src/voicecall.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [1/3] voicecall: Fix memory leak
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=0695b4df2ca4
  - [2/3] voicecall: Fix use after free
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=a46dff5b2476
  - [3/3] lte: Fix invalid cleanup
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=6bf0a2541d43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


