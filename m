Content-Type: multipart/mixed; boundary="===============4461537209988028176=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Document the SS control string API
Date: Wed, 13 Oct 2010 08:52:52 -0500
Message-ID: <4CB5B9B4.2050003@gmail.com>
In-Reply-To: <1286969618-3558-1-git-send-email-alexander.kanavin@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4461537209988028176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On 10/13/2010 06:33 AM, Alexander Kanavin wrote:
> ---
>  doc/supplementaryservices-api.txt |   95 +++++++++++++++++++++++++++++++=
++++-
>  1 files changed, 92 insertions(+), 3 deletions(-)
> =

> +			The first return argument and the corresponding =

> +			second return argument are:
> +
> +			"USSD"				string ussd_response
> +			"CallBarring"			(string ss_op, string cb_service, dict cb_dict)
> +			"CallForwarding"		(string ss_op, string cf_service, dict cf_dict)
> +			"CallWaiting"			(string ss_op, dict cw_dict)
> +			"CallingLinePresentation"	(string ss_op, string status)
> +			"CalledLinePresentation"	(string ss_op, string status)
> +			"CallingLineRestriction"	(string ss_op, string clir_status)
> +			"CalledLineRestriction"		(string ss_op, string status)

Please try to keep the lines to under 80 characters.  This might need to
be moved to a separate section.

We also have pretty strict git am settings, so your patch does not apply:

Applying: Document the SS control string API
/home/denkenz/ofono-master/.git/rebase-apply/patch:15: trailing whitespace.
			If the command is a recognized supplementary service
/home/denkenz/ofono-master/.git/rebase-apply/patch:19: trailing whitespace.
			Otherwise the command is sent to the network initiating a
/home/denkenz/ofono-master/.git/rebase-apply/patch:29: trailing whitespace.
			The first return argument and the corresponding
/home/denkenz/ofono-master/.git/rebase-apply/patch:48: trailing whitespace.
			=

/home/denkenz/ofono-master/.git/rebase-apply/patch:49: trailing whitespace.
			cb_service contains the call barring service for
warning: squelched 20 whitespace errors
fatal: 25 lines add whitespace errors.

Please fix all occurrences of trailing whitespace damage.  Otherwise the
content of the patch looks great.

Thanks,
-Denis

--===============4461537209988028176==--

