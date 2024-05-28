Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9E445012
	for <ofono@lists.linux.dev>; Tue, 28 May 2024 20:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716929443; cv=none; b=ZXiVM0xoYB6GTThKxKuyPCzkyLGlRFaOF+IMey1dYsCDPBPCjaKUgyA9c4230RDZuDYkUzhBysdxquSn/aONVQbe/cBgphTBd7ZsEOgwVlc3+2AAVT+wAp8vMhscvLq+ptBYcelJw7d2uTbU3tT9zXKdNTe6A+hR5Mm1ncR0nvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716929443; c=relaxed/simple;
	bh=DCNwDVXw/4bWBWv0PyTobxQkDPx95UnYLVpzoichd3Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rQCerIeBUY6tvDeXWOfz+QOvP1j3vDq+rdQxnE38BKjSxtYgXUp7euqPcx4xlgrGAOMy2/nXco2I0od/MWGKNDKRx9hmUAyIKZ8nlItY/yOzwB3nNEysY1C7C5ePClBtaX9yP1CePM1UILgQIUS9htxIqOOEhSr1vUMuaKWFVnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGVtfPIC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGVtfPIC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E19AC32781;
	Tue, 28 May 2024 20:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716929443;
	bh=DCNwDVXw/4bWBWv0PyTobxQkDPx95UnYLVpzoichd3Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FGVtfPICaXYQGDN4fAYG+hmqaLYC53QPPC0qMv1JoV0VKpTUjAKDHo77q7jKyQ0Z+
	 tUYT8E2smNAq+mCpGLE0swH/2OoOV4DDLuEL4rgPtMIBtE3i0r1+1Cp1+BBK1Xecva
	 d0lSZC+2Bia4nfW11iq/g5ITdV+uGbHuePhhHj9Zi3eAjZs0QNfIz3WQqX22g2SJTk
	 /AOisqVroGjaRD3mZ/fTrDy+6lzNZVBrNC/KEp1+Y5SZ9XKGXwZk4tQsilZus1pwgn
	 tcN6iiRLN8+vBs8mNktAC9vcMYYyC0SWBE8+5Bh+zwcHgnMZRMEdawj6dIZDCj8igz
	 ISOSAwjAG0fRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0ABC7C4361B;
	Tue, 28 May 2024 20:50:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] atmodem: sim: Fix CRSM result handling
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171692944303.28738.6561603217680887178.git-patchwork-notify@kernel.org>
Date: Tue, 28 May 2024 20:50:43 +0000
References: <20240528200808.239108-1-denkenz@gmail.com>
In-Reply-To: <20240528200808.239108-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 28 May 2024 15:07:54 -0500 you wrote:
> The previous commit tries to parse all CRSM lines until sw1 and sw2
> parameters are found.  Unfortunately the current logic does not break
> out of the loop once a valid result line is detected, and the iterator
> is modified once again, becoming invalid.  This results in subsequent
> operations (g_at_result_iter_next_hexstring) failing.  Fix that by
> breaking out of the loop as soon as sw1 and sw2 parameters are read
> successfully.
> 
> [...]

Here is the summary with links:
  - atmodem: sim: Fix CRSM result handling
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=31dfe78a070f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


