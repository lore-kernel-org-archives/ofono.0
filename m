Content-Type: multipart/mixed; boundary="===============0092858287758161877=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Add CDMA voice call answering support
Date: Mon, 15 Aug 2011 00:58:39 -0500
Message-ID: <4E48B58F.1090502@gmail.com>
In-Reply-To: <1313140749-28926-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0092858287758161877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 08/12/2011 04:19 AM, Caiwen Zhang wrote:
> ---
>  include/cdma-voicecall.h |    3 +++
>  src/cdma-voicecall.c     |   23 +++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 0 deletions(-)

I applied this patch, however I broke it up into two:
06d45196a8f1e3617c529f9b008d4fa67f84aa92 and
e2be184afbd88cac07e086f5d9ae07133077ae95

In the future please structure your commits such that any new public API
additions (e.g. inside include/) are in a separate commit.

Regards,
-Denis

--===============0092858287758161877==--

