Content-Type: multipart/mixed; boundary="===============9133293432162479231=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] location-reporting: don't add client-exit watch too
 early
Date: Tue, 01 Mar 2011 15:50:03 -0600
Message-ID: <4D6D6A0B.8000504@gmail.com>
In-Reply-To: <1298900634-2337-2-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9133293432162479231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 02/28/2011 07:43 AM, Lucas De Marchi wrote:
> Wait until driver gives us a file descriptor to start watching for
> client exit. This fixes a race when client exits before the driver
> calls location_reporting_enable_cb().
> ---
>  src/location-reporting.c |   10 ++++------
>  1 files changed, 4 insertions(+), 6 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============9133293432162479231==--

