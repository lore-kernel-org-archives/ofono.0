Content-Type: multipart/mixed; boundary="===============6307233286937060842=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] gatmux: don't free cmux data until watchers are destroyed
Date: Thu, 26 Sep 2019 20:44:12 -0500
Message-ID: <faaeeed1-486a-61d6-7bac-f794c2389165@gmail.com>
In-Reply-To: <20190926211759.242770-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6307233286937060842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

<snip>

> My theory is this:
>   * The main loop has (at least) two pending sources:
>       1) a gatchat callback to e.g. a plugin CFUN=3D0 command
>       2) rx data ready on the cmux uart channel
>   * The main loop calls the plugin callback first, where g_at_mux_unref()
>     is called
>   * The main loop then calls the mux->read_watch callback, where the
>     (freed) cmux object is dereferrenced.

Hmm, I think it is a little simpler than that...?

You have data on CMUX that we process inside dispatch_sources.  This in =

fact calls into GAtIO and thus GAtChat.  GAtChat callback results in =

g_at_mux_unref which destroys the object.  But dispatch_sources is still =

running.

An easy fix would be to defer calling g_at_mux_unref until the next =

event loop iteration (e.g. via l_idle_oneshot).

Alternatively, taking a reference to g_at_mux at the beginning of =

received_data and dropping it at the end might also do the trick.

Regards,
-Denis

--===============6307233286937060842==--

