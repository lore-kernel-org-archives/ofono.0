Content-Type: multipart/mixed; boundary="===============8515000674006289078=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Allow override of phonesim conf
Date: Wed, 26 Mar 2014 10:49:06 -0500
Message-ID: <5332F6F2.5090507@gmail.com>
In-Reply-To: <5332B979.1010604@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8515000674006289078==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

On 03/26/2014 06:26 AM, Jussi Pakkanen wrote:
> Hi
> =

> Currently phonesim tries to open its conf file from the location
> specified at configure time (/etc/ofono/phonesim.conf). For testing
> purposes it would be nice to be able to override this. This patch allows
> you to override the location with the environment variable
> OFONO_PHONESIM_CONFIG.

Can you please use git send-email to submit patches.

Also, the coding style in the patch is incorrect.  Please review
doc/coding-style.txt and the kernel coding style guidelines.
Specifically the use of {} in if/else statements.

Regards,
-Denis


--===============8515000674006289078==--

