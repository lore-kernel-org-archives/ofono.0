Content-Type: multipart/mixed; boundary="===============4180519729625587469=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] common: fix buffer length in phone_number_to_string
Date: Wed, 23 Mar 2011 15:03:59 -0500
Message-ID: <4D8A522F.9000007@gmail.com>
In-Reply-To: <1300900595-32375-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4180519729625587469==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 03/23/2011 12:16 PM, Fr=C3=A9d=C3=A9ric Danis wrote:
> update buffer length related to OFONO_MAX_PHONE_NUMBER_LENGTH change
> 78c1e96bf9601b5e5d31d04413baa1265a1c284f
> ---
>  src/common.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> =


Nice catch.  Patch has been applied, thanks.

Regards,
-Denis

--===============4180519729625587469==--

