Content-Type: multipart/mixed; boundary="===============1678878393014404279=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] bluez5: Add role parameter to bt_register_profile
Date: Fri, 01 Mar 2013 13:42:58 -0600
Message-ID: <513104C2.2090500@gmail.com>
In-Reply-To: <1362002040-6723-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1678878393014404279==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paulo,

On 02/27/2013 03:54 PM, Paulo Borges wrote:
> This commit allows asymmetric profiles that do not have UUIDs
> available to uniquely identify each role specify which role is
> been registered.
> ---
>   plugins/bluez5.c |    5 ++++-
>   plugins/bluez5.h |    2 +-
>   2 files changed, 5 insertions(+), 2 deletions(-)
>

Which profiles actually need this?  If this is an extreme minority, then =

I'd rather see a dedicated function for this.  e.g.

bt_register_profile_with_role()

Regards,
-Denis

--===============1678878393014404279==--

