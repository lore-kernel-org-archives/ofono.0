Content-Type: multipart/mixed; boundary="===============6403139764280164020=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2, 6/7] test: Add CDMA SMS Support
Date: Tue, 04 Jan 2011 15:25:15 -0600
Message-ID: <4D23903B.2030109@gmail.com>
In-Reply-To: <1292976149-15598-7-git-send-email-lei.2.yu@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6403139764280164020==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lei,

On 12/21/2010 06:02 PM, Lei Yu wrote:
> ---
>  Makefile.am         |    6 ++-
>  unit/test-cdmasms.c |  137 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 142 insertions(+), 1 deletions(-)
>  create mode 100644 unit/test-cdmasms.c
> =


This one looks fine but have you considered using g_test_add_data_func
instead of g_test_add_func?  That makes it much easier to add new tests...

Regards,
-Denis

--===============6403139764280164020==--

