Content-Type: multipart/mixed; boundary="===============2334652349969843562=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Teach USSD to recognise password change strings.
Date: Thu, 18 Jun 2009 17:02:08 -0500
Message-ID: <200906181702.08361.denkenz@gmail.com>
In-Reply-To: <1245297863-15310-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2334652349969843562==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wednesday 17 June 2009 23:04:23 Andrzej Zaborowski wrote:
> This is slightly hacky, part of ussd.c responsible for registering servic=
es
> is duplicated and parse_ss_control_string is modified to accept a fourth
> SI fragment in the input string.

Patch has been applied, along with fixes to two minor logic flaws.

Regards,
-Denis

--===============2334652349969843562==--

