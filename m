Content-Type: multipart/mixed; boundary="===============2095936574612697488=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofonod crash on Ericsson F5521GW
Date: Tue, 31 May 2011 11:43:41 -0500
Message-ID: <4DE51ABD.3020508@gmail.com>
In-Reply-To: <D5AB6E638E5A3E4B8F4406B113A5A19A5262CD33@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2095936574612697488==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dongxiao,

>>
>> I suggest you try the latest release of oFono, 0.43 is pretty old.
>> Judging by your log this issue should be fixed in later versions.  If yo=
u still
>> encounter the problem, please post a proper backtrace.  Either by using =
gdb or
>> running the backtrace through test/backtrace script.
> =

> Latest ofono-0.48 also has the same problem. Here I attached a more detai=
led crash log.
> =


At least the GError warning should be fixed by commit d99ca17.  If you
have other crashes, please report back.  You still need to provide a
proper gdb trace or run the log through the test/backtrace script.

Regards,
-Denis

--===============2095936574612697488==--

