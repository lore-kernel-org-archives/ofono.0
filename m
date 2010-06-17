Content-Type: multipart/mixed; boundary="===============7958421812349569355=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/7] Move bluetooth utils from hfp.c to bluetooth.c
Date: Thu, 17 Jun 2010 05:36:25 -0500
Message-ID: <201006170536.25988.denkenz@gmail.com>
In-Reply-To: <1276538668-12755-4-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7958421812349569355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

> The new Bluetooth plugin will be responsible for handle DBus for the
> Bluetooth profiles implemented by oFono. Each Bluetooth profile can
> register callbacks to create a modem, remove all modems and set alias. The
> idea is to have here soon code the handle Bluetooth Agent stuff too.

Could you break this patch up some more? 500 insertions and 400 deletions a=
re =

really hard to follow.

Regards,
-Denis

--===============7958421812349569355==--

