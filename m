Content-Type: multipart/mixed; boundary="===============6925853197246412411=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] gprs: added two authentication methods: NONE and ANY
Date: Thu, 20 Sep 2018 10:27:08 -0500
Message-ID: <ca7c3785-5855-0942-a464-ebc40cae2a47@gmail.com>
In-Reply-To: <1537417430-10904-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6925853197246412411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 09/19/2018 11:23 PM, Giacinto Cifelli wrote:
> OFONO_GPRS_AUTH_METHOD_NONE disables the authentication
> OFONO_GPRS_AUTH_METHOD_ANY tries first CHAP then PAP,
> but only applies to supporting drivers and modules

No, we're not supporting METHOD_ANY for the reasons outlined already. =

Pretty much all of our drivers cannot handle this and settings are =

expected to work across devices.  So if I plug modem from manufacturer =

A, provision a context, connect.  Disconnect modem A, then connect modem =

from manufacturer B, things should still work seamlessly.

> ---
>   include/gprs-context.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> =


Regards,
-Denis

--===============6925853197246412411==--

