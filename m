Content-Type: multipart/mixed; boundary="===============1412042203267068564=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] fix ppp protocol-reject constructing error
Date: Wed, 11 May 2011 13:34:27 -0500
Message-ID: <4DCAD6B3.5090701@gmail.com>
In-Reply-To: <1305101719-2913-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1412042203267068564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 05/11/2011 03:15 AM, Caiwen Zhang wrote:
> In PPP Protocol-Reject package the 'rejected data field' should be a copy
> of the rejected package, the copy starts from the data field. besides, =

> Protocol-Reject package include a 'rejected protocol field', it is the
> same as the protocol field of the rejected package.
> =

> Protocol-Reject package structure is:
> =

> 	| PPP_header | rejected protocol | rejected data
> =

> The rejected package structure is:
> 	| Addr | Control | protocol | data
> 	=

> So the Protocol-Reject package data field is copied from the 3rd byte of
> the rejected package.
> =

> ---
>  gatchat/ppp_cp.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============1412042203267068564==--

