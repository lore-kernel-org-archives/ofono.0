Content-Type: multipart/mixed; boundary="===============8933103337432780369=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] emulator: add dialing support
Date: Fri, 18 Feb 2011 13:22:00 -0600
Message-ID: <4D5EC6D8.3030908@gmail.com>
In-Reply-To: <1298050054-30702-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8933103337432780369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On 02/18/2011 11:27 AM, Gustavo F. Padovan wrote:
> It handles client ATD*99# request and then initiate the PPP negotiation.
> IP forward through the new ppp interface is not done yet.
> =

> Initially based on patches from Zhenhua Zhang <zhenhua.zhang@intel.com>
> ---
>  src/emulator.c |  121 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 121 insertions(+), 0 deletions(-)
> =


Patch has been applied.  You had one minor whitespace issue (mixing tab
& spaces) which I had to amend.  Lets get this tested and stabilized,
particularly the socket disconnection conditions while in PPP.

Regards,
-Denis

--===============8933103337432780369==--

