Content-Type: multipart/mixed; boundary="===============1626987606195550273=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] plugins: Add allowed APN list
Date: Wed, 20 Apr 2016 10:07:24 -0500
Message-ID: <57179B2C.7060608@gmail.com>
In-Reply-To: <1461122890-7163-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1626987606195550273==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nishanth,

On 04/19/2016 10:28 PM, Nishanth V wrote:
> ---
>   Makefile.am                     |   9 +-
>   doc/allowed-apns-api.txt        |  17 +++
>   plugins/allowed-apns.c          | 272 +++++++++++++++++++++++++++++++++=
+++++++
>   src/simutil.c                   |   1 +
>   test/list-allowed-access-points |  25 ++++
>   5 files changed, 322 insertions(+), 2 deletions(-)
>   create mode 100644 doc/allowed-apns-api.txt
>   create mode 100644 plugins/allowed-apns.c
>   create mode 100755 test/list-allowed-access-points
>

Looks good, but please submit this as a series.  Remember our patch =

submission guidelines can be found in HACKING 'Submitting patches' section.

So:
- one patch for doc/allowed-apns-api.txt + makefile specific changes
- one patch for simutil.c changes
- one patch for the plugin + required makefile changes
- one patch for test script + required makefile makefile

Regards,
-Denis

--===============1626987606195550273==--

