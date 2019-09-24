Content-Type: multipart/mixed; boundary="===============3298167016933130767=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] quectel: remove unused variable in quectel_pre_sim
Date: Tue, 24 Sep 2019 09:56:59 -0500
Message-ID: <78d3a1ca-2bb9-88b2-8ab8-95796920a451@gmail.com>
In-Reply-To: <20190924071514.6072-1-nicola.lunghi@jci.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3298167016933130767==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicola,

On 9/24/19 2:15 AM, Nicola Lunghi wrote:
> From: Nicola Lunghi <nick83ola@gmail.com>
> =

> This variable was left over by a previous commit and in gcc 9.1
> was throwing an error an error (unused variable)
> ---
>   plugins/quectel.c | 1 -
>   1 file changed, 1 deletion(-)
> =


Thanks for the patch.  I pushed the one from Richard since it was in my =

mailbox a bit earlier.

Regards,
-Denis

--===============3298167016933130767==--

