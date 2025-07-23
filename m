Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA132F234A
	for <ofono@lists.linux.dev>; Wed, 23 Jul 2025 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753280989; cv=none; b=G93rT4t057XImH9lUb17XRaGFcivXBFz6cSoORFrsCXB9OkuoW+WPVt8HfFprKzOgavkYgjUwzOYEfzO6Vwt8lJQeQ6jtf2BeTApeuk7UPV/XgVbUJEq7CGR/f8dcg7PVRfjPhAEbTiob2kJmLDuCyIWq8E0fp8K70tlx1c2GH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753280989; c=relaxed/simple;
	bh=zsJj6AKiXxlNw+i05qIbg92PYw/rvILltyXkHZrl1AI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uIjKA1IG1k0O4c85o71pK+NQmIgiUFvmm4BKcRVIpDLGxw4S8AzQyFIamF6L6dkiJyfvK1cySOU1XwvlJRZbYwuj4xDY1UOgyksmbsiDZn7CXcKSK31Dl+UmBKGPDuVAtg6piEeHhDeMlRyI9MwO9VN+NKbdboDH39TkKfEs8T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQjWAxdj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQjWAxdj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424A2C4CEEF;
	Wed, 23 Jul 2025 14:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753280989;
	bh=zsJj6AKiXxlNw+i05qIbg92PYw/rvILltyXkHZrl1AI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pQjWAxdjniiezYl7W1PmlYPy2J92ji83BIqpTrCl7lLbH83Y0jNW4iQuxvO5q15K2
	 wAGthS2lryuXtAMXt8N1d4rUpkGkf9tEfWw2/cJH02xKm905/hVChzs8RGzV3EXqgB
	 CgK2lNZMppbk1IQqJ1VwAeC2kCVs+SiZY+EcW0Wd6ysRGWU7NUSs0bgtH2fX6N941V
	 LJHOZNUx5ghakEvEABtBrYCghUc5g0hr+z0BJDbMN7kxZxyfs5xI9RgPLNsA/5UKmW
	 lPbXh29Z6RAofZ6VP0ntr76dosPOMZeBHPcoMPbNGlw8JHS3U78EZ90t+Pqioop5SC
	 NTC0DUNVlb29A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEB6C383BF4E;
	Wed, 23 Jul 2025 14:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qmi: sms: Change SMS storage type to UIM
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <175328100724.1586996.18127506340973290118.git-patchwork-notify@kernel.org>
Date: Wed, 23 Jul 2025 14:30:07 +0000
References: <20250723060332.560825-1-ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20250723060332.560825-1-ivo.g.dimitrov.75@gmail.com>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: ofono@lists.linux.dev, denkenz@gmail.com, absicsz@gmail.com,
 merlijn@wizzup.org

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Wed, 23 Jul 2025 09:03:32 +0300 you wrote:
> In theory, a SIM card can be moved to another device before a particular
> message in NV is read and then moved back. That might lead to that message
> being received twice.
> 
> Also, some modems (like MDM6600 found in Motorola Droid4), cannot store
> incoming class 4 messages in NV, only in UIM.
> 
> [...]

Here is the summary with links:
  - qmi: sms: Change SMS storage type to UIM
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=d5066b090ded

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


