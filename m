Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26991DDC13
	for <ofono@lists.linux.dev>; Wed, 11 Dec 2024 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733941814; cv=none; b=tZRu8ikgW39GUzENItK0aGaFuLX4lHXQuHoN1eeFSkzj2gwenlWlsqjovT6SJ66UgRvxqQECnZtSL7cVSGrUl1G7FxaJ7x/482xKa1kwW/Z4gCYNdV3QHo8Fx7hkMLUilMJ85PtKPppDBhqUbdxnFdiHKMXgJVuCioY+u2VeFL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733941814; c=relaxed/simple;
	bh=Rtu2c/Q/ABuWJKNaXxeVd3cHD69xO+NE0UJ8OwK5E/k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RzSKQjLHobEehMuu73364eOnqikQUv5YxmcGoLZO00+fxMbGKpunY+/YAZxZrvTKNyGlsM0vDoPieGozimHEimMl4QYPrsICU5Tgpx1mrksWDklIU+ZPkVvZ0i7LXZ5NVFcnCZ4lb5ocFyjU/HPN213cIP7G7cu+em2ypCaxiwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0m/Da7D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0m/Da7D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384BBC4CED2;
	Wed, 11 Dec 2024 18:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733941814;
	bh=Rtu2c/Q/ABuWJKNaXxeVd3cHD69xO+NE0UJ8OwK5E/k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E0m/Da7DZJTRwhPxngqFj+oxgtu7T1i3PFVIE4jVnlBsfm07EgSz71S5yGHADo0ql
	 NOJlB1b7QULlaTWdkbdB9vbOjJLDdoVEd20xTugRHIWvD9jlnUL+z/eQHP+AdEPmMz
	 jhI62/Q8PMjZ1WSNis2WRyvhtCgn3TwVsTAnOiPdKexsL6nyVXJs/o+4PrwWPSh3NM
	 CsiXphlTiYVHNhhAqAomkJYX58kp8tHOz24QpcaSejdaTBYipNP9bdl7Gq4iYSlHkt
	 0VcRWMCDs0AT5Fc/p+ctrRYuJM8cXNFteDkApyOPSVxDwpB0lxvnziQMj9iKOT56bK
	 KQDIRx4JANgSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CA7380A962;
	Wed, 11 Dec 2024 18:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] qmi: gprs/lte: query for tethered default profile instead
 of embedded
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <173394183025.1671235.15591274444685761940.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 18:30:30 +0000
References: <20241211181514.504220-1-ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20241211181514.504220-1-ivo.g.dimitrov.75@gmail.com>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: ofono@lists.linux.dev, denkenz@gmail.com, absicsz@gmail.com,
 merlijn@wizzup.org

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Wed, 11 Dec 2024 20:15:14 +0200 you wrote:
> At least the modem in Motorola Droid 4 returns error if embedded 3gpp
> profile is queried, however, it does not error if tethered one is used.
> qmicli uses tethered when doing --wds-get-default-profile-number=3gpp
> ---
>  drivers/qmimodem/gprs.c | 2 +-
>  drivers/qmimodem/lte.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [v2] qmi: gprs/lte: query for tethered default profile instead of embedded
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=c3335c6e6935

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


