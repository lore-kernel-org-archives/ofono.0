Content-Type: multipart/mixed; boundary="===============6226072397157752874=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sms: add support for 2 regional languages
Date: Mon, 01 Oct 2018 14:57:07 -0500
Message-ID: <b2afd78b-c031-2b2d-0a95-7b5454334d8a@gmail.com>
In-Reply-To: <1538388176-12699-1-git-send-email-nandini.rebello@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6226072397157752874==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 10/01/2018 05:02 AM, Nandini Rebello wrote:
> Adding support for bengali and gujrati for GSM 7 bit. More 8 to
> follow soon. Adding script to set the sms alphabet.
> ---
>   doc/messagemanager-api.txt |   2 +
>   src/sms.c                  |   8 +
>   src/smsutil.c              |   4 +-
>   src/smsutil.h              |   2 +
>   src/util.c                 | 454 ++++++++++++++++++++++++++++++++++++++=
++++++-
>   src/util.h                 |   2 +
>   test/set-sms-alphabet      |  25 +++
>   7 files changed, 493 insertions(+), 4 deletions(-)
>   create mode 100644 test/set-sms-alphabet
> =


I went ahead and applied this patch after splitting it into 4 commits =

per our 'Patch Submission' guidelines.  Please do this on your end in =

the future :)

You're also now in AUTHORS.

Regards,
-Denis

--===============6226072397157752874==--

