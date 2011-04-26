Content-Type: multipart/mixed; boundary="===============9161136406305408757=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] Fix ofonod crash issue
Date: Tue, 26 Apr 2011 14:53:13 -0500
Message-ID: <4DB722A9.4030605@gmail.com>
In-Reply-To: <1303808863-831-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9161136406305408757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 04/26/2011 04:07 AM, martin.xu(a)intel.com wrote:
> From: Martin Xu <martin.xu@intel.com>
> =

> In case of offline modem when GPRS data connection is connected, if gprs
> atom is removed before PPP termination process is complete, the terminate=
_timer
> will not be stop. It will cause ofonod crash when the timer time out.
> ---
>  gatchat/ppp_cp.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> =


I fixed up the commit message slightly and applied this patch.  Thanks
for that.

Regards,
-Denis

--===============9161136406305408757==--

