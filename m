Content-Type: multipart/mixed; boundary="===============4855893889553902267=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv6 3/3] Mobile broadband provider info plugin
Date: Thu, 08 Sep 2011 23:58:35 -0500
Message-ID: <4E699CFB.7090500@gmail.com>
In-Reply-To: <1316006204-11390-4-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4855893889553902267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 09/14/2011 08:16 AM, Oleg Zhurakivskyy wrote:
> ---
>  plugins/mobile-broadband-provider-info.c |  804 ++++++++++++++++++++++++=
++++++
>  1 files changed, 804 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/mobile-broadband-provider-info.c
> =


After reviewing this patch I got the impression that you were still
making things just way too complicated and not taking full advantage of
the push/pop semantics.  So just for fun I wrote my own version in
plugins/mbpi.[ch] and reworked tools/lookup-apn to use that.  The code
seems to be valgrind clean and can handle duplicate detection, bail out
early, etc.

Can you please take a look and suggest improvements?  Once you think it
is good enough, I'd like you to rewrite this patch series to utilize
mbpi.c parser.

Regards,
-Denis

--===============4855893889553902267==--

