Content-Type: multipart/mixed; boundary="===============3563989884122959448=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v2 4/4] test: add script to set credentials for cdma
 connection
Date: Thu, 21 Jul 2011 04:56:34 -0500
Message-ID: <4E27F7D2.7060802@gmail.com>
In-Reply-To: <1311223244-26904-5-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3563989884122959448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 07/20/2011 11:40 PM, Guillaume Zajac wrote:
> ---
>  test/create-cdma-credentials |   29 +++++++++++++++++++++++++++++
>  1 files changed, 29 insertions(+), 0 deletions(-)
>  create mode 100755 test/create-cdma-credentials

Can you rename this script to cdma-set-credentials?  I want to follow
our current convention and prefix all cdma related test scripts with cdma.

Also, you are forgetting Makefile.am changes here, the script should be
added to the relevant section in Makefile.am.

Regards,
-Denis

--===============3563989884122959448==--

