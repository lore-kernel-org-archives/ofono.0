Content-Type: multipart/mixed; boundary="===============8019158208091018044=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/7] Added call-barring-api.txt.
Date: Thu, 18 Mar 2010 11:46:47 -0500
Message-ID: <201003181146.47727.denkenz@gmail.com>
In-Reply-To: <1268923471-29059-6-git-send-email-ppessi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8019158208091018044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> ---
>  doc/call-barring-api.txt |   65
>  ++++++++++++++++++++++++++++++++++++++++++++++ 1 files changed, 65
>  insertions(+), 0 deletions(-)
>  create mode 100644 doc/call-barring-api.txt
> =


> +Signals		PropertyChanged(string property, variant value)
> +
> +			Signal is emitted whenever a property has changed.  The new
> +			value is passed as the signal argument.

This line was over 80 characters.  I fixed it up for you this time, but ple=
ase =

keep this in mind.

Also, when applying the patch I got this:
Applying: Added call-barring-api.txt.
/home/denkenz/ofono-master/.git/rebase-apply/patch:51: trailing whitespace.
		=

/home/denkenz/ofono-master/.git/rebase-apply/patch:56: trailing whitespace.

Please make sure that your editor is setup properly and does not introduce =

trailing whitespace.  Again I fixed it up for you this time around.

Patch has been applied, thanks.

Regards,
-Denis

--===============8019158208091018044==--

