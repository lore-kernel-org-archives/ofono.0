Content-Type: multipart/mixed; boundary="===============5749384762094578629=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] mbpi: mbpi_lookup becomes mbpi_lookup_apn
Date: Mon, 14 Nov 2011 14:12:13 -0600
Message-ID: <4EC1761D.2020609@gmail.com>
In-Reply-To: <1321362255-11262-2-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5749384762094578629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 11/15/2011 07:04 AM, Philippe Nunes wrote:
> ---
>  plugins/mbpi.c      |   71 +++++++++++++++++++++++++--------------------=
------
>  plugins/mbpi.h      |    2 +-
>  plugins/provision.c |    2 +-
>  tools/lookup-apn.c  |    2 +-
>  4 files changed, 38 insertions(+), 39 deletions(-)
> =


Patch looks good to me and has been applied.  I did however split it up
into three commits, one for mbpi changes, one for provision updates and
one for look-apn updates.

Regards,
-Denis

--===============5749384762094578629==--

