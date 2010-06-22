Content-Type: multipart/mixed; boundary="===============5205208858242368753=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] bluetooth: Move functions from hfp.c to bluetooth.c
Date: Mon, 21 Jun 2010 22:56:35 -0500
Message-ID: <201006212256.35961.denkenz@gmail.com>
In-Reply-To: <1277023884-27143-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5205208858242368753==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

> The part that call device_properties_cb is commented to permit this patch
> compile.
> device_properties_cb() will be changed, so it will have separated patch.

I pushed the first 5 patches in this series.  Just some minor nagging, but =

please follow the 80 character per code line limit and the 50 character git =

commit header limit.

Regards,
-Denis

--===============5205208858242368753==--

