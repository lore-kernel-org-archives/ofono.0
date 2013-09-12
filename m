Content-Type: multipart/mixed; boundary="===============0439830249470614669=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] fix ofonod crash when pin is blocked
Date: Thu, 12 Sep 2013 08:28:48 -0500
Message-ID: <5231C190.4070302@gmail.com>
In-Reply-To: <DA62CA5DDF4CA640AA25B1684E5D141101D85F2F@SHSMSX102.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0439830249470614669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

 >>
>> What is the real reason why the watchlist is NULL at the point in time t=
his
>> function is being called?
>
> Yes, you are right. The correct comment should be "If at that time, "spn_=
watch" has been removed ofonod will crash due to
> "sim->spn_watches" is NULL."
>

Then please fix the patch description

> "spn_watch" is removed at "sim_free_main_state" function when SIM PIN is =
blocked. This is done before gprs/network atom is removed.
>

Then please fix the underlying issue itself.  Would signaling LOCKED_OUT =

state first before freeing the main state do the trick?


> About network registration status watch, the original comment is true.

Please elaborate.

Regards,
-Denis

--===============0439830249470614669==--

