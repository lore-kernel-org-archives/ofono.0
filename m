Content-Type: multipart/mixed; boundary="===============5148275582956675374=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] atmodem: Fix SMS reception for Gemalto modems
Date: Fri, 21 Apr 2017 11:05:38 -0500
Message-ID: <55e3a75e-d6b0-57c7-8e76-04c1533b5aeb@gmail.com>
In-Reply-To: <1492783616-5897-2-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5148275582956675374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On 04/21/2017 09:06 AM, Vincent Cesson wrote:
> SMS reception is not working for Gemalto modems because of +CMT parsing.
> PDU length is the first argument of +CMT URCs in Gemalto modems.

Funny, can't believe they got this wrong.

>
> Add a switch case on vendor info to handle Gemalto case.
> Also handle acknowledgment, +CNMA takes only one parameter.
>
> CMT parsing is moved from at_parse_cmt() to at_cmt_notify(). This
> function is modified to match the style of at_cmgr_notify() and it
> includes a switch case for CINTERION modems.
> ---
>  drivers/atmodem/sms.c | 66 +++++++++++++++++++++++++++++----------------=
------
>  plugins/gemalto.c     |  2 +-
>  2 files changed, 39 insertions(+), 29 deletions(-)
>

I broke this up into two commits to follow our patch submission =

guidelines.  Applied, thanks!

Regards,
-Denis


--===============5148275582956675374==--

