Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DBC1DA53
	for <ofono@lists.linux.dev>; Thu, 30 May 2024 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717080031; cv=none; b=bjkfQnyic5kfm2zAExmGPrmcxNedMB8dhnKYGafVXo4+wPRIFSz+h/p/dxQ+XlsNGmHLmKDsToZgeaclQgagzPHkyOFh184Lh4IYDAJ61FtaBrVhiCGYrvFSBPS+BPrEghTF3xcHsdZSDVjxOA4QTFCOQAVEEMBojYCd9Wj4BRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717080031; c=relaxed/simple;
	bh=z9k+H54YcRkPDYHECokuCE9fJ4qdq6PAGxaWnmAcTqk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FLOgzQugVNrrqMWZpTrqWYi6DDtS09Gt+DmO/f1wV55W+fehDJmh+v75+pEL09TH4X36NV9NSws2aTpAWjb+EHvc+fBsRrIPXDiauxiLoJF1O4Q6DlNKn9XeOA4K+M8VjT2iJCOSETruNahWj9AZylzW3y0/bcAsgPjjLIMTtEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgCxB2UC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgCxB2UC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 280A6C32782;
	Thu, 30 May 2024 14:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717080030;
	bh=z9k+H54YcRkPDYHECokuCE9fJ4qdq6PAGxaWnmAcTqk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mgCxB2UCgIIEejbNafTSAqyNpGZjncuAxoENqJDfCuYqJ8SsQp6N1RbJKKsNNyy8A
	 V4aGbzaGBnFgK1K7W4+ea/f6rc1CUYz7GJCDq0wdDKGVIABuwoEj6iv/qGZURxfGZF
	 sn/bjgrAqGvyK5LXcOQ+1qR2lmlAINfEpQplny6/l1st2iRsbehCIh5uOmvMaRNyuj
	 yZO+GGLWG0QA34LsQ0LmhS7MABnCM+I0DQP+uJmlxEeVYVEtyqo5YqxunA3pj4MLGR
	 9vN+r9yoaXIUPSWEvummCWX0TT236kEy67COaxpx9x7V51PuqY6QEoGl33qdcJ5oxw
	 3v0Rp2jo/SKEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 171C1CF21F2;
	Thu, 30 May 2024 14:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] voicecall: Fix use after free
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171708003008.1136.15146630598600856328.git-patchwork-notify@kernel.org>
Date: Thu, 30 May 2024 14:40:30 +0000
References: <20240528220642.251435-1-denkenz@gmail.com>
In-Reply-To: <20240528220642.251435-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 28 May 2024 17:06:29 -0500 you wrote:
> On shutdown, if the sim atom is removed before the voicecall atom, the
> sim context is removed automatically.  However, voicecall atom does set
> sim_context to NULL in that case, resulting in the following valgrind
> report:
> 
> ==251105== Invalid read of size 8
> ==251105==    at 0x59B4F3: sim_fs_file_watch_remove (src/simfs.c:243)
> ==251105==    by 0x560E2A: ofono_sim_remove_file_watch (src/sim.c:2621)
> ==251105==    by 0x5412E3: unwatch_sim_ecc_numbers (src/voicecall.c:2820)
> ==251105==    by 0x53B8C8: voicecall_unregister (src/voicecall.c:2849)
> ==251105==    by 0x52B16B: __ofono_atom_unregister (src/modem.c:336)
> ==251105==    by 0x52E6E4: flush_atoms (src/modem.c:492)
> ==251105==    by 0x52C1BE: modem_change_state (src/modem.c:586)
> ==251105==    by 0x52E155: set_powered (src/modem.c:974)
> ==251105==    by 0x52E307: __ofono_modem_shutdown (src/modem.c:2279)
> ==251105==    by 0x5296B6: signal_handler (src/main.c:85)
> ==251105==    by 0x48FF198: ??? (in /usr/lib/libglib-2.0.so.0.8000.0)
> ==251105==    by 0x495E3BE: ??? (in /usr/lib/libglib-2.0.so.0.8000.0)
> ==251105==  Address 0x5baa6f8 is 8 bytes inside a block of size 16 free'd
> ==251105==    at 0x48458CF: free (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==251105==    by 0x59B2A1: sim_fs_context_free (src/simfs.c:213)
> ==251105==    by 0x59B133: sim_fs_free (src/simfs.c:123)
> ==251105==    by 0x5620EF: sim_remove (src/sim.c:3239)
> ==251105==    by 0x52E701: flush_atoms (src/modem.c:495)
> ==251105==    by 0x52C1BE: modem_change_state (src/modem.c:586)
> ==251105==    by 0x52E155: set_powered (src/modem.c:974)
> ==251105==    by 0x52E307: __ofono_modem_shutdown (src/modem.c:2279)
> ==251105==    by 0x5296B6: signal_handler (src/main.c:85)
> ==251105==    by 0x48FF198: ??? (in /usr/lib/libglib-2.0.so.0.8000.0)
> ==251105==    by 0x495E3BE: ??? (in /usr/lib/libglib-2.0.so.0.8000.0)
> ==251105==    by 0x48FFDC6: g_main_loop_run (in /usr/lib/libglib-2.0.so.0.8000.0)
> 
> [...]

Here is the summary with links:
  - voicecall: Fix use after free
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=da1e4440a17b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


