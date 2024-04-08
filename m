Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F57B1D52C
	for <ofono@lists.linux.dev>; Mon,  8 Apr 2024 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712616027; cv=none; b=Ha9CuWuO4B/0Y5T4BIcd7DZ+eF95h5CohPN7FLsh+8O4/v/3Y19SPUpvRtoxwYGbdrDKnEHadOcX3TDK3Yz77W1Gv5ukant1ns2tSR4t4ajrilin7d8ipi8cl7iQ9lb5wnxZsld8iHTmlVsWSTka9QCks8//+UEG4hjr/Jaifrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712616027; c=relaxed/simple;
	bh=njnIdOPm1gYT2+WWPO/Dgrwuk8/lKCuZkGM+9Bqusd4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Itc1gHxoA58n9C+TpChbCLChTmXIRYuoTfH4QyQb/gfiApUrn1efAw4qL/IKE0NTV4iJ0qb+I7L9Ggvt/cuLTiAV+Aw++7w7DZUWf8/Ulq6OCnQlB69nVq3uSHOmo2ac1rHG5sRm/Vlv4SwqzBW45WFtzaR/k/dzpcM/M+IQ97k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWFYBGXS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWFYBGXS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65035C43399;
	Mon,  8 Apr 2024 22:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712616027;
	bh=njnIdOPm1gYT2+WWPO/Dgrwuk8/lKCuZkGM+9Bqusd4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YWFYBGXS89LyAbdcBeFIAQXeJKDb827VzHYGF652jCkPFpzTdwjBMOLdWdGiPqZ0I
	 qmsaV39W/HYU+JuqLEYpap6ruEwf3XKfjYFoZfe1tAT37TVQFpiKF+5hy7LSVOy2A/
	 5R4gOU1miK/IH1Q7VjlHDiiHEnZ8RWrZpb+TGMdOoeN2mU/xR+IyDmBCifaRsPXKx2
	 2Tw82cx7Ugs7tIHe+5063eaPiGwL1RsprMGGBZtTBDWJmdkY55QfXVQdaLnP+tiQlT
	 blIjpV15UJZgcqOk2A18su0VSD9jIZ+iGheLZnfS1yOpuXAAB/wYzaizgQ9OSuqn7b
	 1+LfK7jGbArHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A45FC54BD8;
	Mon,  8 Apr 2024 22:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qmi unit: Ignore QRTR control packets
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171261602736.14139.14296232964526018914.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 22:40:27 +0000
References: <20240408194605.11666-1-steve.schrock@getcruise.com>
In-Reply-To: <20240408194605.11666-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon,  8 Apr 2024 19:46:05 +0000 you wrote:
> Sometimes the test server will receive a QRTR_TYPE_DEL_CLIENT control
> packet which is broadcast when the prior test client is destroyed. It
> is entirely schdeduler-dependent as to whether this broadcast will
> occur before or after the subsequent test's servers are created. If
> the test server receives a control packet, then test_send_data will
> fail. There is no need for the tests to be aware of any control
> packets at this time so it should simply ignore them.
> 
> [...]

Here is the summary with links:
  - qmi unit: Ignore QRTR control packets
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=6d4a89bbf07c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


