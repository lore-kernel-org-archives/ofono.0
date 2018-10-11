Content-Type: multipart/mixed; boundary="===============0260584579956452867=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sms:fix a missing entry in single shift table
Date: Thu, 11 Oct 2018 10:18:30 -0500
Message-ID: <3d99b888-b929-93ae-ce37-e3a5338b22cc@gmail.com>
In-Reply-To: <1539257012-19328-1-git-send-email-nandini.rebello@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0260584579956452867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nandini,

On 10/11/2018 06:23 AM, Nandini Rebello wrote:
> Fix a missing char in the nation language set in single shift table
> for a special character. Character set again validated.
> =

> Future language table to carry this fix.
> ---
>   src/util.c | 2 ++
>   1 file changed, 2 insertions(+)
> =


Applied, thanks.

You may want to add unit tests for each new alphabet you introduce into =

unit/test-sms.c.  I think we have some sanity checks in there for =

Spanish/etc alphabets already.

Regards,
-Denis

--===============0260584579956452867==--

