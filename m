Content-Type: multipart/mixed; boundary="===============5766300463281830406=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] stkutil: Move advance of ctlv to parse_dataobj
Date: Tue, 27 Apr 2010 09:36:21 -0500
Message-ID: <201004270936.22558.denkenz@gmail.com>
In-Reply-To: <1272361632-21352-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5766300463281830406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> Not all the proactive commands have comprehension tlv other than command
> details and device identities. So the appropriate code should be moved to
> parse_dataobj() from stk_command_new_from_pdu().
> ---
>  src/stkutil.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)

All 7 patches have been applied, thanks.  Can you make sure your commit =

headers are less than 50 characters long and your commit description is les=
s =

than 72 characters long?

Regards,
-Denis

--===============5766300463281830406==--

