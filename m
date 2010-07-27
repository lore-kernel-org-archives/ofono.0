Content-Type: multipart/mixed; boundary="===============6916591769091598828=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH] Fix busylooped in ppp_disconnect for huawei modem
Date: Tue, 27 Jul 2010 22:39:30 +0300
Message-ID: <87tynkk93h.fsf@potku.valot.fi>
In-Reply-To: <33AB447FBD802F4E932063B962385B3528AA1DA4@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6916591769091598828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

"Zhang, Zhenhua" <zhenhua.zhang@intel.com> writes:

> Hi Kalle,

Hi Zhenhua,

> Could you try my fix for this busy loop issue? It is not perfect but
> at least work for me.

I noticed you sent v2. I'm testing that right now and will send the
results as a reply to that mail.

> Btw, I still meet the kernel warning or even Ubuntu crash after
> activate/deactivate gprs context multiple times on E1552. Do you see
> such problem? the kernel dmesg is attached for reference.

I have had lots of disconnect issues, but they have been always in
ofono. I don't recall seeing a single kernel issue during the last three
months I have been testing my Huawei E1552.

-- =

Kalle Valo

--===============6916591769091598828==--

