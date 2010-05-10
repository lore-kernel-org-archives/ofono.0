Content-Type: multipart/mixed; boundary="===============5455179402613693307=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] Fix check data device before register the modem
Date: Mon, 10 May 2010 09:35:58 -0500
Message-ID: <201005100935.58206.denkenz@gmail.com>
In-Reply-To: <1273127293-4671-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5455179402613693307==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> To avoid the race condition that modem is registered before we retrieve
> the data device property.
> ---
>  plugins/udev.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============5455179402613693307==--

