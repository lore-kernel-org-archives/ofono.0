Content-Type: multipart/mixed; boundary="===============3088652429852005396=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Add init phonesim stk support
Date: Thu, 08 Jul 2010 15:10:44 -0500
Message-ID: <4C3630C4.1090409@gmail.com>
In-Reply-To: <1278586608-6246-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3088652429852005396==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On 07/08/2010 05:56 AM, Yang Gu wrote:
> ---
>  Makefile.am                           |   28 ++--
>  drivers/phonesimmodem/phonesimmodem.c |   48 +++++
>  drivers/phonesimmodem/phonesimmodem.h |   26 +++
>  drivers/phonesimmodem/stk.c           |  316 +++++++++++++++++++++++++++=
++++++
>  plugins/phonesim.c                    |    2 +-

Another thought just occurred here, instead of duplicating all this work
inside phonesimmodem, lets just have a separate function inside
sim-poll.c that will listen to the phonesim specific notification.  E.g.
instead of atmodem_poll_enable have something like phonesim_poll_enable.

Regards,
-Denis

--===============3088652429852005396==--

