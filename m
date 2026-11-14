Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=136.144.136.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794636840;
	b=EeRXQwLquLrW7cGIrA9q7QZl18ZFZowKYXvqr7rTjv0PfWQOwjFMja5jJGeykGHbVeN1
	 zXfaXRFnz+HMBTXhBGUQHUHPB4WM24qpITgNu1cz7L3irkTksS8Xr83qw7Upt47UBATVI
	 XVOE2SHa6/K7b7EfS0/pZxsQJQCuq3zcMCqzEibCPLIxlpfApi7zUBOfcJIKaUKtIvJI6
	 hy3s4vpxzngvaPrv40EO18O9EP/yJC4y2MUcvyCz8bNwdm0oqDjcDk5QOnc9b/QMBijKg
	 2hGy+ZpBC75/Igi8qQPT+IFFgOi4sxeXn19ofStxqQDM8rWu6F7aRLGmH4xrYnBVFzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794636840;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By:DKIM-Signature:
	 X-Report-Abuse-To;
	bh=KFawyh3puK1PJ3KuCeM4CqQSHVvwsHWHPegk5kaTRPg=;
	b=BWak8nfBEIGNyzzitsBnQ58h17QEsgBNNOZG7somDG8m+UCqrVf6+ZRvtl1PmLDgEELX
	 S5Y24eDej0sCt1Yc1OW70caabKjjsMYfUNdGrlpkJquTNXz5T3KyvHb7G1M5UlzjOb5GI
	 wK/Vn2QZ65UKN6eGsfQR6kTCj/waM5xJT2zCsbm00oRNILRvFA5uMqJkPPtmvKyDHl5yB
	 KKgPadO9gCdzADP2Hvr7E8UK2Aa3tW/8XdIERJ2EviQL8sGzFrShgpgeKUmGxjQEStbZ7
	 QT6iojGPyCUADJFZSmrXUKKlEWDENjbqpFopqHstWRAVGEWutE2BjsmaQloz98MnZTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=herrie.org;
	spf=pass smtp.mailfrom=herrie.org;
	arc=none smtp.remote-ip=136.144.136.12
Received: from outbound3.mail.transip.nl (outbound3.mail.transip.nl [136.144.136.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0B9606A329
	for <ofono@lists.linux.dev>; Sat, 14 Nov 2026 06:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D0B9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Received: from submission15.mail.transip.nl (unknown [10.103.8.166])
	by outbound3.mail.transip.nl (Postfix) with ESMTP id 4jRP2k2bjzzDTnj
	for <ofono@lists.linux.dev>; Sat, 14 Nov 2026 07:13:50 +0100 (CET)
Received: from herrie-desktop (150-83-201-31.ftth.glasoperator.nl [31.201.83.150])
	by submission15.mail.transip.nl (Postfix) with ESMTPA id 4jRP2j61nNz3R3nyh;
	Sat, 14 Nov 2026 07:13:49 +0100 (CET)
From: Herman van Hazendonk <github.com@herrie.org>
To: Andres Salomon <dilinger@queued.net>
Cc: ofono@lists.linux.dev,
	Marcel Holtmann <marcel@holtmann.org>,
	Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] phonesim: fix exporting of child widgets to javascript engine
Date: Sat, 14 Nov 2026 07:13:49 +0100
Message-ID: <20261114061349.4151603-1-github.com@herrie.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20251229031053.1441ddc6@5400>
References: <20251229031053.1441ddc6@5400>
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Post: <mailto:ofono@lists.linux.dev>
List-Help: <mailto:ofono+help@lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
List-Owner: <mailto:ofono+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission15.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1794636830; h=from:subject:to:cc:
 references:in-reply-to:date:mime-version;
 bh=KFawyh3puK1PJ3KuCeM4CqQSHVvwsHWHPegk5kaTRPg=;
 b=RV4WdqgTsNPPiLhuOC317r6w89U8Ijl42h0yDsqKi0rO1J9URElrUvsLLYYbf6Uieiht9r
 U+kD6/UzPFn6n5Bkv2BKRsVXgk4+Z/rr7kbpLRw8j0hLw61dgt6STYuLMXGb4Q8TLQeds0
 phHi1BJ24IFyhrwv6RuGtmTXDOrFy8JXkL1eFCjHxD+27RAg4C3gI2Zh80PPtm2FdP/pOP
 /WtGxsU7hXb80rwmlg0kM3bdZF36W0vb88PWw5xyk3xUou5PX3ga3qL6YvGO4yZ2IZpoLH
 qmwi2qEq8n7pycLoqZe1ANZyELcndaQo5eo4EhwJp6OdMz4AdEKLXd/XRzuGXQ==
X-Report-Abuse-To: abuse@transip.nl

Hi Andres,

On Mon, 29 Dec 2025 03:10:53 -0500, Andres Salomon wrote:
> Using the example sms.js script in doc/scriptable.txt, the following
> error occurs with phonesim built using Qt5.15:
>
> Error org.ofono.phonesim.Error.ScriptExecError: /tmp/sms.js, line 1, TypeError: Cannot read property 'leMessageSender' of undefined

We hit the same thing in LuneOS and carry a fix of our own, so I gave
yours a run.  On current master with Qt 5.15, the call.js and sms.js
examples from doc/scriptable.txt fail exactly as you describe.  With
your patch both work: call.js produces +CRING/+CLIP for 12345 on the
AT side, sms.js a +CMTI, and a script reading
tabCall.gbIncomingCall.leCaller.text gets the number back.

> I'm not sure if this is related to behavior changes in current versions
> of QJSEngine/UIC or what

It goes back to 04e66fd ("Replace QtScript with QtQml").  QtScript made
every named child of an exported QObject a property of it; QJSEngine
only exposes properties, slots and invokables, so the scripts lost
their path to the widgets with that commit.

> +    QList<QWidget*> kids = parentW->findChildren<QWidget*>(QString(),
> +            Qt::FindDirectChildrenOnly);
> +    foreach (QWidget *w, kids) {

One request: could this be a range-based for?  phonesim was ported
away from Q_FOREACH in a2bb630, and builds that define QT_NO_FOREACH
(our CMake/Qt 6 build does) fail here with "expected primary-expression
before '*' token".  Something like

	const QList<QWidget *> kids = parentW->findChildren<QWidget *>(
			QString(), Qt::FindDirectChildrenOnly);
	for (QWidget *w : kids) {

builds cleanly with Qt 6 for armv7, aarch64 and x86-64 here.

Two smaller things you may or may not want to pick up; ours does both:

 - widgets without an objectName (and Qt's own qt_* children, such as
   the viewport of a QTextEdit) still get exported, as a property with
   an empty or internal name;

 - a child whose name matches a real property of its parent would
   replace that property.  Nothing in controlbase.ui collides today,
   so this is only defensive.

Thanks for chasing this.

Herman

(The testing and this review were done with the help of Claude, an AI
assistant.)
