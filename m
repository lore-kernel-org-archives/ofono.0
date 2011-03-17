Content-Type: multipart/mixed; boundary="===============1247950639252437151=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/6] gathdlc: add mechanism to detect ppp suspension from
 DUN client.
Date: Thu, 17 Mar 2011 15:13:50 -0500
Message-ID: <4D826B7E.4020507@gmail.com>
In-Reply-To: <1300180743-27624-4-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1247950639252437151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 03/15/2011 04:19 AM, Guillaume Zajac wrote:
> ---
>  gatchat/gathdlc.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 58 insertions(+), 0 deletions(-)

http://en.wikipedia.org/wiki/Time_Independent_Escape_Sequence

If you really want to do this, then lets do this properly, including the
guard timeouts.

Regards,
-Denis

--===============1247950639252437151==--

