Content-Type: multipart/mixed; boundary="===============8376234518363141335=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/6] ims: add implementation for IMS atom
Date: Mon, 09 Oct 2017 11:41:18 -0500
Message-ID: <e42ef78b-39d8-5076-f64d-f155ab301c4c@gmail.com>
In-Reply-To: <1507223703-13827-1-git-send-email-ankit.p.navik@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8376234518363141335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ankit,

On 10/05/2017 12:15 PM, Ankit Navik wrote:
> This implementation includes:
> * D-Bus interface
> * interaction with driver
> ---
>   Makefile.am |   2 +-
>   src/ims.c   | 389 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   src/ofono.h |   2 +
>   3 files changed, 392 insertions(+), 1 deletion(-)
>   create mode 100644 src/ims.c
> =


I applied this patch but reworked it slightly in 2 follow on commits. =

Please review and let me know if I screwed anything up.

Regards,
-Denis


--===============8376234518363141335==--

