Content-Type: multipart/mixed; boundary="===============0620136162431777817=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] stk: Add busy error for the display text command
Date: Tue, 30 Nov 2010 08:22:50 -0600
Message-ID: <4CF508BA.8010809@gmail.com>
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D4018813547DA8B@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0620136162431777817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 11/30/2010 07:21 AM, Lucas, GuillaumeX wrote:
> From: Guillaume Lucas <guillaumex.lucas@intel.com>
> =

> According to the sequence 1.2 of the ETSI TS 102 384 a busy
> screen error should be returns for the display text proactive
> command when the ME is not able to display the text.
> ---
>  doc/stk-api.txt |    1 +
>  src/stk.c       |   15 +++++++++++++++
>  src/stkagent.c  |   12 ++++++++++--
>  src/stkagent.h  |    1 +
>  4 files changed, 27 insertions(+), 2 deletions(-)
> =


Patch has been applied, however I fixed one minor booboo for you:

Applying: stk: Add busy error for the display text command
/home/denkenz/ofono-master/.git/rebase-apply/patch:113: trailing whitespace.
			ALLOWED_ERROR_GO_BACK | ALLOWED_ERROR_TERMINATE |
fatal: 1 line adds whitespace errors.
Patch failed at 0001 stk: Add busy error for the display text command

Regards,
-Denis

--===============0620136162431777817==--

