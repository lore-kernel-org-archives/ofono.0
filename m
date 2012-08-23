Content-Type: multipart/mixed; boundary="===============6947910397977993299=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sms: Add delay before submitting multiple SMS to modem
Date: Thu, 23 Aug 2012 08:48:33 -0500
Message-ID: <503634B1.90701@gmail.com>
In-Reply-To: <5035F205.8040008@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6947910397977993299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

<snip>

> Unfortunately I come to the conclusion that if I want to send one same
> SMS to 3/4/5/... recipients with an application using oFono middleware,
> I will not be able to send them through the same RRC channel, unless I
> queue them offline.
>

If such a feature is important, then you do have a point.  However, =

implementing _anything_ by introducing an arbitrary delay is simply =

wrong.  I believe they teach the reasons for that in Operating Systems =

101.  You are introducing a race condition that will break things at the =

most inopportune time.

If we really require multi-recipient SMS to go on the same RRC channel, =

then the best way to do so would be to introduce a new API specifically =

for this use case.

Regards,
-Denis

--===============6947910397977993299==--

