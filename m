Content-Type: multipart/mixed; boundary="===============4473592528980937388=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Fix huawei_disconnect function issue
Date: Tue, 15 Mar 2011 13:57:00 -0500
Message-ID: <4D7FB67C.8010608@gmail.com>
In-Reply-To: <1299648442-30541-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4473592528980937388==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 03/08/2011 11:27 PM, martin.xu(a)intel.com wrote:
> From: Martin Xu <martin.xu@intel.com>
> =

> huawei_disconnect is used to recovery the io and gprs context when
> io error happends, see commit 39382730d7758b093ca6271f4e9dea875fa04b3a
> However, io error not only happends at PPP disconnect, in theory it
> can happends at any situation. I also observed that it happens when modem
> go into offline mode at my Huawei EM770W modem. in this case, gprs should
> not be reopened.
> ---
>  plugins/huawei.c |   50 ++++++++++++++++++++++++++++++++++++------------=
--
>  1 files changed, 36 insertions(+), 14 deletions(-)
> =


I applied this patch but reworked it afterwards.  Can you test it and
make sure I didn't screw something up?

Regards,
-Denis

--===============4473592528980937388==--

