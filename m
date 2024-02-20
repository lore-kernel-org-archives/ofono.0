Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28DA7691A
	for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443028; cv=none; b=qHL7jFGJHr1bnuP7Uns67TozdjA7vxxl60tzDWluK9x9RyAi+jpxo0Rii8RmW9LUNdv+aonH9EnIg9StriHxa67MXebcQXTg5VLrr/EFzIeTxwi3ck79ISO+DaY0A/+JG4bN/5U2zmT3eTp8OcG6Gjj75Nsy1zPvKSosStVkYqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443028; c=relaxed/simple;
	bh=eoXQI+PuNoRKFq3RiDiZLNeGEvxW7thLbkYLmllpQRs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=miSfxxU+/zodQ8ZU9IDyUMdCJmYLk8sBidDN4zBm1/kbMaNNh2XOt4talG2OQMyPJCFaNBd535I1Sk8UsL/vULmZJ8KosBblBt0WPv9Z2dpqsVpEwhStZH71+clcvbpmaQrezRKmykHqCbfowCYeiakABROUjPTqKAKSKdgLB+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVxq9hXM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVxq9hXM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 529BCC433B2;
	Tue, 20 Feb 2024 15:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708443028;
	bh=eoXQI+PuNoRKFq3RiDiZLNeGEvxW7thLbkYLmllpQRs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bVxq9hXMKGiLTAiTs/lkeBLLaeNh5IVD0G4s3qhOaS2bVP9zjpJU2KUckZmYH+G/L
	 vUZ3YNvsO2rKpwO5+y9UwA8OqsaLf2vCFGUVsNqPXIsfie4vqfuX77Mx4ha4YxPzri
	 OQRAFGGxS7BoNl5GF3/pej8CMt5zdiFUsAtOBM4s9bL/0GgmZku4vuta5ZA1V+OXRf
	 bdTz1DxzyoMiCsQL34DuQSDKV0hAy8zA9JfBYAxAyoCFlqC8crYCxnhnD+lC8nQ4Vu
	 AQ/VVTC7Vsf8PnM6x9C+LQQtz/NlRunyQFTTAYvkpeZYqyXU/GYeBXcPSOForKkI7l
	 7BouPOXiz3xbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 357E8D84BC2;
	Tue, 20 Feb 2024 15:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] treewide: Make modem drivers builtin
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170844302821.30347.16187929099827928902.git-patchwork-notify@kernel.org>
Date: Tue, 20 Feb 2024 15:30:28 +0000
References: <20240215193625.1140095-1-denkenz@gmail.com>
In-Reply-To: <20240215193625.1140095-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 15 Feb 2024 13:36:22 -0600 you wrote:
> Modem drivers are currently defined as plugins that register a
> modem driver via ofono_modem_driver_register in the plugin init
> method.  While oFono supports external plugins, this functionality
> hasn't been used in practice for a long time.  External modem drivers is
> also something that upstream project no longer wants to support.
> 
> Make all modem drivers builtin and introduce a new macro to make this
> explicit.  Remove ofono_modem_driver_register and
> ofono_modem_driver_unregister methods.
> 
> [...]

Here is the summary with links:
  - [1/2] treewide: Make modem drivers builtin
    (no matching commit)
  - [2/2] caif: Remove caif plugin
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=772eac040735

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


