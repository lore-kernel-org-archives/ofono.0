Content-Type: multipart/mixed; boundary="===============5790603492567206369=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gril: avoid glib runtime warning
Date: Tue, 17 May 2016 09:47:01 -0500
Message-ID: <573B2EE5.8030901@gmail.com>
In-Reply-To: <1463448279-20873-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5790603492567206369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 05/16/2016 08:24 PM, caiwen.zhang(a)intel.com wrote:
> From: Caiwen Zhang <caiwen.zhang@intel.com>
>
> gril may be destroyed in the request callback (e.g in the callback of
> set modem power off request). 'out_queue' and 'command_queue' is NULL.
> there will be glib runtime warning if use them.
> ---
>   gril/gril.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>

Applied, thanks.

Regards,
-Denis


--===============5790603492567206369==--

