Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5AB1D558
	for <ofono@lists.linux.dev>; Mon,  8 Apr 2024 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712616027; cv=none; b=FHskzoiHby43w8HSWMoL72qDToasBE9xtzHAcd+d+2ykgNl0arsdnljB6gjb9rAqLMlzb4A3f1mYFOoQZT+xtrZIm87BnTqxikniNeesPvQNaHqP5qco4RFxURzKGg4c2qBBrRFKQwyC8Gt/y/FWcE/eApg88VL4QyOIUFFh56U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712616027; c=relaxed/simple;
	bh=Ypk+p7JTblVZhL7WFcLh32FcOCYQc6yJkAa8TdIQEeU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hZ+9WHeFkBk15ReJj7Z+l1oyBoGqxbOx3uWdWvZ9DgTrWp13F2lRXHzKy1yexxGcijhm96Vo2Pm+cyxlFn+KODG2mzuA+FHpH5jRMw5DEiIzL0xrEORv70FiGEfvnoDF7WjnVtiM4kpPscFNg8Ig5l70DyrFTYkRRSOX9eQbiVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fB7bdmOa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fB7bdmOa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D168C43390;
	Mon,  8 Apr 2024 22:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712616027;
	bh=Ypk+p7JTblVZhL7WFcLh32FcOCYQc6yJkAa8TdIQEeU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fB7bdmOaOztMEG1KJ+QfsuHJsrZIszcxeH9fr1P5L4nOx2CJgeiJMzDDqM+SBatp9
	 mUVoyp+dAaq+T6LmcCl1bkcYZ2+wWz3OX2A3FuUhLodFV8TNJDOfjujscuCZsKVMY5
	 gli5g/fHVDmV2ScgidHxndE00A1Yk7ujowW7zS84oe85xw3ebZszm8f5xna+scABlp
	 E3xua2HKb4Bkv8cdQwON1D5mhnu2fj+3IPBRlTBFsKSI28rLRh5+8CyVvwtQlsrTVG
	 KJXAknLyZbIPWZGodcW5hde9EuTQAI0LIQ9BtL401B19Hv0JwcBZJGWx6g3+gNlkHn
	 /diYjiTBzDs9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 448D3C54BD6;
	Mon,  8 Apr 2024 22:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] modem: remove atom entry prior to invoking the watch
 callback
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171261602727.14139.14203901120887736941.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 22:40:27 +0000
References: <20240408215710.2984399-1-denkenz@gmail.com>
In-Reply-To: <20240408215710.2984399-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon,  8 Apr 2024 16:56:56 -0500 you wrote:
> In __ofono_atom_free, the atom is removed from the list prior to
> invoking __ofono_atom_unregister.  This ensures that any invocation of
> __ofono_atom_find or __ofono_modem_find_atom() will fail to find the
> just-removed object when invoked from the atom watch.
> 
> The above does not hold in flush_atoms() implementation, which can lead
> to surprising results.  Make sure that the atom is removed from the
> modem's atom list prior to invoking __ofono_atom_unregister in all
> cases.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] modem: remove atom entry prior to invoking the watch callback
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=a4e8c26e4bfc
  - [v2,2/2] hfp_ag_bluez5: Fix use-after-free
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=18dcd90cf085

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


