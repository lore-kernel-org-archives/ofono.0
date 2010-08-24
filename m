Content-Type: multipart/mixed; boundary="===============8724839778233117446=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/4] Support text mode sms sending and receiving
Date: Tue, 24 Aug 2010 10:59:02 +0200
Message-ID: <1282640342.6841.13.camel@localhost.localdomain>
In-Reply-To: <1282631659-15840-1-git-send-email-yong.su@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8724839778233117446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yong,

>  gatchat/gatchat.c |  236 +++++++++++++++++++++++++++++++++++++++++++++++=
+++---
>  1 files changed, 224 insertions(+), 12 deletions(-)

<snip>

> +			/* Read expect message length
> +			 * If length is -1, use original solution
> +			 */
> +			if(notify->expect_msglen_func){
> +				int len =3D notify->expect_msglen_func(line);
> +				chat->syntax->expect_msg_len =3D len;
> +			}else{
> +				chat->syntax->expect_msg_len =3D -1;
> +			}
> +

the golden rule is to follow the coding style of the project. So no
matter what, get the coding style fixed first. We are pretty picky in
enforcing the same coding style through the whole project. Every now and
then we might overlook something, but I think that rate is less than 1%
actually.

Enforcing the coding style is a necessity to keep the project
maintainable and ensure its stability.

Regards

Marcel



--===============8724839778233117446==--

