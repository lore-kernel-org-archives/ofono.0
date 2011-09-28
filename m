Content-Type: multipart/mixed; boundary="===============4638512249812454758=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv7 3/3] plugins: Add provisioning plugin
Date: Tue, 27 Sep 2011 23:22:59 -0500
Message-ID: <4E82A123.9020408@gmail.com>
In-Reply-To: <1316778070-3862-4-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4638512249812454758==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 09/23/2011 06:41 AM, Oleg Zhurakivskyy wrote:
> ---
>  plugins/provision.c |  586 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 586 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/provision.c

Please don't copy paste the contents of plugins/mbpi.c.  The intent is
to just re-use that code, similar to how tools/lookup-apn.c works.  If
you want to make any improvements to plugins/mbpi.c, then submit a
separate patch against that file.

Regards,
-Denis

--===============4638512249812454758==--

