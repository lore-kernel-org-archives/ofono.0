Content-Type: multipart/mixed; boundary="===============3989337824609792523=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] stk: Handle null Text field.
Date: Tue, 23 Nov 2010 03:09:29 -0600
Message-ID: <4CEB84C9.2060307@gmail.com>
In-Reply-To: <1290400982-17615-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3989337824609792523==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 11/21/2010 10:43 PM, Andrzej Zaborowski wrote:
> Add a NULL check in dbus_apply_text_attributes because in some places
> (like DisplayText handler) we call it without checking and we just check
> the return value once.
> ---
>  src/stk.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============3989337824609792523==--

