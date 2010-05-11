Content-Type: multipart/mixed; boundary="===============6639377079072271345=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 09/19] stkutil: Add poll interval proactive command parser
Date: Tue, 11 May 2010 14:23:29 -0500
Message-ID: <201005111423.29504.denkenz@gmail.com>
In-Reply-To: <1273487942-27213-9-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6639377079072271345==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

>  	union {
> +		struct stk_duration duration;
>  		struct stk_command_display_text display_text;
>  		struct stk_command_get_inkey get_inkey;
>  		struct stk_command_get_input get_input;
>

For symmetry / consistency with other commands, can we please make a struct =

stk_command_poll_interval with only duration as a member?

Regards,
-Denis=20

--===============6639377079072271345==--

