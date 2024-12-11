Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4960D6136
	for <ofono@lists.linux.dev>; Wed, 11 Dec 2024 05:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733895616; cv=none; b=bT0mziYzFdozEIREgrGTFBP6EGwAHB0XXbU6eHCDuHbFJUAOckgmXbhJx9rGO/Jzn9Zb/Msn0P3wYcuc+V/chQzHEqGaUcUpzziOJ2tPeoGC0Xdfuwt0/XKJzEe0mlTRw1uhmxotd9tg/N8V/L/qAPskUGod/wSmULuOQ1UR4Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733895616; c=relaxed/simple;
	bh=YxWMCuJM4PW1vtgwyDwbV9NKOxqiSZI/wSb1L9QsGWk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CKz9bb9WpnPFCnSFBodkGm6ZXpIWVtIuuXtOO8B18D2uO4FaNZbOgM8YtgbzVnFfSVJPDq/qRlJ4eRTjHdKV/bb98s8kh4F/3Y2ZrKM6dCKRpk7728B3JnkpqRQVdJl+kkohOKC/5376Pt1eyFMVJPoGOusXb5u7um3nWBkpogE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mjc/LDo1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mjc/LDo1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0ABFC4CED2;
	Wed, 11 Dec 2024 05:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733895615;
	bh=YxWMCuJM4PW1vtgwyDwbV9NKOxqiSZI/wSb1L9QsGWk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Mjc/LDo1nH40Urj1fJVohhS+XMes2TdRsvLxBtX9d5NfvaFtpUATPoAXtI1xfhMah
	 iW9wtmoLwb6HbaOpg/sGUqznXeAFv3XIgxZZ041O11+KcyjjbqMJrtTn0MzeblfWTA
	 XOxSzn31TxHjpIx49HRc3pP8vWgl7EiFXiD/Gbh1byNpg/6qOy7/HdSdfIUb7GrvyR
	 rYMUzJo2qoX/MMxcw9UzDFbrqvWvmFxyrUHhV9T/JqS9AQWwi38wkk+zaXz+J9AAiw
	 KxtlJiYAJbD4xch3+xmMa5De/qZEmg9NA+OVsEBfqJl89cQImVJ5ZIsvX0rkbqzl+B
	 yoNiFMLb+u9CA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF1E380A962;
	Wed, 11 Dec 2024 05:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qmi: netreg: Fix RAT detection
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <173389563176.1447839.5904538361646071656.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 05:40:31 +0000
References: <20241208114934.252012-1-ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20241208114934.252012-1-ivo.g.dimitrov.75@gmail.com>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: ofono@lists.linux.dev, denkenz@gmail.com, absicsz@gmail.com,
 merlijn@wizzup.org

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Sun,  8 Dec 2024 13:49:34 +0200 you wrote:
> It is not clear why extract_ss_info is looping over all ss->radio_if_count
> interfaces, given that the result of that loops is that it always gets the
> last RAT. However, if there is more than one active interface, like:
> 
> qmicli  -d  /dev/cdc-wdm1 --nas-get-serving-system
> [/dev/cdc-wdm1] Successfully got serving system:
> 	Registration state: 'registered'
> 	CS: 'attached'
> 	PS: 'detached'
> 	Selected network: '3gpp'
> 	Radio interfaces: '2'
> 		[0]: 'umts'
> 		[1]: 'cdma-1xevdo'
> ...
> 
> [...]

Here is the summary with links:
  - qmi: netreg: Fix RAT detection
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=2f6f9dd21b74

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


