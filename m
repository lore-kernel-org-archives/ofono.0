Content-Type: multipart/mixed; boundary="===============4240607906466113920=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] stk: fix issue to avoid null pointer for alpha_id
Date: Fri, 10 Dec 2010 11:18:37 -0600
Message-ID: <4D0260ED.2080301@gmail.com>
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D40188136D95EB8@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4240607906466113920==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 12/08/2010 06:33 AM, Lucas, GuillaumeX wrote:
> From: Guillaume Lucas <guillaumex.lucas@intel.com>
> =

> If a SET UP CALL proactive command with no alpha identifier
> occurs, the alpha_id pointer will be set to NULL. This will
> generate a crash in the stkagent with dbus function. To avoid
> this we use an empty string if the alpha identifier is not
> present in the command.
> ---
>  src/stk.c |   13 ++++++-------
>  1 files changed, 6 insertions(+), 7 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============4240607906466113920==--

