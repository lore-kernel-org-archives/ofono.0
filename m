Content-Type: multipart/mixed; boundary="===============1690817588219051047=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3 v2] bluetooth: fix not removing data when
 devices/adapters are removed
Date: Tue, 05 Jul 2011 21:12:45 -0500
Message-ID: <4E13C49D.8070400@gmail.com>
In-Reply-To: <1309764736-26327-1-git-send-email-luiz.dentz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1690817588219051047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On 07/04/2011 02:32 AM, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> =

> If an adapter or device is removed any data associate should be removed,
> otherwise the next time they appear/are created the drivers may not
> asssociate again.
> ---
>  plugins/bluetooth.c |   79 ++++++++++++++++++++++++++++++++++++---------=
-----
>  plugins/bluetooth.h |    4 +-
>  plugins/hfp_hf.c    |   30 ++++++++++++-------
>  3 files changed, 78 insertions(+), 35 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============1690817588219051047==--

